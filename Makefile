crypt:
	tar czf ./private.tgz ./inventory ./playbooks
	openssl enc -e -base64 -pbkdf2 -aes-256-cbc -salt  -in ./private.tgz -out ./private.tgz.enc
	rm private.tgz

