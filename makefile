
include .docker/.env.docker

USER_UID=`id -u`
AS_LOCAL_USER=-u $(USER_UID)
ENV_FILES=--env-file `pwd`/.docker/.env.application
SOURCES_MAPPING=-v `pwd`:/var/www/html
WITH_FLAGS=--rm $(ENV_FILES) $(SOURCES_MAPPING) --network=chatbot-private --env POSTGRES_URL=$(POSTGRES_URL)

POSTGRES_URL=postgres://postgres:postgres@postgres-chatbot:5432/postgres


init:
	./bin/create-internal-net.sh chatbot-private
	docker run $(AS_LOCAL_USER) $(WITH_FLAGS) $(NODE_IMAGE) bash -c "pnpm i && pnpm db:generate && pnpm db:migrate"

start:
	./bin/create-internal-net.sh chatbot-private
	docker compose -p $(PROJECT_NAME) -f .docker/docker-compose.yml --env-file .docker/.env.application --env-file .docker/.env.docker up

stop:
	docker compose -p $(PROJECT_NAME) -f .docker/docker-compose.yml --env-file .docker/.env.application --env-file .docker/.env.docker down
	./bin/remove-internal-net.sh chatbot-private

restart:
	make stop
	make start

run:
	./bin/create-internal-net.sh chatbot-private
	docker run -it  $(AS_LOCAL_USER) $(WITH_FLAGS) $(NODE_IMAGE) bash
