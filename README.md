# Buildme GitHub Action

This GitHub Action automatically searches for `.buildme` files in your repository and builds the associated projects.

## How it works

1. Searches the repository for files named `.buildme`
2. For each directory containing a `.buildme` file:
   - Checks if a `package.json` file exists
   - If found, verifies that `package.json` contains a `"build"` script in the `scripts` section
   - Runs `npm install` followed by `npm run build`
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
      - uses: actions/checkout@v3 # You need this step to checkout your code first
      - name: Build Projects
        uses: KLIXPERT-io/buildme@v1
        with:
          node-version: '22' # Optional, defaults to 22 if not specified
```

### Inputs

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `node-version` | Node.js version to use | No | `'22'` |

## Creating a buildable project

To mark a project for automatic building:

1. Create an empty file named `.buildme` in the project directory or any subdirectory
2. Ensure the directory has a valid `package.json` with a `build` script defined in the `scripts` section, for example:
   ```json
   {
     "scripts": {
       "build": "your-build-command"
     }
   }
   ```

# Why this Action?

This action was created to solve a common problem in WordPress development. When working with WordPress plugins and themes, each component often requires its own build process. While deploying pre-built files is convenient, it can lead to inconsistencies when different developers work with different local environments.

This action ensures that:
- All builds are performed in a consistent environment
- No pre-built files need to be committed to the repository
- Every deployment builds the code fresh, preventing environment-specific issues
- Developers can focus on their code without worrying about build artifacts

And and it's simple to use :)

## License

MIT