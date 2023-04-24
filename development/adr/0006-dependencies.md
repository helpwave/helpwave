# ADR-0006: Dependencies

# **Dependencies**

## Status

Accepted

## Context

To keep up with upcoming version of used third-party dependencies in our repositories. We should use tooling around dependency management. These tools should automagically create pull requests against our repositories with the new versions of the dependencies addressed. Right now, our CI already fails at build issues. Therefore, dependency related pull requests should also be reviewed.

There are many tools that address these issues. The two major one are

* [Renovate](https://docs.renovatebot.com)
* [Dependabot](https://github.com/dependabot)

## Decision

~~Adopting Dependabot in all of our repositories where we need to manage dependencies. Dependabot seams to be a good fit because it runs natively on GitHub and has some good standards, not much setup and configuration needs to be done.~~

With [helpwave/web/pull/214](https://github.com/helpwave/web/pull/214) we migrated from Dependabot to renovate. As already said, the standards were good, but Dependabot does not support pnpm and grouped pull requests per directory.

## Consequences

The semi-automatic process (notify / pull request / review / merge) as mentioned in [Context](https://wiki.helpwave.de/doc/adr-006-dependencies-sRkR9XMjdg#h-context) is made possible by this decision. Because of the low integration effort and vendor-lock-in, these decision should not influence further decisions about dependency management.

In the future, we must be more strict about security best-practices around third-party dependencies and should not only on versioning. 
