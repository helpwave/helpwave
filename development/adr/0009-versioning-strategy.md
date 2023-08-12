# **ADR-009: Versioning strategy**

## Status

Proposed

## Context

As a software product, we should establish a sense of versioning.
With versioning we are able to pin our products as a versioned resource at customer facing deployments
or for feature planing. This ADR is focused on the Git implementation of our versioning strategy.

## Decision

The base of every versioning strategy is the version number. We are using [Semantic Versioning 2.0.0](https://semver.org/) with version prefix of `v`.
Our Git strategy is based on the branching and versioning strategy of [Dapr](https://github.com/dapr/dapr).

- New changes are made against the `main` branch.
- For every `MINOR` release, we are opening a branch called `release-v[MAJOR].[MINOR]` (release branch) based of the previous release.
- New changes for the release branch are either merged or cherry-picked from `main`.
- The version of the software on a release branch, until tagged, is called pre-release.
- The tag should be called `v[MAJOR].[MINOR].[PATCH]`. Based on the versioning number of SemVer.
- A tag of a commit on the release branch indicates a released version.
- If a Bugfix needs to take place for all versions, the fix can be made against the `main` branch and cherry-picked into the release branches.
- If a Bugfix needs to take place only for a specific version, this fix can be made against the release branch. 

![](../../assets/versioning-strategy-visualization.png)

## Consequences

As long as our versioning strategy stays consistent across our whole product landscape.
The major version is a compatibility identifier. `web/tasks/v1.1.1` is compatible with `services/v1.2.3`. 
