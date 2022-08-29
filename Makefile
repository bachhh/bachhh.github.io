JEKYLL_VERSION=3.8
DOCKER_IMAGE=jekyll/builder

# check if podman is installed, podman takes precedent over docker
DOCKER_COMMAND ?=$(shell type -p podman 2>&1 >/dev/null && echo podman || echo docker)

chown:
	sudo rm -rf .jekyll-cache; mkdir -p .jekyll-cache; 

build: chown
	${DOCKER_COMMAND} run -it --rm --volume="$(PWD):/srv/jekyll:z" \
		-u root \
		jekyll/jekyll jekyll build; \
	sudo chown -R bach:bach ./

test: chown
	${DOCKER_COMMAND} run -it --rm --volume="$(PWD):/srv/jekyll:z" \
		-u root \
		jekyll/jekyll /bin/bash


serve:
	${DOCKER_COMMAND} run -it --rm --volume="$(PWD):/srv/jekyll:Z" \
		-u root \
		-p 4000:4000/tcp jekyll/jekyll jekyll serve
