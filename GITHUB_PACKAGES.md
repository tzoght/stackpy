# 📦 Installing from GitHub-hosted PyPI Index

This package is published to a custom GitHub-hosted PyPI index instead of the official PyPI. Here's how to install and use it:

## 🌐 What is a GitHub-hosted PyPI Index?

This is a custom PyPI index hosted on GitHub Pages that provides a PEP503-compliant package index. It points to GitHub releases containing the actual package files, providing:

- **Private package management** without PyPI
- **Full control** over your package ecosystem
- **GitHub integration** with releases and authentication
- **Supply chain security** with automated vulnerability checks

Visit the index at: **https://tzoght.github.io/github-hosted-pypi/**

## 🔧 Installation Methods

### Method 1: Direct Installation with Extra Index URL

```bash
pip install stackpy --extra-index-url https://tzoght.github.io/github-hosted-pypi/
```

### Method 2: Install Specific Version

```bash
pip install stackpy==1.0.0 --extra-index-url https://tzoght.github.io/github-hosted-pypi/
```

### Method 3: Using requirements.txt

Create a `requirements.txt` file:

```txt
--extra-index-url https://tzoght.github.io/github-hosted-pypi/
stackpy==1.0.0
```

Then install:

```bash
pip install -r requirements.txt
```

### Method 4: With Poetry

If you're using Poetry, add the repository source to your `pyproject.toml`:

```toml
[[tool.poetry.source]]
name = "github-pypi"
url = "https://tzoght.github.io/github-hosted-pypi/"
priority = "explicit"

[tool.poetry.dependencies]
stackpy = {version = "^1.0.0", source = "github-pypi"}
```

### Method 5: Direct from GitHub (alternative)

You can also install directly from GitHub releases:

```bash
pip install git+https://github.com/tzoght/stackpy@v1.0.0
```

## 🔐 Authentication

### For Public Packages
**No authentication required!** The GitHub-hosted PyPI index is public and packages can be installed directly.

### For Private Packages (if repository becomes private)
If this repository becomes private, you'll need GitHub authentication:

1. **Create a Personal Access Token (PAT):**
   - Go to GitHub Settings → Developer settings → Personal access tokens
   - Create a token with `repo` permission for private repositories

2. **Use git+https with authentication:**
   ```bash
   pip install git+https://YOUR_TOKEN@github.com/tzoght/stackpy@v1.0.0
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

You can view:
- **Available packages**: https://tzoght.github.io/github-hosted-pypi/
- **Package details**: https://tzoght.github.io/github-hosted-pypi/stackpy/
- **GitHub releases**: https://github.com/tzoght/stackpy/releases

## 🆚 Why GitHub-hosted PyPI vs Official PyPI?

- **Private ecosystem**: Keep all your packages in one private index
- **No PyPI account needed**: Uses GitHub infrastructure
- **Integrated workflow**: Seamless with GitHub releases
- **Security**: Built-in supply chain attack protection
- **Flexibility**: Can host any package, including forks of public packages

## 🚀 Publishing (for maintainers)

The package is automatically published to the GitHub-hosted PyPI index when code is merged to the main branch:

1. **Merge to main** → Triggers workflow
2. **Semantic Release** → Creates GitHub release with version bump
3. **Build Package** → Creates distribution files (.whl, .tar.gz)
4. **Upload to Release** → Attaches files to GitHub release
5. **Update PyPI Index** → Triggers update in the github-hosted-pypi repository
6. **Test Installation** → Verifies the package works from the index

## 🛡️ Security Features

The GitHub-hosted PyPI index includes protection against supply chain attacks:

- **Version monitoring**: Warns if a package with the same name and higher version appears on public PyPI
- **Source verification**: All packages point to specific GitHub releases
- **Audit trail**: Full history via GitHub releases and commits

## 📝 Notes

- **Package versions** follow semantic versioning
- **Index updates** may take a few minutes after release creation
- **Fallback to PyPI**: If a package isn't found in the index, pip will check PyPI
- **Compatible** with all standard pip and Poetry workflows

## 🔗 Related URLs

- **PyPI Index**: https://tzoght.github.io/github-hosted-pypi/
- **Index Repository**: https://github.com/tzoght/github-hosted-pypi
- **Package Repository**: https://github.com/tzoght/stackpy
- **Package Releases**: https://github.com/tzoght/stackpy/releases

---

> **💡 Tip**: Bookmark the index URL for easy access to all your private packages! 