vagrant: 
	@cd infra/ && vagrant up

build: 
	vagrant scp ../golang-helloworld/ node03:/home/vagrant/
	vagrant ssh node03 'cd /home/hdpsvc/golang-helloword && docker build -t hello-v1 .'
	@echo 'belum'