# Buildme GitHub Action

This GitHub Action automatically searches for `.buildme` files in your repository and builds the associated projects.

## How it works

1. Searches the repository for files named `.buildme`
2. For each directory containing a `.buildme` file:
   - Checks if a `package.json` file exists
   - If found, runs `npm install` followed by `npm run build`
   - Cleans up by removing the `node_modules` folder
3. Provides detailed console output at each step

## Usage

Add this to your GitHub workflow file:

```yaml
name: Build Projects

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build Projects
        uses: KLIXPERT-io/buildme@v1
        with:
          node-version: '18' # Optional, defaults to 18 if not specified
```

### Inputs

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `node-version` | Node.js version to use | No | `'18'` |

## Creating a buildable project

To mark a project for automatic building:

1. Create an empty file named `.buildme` in the project directory
2. Ensure the directory has a valid `package.json` with a `build` script

## License

MIT