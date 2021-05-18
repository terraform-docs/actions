# terraform-docs GitHub Actions

A Github action for generating Terraform module documentation using terraform-docs and gomplate.
In addition to statically defined directory modules, this module can search specific
subfolders or parse `atlantis.yaml` for module identification and doc generation. This
action has the ability to auto commit docs to an open PR or after a push to a specific
branch.

## Version

`v0.10.0` (uses [terraform-docs] v0.15.0, which is supported and tested on Terraform
version 0.11+ and 0.12+ but may work for others.)

## Usage

To use terraform-docs github action, configure a YAML workflow file, e.g.
`.github/workflows/documentation.yml`, with the following:

```yaml
name: Generate terraform docs
on:
  - pull_request
jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        ref: ${{ github.event.pull_request.head.ref }}

    - name: Render terraform docs inside the USAGE.md and push changes back to PR branch
      uses: terraform-docs/gh-actions@v0.10.0
      with:
        working-dir: .
        output-file: USAGE.md
        output-method: inject
        git-push: "true"
```

| NOTE: If USAGE.md already exists it will need to be updated, with the block delimeters `<!--- BEGIN_TF_DOCS --->` and `<!--- END_TF_DOCS --->`, where the generated markdown will be injected. |
| --- |

## Configuration

### Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| args | Additional arguments to pass to the command (see [full documentation](https://github.com/terraform-docs/terraform-docs/tree/master/docs)) | `""` | false |
| atlantis-file | Name of Atlantis file to extract list of directories by parsing it. To enable, provide the file name (e.g. `atlantis.yaml`) | `disabled` | false |
| config-file | Name of terraform-docs config file. To enable, provide the file name (e.g. `.terraform-docs.yml`) | `disabled` | false |
| fail-on-diff | Fail the job if there is any diff found between the generated output and existing file (ignored if `git-push` is set) | `false` | false |
| find-dir | Name of root directory to extract list of directories by running `find ./find\_dir -name \*.tf` (ignored if `atlantis-file` is set) | `disabled` | false |
| git-commit-message | Commit message | `terraform-docs: automated action` | false |
| git-push | If true it will commit and push the changes | `false` | false |
| git-push-sign-off | If true it will sign-off commit | `false` | false |
| git-push-user-email | If empty the no-reply email of the GitHub Actions bot will be used (i.e. `github-actions[bot]@users.noreply.github.com`) | `""` | false |
| git-push-user-name | If empty the name of the GitHub Actions bot will be used (i.e. `github-actions[bot]`) | `""` | false |
| indention | Indention level of Markdown sections [1, 2, 3, 4, 5] | `2` | false |
| output-file | File in module directory where the docs should be placed | `USAGE.md` | false |
| output-format | terraform-docs format to generate content (see [all formats](https://github.com/terraform-docs/terraform-docs/blob/master/docs/FORMATS\_GUIDE.md)) (ignored if `config-file` is set) | `markdown table` | false |
| output-method | Method should be one of `replace`, `inject`, or `print` | `inject` | false |
| template | When provided will be used as the template if/when the `output-file` does not exist | `<!-- BEGIN_TF_DOCS -->\n{{ .Content }}\n<!-- END_TF_DOCS -->` | false |
| working-dir | Comma separated list of directories to generate docs for (ignored if `atlantis-file` or `find-dir` is set) | `.` | false |

#### Output Method (output-method)

- `print`

  This will just print the generated output

- `replace`

  This will create or replace the `output-file` at the determined module path(s)

- `inject`

  Instead of replacing the `output-file`, this will inject the generated documentation
  into the existing file between the predefined delimeters: `<!--- BEGIN_TF_DOCS --->`
  and `<!--- END_TF_DOCS --->`. If the file exists but does not contain the delimeters,
  the action will append the generated content at the end of `output-file`. If the file
  doesn't exist, it will create it using the value template which MUST have the delimeters.

#### Auto commit changes

To enable you need to ensure a few things first:

- set `git-push` to `true`
- use `actions/checkout@v2` with the head ref for PRs or branch name for pushes
  - PR

    ```yaml
    on:
      - pull_request
    jobs:
      docs:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v2
          with:
            ref: ${{ github.event.pull_request.head.ref }}
    ```

  - Push

    ```yaml
    on:
      push:
        branches:
          - master
    jobs:
      docs:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v2
          with:
            ref: master
    ```

### Outputs

| Name | Description |
|------|-------------|
| num\_changed | Number of files changed |

## Examples

### Single folder

```yaml
- name: Generate TF Docs
  uses: terraform-docs/gh-actions@v0.10.0
  with:
    working-dir: .
    output-file: README.md
```

### Multi folder

```yaml
- name: Generate TF Docs
  uses: terraform-docs/gh-actions@v0.10.0
  with:
    working-dir: .,example1,example3/modules/test
    output-file: README.md
```

### Use `atlantis.yaml` v3 to find all directories

```yaml
- name: Generate TF docs
  uses: terraform-docs/gh-actions@v0.10.0
  with:
    atlantis-file: atlantis.yaml
```

### Find all `.tf` file under a given directory

```yaml
- name: Generate TF docs
  uses: terraform-docs/gh-actions@v0.10.0
  with:
    find-dir: examples/
```

Complete examples can be found [here](https://github.com/terraform-docs/gh-actions/tree/v0.10.0/examples).

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
