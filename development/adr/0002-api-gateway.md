# ADR-0002: API gateway

# Choose an API gateway

## Status

Accepted

## Context

We need some sort of API gateway in front of our microservice architecture that handles common tasks as ingress, authentication and rate-limiting.

## Decision

There are many open-source API gateways. We reduced the pool of API gateways down to a [few](https://landscape.cncf.io/card-mode?category=api-gateway&grouping=category) that are part of the CNCF (cloud native computing foundation). We preferred the API gateways, which we have heard about before. Our requirements were OIDC, GRPC-to-GRPC, open for extension via plugins and a first class Kubernetes support.

Since we are decided to run on GCP (Google Cloud Platform) there were three more options available. Google Cloud Endpoints, Google Cloud API Gateway and Google Cloud Apigee. Endpoints, no first class Kubernetes support, only via sidecars. API Gateway, S/PaaS solution, no Kubernetes support. Apigee, to expensive.

Based on our requirements, we compared the common API gateways and decided to use [APISIX](https://apisix.apache.org).

## Consequences

We can run APISIX in front of our microservices to fulfill our goal. Currently, none of the current team has been able to gain productive experience with APISIX. However, we should be able to build up this knowledge in the course of use.
