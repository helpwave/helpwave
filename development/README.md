# Conventions for the project _helpwave_

## Content
- [Introduction](#introduction)
- [Git](#git)
  - [Branches](#branches)
  - [Commit messages](#commit-messages)
  - [Merge commits](#merge-commits)

## Introduction
This convention is a set of rules to be followed by all developers working on the project _helpwave_ and helps to
maintain a consistent code style.

## Git
### Branches
The project uses the following branches:
* `main` - the main branch, contains the latest stable version of the project
* `issue/<issue-number>-<issue-name>` - a branch for a specific issue, where `<issue-number>` is the number of the issue
and `<issue-name>` is the name of the issue

### Commit messages
Commit messages should be written in the following format:
```text
<type>: <message>
```
where `<type>` is the type of the commit, `<issue-number>` is the number of the issue and `<message>` is the message of
the commit.

#### Type
The type of the commit message should be one of the following:
* `feat` - a new feature
* `fix` - a bug fix
* `docs` - changes to the documentation
* `style` - formatting, missing semicolons, etc.; no code change
* `refactor` - refactoring production code
* `test` - adding tests, refactoring test; no production code change
* `chore` - updating build tasks, package manager configs, etc.; no production code change
* `ci` - changes to the CI configuration files and scripts
* `wip` - work in progress

#### Message
The message of the commit should be written in the imperative, present tense: "change" not "changed" nor "changes". The
first letter should not be capitalized. The message should **not** contain a dot (.) at the end.
The maximum length of the message is 50 characters and the language should be English.

#### Examples
```text
feat: add the ability to create a new user
```
```text
fix: fix the bug with the user creation
```
```text
docs: add the documentation for the user creation
```

## Merge commits
Merge commits from a feature branch to the main branch should be in the following format:
```text
Merge from 'issue/<issue-number>-<issue-name>' into main (#<pull-request-number>)
```
where `<issue-number>` is the number of the issue, `<issue-name>` is the name of the issue and `<pull-request-number>`
is the number of the pull request.
### Examples
```text
Merge from issue/1-add-the-ability-to-create-a-new-user into main (#1)
```
```text
Merge from issue/2-fix-the-bug-with-the-user-creation into main (#2)
```
[…]

## Pull requests
### Title
The title of a pull request should be broken down to a few words. In addition, special characters such as `[]\()/;+-*'`
should be avoided.

### Description
The description of a pull request should contain the following information:
* A short description of the changes
* A link to the issue
* Testing instructions
* Additional notes

#### Examples
```text
Add the ability to create a new user

This pull request adds the ability to create a new user.

[#<issue-number](<issue-link>)

Testing instructions:
1. Go to the user creation page
2. Fill in the form
3. Click on the button "Create user"
4. Check that the user was created successfully in the database

Additional notes:
- The user creation page must be created first.
- Then the user creation form must be created.
```

### Merge conflicts
If a pull request has merge-conflicts, the main branch should be merged into the feature branch and the merge conflicts 
should be resolved.
The commit message of the merge commit should be in the following format:
```text
merge conflicts solved (#<pull-request-number>)
```

### Reviews
A pull request should be reviewed by at least one other developer before it can be merged into the main branch.

## Releases
### Versioning
The project uses the [Semantic Versioning](https://semver.org/) scheme.

### Hotfixes
If a bug is found in the latest stable version of the project, a hotfix branch should be created from the main branch.
The hotfix branch should be named `hotfix/<issue-number>-<issue-name>`.
This branch should be merged into the main branch and the latest stable version should be released.

## Code style
_This section is still under construction._
### General
* The code and comments should be written in English.
* For local convention tests, the pre-commit hook plugin husky should be used.

### Git Hooks
For local convention tests, the pre-commit hook plugin husky should be used.

#### Husky for go
##### Installation
```bash
go install github.com/automation-co/husky@latest
```
[…]

##### Usage
[…]

#### Husky for TypeScript
##### Installation
```bash
npm install husky --save-dev
```
[…]

##### Usage
[…]