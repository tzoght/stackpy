# 🔧 Setting Up Automation for GitHub-hosted PyPI Index

To fully automate the deployment to your GitHub-hosted PyPI index, you need to set up a Personal Access Token (PAT) that allows cross-repository workflow triggers.

## 🎯 Why is this needed?

The default `GITHUB_TOKEN` provided by GitHub Actions only has permissions for the current repository. To automatically trigger the update workflow in your `github-hosted-pypi` repository, we need a PAT with broader permissions.

## 📝 Step-by-Step Setup

### 1. Create a Personal Access Token (PAT)

1. **Go to GitHub Settings:**
   - Click your profile picture → Settings
   - Or visit: https://github.com/settings/tokens

2. **Create a new token:**
   - Click "Developer settings" (left sidebar)
   - Click "Personal access tokens" → "Tokens (classic)"
   - Click "Generate new token" → "Generate new token (classic)"

3. **Configure the token:**
   - **Note**: `PyPI Index Update Token`
   - **Expiration**: Choose your preferred expiration (90 days, 1 year, or no expiration)
   - **Scopes**: Select the following permissions:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
     - ✅ `actions:write` (Needed for workflow dispatch)

4. **Generate and copy the token:**
   - Click "Generate token"
   - **⚠️ IMPORTANT**: Copy the token immediately - you won't see it again!

### 2. Add the Token as a Repository Secret

1. **Go to your stackpy repository:**
   - Navigate to: https://github.com/tzoght/stackpy

2. **Add the secret:**
   - Click "Settings" tab
   - Click "Secrets and variables" → "Actions" (left sidebar)
   - Click "New repository secret"

3. **Configure the secret:**
   - **Name**: `PYPI_UPDATE_PAT`
   - **Secret**: Paste the PAT you copied
   - Click "Add secret"

### 3. Test the Automation

Once the PAT is configured, your next deployment will automatically:

1. ✅ Build and release your package
2. ✅ Trigger the PyPI index update workflow
3. ✅ Update the index at https://tzoght.github.io/github-hosted-pypi/

## 🔄 Manual Alternative (if automation fails)

If you prefer not to use automation or the PAT setup fails, you can manually update the index:

1. **Go to the update workflow:**
   - Visit: https://github.com/tzoght/github-hosted-pypi/actions/workflows/update.yml

2. **Trigger manually:**
   - Click "Run workflow"
   - Fill in the form with your package details
   - Click "Run workflow"

## 🛡️ Security Considerations

- **Minimal permissions**: The PAT only needs `repo` and `workflow` permissions
- **Repository scope**: Consider creating organization-level tokens if you have multiple repositories
- **Token rotation**: Regularly rotate your PATs for security
- **Monitoring**: Check the token usage in GitHub Settings

## 🔍 Troubleshooting

### PAT not working?
- Verify the token has `workflow` and `actions:write` permissions
- Check that the token hasn't expired
- Ensure the secret name is exactly `PYPI_UPDATE_PAT`

### Workflow dispatch still failing?
- The target repository (`github-hosted-pypi`) must have an `update.yml` workflow
- Verify the workflow accepts the expected inputs (`package_name`, `package_url`, `new_version`)

### Testing the setup
You can test the PAT manually:
```bash
curl -H "Authorization: token YOUR_PAT" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/tzoght/github-hosted-pypi/actions/workflows
```

## 📚 References

- [GitHub PAT Documentation](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Workflow Dispatch Events](https://docs.github.com/en/rest/actions/workflows#create-a-workflow-dispatch-event)

---

> **💡 Pro Tip**: Once set up, this automation will handle all future deployments seamlessly! 