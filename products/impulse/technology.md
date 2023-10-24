# Technology

## Frontend

The frontend should be built with the Flutter framework and Dart programming language. This combination is well known in the helpwave community so that there should be no problem with adapting to this domain.

## Backend

For the backend a possibility would be Django. This framework is wildly adopted in the Python community for building production ready web apps and APIs. The Django Admin interface could be utilized as a Dashboard to create and manage the content of the app. For the API a GraphQL extension should be used to optimize the communication between Django and the app.
> To futureproof this concept a gRPC extension should be added which is more build to fit with Django. This could be achieved by utilizing async behaviour or threads to integrate in Django.  

The other possibility would be to create a go app based on the knowledge the helpwave team has build up from task. If this is used gRPC could also be used for the frontend but his is not recommended. The other solution would be to also adapt GraphQL in Go for the communication. In addition to Django there is the need for a standalone Dashboard for content creation and management.  

### Auth

For authentication Ory should be used with federation enabled so that a user is able to login via google, apple, or other OIDC Provider.
