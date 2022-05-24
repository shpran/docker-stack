# Docker stack

## Images
* php:8.1.6-fpm
* nginx:1.21.6-alpine
* mysql:8.0.29
* redis:7.0.0-alpine
* swaggerapi/swagger-ui:v4.11.1
* mailhog/mailhog:v1.0.1

## Requirements
* docker
* docker-compose
* git

## Usage
1. Clone this repository to your local machine and go inside:
   ```shell
   git clone https://github.com/shpran/docker-stack && cd docker-stack
   ```
2. Create an `app` directory:
   ```shell
   mkdir app
   ```
   Further you can store your symfony project inside this `app` folder.
3. Make a copy of `.env.example` file and name it `.env`:
   ```shell
   cp .env.example .env
   ```
4. Configure all environment variables in `.env` file
5. Install [mkcert](https://github.com/FiloSottile/mkcert#installation)
6. Execute the following command to generate certificates:
   ```shell
   ./scripts/gencerts.sh
   ```
7. Create a network:
   ```shell
   docker network create [PROJECT_NAME]
   ```
9. Build and run docker containers:
   ```shell
   docker compose build && docker compose up -d
   ```
10. Open `hosts` file and add new host `127.0.0.1 [PROJECT_NAME].docker.loc`. For example:
    ```
    127.0.0.1 test.docker.loc
    ```
11. Now you can open `https://[PROJECT_NAME].docker.loc:[NGINX_SSL_PORT]` in your browser.

## Environment variables:
| Variable            | Example                                | Default         |
|---------------------|----------------------------------------|-----------------|
| CONTAINER_PREFIX    | local                                  | -               |
| PROJECT_NAME        | test                                   | -               |
| TIMEZONE            | Europe/Minsk                           | -               |
| GITHUB_USER         | user                                   | -               |
| GITHUB_TOKEN        | token                                  | -               |
| GITHUB_EMAIL        | test@test.com                          | -               |
| GITHUB_NAME         | "Name Surname"                         | -               |
| XDEBUG_CLIENT_HOST  | 192.168.100.1                          | -               |
| NGINX_PORT          | 10080                                  | 80              |
| NGINX_SSL_PORT      | 10443                                  | 443             |
| MYSQL_ROOT_PASSWORD | root                                   | root            |
| MYSQL_USER          | dev                                    | dev             |
| MYSQL_PASSWORD      | dev                                    | dev             |
| MYSQL_DATABASE      | dev                                    | dev             |
| MYSQL_PORT          | 13306                                  | 3306            |
| MAILHOG_PORT        | 18025                                  | 8025            |
| SMTP_PORT           | 11025                                  | 1025            |
| SMTP_HOSTNAME       | mailhog.example                        | mailhog.example |
| SWAGGER_API_URL     | https://test.docker.loc:10443/api.yaml | -               |
| SWAGGER_PORT        | 17000                                  | 7000            |

## How to access containers
Use the following command to access your containers:
```shell
docker compose exec [container] [bash|sh]
```
or this command, if you are trying to access containers outside the docker-project directory:
```shell
docker exec -it [CONTATINER_PREFIX]_[container] [bash|sh]
```

## Xdebug
The functionality only gets activated when a specific trigger is present when the request starts.  
The name of the trigger is `XDEBUG_TRIGGER`, and Xdebug checks for its presence in either `$_ENV` (environment variable),
`$_GET` or `$_POST` variable, or `$_COOKIE` (HTTP cookie name).  
Also, you can set environment variable directly on the server:
```shell
export XDEBUG_TRIGGER=1
```
Or remove it:
```shell
unset XDEBUG_TRIGGER
```

The recommended way to initiate a debugging session is by configuring your IDE to accept incoming debugging  
connections, and then use a browser extension which sets the right trigger cookie.

### Browser Extension Initiation
The extensions are:
* [Xdebug Helper for Firefox](https://addons.mozilla.org/en-GB/firefox/addon/xdebug-helper-for-firefox/) ([source](https://github.com/BrianGilbert/xdebug-helper-for-firefox)).
* [Xdebug Helper for Chrome](https://chrome.google.com/extensions/detail/eadndfjplgieldjbigjakmdgkmoaaaoc) ([source](https://github.com/mac-cain13/xdebug-helper-for-chrome)).
* [XDebugToggle for Safari](https://apps.apple.com/app/safari-xdebug-toggle/id1437227804?mt=12) ([source](https://github.com/kampfq/SafariXDebugToggle)).

Each extension adds an icon to your browser where you can select which functionality you want to trigger.  
Xdebug will continue to start debugging for every request as long as the debug toggle has been enabled.

## Swagger OpenAPI
### How to access Swagger OpenAPI
To access it go to `http://localhost:[SWAGGER_PORT]`.
