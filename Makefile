
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
        -w SecLists/Discovery/Web-Content/uri-from-top-55-most-popular-apps.txt \
        -of json -o .results/args.json \
        -u 'http://localhost:3000/rest/user/login?FUZZ=1'
	
sqli:
	 ffuf \
        -w SecLists/Fuzzing/SQLi/Generic-BlindSQLi.fuzzdb.txt \
        -of json -o .results/sqli.json \
        -u 'http://localhost:3000/rest/products/search?q=FUZZ'

swagger:
	 ffuf \
        -w SecLists/Discovery/Web-Content/swagger.txt \
        -of json -o .results/swagger.json \
        -u 'http://localhost:3000/FUZZ'

login-leaks:
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
	ffuf \
        -of html -o .results/login-leaks.html \
		-request inputs/login-req.txt \
		-request-proto http \
		-mode clusterbomb \
		-w .tmp.usernames:USERFUZZ \
		-w .tmp.passwords:PASSFUZZ \
		-mc 200
	@rm .tmp.usernames .tmp.passwords

login:
	@cat SecLists/Passwords/500-worst-passwords.txt \
		SecLists/Passwords/2020-200_most_used_passwords.txt \
		SecLists/Passwords/Common-Credentials/100k-most-used-passwords-NCSC.txt \
		SecLists/Passwords/Common-Credentials/best1050.txt \
		SecLists/Passwords/Common-Credentials/common-passwords-win.txt \
		SecLists/Passwords/Common-Credentials/top-20-common-SSH-passwords.txt \
		SecLists/Passwords/Common-Credentials/top-passwords-shortlist.txt \
		SecLists/Passwords/Common-Credentials/worst-passwords-2017-top100-slashdata.txt \
		SecLists/Passwords/Default-Credentials/default-passwords.txt \
		SecLists/Passwords/Keyboard-Walks/Keyboard-Combinations.txt \
		SecLists/Passwords/Keyboard-Walks/walk-the-line.txt \
		SecLists/Passwords/Permutations/1337speak.txt \
		SecLists/Passwords/Permutations/korelogic-password.txt \
		SecLists/Passwords/Permutations/password-permutations.txt \
		| sort | uniq >.tmp.passwords
	@cat SecLists/Usernames/cirt-default-usernames.txt \
		SecLists/Usernames/Names/familynames-usa-top1000.txt \
		SecLists/Usernames/Names/femalenames-usa-top1000.txt \
		SecLists/Usernames/Names/malenames-usa-top1000.txt \
		SecLists/Usernames/Names/names.txt \
		SecLists/Usernames/sap-default-usernames.txt \
		SecLists/Usernames/top-usernames-shortlist.txt \
		| sort | uniq >.tmp.usernames
	ffuf \
        -of html -o .results/login.html \
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
