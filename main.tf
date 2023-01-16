terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "github" {
    owner="palo-it-hk"
    token = "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"
}


resource "github_repository" "new-repo" {
  name        = "new_terraform_created_repo"
  description = "My awesome codebase"

  visibility = "private"
  auto_init = true
}

resource "github_branch" "master" {
    repository = github_repository.new-repo.name
    branch = "main"
}

resource "github_branch_default" "default" {
    repository = github_repository.new-repo.name
    branch = github_branch.master.branch
}

resource "github_branch_protection_v3" "example" {
    repository = github_repository.new-repo.name
    branch = "main"

    required_pull_request_reviews {
        require_code_owner_reviews = true
    }
}