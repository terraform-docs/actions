{{- define "escape_chars" }}{{ . | strings.ReplaceAll "_" "\\_" | strings.ReplaceAll "|" "\\|" | strings.ReplaceAll "*" "\\*" }}{{- end }}
{{- define "sanatize_string" }}{{ . | strings.ReplaceAll "\n\n" "<br><br>" | strings.ReplaceAll "  \n" "<br>" | strings.ReplaceAll "\n" "<br>" | tmpl.Exec "escape_chars" }}{{- end }}
{{- define "sanatize_value" }}{{ . | strings.ReplaceAll "\n\n" "\\n\\n" | strings.ReplaceAll "  \n" "\\n" | strings.ReplaceAll "\n" "\\n" }}{{- end }}
{{- $action := (datasource "action") -}}
{{- $version := or (getenv "VERSION") "main" -}}
# terraform-docs GitHub Actions

{{ $action.description }}
In addition to statically defined directory modules, this module can search specific
subfolders or parse `atlantis.yaml` for module identification and doc generation. This
action has the ability to auto commit docs to an open PR or after a push to a specific
branch.

## Version

`{{ $version }}` (uses [terraform-docs] v0.15.0, which is supported and tested on Terraform
version 0.11+ and 0.12+ but may work for others.)

{{- if eq $version "main" }}
| WARNING:  You should not rely on main being stable or to have accurate documentation.  Please use a git tagged semver or major version tag like `v1`. |
| --- |
{{- end }}

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
        ref: {{"${{"}} github.event.pull_request.head.ref {{"}}"}}

    - name: Render terraform docs inside the USAGE.md and push changes back to PR branch
      uses: terraform-docs/gh-actions@{{ $version }}
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
{{- range $key, $input := $action.inputs }}
| {{ tmpl.Exec "escape_chars" $key }} | {{ if (has $input "description") }}{{ tmpl.Exec "sanatize_string" $input.description }}{{ else }}{{ tmpl.Exec "escape_chars" $key }}{{ end }} | {{ if (has $input "default") }}`{{ if $input.default }}{{ tmpl.Exec "sanatize_value" $input.default }}{{ else }}""{{ end }}`{{ else }}N/A{{ end }} | {{ if (has $input "required") }}{{ $input.required }}{{ else }}false{{ end }} |
{{- end }}

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
            ref: {{"${{"}} github.event.pull_request.head.ref {{"}}"}}
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
{{- range $key, $output := $action.outputs }}
| {{ tmpl.Exec "escape_chars" $key }} | {{ if (has $output "description") }}{{ tmpl.Exec "sanatize_string" $output.description }}{{ else }}{{ tmpl.Exec "escape_chars" $key }}{{ end }} |
{{- end }}

## Examples

### Single folder

```yaml
- name: Generate TF Docs
  uses: terraform-docs/gh-actions@{{ $version }}
  with:
    working-dir: .
    output-file: README.md
```

### Multi folder

```yaml
- name: Generate TF Docs
  uses: terraform-docs/gh-actions@{{ $version }}
  with:
    working-dir: .,example1,example3/modules/test
    output-file: README.md
```

### Use `atlantis.yaml` v3 to find all directories

```yaml
- name: Generate TF docs
  uses: terraform-docs/gh-actions@{{ $version }}
  with:
    atlantis-file: atlantis.yaml
```

### Find all `.tf` file under a given directory

```yaml
- name: Generate TF docs
  uses: terraform-docs/gh-actions@{{ $version }}
  with:
    find-dir: examples/
```

Complete examples can be found [here](https://github.com/terraform-docs/gh-actions/tree/{{ $version }}/examples).

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
