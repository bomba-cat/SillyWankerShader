# Contributing to SillyWankerShader

## How Can I Contribute?

### Creating Issues
When Reporting a bug/feature, please open an Issue on the GitHub repository.

Make sure that:
- a similiar Issue doesnt already exist.
- the Issue is reproducible.
- you follow the Issue creation template.

### Pull Requests
1. First of, **Fork** the repository and create a Branch
```bash
git checkout -B update/your_user_name
```

2. **Make your changes** following our coding guidelines.

3. **Commit and Push** your changes
```bash
git add .
git commit -m "Add a concise commit message"
git push origin feature/my-feature
```

4. **Open a pull request** on the original repository and provide a detailed description of your changes.

# But most important of all
## Be Silly :3

## Coding Guideline
### File and Directory structure
For each feature, create a `.glsl` inside the `lib/` folder for each dimension.

#### Naming scheme
```bash
lib/
|_ {feature_name}.glsl
```
or
```bash
lib/
|_ {feature_name}
    |_ {file_purpose}.glsl
    |_ {file_purpose}.glsl
```

### Commenting
Comments are appreciated and should be clear and simple.

Comments should:
- be short
- explain what the function does

Comments should not:
- be too long
- be AI generated
- contain useless or private information

Please note that if you are copying a piece of code for example from shadertoys or other sources, please put the link to the original code as a Comment above the copied Code snippet

### General code structure
- Keep functions small: Each function should do one thing and do it well.
- Avoid code duplication: Reuse existing code whenever possible.
- Write self-documenting code: Choose clear and descriptive names for variables, functions, and classes.
- Adhere to DRY: Don’t Repeat Yourself – aim for reusable and modular code.
- Test your code: Ensure that new code includes tests and doesn’t break existing functionality.

also
- Indentation: Use spaces 2 consistently.
- Line Length: Limit lines to 80-100 characters where possible.

Please make sure the Functions are customizable, extendable and toggable (meaning there is an option to turn that feature off)

### Variable names
When using general Variables, you can choose any naming convention you like, but if you use `#define` please make sure you:
- define the options using `// []`
- use UPPER_SNAKE_CASE naming convention
