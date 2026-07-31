# Skeleton

## Quick Start

There are two ways to create a new project from this skeleton.

### Option 1 — Bash script (recommended)

Use the provided helper script to automate the entire setup:

```bash
./init-blendhtml-project.sh <project-name> <username> [host] [transport]
```

Examples:

```bash
# GitHub (HTTPS, default)
./init-blendhtml-project.sh my-project johndoe

# GitHub (SSH)
./init-blendhtml-project.sh my-project johndoe https://github.com ssh

# GitLab (HTTPS)
./init-blendhtml-project.sh my-project johndoe https://gitlab.com

# Self-hosted Git server (HTTPS)
./init-blendhtml-project.sh my-project acme https://git.example.com

# Self-hosted Git server (SSH)
./init-blendhtml-project.sh my-project acme https://git.example.com ssh
```

The script will:

- Clone the skeleton
- Install Composer dependencies
- Remove the template Git history
- Initialize a new Git repository
- Create the initial commit
- Configure the `origin` remote

### Option 2 — Manual setup

Clone the repository:

```bash
git clone https://github.com/blendhtml/skeleton.git my-project
cd my-project
```

Install PHP dependencies:

```bash
composer install
```

Remove the existing Git history and initialize a fresh repository:

```bash
rm -rf .git
git init
```

Create the initial commit:

```bash
git add .
git commit -m "Initial commit"
```

Add your own remote repository:

```bash
# GitHub
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git

# GitLab
git remote add origin https://gitlab.com/YOUR_USERNAME/YOUR_REPOSITORY.git

# Self-hosted Git
git remote add origin https://git.example.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

Push the project:

```bash
git branch -M main
git push -u origin main
```

Your project is now ready to use as the foundation for your new BlendHTML application.