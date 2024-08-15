# /// script
# dependencies = ["jsonpatch", "json-pointer"]
# ///

import json
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any, NamedTuple

from jsonpatch import JsonPatch
from jsonpointer import resolve_pointer


OldValue = Any
NewValue = Any
JSONPath = str


class Vals(NamedTuple):
    old: set[str]
    new: set[str]


def main(old_path: Path, new_path: Path) -> None:
    old_json: dict[str, Any] = json.loads(old_path.read_text())
    new_json: dict[str, Any] = json.loads(new_path.read_text())
    patch = JsonPatch.from_diff(old_json, new_json)

    path_vals: dict[JSONPath, Vals] = defaultdict(lambda: Vals(set(), set()))
    old_val_paths: dict[OldValue, set[JSONPath]] = defaultdict(set)

    for action in patch.patch:
        match action:
            case {"path": path}:
                old_val: Any = resolve_pointer(old_json, path, None)
                if old_val:
                    path_vals[path].old.add(old_val)
                    old_val_paths[old_val].add(path)

                new_val: Any = resolve_pointer(new_json, path, None)
                if new_val:
                    path_vals[path].new.add(new_val)

            case _:
                raise ValueError(f"Unhandled json patch action! {json.dumps(action)}")

    for path, vals in path_vals.items():
        _path_pfx, _, path_sfx = path.rpartition("/")

        match (list(vals.old), list(vals.new)):
            case ([old_val], [_new_val]):
                assert all(
                    path.rpartition("/")[-1] in ("UUID", "OutputUUID")
                    for path in old_val_paths[old_val]
                ), f"Replacement of non-UUID value {old_val}!"

                all_new_vals = set(
                    new_val
                    for path in old_val_paths[old_val]
                    for new_val in path_vals[path].new
                )
                assert (
                    len(all_new_vals) == 1
                ), f"Inconsistent replacement of value {old_val}!"

            case ([_old_val], []):
                assert path_sfx in [
                    "UUID",
                    "CustomOutputName",
                ], f"Unrecognized removal at {path}!"

            case ([], [_new_val]):
                assert path_sfx in [
                    "CustomOutputName"
                ], f"Unrecognized removal at {path}!"

            case _:
                raise ValueError(f"Unexpected case at {path} ({vals})")


if __name__ == "__main__":
    main(*map(Path, sys.argv[1:]))
