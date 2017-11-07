# Datadog Docker Agent Rootless

We faced a huge challenge using a managed service PaaS where we couldn't run our containers as `root` and needed to run as `USER 1001`, `USER nobody` or some other non privileged user.  I was able to get this working and hope that it may be of use to other people facing the same dilema.

## Getting Started

There are a few scripts to help test this configuration out.  The first thing you will need to do is set the following to an actual api key either in the Dockerfile, the docker-compose.yml or via your PaaS environment variable settings. 

`API_KEY=xxxxxxxxxxxxxx`

Refer to the information located at the following for more details as this image extends this base: https://github.com/DataDog/docker-dd-agent

### Docker

To build the image you can use run the `./build.sh` script to get you started or simply run some variant of the following command that meets your needs `docker build -t dd-docker-rootless .`

### Docker Compose

To run using docker compose simply run the `./run.sh` script to get you started or simply run some variant of the following command that meets your needs `docker-compose up`

### OpenShift v3

When deploying your container from a PaaS like OpenShift, make sure to set something like the following in your deployment configuration

```yml
# ...
	env:
		-
			name: API_KEY
			value: xxxxxxxx
		-
			name: DD_HOSTNAME
			value: optional_custom_name
		-
			name: DD_TAGS
			value: custom:foo,bar,baz,environment:demo 
		# ...
# ...
``` 




 