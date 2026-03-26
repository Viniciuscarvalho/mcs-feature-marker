# Python Stack Patterns

## Detection Signals

- `pyproject.toml` → Modern Python project
- `setup.py` → Legacy Python project
- `requirements.txt` → Pip-based project

## Test Commands

- **Primary**: `pytest -v`
- **Lint**: `ruff check .` (preferred) or `flake8 .`
- **Build**: `python -m build` (if `pyproject.toml` exists)

## Key Patterns

- Type hints on all function signatures
- Specific exceptions — never bare `except:`
- `dataclass` or `pydantic` for structured data
- Async/await where appropriate
- Organized imports (stdlib → third-party → local)
- Docstrings for public functions/classes

## Test Patterns

```python
import pytest

class TestFeature:
    def test_expected_behavior(self):
        result = my_function(input_data)
        assert result == expected

    def test_invalid_input_raises(self):
        with pytest.raises(ValueError):
            my_function(None)

    @pytest.mark.parametrize("input,expected", [
        ("a", 1),
        ("b", 2),
    ])
    def test_parametrized(self, input, expected):
        assert my_function(input) == expected
```
