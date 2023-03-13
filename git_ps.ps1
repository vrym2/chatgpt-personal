param([string]$message)

# Git functions in PowerShell
$status = git status --porcelain
if ($status -eq "") {
  Write-Host "Working directory is clean"
} else {
  Write-Host "Working directory has changes"
  git add .
  git commit -am "$message"
  git push
  Write-Host "Changes pushed to the main branch"
}