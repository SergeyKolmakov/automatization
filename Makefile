install:
	npm install
	composer install
	composer update

start:
	sudo service nginx restart

logs:
	sudo tail -f /var/log/upstart/webserver.log

test:
	/vendor/.bin/phpunit 

deploy: test
	ansible-playbook deploy.yml -i $(E) -u $(U) -v

# make deploy E=production U=ubuntu

retry:
	for i in {1..5}; do $(CMD) && break \
	||sleep 3; done

# if task have same name as directory
.PHONY: test log