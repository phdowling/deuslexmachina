from typing import NamedTuple


class Employee(NamedTuple):
    employee_id: int
    name: str
    description: str
    email: str