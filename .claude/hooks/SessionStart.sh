#!/bin/bash

# Only run in remote Claude environments
if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
  exit 0
fi

set -e

echo "Setting up development environment..."

# Install pre-commit if not available
if ! command -v pre-commit &> /dev/null; then
  echo "Installing pre-commit..."
  if command -v pip3 &> /dev/null; then
    pip3 install pre-commit
  elif command -v pip &> /dev/null; then
    pip install pre-commit
  else
    echo "Error: pip not found, cannot install pre-commit"
    exit 1
  fi
fi

# Install pre-commit hooks if .pre-commit-config.yaml exists
if [ -f "$CLAUDE_PROJECT_DIR/.pre-commit-config.yaml" ]; then
  echo "Installing pre-commit hooks..."
  pre-commit install
  pre-commit install --hook-type commit-msg
fi

# Install shellcheck if not available
if ! command -v shellcheck &> /dev/null; then
  echo "Installing shellcheck..."
  if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y shellcheck
  elif command -v apk &> /dev/null; then
    sudo apk add shellcheck
  else
    echo "Warning: Could not install shellcheck - no supported package manager found"
  fi
fi

# Install actionlint if not available
if ! command -v actionlint &> /dev/null; then
  echo "Installing actionlint..."
  ACTIONLINT_VERSION="1.7.9"
  curl -sL "https://github.com/rhysd/actionlint/releases/download/v${ACTIONLINT_VERSION}/actionlint_${ACTIONLINT_VERSION}_linux_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/actionlint /usr/local/bin/
  sudo chmod +x /usr/local/bin/actionlint
fi

echo "Development environment setup complete!"
echo "Available tools:"
command -v pre-commit && echo "  - pre-commit: $(pre-commit --version)"
command -v shellcheck && echo "  - shellcheck: $(shellcheck --version | head -2 | tail -1)"
command -v actionlint && echo "  - actionlint: $(actionlint --version)"
