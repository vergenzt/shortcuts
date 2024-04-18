from typing import DefaultDict
import uuid


def UUIDv5(ns_str: str, id_str: str) -> str:
    _0 = uuid.UUID(int=0)
    ns = uuid.uuid5(_0, ns_str)
    id = uuid.uuid5(ns, id_str)
    return str(id)


_counters = DefaultDict[str, int](lambda: 0)


def global_count(namespace: str) -> int:
    _counters[namespace] += 1
    return _counters[namespace]
