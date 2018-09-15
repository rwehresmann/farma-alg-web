APP := web
RUN := docker-compose run --rm 
ENV := development

install_gems:
	$(RUN) --entrypoint='' $(APP) bundle install

server_up:
	docker-compose up

show_console:
	$(RUN) $(APP) rails c -e $(ENV)

migrate_db:
	$(RUN) $(APP) rake db:migrate

create_db:
	$(RUN) $(APP) rake db:create

drop_db:
	$(RUN) $(APP) rake db:drop

run:
	$(RUN) $(APP) $(c)
