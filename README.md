# Runa Test

Ruby on Rails project for Runa Backend Test

## Requirements

This project is wrapped with Docker containers use Docker Compose as orchestrator.
If you want to use this project with containers, you have to use

* Docker
* Docker Compose

This project was builded with

* Ruby 2.5
* Ruby on Rails 5.1

## Starting Up

If you use Docker and Docker Compose you only have to:
* First you have to copy `dev.env` file to `.env` over the root folder
* Then you have to run `docker-compose up` for starting the project. This command will download the docker images for the project and start Webrick server over 3000 host port. If you want set another port you have to change over `.env` file, the name of this variable is `RAILS_PORT`
* During this setup you can see the logs of the project, once you see that Webrick is available on 3000 the project is ready on `localhost:$RAILS_PORT` by default `localhost:3000`

## Access
This project was documented with Swagger 2. You can access to this doc on `localhost:3000/api/v1/swagger` or `https://runa.ripperon.com`
The default access for this project are:

* Admin
  * **email**: *admin@runa.test*
  * **password**: *12345678*
* Employee
  * **email**: *employee@runa.test*
  * **password**: *12345678* *
