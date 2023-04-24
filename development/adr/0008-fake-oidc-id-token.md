# ADR-0008: Fake OIDC ID-Token


# **ADR-008: Fake OIDC ID-Token**

## Status

Propsed

## Context

To streamline the development process between front- and backend, we cannot and should not use our production Ory instance. 

We cannot because Ory wants us to use their `ory tunnel` or `ory proxy` to communicate with the Ory Network from a local environment. The communication gets blocked by CORS if we communicate directly with Ory, without `ory tunnel` or `ory proy`.

## Decision

`helpwave/services`

Provides an endpoint that issues JWTs in the OIDC ID-Token format with an expiration time of one day. The schema of the payload from the JWT is the same as our production ID-Token.

The authentication middleware of every `helpwave/services` service should check the development JWT before check against the OIDC provider. This behavior should be opt-in via an environment variable.

It should only be enabled in our staging environment.

We only accept the fake **OR** real (Ory) tokens.

`helpwave/web`

With a specific flag set in development mode, instead of redirecting the user to our OIDC-Provider, the frontend gets the ID-Token via the mentioned JWT endpoint, persists the token and redirects the user directly to the OAuth2 callback URL with the fake ID-Token attached. The callback page can then use this token, when the flag is set, instead of initiating the token exchange.

## Consequences

The development and integration between front- and backend becomes more streamlined. There is no sidecar or token manipulation in the frontend required (ID-Token issuer claim).

The flags that adopt the Fake-ID-Token behavior should only be enabled in combination with `env === dev`.
