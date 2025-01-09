.PHONY: curl-health-check
curl-health-check:
	curl -v http://127.0.0.1:8080/health_check; echo

.PHONY: curl-test-query
curl-test-query:
	curl -v -X POST \
		-H "Content-Type: application/x-www-form-urlencoded" \
		-d "name=joe%20miller&media=the%20expanse" \
		http://127.0.0.1:8080/query; echo


.PHONY: db-download-data
# download title.principals.tsv.gz (~650M compressed/~3.8G uncompressed),
# save the first 10k lines in a new file in ./data
db-download-data:
	curl https://datasets.imdbws.com/title.principals.tsv.gz \
		-o /tmp/title.principals.tsv.gz && \
	 gzip -d /tmp/title.principals.tsv.gz && \
	 head -n 10000 /tmp/title.principals.tsv | tee ./data/title.principals.tsv && \
	 rm /tmp/title.principals.tsv.gz

.PHONY: db-ingest-data
db-ingest-data:
	echo ingest data
