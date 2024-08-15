import os
import sys
from inspect import signature
from pathlib import Path
from typing import Iterable

import _jsonnet

import jsonnet_methods


# https://github.com/google/jsonnet/blob/2bca3a02ac3c06e4dac74c10c4b6c650ae53d148/python/_jsonnet_test.py#L22C1-L42C39
def import_callback(dir: str, rel: str) -> tuple[str, bytes]:
    dpath: Path = Path(dir)
    rpath: Path = Path(rel)
    jpath: Iterable[Path] = map(
        Path, filter(None, os.getenv("JSONNET_PATH", "").split(":"))
    )
    candidates = (
        candidate
        for candidate_root in [dpath, *jpath]
        if (candidate := candidate_root / rpath).is_file()
    )
    path = next(candidates, None)
    if path:
        return str(path.resolve()), path.read_bytes()
    else:
        raise RuntimeError("Path not found!")


def render_jsonnet(filename: str, input: str) -> str:
    return _jsonnet.evaluate_snippet(  # type: ignore
        filename,
        input,
        native_callbacks={
            k: (tuple(p.name for p in signature(v).parameters.values()), v)
            for k, v in jsonnet_methods.__dict__.items()
            if callable(v)
        },
        import_callback=import_callback,
    )


if __name__ == "__main__":
    if args := (sys.argv[1:]):
        for arg in args:
            print(render_jsonnet(arg, Path(arg).read_text()))
    else:
        filename = os.getenv("JSONNET_STDIN_FILENAME", "<stdin>")
        print(render_jsonnet(filename, sys.stdin.read()))
