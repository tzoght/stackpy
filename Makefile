.PHONY: help setup env install install-dev test test-cov lint format check build clean docs docs-serve release pre-commit all

# Default target
help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Environment Management
env: ## Create conda environment from environment.yml (or update if exists)
	@if conda env list | grep -q "^stackpy "; then \
		echo "Environment 'stackpy' already exists. Updating..."; \
		conda env update -f environment.yml --prune; \
	else \
		echo "Creating new environment 'stackpy'..."; \
		conda env create -f environment.yml; \
	fi

env-update: ## Update conda environment
	conda env update -f environment.yml --prune

env-remove: ## Remove conda environment
	conda env remove -n stackpy

# Installation
install: ## Install project dependencies
	@echo "Activating conda environment and installing with poetry..."
	conda run -n stackpy poetry install

install-dev: ## Install project with development dependencies
	@echo "Installing with development dependencies..."
	conda run -n stackpy poetry install --with dev

setup: env install-dev ## Complete setup: create environment and install dependencies
	@echo "Setting up pre-commit hooks..."
	conda run -n stackpy pre-commit install

# Testing
test: ## Run tests
	conda run -n stackpy python -m pytest tests/ -v

test-cov: ## Run tests with coverage report
	conda run -n stackpy python -m pytest tests/ -v --cov=src/stackpy --cov-report=html --cov-report=term

test-quick: ## Run tests without coverage
	conda run -n stackpy python -m unittest discover tests/

# Code Quality
lint: ## Run linting with flake8
	conda run -n stackpy flake8 src/ tests/

format: ## Format code with black
	conda run -n stackpy black src/ tests/

format-check: ## Check code formatting without making changes
	conda run -n stackpy black --check src/ tests/

check: format-check lint ## Run all code quality checks

# Pre-commit
pre-commit: ## Run pre-commit hooks on all files
	conda run -n stackpy pre-commit run --all-files

# Building & Packaging
build: ## Build distribution packages
	conda run -n stackpy poetry build

build-wheel: ## Build wheel distribution only
	conda run -n stackpy poetry build --format wheel

build-sdist: ## Build source distribution only
	conda run -n stackpy poetry build --format sdist

publish-test: ## Publish to test PyPI
	conda run -n stackpy poetry publish --repository testpypi

publish: ## Publish to PyPI
	conda run -n stackpy poetry publish

# Documentation
docs: ## Build documentation
	@if [ -d "docs" ]; then \
		echo "Building documentation..."; \
		conda run -n stackpy sphinx-build -b html docs docs/_build/html; \
	else \
		echo "No docs directory found. Skipping documentation build."; \
	fi

docs-serve: docs ## Build and serve documentation locally
	@if [ -d "docs/_build/html" ]; then \
		echo "Serving docs at http://localhost:8000"; \
		cd docs/_build/html && python -m http.server 8000; \
	else \
		echo "Documentation not built. Run 'make docs' first."; \
	fi

docs-clean: ## Clean documentation build files
	@if [ -d "docs/_build" ]; then rm -rf docs/_build; fi

# Release Management
version-patch: ## Bump patch version and create release
	conda run -n stackpy semantic-release version --patch

version-minor: ## Bump minor version and create release
	conda run -n stackpy semantic-release version --minor

version-major: ## Bump major version and create release
	conda run -n stackpy semantic-release version --major

release: ## Create a release with semantic-release
	conda run -n stackpy semantic-release publish

# Cleaning
clean: ## Clean build artifacts and cache files
	@echo "Cleaning build artifacts..."
	rm -rf build/
	rm -rf dist/
	rm -rf src/*.egg-info/
	rm -rf .pytest_cache/
	rm -rf htmlcov/
	rm -rf .coverage
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete

clean-all: clean docs-clean ## Clean everything including docs
	conda env remove -n stackpy 2>/dev/null || true

# Development workflow
dev-setup: setup ## Alias for setup
dev-test: test-cov lint ## Run comprehensive development tests
dev-check: format check test ## Full development check before commit

# CI/CD
ci: install-dev check test-cov build ## Run CI pipeline locally

# Convenience targets
all: clean setup check test-cov build ## Run complete development workflow

# Project info
info: ## Show project information
	@echo "Project: stackpy"
	@echo "Python version: $(shell conda run -n stackpy python --version 2>/dev/null || echo 'Environment not found')"
	@echo "Poetry version: $(shell conda run -n stackpy poetry --version 2>/dev/null || echo 'Poetry not installed')"
	@echo "Conda environment: $(shell conda env list | grep stackpy || echo 'Environment not found')" 