crypt:
	tar czf ./private.tgz ./inventory ./playbooks ./files
	openssl enc -e -base64 -pbkdf2 -aes-256-cbc -salt  -in ./private.tgz -out ./private.tgz.enc
	rm private.tgz
decrypt:
	openssl enc -d -base64 -pbkdf2 -aes-256-cbc -salt  -in ./private.tgz.enc -out ./private.tgz
	tar xzf ./private.tgz
	rm private.tgz
	rm private.tgz.enc

