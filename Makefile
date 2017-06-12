DOCKER_TAG := ricty_generator
DOCKER_ENV :=
ifneq "$(origin RICTY_DISCORD_OPT)" "undefined"
	DOCKER_ENV += -e RICTY_DISCORD_OPT=$(RICTY_DISCORD_OPT)
endif

all: build
	docker run --rm -i -t -v $(PWD)/fonts:/ricty/fonts $(DOCKER_ENV) $(DOCKER_TAG)

build:
	docker build -t $(DOCKER_TAG) .
