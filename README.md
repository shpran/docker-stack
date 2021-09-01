# Docker stack

## Images
* php:8.0.9-fpm
* nginx:1.21.1-alpine
* mysql:8.0.26
* redis:6.2.5-alpine
* swaggerapi/swagger-ui:v3.52.0

## Requirements
* docker
* docker-compose
* git

## Usage
1. Clone this repo to your local machine
2. Create an `app` directory and move necessary project inside. After this structure should be:
   ```
   docker-stack
   |____app
   |    |____... NECESSARY PROJECT FILES ...
   |
   |____config
   |    |____...
   |
   |____scripts
   |    |____...
   |
   |____...
   ```
3. Make a copy of `.env.example` file and name it `.env`
4. Configure all environment variables in `.env` file
5. Run `docker-compose build`
6. Run `docker-compose up -d`
7. Open `hosts` file and add new host `127.0.0.1 [PROJECT_NAME].docker.loc`. For example:
   ```
   127.0.0.1 test.docker.loc
   ```
8. Now you can open `https://[PROJECT_NAME].docker.loc` in your browser.

## Environment variables:
| Variable | Example | Default |
| -------- | ------- | ------- |
| CONTAINER_PREFIX | local | - |
| PROJECT_NAME | test | - |
| TIMEZONE | Europe/Minsk | - |
| GITHUB_USER | user | - |
| GITHUB_TOKEN | token | - |
| GITHUB_EMAIL | test@test.com | - |
| GITHUB_NAME | "Name Surname" | - |
| XDEBUG_CLIENT_HOST | 192.168.1.1 | - |
| MYSQL_ROOT_PASSWORD | root | root |
| MYSQL_USER | dev | dev |
| MYSQL_PASSWORD | dev | dev |
| MYSQL_DATABASE | test_dev | ${PROJECT_NAME}_dev |

## How to access containers
Use the following command to access your containers: `docker exec -it [CONTAINER_PREFIX]_[container_type] [bash|sh]`.  
`container_type` means `php|nginx|mysql|redis|swagger` - you can find them inside your `docker-compose` file as a second part of `container_name` section.

Example:
```shell
docker exec -it local_php bash
docker exec -it local_nginx sh
docker exec -it local_mysql bash
docker exec -it local_redis sh
docker exec -it local_swagger sh
```  
