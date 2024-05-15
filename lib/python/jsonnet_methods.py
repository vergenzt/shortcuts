import uuid


def UUIDv5(ns_str: str, id_str: str) -> str:
    _0 = uuid.UUID(int=0)
    ns = uuid.uuid5(_0, ns_str)
    id = uuid.uuid5(ns, id_str)
    return str(id).upper()
