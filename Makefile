app := web
run := docker-compose run --rm 
env := development
spec := spec

run:
	$(run) $(app) $(c)

fix_permissions:
	sudo chown -R $$USER:$$USER .

server_up:
	docker-compose up

install_gems:
	$(run) --entrypoint='' $(app) bundle install

open_console:
	$(run) $(app) rails c -e $(env)

open_sandbox_console:
	$(run) $(app) rails c -e $(env) --sandbox

test:
	$(run) $(app) rspec $(spec)

migrate_db:
	$(run) $(app) rake db:migrate

create_db:
	$(run) $(app) rake db:create

drop_db:
	$(run) $(app) rake db:drop

rollback_last_migration:
	$(run) $(app) rake db:rollback STEP=1

generate_model:
	$(run) $(app) rails g model $(m)
	make fix_permissions

destroy_model:
	$(run) $(app) rails d model $(m)
