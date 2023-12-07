SHELL := /bin/bash
.DEFAULT_GOAL := help
.PHONY: help
primary := '\033[1;36m'
err := '\033[0;31m'
bold := '\033[1m'
clear := '\033[0m'

-include .env
export $(shell sed 's/=.*//' .env)
-include .env.local
export $(shell sed 's/=.*//' .env.local)

ifndef TARGET
TARGET=http://localhost:3000
endif

ifndef FFUF_THREADS
FFUF_THREADS=40
endif

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

env:
	@echo -e $(bold)$(primary)TARGET$(clear) = $(TARGET)
	@echo -e $(bold)$(primary)FFUF_THREADS$(clear) = $(FFUF_THREADS)

dirs: ## /DIRFUZZ > .results/dirs.json
	ffuf -ic -ac -se -t $(FFUF_THREADS) \
		-r \
		-ignore-body \
		-recursion \
		-recursion-depth 4 \
		-of json -o .results/dirs.json \
		-u $(TARGET)/DIRFUZZ

urls: ## /PATHSBGFUZZ > .results/urls.json
	ffuf -ic -ac -se -t $(FFUF_THREADS) \
		-r \
		-ignore-body \
		-recursion \
		-recursion-depth 4 \
		-of json -o .results/urls.json \
		-u $(TARGET)/PATHSBGFUZZ

args-Bo0oM: ## /rest/user/login?ARGSBGFUZZ=1 > .results/args-Bo0oM.json
	 ffuf -ic -ac -t $(FFUF_THREADS) \
        -of json -o .results/args-Bo0oM.json \
        -u '$(TARGET)/rest/user/login?ARGSBGFUZZ=1'

args: ## /rest/user/login?ARGSSMFUZZ=1 > .results/args.json
	 ffuf -ic -ac -t $(FFUF_THREADS) \
        -of json -o .results/args.json \
        -u '$(TARGET)/rest/user/login?ARGSSMFUZZ=1'
	
sqli: ## /rest/products/search?q=BLINDSQLIFUZZ > .results/sqli.json
	 ffuf -ic -ac -se -t $(FFUF_THREADS) \
        -of json -o .results/sqli.json \
        -u '$(TARGET)/rest/products/search?q=BLINDSQLIFUZZ'

swagger: ## /OASFUZZ > .results/swagger.json
	 ffuf -ic -ac -se -t $(FFUF_THREADS) \
        -of json -o .results/swagger.json \
        -u '$(TARGET)/OASFUZZ'

