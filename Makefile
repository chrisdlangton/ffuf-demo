
TARGET=http://localhost:3000

dirs:
	ffuf \
		-w SecLists/Discovery/Web-Content/dirsearch.txt \
		-u $(TARGET)/FUZZ

urls:
	ffuf \
		-w SecLists/Discovery/Web-Content/big.txt \
		-of json -o .results/urls.json \
		-u $(TARGET)/FUZZ

args-Bo0oM:
	 ffuf \
        -w SecLists/Fuzzing/fuzz-Bo0oM.txt \
        -of json -o .results/args-Bo0oM.json \
        -u 'http://localhost:3000/rest/user/login?FUZZ=1'

args:
	 ffuf \
        -w wordlists/parameters.txt \
        -of json -o .results/args.json \
        -u 'http://localhost:3000/rest/user/login?FUZZ=1'

login:
	@cat SecLists/Passwords/*.txt \
		SecLists/Passwords/**/*.txt \
		>.tmp.passwords
	@cat SecLists/Usernames/*.txt \
		SecLists/Usernames/**/*.txt \
		>.tmp.usernames
	ffuf \
        -of html -o .results/args.html \
		-request inputs/login-req.txt \
		-request-proto http \
		-mode clusterbomb \
		-w .tmp.usernames:USERFUZZ \
		-w .tmp.passwords:PASSFUZZ \
		-mc 200
	@rm .tmp.usernames .tmp.passwords

juiceshop:
	podman run -d --restart=always -p 3000:3000 docker.io/bkimminich/juice-shop:v15.3.0

init:
	git config --local diff.submodule log
	git config --local status.submoduleSummary true
	git submodule update --remote --merge
