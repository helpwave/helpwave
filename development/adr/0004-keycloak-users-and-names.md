# ADR-0004: Keycloak, Users and Names

## Status

Accepted

## Context

Names are a complex topic and we want people to be able use their preferred name (*nickname*) additionally to the *fullName*.


Keycloak however only understands *firstName* and *lastName*.


## Decision

We use the convention `kc.firstName = nickname` and `kc.lastName = fullName`.