login-leaks: ## WARN: uses breach data and will run for days on a laptop > .results/login-leaks.html
	@cat SecLists/Passwords/500-worst-passwords.txt \
		SecLists/Passwords/2020-200_most_used_passwords.txt \
		SecLists/Passwords/clarkson-university-82.txt \
		SecLists/Passwords/darkc0de.txt \
		SecLists/Passwords/darkweb2017-top10000.txt \
		SecLists/Passwords/Most-Popular-Letter-Passes.txt \
		SecLists/Passwords/probable-v2-top12000.txt \
		SecLists/Passwords/stupid-ones-in-production.txt \
		SecLists/Passwords/twitter-banned.txt \
		SecLists/Passwords/xato-net-10-million-passwords-1000000.txt \
		SecLists/Passwords/Common-Credentials/10k-most-common.txt \
		SecLists/Passwords/Common-Credentials/10-million-password-list-top-1000000.txt \
		SecLists/Passwords/Common-Credentials/100k-most-used-passwords-NCSC.txt \
		SecLists/Passwords/Common-Credentials/best1050.txt \
		SecLists/Passwords/Common-Credentials/common-passwords-win.txt \
		SecLists/Passwords/Common-Credentials/top-20-common-SSH-passwords.txt \
		SecLists/Passwords/Common-Credentials/top-passwords-shortlist.txt \
		SecLists/Passwords/Common-Credentials/worst-passwords-2017-top100-slashdata.txt \
		SecLists/Passwords/Default-Credentials/avaya_defaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/db2-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/default-passwords.txt \
		SecLists/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/mssql-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/oracle-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/postgres-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/telnet-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/vnc-betterdefaultpasslist.txt \
		SecLists/Passwords/Default-Credentials/windows-betterdefaultpasslist.txt \
		SecLists/Passwords/Honeypot-Captures/Sucuri-Top-Wordpress-Passwords.txt \
		SecLists/Passwords/Honeypot-Captures/wordpress-attacks-july2014.txt \
		SecLists/Passwords/Keyboard-Walks/Keyboard-Combinations.txt \
		SecLists/Passwords/Keyboard-Walks/walk-the-line.txt \
		SecLists/Passwords/Leaked-Databases/000webhost.txt \
		SecLists/Passwords/Leaked-Databases/adobe100.txt \
		SecLists/Passwords/Leaked-Databases/alleged-gmail-passwords.txt \
		SecLists/Passwords/Leaked-Databases/Ashley-Madison.txt \
		SecLists/Passwords/Leaked-Databases/bible.txt \
		SecLists/Passwords/Leaked-Databases/bible-withcount.txt \
		SecLists/Passwords/Leaked-Databases/carders.cc.txt \
		SecLists/Passwords/Leaked-Databases/elitehacker.txt \
		SecLists/Passwords/Leaked-Databases/elitehacker-withcount.txt \
		SecLists/Passwords/Leaked-Databases/faithwriters.txt \
		SecLists/Passwords/Leaked-Databases/faithwriters-withcount.txt \
		SecLists/Passwords/Leaked-Databases/fortinet-2021_clean-combos.txt \
		SecLists/Passwords/Leaked-Databases/fortinet-2021_passwords.txt \
		SecLists/Passwords/Leaked-Databases/fortinet-2021.txt \
		SecLists/Passwords/Leaked-Databases/fortinet-2021_users.txt \
		SecLists/Passwords/Leaked-Databases/hak5.txt \
		SecLists/Passwords/Leaked-Databases/hak5-withcount.txt \
		SecLists/Passwords/Leaked-Databases/honeynet2.txt \
		SecLists/Passwords/Leaked-Databases/honeynet.txt \
		SecLists/Passwords/Leaked-Databases/honeynet-withcount.txt \
		SecLists/Passwords/Leaked-Databases/hotmail.txt \
		SecLists/Passwords/Leaked-Databases/izmy.txt \
		SecLists/Passwords/Leaked-Databases/Lizard-Squad.txt \
		SecLists/Passwords/Leaked-Databases/md5decryptor-uk.txt \
		SecLists/Passwords/Leaked-Databases/muslimMatch.txt \
		SecLists/Passwords/Leaked-Databases/muslimMatch-withcount.txt \
		SecLists/Passwords/Leaked-Databases/myspace.txt \
		SecLists/Passwords/Leaked-Databases/myspace-withcount.txt \
		SecLists/Passwords/Leaked-Databases/NordVPN.txt \
		SecLists/Passwords/Leaked-Databases/phpbb-cleaned-up.txt \
		SecLists/Passwords/Leaked-Databases/phpbb.txt \
		SecLists/Passwords/Leaked-Databases/phpbb-withcount.txt \
		SecLists/Passwords/Leaked-Databases/porn-unknown.txt \
		SecLists/Passwords/Leaked-Databases/porn-unknown-withcount.txt \
		SecLists/Passwords/Leaked-Databases/singles.org.txt \
		SecLists/Passwords/Leaked-Databases/singles.org-withcount.txt \
		SecLists/Passwords/Leaked-Databases/tuscl.txt \
		SecLists/Passwords/Leaked-Databases/youporn2012.txt \
		SecLists/Passwords/Malware/conficker.txt \
		SecLists/Passwords/Malware/mirai-botnet.txt \
		SecLists/Passwords/Permutations/1337speak.txt \
		SecLists/Passwords/Permutations/korelogic-password.txt \
		SecLists/Passwords/Permutations/password-permutations.txt \
		SecLists/Passwords/WiFi-WPA/probable-v2-wpa-top4800.txt \
		SecLists/Passwords/xato-net-10-million-passwords-1000000.txt \
		>.tmp.passwords
	@cat SecLists/Usernames/cirt-default-usernames.txt \
		SecLists/Usernames/Honeypot-Captures/multiplesources-users-fabian-fingerle.de.txt \
		SecLists/Usernames/mssql-usernames-nansh0u-guardicore.txt \
		SecLists/Usernames/Names/familynames-usa-top1000.txt \
		SecLists/Usernames/Names/femalenames-usa-top1000.txt \
		SecLists/Usernames/Names/malenames-usa-top1000.txt \
		SecLists/Usernames/Names/names.txt \
		SecLists/Usernames/sap-default-usernames.txt \
		SecLists/Usernames/top-usernames-shortlist.txt \
		SecLists/Usernames/xato-net-10-million-usernames.txt \
		>.tmp.usernames
	ffuf -ic -ac -se -t $(FFUF_THREADS) \
        -of html -o .results/login-leaks.html \
		-request inputs/login-req.txt \
		-request-proto http \
		-mode clusterbomb \
		-w .tmp.usernames:USERFUZZ \
		-w .tmp.passwords:PASSFUZZ \
		-mc 200
	@rm .tmp.usernames .tmp.passwords

login:  ## WARN: demo, fuzzers are poor choice for this task > .results/login.html
	@cat SecLists/Passwords/500-worst-passwords.txt \
		SecLists/Passwords/Common-Credentials/100k-most-used-passwords-NCSC.txt \
		SecLists/Passwords/Common-Credentials/top-20-common-SSH-passwords.txt \
		SecLists/Passwords/Default-Credentials/default-passwords.txt \
		SecLists/Passwords/Keyboard-Walks/Keyboard-Combinations.txt \
		| sort -uf >.tmp.passwords
	@cat SecLists/Usernames/cirt-default-usernames.txt \
		SecLists/Usernames/Names/names.txt \
		SecLists/Usernames/top-usernames-shortlist.txt \
		| tr "[:upper:]" "[:lower:]" | sort -uf >.tmp.usernames
	ffuf -ic -ac -se -t $(FFUF_THREADS) \
        -of html -o .results/login.html \
		-request inputs/login-req.txt \
		-request-proto http \
		-mode clusterbomb \
		-w .tmp.usernames:USERFUZZ \
		-w .tmp.passwords:PASSFUZZ \
		-mc 200
	@rm .tmp.usernames .tmp.passwords

juiceshop: ## Runt he target OWASP Juice Shop app with podman
	podman run -d --restart=always -p 3000:3000 docker.io/bkimminich/juice-shop:v15.3.0

init: ## git stuff for submodule management
	git config --local diff.submodule log
	git config --local status.submoduleSummary true
	git submodule update --remote --merge
