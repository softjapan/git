
# softjpn/git

A minimal Docker image based on Alpine Linux with the latest version of **git** installed.  
This image is designed to keep the size as small as possible while providing the essential git functionality in a containerized environment.

- **GitHub:** [https://github.com/softjapan/git](https://github.com/softjapan/git)
- **Docker Hub:** [https://hub.docker.com/r/softjpn/git](https://hub.docker.com/r/softjpn/git)

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Dockerfile](#dockerfile)
4. [Usage](#usage)
   - [Pull from Docker Hub](#pull-from-docker-hub)
   - [Run Git Commands](#run-git-commands)
   - [Common Git Operations](#common-git-operations)
5. [Building from Source](#building-from-source)
6. [Per-Folder GitHub Account Configuration](#per-folder-github-account-configuration)
7. [License](#license)
8. [Author](#author)

---

## Overview

**softjpn/git** is a lightweight Docker image that packages the latest Git client. By mounting your project directory into the container, you can run all standard Git commands without installing Git locally. This is especially useful for maintaining a clean environment or for CI/CD pipelines where you need a reliable, up-to-date Git version.

---

## Features

- **Small Image Size:** Built on Alpine Linux, this image is significantly smaller than many alternatives.  
- **Latest Git Version:** Uses the Alpine package manager to install Git (frequently updated).  
- **Simple Volume Mount:** Easily mount your local directory into `/app` for Git operations.  
- **SSH Client Pre-Installed:** Includes `openssh-client` so you can work with private repositories that require SSH keys.  

---

## Dockerfile

Below is the core of the Dockerfile, located in this repository:

```dockerfile
FROM alpine:3.18

RUN apk update && \
    apk add --no-cache git openssh-client && \
    rm -rf /var/cache/apk/*

WORKDIR /app

ENTRYPOINT ["git"]
```

---

## Usage

### Pull from Docker Hub

```bash
docker pull softjpn/git
```

### Run Git Commands

Mount your local directory to the container’s `/app` folder and run Git commands as needed:

```bash
# Check status
docker run --rm -it -v "$PWD:/app" softjpn/git status

# Add files
docker run --rm -it -v "$PWD:/app" softjpn/git add -A .

# Commit changes
docker run --rm -it -v "$PWD:/app" softjpn/git commit -m "Your commit message"

# Push to remote repository
docker run --rm -it -v "$PWD:/app" softjpn/git push origin main
```

### Common Git Operations

Here are some additional commands you may find useful. Simply prefix with `docker run --rm -it -v "$PWD:/app" softjpn/git`:

- **Clone a repository**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git clone https://github.com/user/repo.git
  ```
- **List branches**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git branch
  ```
- **Check logs**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git log --oneline --graph
  ```
- **Create/switch branch**  
  ```bash
  # Create and switch to a new branch
  docker run --rm -it -v "$PWD:/app" softjpn/git checkout -b feature-branch

  # Switch to an existing branch
  docker run --rm -it -v "$PWD:/app" softjpn/git checkout main
  ```
- **Pull updates**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git pull
  ```
- **Merge branches**  
  ```bash
  # Switch to the branch you want to merge into
  docker run --rm -it -v "$PWD:/app" softjpn/git checkout main
  
  # Merge the other branch
  docker run --rm -it -v "$PWD:/app" softjpn/git merge feature-branch
  ```
- **Rebase**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git checkout main
  docker run --rm -it -v "$PWD:/app" softjpn/git rebase feature-branch
  ```
- **Stash changes**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git stash
  docker run --rm -it -v "$PWD:/app" softjpn/git stash pop
  ```
- **Tag and push tags**  
  ```bash
  docker run --rm -it -v "$PWD:/app" softjpn/git tag v1.0.0
  docker run --rm -it -v "$PWD:/app" softjpn/git push --tags
  ```

---

## Building from Source

If you wish to build the Docker image locally from the Dockerfile in this repository:

```bash
git clone https://github.com/softjapan/git.git
cd git
docker build -t softjpn/git .
```

---

## Per-Folder GitHub Account Configuration

To maintain different Git configurations per project (e.g., different username, email), you have multiple options:

1. **Local .git/config**  
   - Inside each project’s `.git/config`, specify:  
     ```ini
     [user]
       name = "Your Name"
       email = "your.email@example.com"
     ```
2. **Mount a Custom .gitconfig**  
   - You can keep a custom `.gitconfig` file in your project folder and mount it into the container:  
     ```bash
     docker run --rm -it \
       -v "$PWD:/app" \
       -v "$PWD/.my_gitconfig:/root/.gitconfig" \
       softjpn/git config --list
     ```

---

## License

This project is licensed under the [MIT License](LICENSE) - feel free to use, modify, and distribute it.

---

## Author

- **softjapan** - [https://github.com/softjapan](https://github.com/softjapan)

For any inquiries or suggestions, please open an issue on GitHub or contact us directly. We appreciate all contributions and feedback!

---
