# Conventions for the project _helpwave_

## Content
- [Introduction](#introduction)
- [Git](#git)
  - [Branches](#branches)
  - [Commit messages](#commit-messages)
  - [Merge commits](#merge-commits)

## Introduction
This convention is a set of rules to be followed by all developers working on the project and repositories of _helpwave_ to help
maintain a consistent code style.

## Git
### Branches
The project uses the following branches:
* `main` - the main branch, contains the latest stable version of the project
* `issue/<issue-number>-<issue-name>` - a branch for a specific issue, where `<issue-number>` is the number of the issue
and `<issue-name>` is the name of the issue.

### Commit messages
The projects use the [Conventional Commits](http://conventionalcommits.org) scheme.
Commit messages should be written in the following format:
```text
<type>[(<scope>)]: <message>
```
where `<type>` is the type of the commit, `<message>` is the message of
the commit and `<scope>` represents an optional sub-part of the type.

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
* `infra`

#### Message
The message of the commit should be written in the imperative, present tense: "change" not "changed" nor "changes". The
first letter should not be capitalized. The message should **not** contain a dot (.) at the end.
The maximum length of the message is 50 characters and the language should be english.

#### Scope
The scope represents a sub-part of the project, like a specific microservice.

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
```text
fix(infra): reduce costs
```

## Merge commits
Merge commits should look like what github suggests in a pull request.

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

Closes #<issue-number

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
*WIP*

### General
* The code and comments should be written in english.
