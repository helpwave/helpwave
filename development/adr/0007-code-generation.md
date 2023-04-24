# ADR-007: code generation

# Protobuf Code Generation

## Status

Accepted

## Context

We want to provide generated code for web (nextjs/ts) and mobile-app (dart) in order to reduce workload. This generated client code for interacting with the API should be packed in proper packages and pushed to a registry. ([GitHub Packages](https://github.com/orgs/helpwave/packages), [npm](https://www.npmjs.com/), [pub.dev](https://pub.dev/)) 

## Decision

Using [buf](https://github.com/bufbuild/buf) generating the client-side API services:

* mobile-app (flutter/dart): <https://buf.build/protocolbuffers/dart>
* web (next.js/typescript): <https://buf.build/community/stephenh-ts-proto>


### Versioning

* **Major**: Contains a **breaking change,** i.e. a deletion of a deprecated package
* **Minor**: Addition of new packages\neither a new version of a package is available, or a new package (for a new feature/service) was added\nin the former case, clients should update their implementation to use the new version\nold package versions are always considered deprecated
* **Patch**: non-breaking changes to existing packages (may include new messages / features)


Both patch and minor updates are always backwards compatible.


A typical lifecycle of a proto package may be:


1. *starting at v1.0.0-sha1*
2. addition of new package `services/ex_svc/v1` in v1.**1**.0-sha2
3. non-breaking update of a message in `services/ex_svc/v1` in v1.1.**1**-sha3
4. new package `services/ex_svc/v2` in v1.**2**.0-sha4\nAll clients are advised to move to v2, v1 is considered deprecated\nv2 may be breakingly different to v1!
5. deletion of deprecated `services/ex_svc/v2` in v**2**.0.0-sha5\nThose using v2 can update safely, but this change is obviously truly breaking for those on v1


Our CI-pipeline will run the code generation for all clients after each push and then tag them with the appropriate versions tag on the respective package management registries. The API version and the commit hash together should result in the versions tag.\n\nClient maintainers are advised to set up Dependabot for updates.

## Consequences for client maintainers

If you see a new patch version, you can safely update to it. No further action is required.

If you see a new minor version, you can safely update to it. Familiarize yourself with the changes and adopt new versions of packages when needed. Failing to do so will resolve in breakage once the next major version is released.

If you see a new major version and have stopped sending deprecated messages, you can safely update. Else you need to do so ASAP as the backend will not answer you anymore!
