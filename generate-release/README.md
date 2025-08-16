# generate-release

This build step image prepares the environment to generate a release for a javascript-based project.

## Configuration

After building the image, you need to configure the build step to use it.

The build step uses the `GITHUB_TOKEN` secret to authenticate with GitHub fine-grained token with the following scopes:

- `Metadata: Read-only`
- `Pull requests: Read and write`

Here is an example of how to configure the build step:

```yaml
steps:
  - name: gcr.io/$PROJECT_ID/generate-release
    id: generate-release
    entrypoint: bash
    secretEnv: ['GITHUB_TOKEN']
    args:
      - -lc
      - |
        export GH_TOKEN=$$GITHUB_TOKEN
        if ! gh auth status; then
          echo "Failed to login to GitHub"
          exit 1
        fi

        gh auth setup-git

        git config --global user.name "$_GITHUB_USER_NAME"
        git config --global user.email "$_GITHUB_USER_EMAIL"

        # your step code here

availableSecrets:
  secretManager:
  - versionName: projects/$PROJECT_ID/secrets/GITHUB_TOKEN/versions/latest
    env: GITHUB_TOKEN

substitutions:
  _GITHUB_USER_NAME: cloud-build # replace with your GitHub username
  _GITHUB_USER_EMAIL: cloud-build@$PROJECT_ID.iam.gserviceaccount.com # replace with your GitHub user email
```
