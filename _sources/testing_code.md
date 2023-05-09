# Class 8: Continuous Integration Testing

Template [this repo](https://github.com/maciejskorski/cached_tests_python) which demonstrates how to *use GitHub actions to automatize and optimize tests execution*.

* Install and run [pre-commit](https://pre-commit.com/) locally
* Fix any mistakes (code workflow, formatting) so that the tests pass.
* Check that the cache builds and speeds-up tests

The action which caches the testing environment and runs tests is shown below: 

```yaml
name: pre-commit

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-python@v4
      with:
        python-version: 3.7
    - name: cache pre-commit deps
      id: cache_pre_commit
      uses: actions/cache@v3
      env:
          cache-name: cache-pre-commit
      with:
        path: |
          .pre_commit_venv 
          ~/.cache/pre-commit
        key: ${{ env.cache-name }}-${{ hashFiles('.pre-commit-config.yaml','~/.cache/pre-commit/*') }}
    - name: install pre-commit
      if: steps.cache_pre_commit.outputs.cache-hit != 'true'
      run: |
        python -m venv .pre_commit_venv
        . .pre_commit_venv/bin/activate
        pip install --upgrade pip
        pip install pre-commit
        pre-commit install --install-hooks
        pre-commit gc
    - name: run pre-commit hooks
      run: |
        . .pre_commit_venv/bin/activate  
        pre-commit run --color=always --all-files
```