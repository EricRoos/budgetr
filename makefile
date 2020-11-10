build:
	docker build . --build-arg RAILS_MASTER_KEY=${BUDGETRENCKEY} -f Dockerfile -t budgetr
run:
	docker run -p 4000:3000 -e RAILS_MASTER_KEY=${BUDGETRENCKEY} --rm -ti budgetr:latest
bash:
	docker run -e RAILS_MASTER_KEY=${BUDGETRENCKEY} --rm -ti budgetr:latest bash
prod_console:
	docker run -e RAILS_MASTER_KEY=${BUDGETRENCKEY} --rm -ti ericroos13/budgetr:latest bundle exec rails c
create_db:
	docker run -e RAILS_MASTER_KEY=${BUDGETRENCKEY} --rm -ti budgetr:latest bundle exec rake db:create
migrate_db:
	docker run -e RAILS_MASTER_KEY=${BUDGETRENCKEY} --rm -ti budgetr:latest bundle exec rake db:migrate
push_image:
	docker tag budgetr:latest ericroos13/budgetr && docker tag budgetr:latest ericroos13/budgetr && docker push ericroos13/budgetr
deploy:
	ssh Budgetr /home/ec2-user/deploy.sh
circle_ci_deploy:
	ssh ec2-user@54.224.120.0 /home/ec2-user/deploy.sh
deploy_pipeline:
	make build push_image migrate_db deploy
circleci_deploy_pipeline:
	make build push_image migrate_db circle_ci_deploy
edit_prod_secret:
	EDITOR=vim bundle exec rails credentials:edit --environment production

