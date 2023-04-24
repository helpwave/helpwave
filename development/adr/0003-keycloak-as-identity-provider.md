# ADR-003: Keycloak as Identity Provider

# Keycloak as Identity Provider

## Status

Accepted

## Context

We need to handle users and their organizations. Those users might want to login using different methods.

## Decision

We use [Keycloak](https://www.keycloak.org/documentation), an open-source, RedHat backed project to manage users and organizations. This means it stores user credentials as well as membership to organizations, which are implemented as Keycloak groups.


Keycloak should only be exposed for login purposes, all management should happen using our API from our services (mainly user-svc for now). Thus users do not have the KC permissions to update their own details. More on this in ADRs about Authorization to come.


For now we only support basic login using email/password.


The Authentication flow is described [here](https://wiki.helpwave.de/doc/keycloak-jedzCcERwF#h-authentication) on a more technical level.

## Consequences

KC supports federation, so other IdP can be added “behind” it easily. Keycloak also features a Policy Agent for Authorization, we should evaluate it for Authorization purposes.


