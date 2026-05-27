# Docstring Usage

- Add a short Doxygen-syle docstrings to any function that isn't immediately obvious from its name and signature (e.g., has non-trivial logic, side effects, or subtle parameters). Skip docstrings for simple getters, setters, and one-liners.
- Use inline comments for member variables whose purpose isn't clear from the name alone.
- Keep docstrings to one line when possible; use multi-line only when the function has important caveats, parameters that need explanation, or non-obvious return values.
