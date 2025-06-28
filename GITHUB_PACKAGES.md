# 📦 Installing from GitHub Packages

This package is published to GitHub Packages instead of PyPI. Here's how to install and use it:

## 🔧 Installation Methods

### Method 1: Direct Installation with Index URL

```bash
pip install --index-url https://pypi.pkg.github.com/tzoght/simple/ stackpy
```

### Method 2: Configure pip globally

```bash
# Set GitHub Packages as your default index
pip config set global.index-url https://pypi.pkg.github.com/tzoght/simple/

# Now you can install normally
pip install stackpy
```

### Method 3: Using requirements.txt

Create a `requirements.txt` file:

```txt
--index-url https://pypi.pkg.github.com/tzoght/simple/
stackpy==0.2.0
```

Then install:

```bash
pip install -r requirements.txt
```

### Method 4: With Poetry

If you're using Poetry, add the repository source to your `pyproject.toml`:

```toml
# For downloading packages (use the simple/ endpoint)
[[tool.poetry.source]]
name = "github"
url = "https://pypi.pkg.github.com/tzoght/simple/"
priority = "explicit"

[tool.poetry.dependencies]
stackpy = {version = "^0.2.0", source = "github"}
```

## 🔐 Authentication

### For Public Packages
No authentication required! The package can be installed directly using the methods above.

### For Private Packages (if applicable)
If this repository becomes private, you'll need to authenticate:

1. **Create a Personal Access Token (PAT):**
   - Go to GitHub Settings → Developer settings → Personal access tokens
   - Create a token with `packages:read` permission

2. **Configure pip with authentication:**
   ```bash
   pip config set global.index-url https://YOUR_TOKEN@pypi.pkg.github.com/tzoght/simple/
   ```

## 📋 Usage Example

```python
import stackpy

# Use the package
generator = stackpy.PrimeGenerator()
primes = generator.generate(1, 100)
print(f"Primes from 1 to 100: {primes}")
```

## 🔍 Finding Package Versions

You can view available versions at:
https://github.com/tzoght/stackpy/packages

## 🆚 Why GitHub Packages vs PyPI?

- **Integrated with GitHub**: Seamless integration with your repository
- **Private packages**: Can easily make packages private if needed
- **Access control**: Use GitHub's permission system
- **No external dependencies**: Everything stays within GitHub ecosystem

## 🚀 Publishing (for maintainers)

The package is automatically published to GitHub Packages when code is merged to the main branch. The workflow:

1. **Merge to main** → Triggers workflow
2. **Semantic Release** → Creates GitHub release with version bump
3. **Build & Publish** → Publishes to GitHub Packages
4. **Test Installation** → Verifies the package works

## 📝 Notes

- Package versions follow semantic versioning
- Each merge to main creates a new release
- Installation requires specifying the GitHub Packages index URL
- Compatible with all standard pip and Poetry workflows

### GitHub Packages URL Reference
- **For installing packages**: `https://pypi.pkg.github.com/tzoght/simple/`
- **For uploading packages** (CI/CD only): `https://upload.pypi.pkg.github.com/tzoght/` 