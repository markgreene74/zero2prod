.PHONY: curl-health-check
curl-health-check:
	curl -v http://127.0.0.1:8080/health_check; echo

.PHONY: curl-test-query
curl-test-query:
	curl -v -X POST \
		-H "Content-Type: application/x-www-form-urlencoded" \
		-d "name=joe%20miller&media=the%20expanse" \
		http://127.0.0.1:8080/query; echo

# create tables on the database
.PHONY: db-create-tables
db-create-tables:
	docker exec -it zero2prod-db-1 \
		psql -U postgres -f /var/tmp/data-ingestion/create-tables.sql

# download title.basics.tsv
.PHONY: db-download-title-basics
db-download-title-basics:
	exit 0; \
	curl https://datasets.imdbws.com/title.basics.tsv.gz \
		-o ./data/title.basics.tsv.gz && \
	 gzip -d ./data/title.basics.tsv.gz

# fix title.basics.tsv
.PHONY: db-fix-title-basics
db-fix-title-basics:
	sed -i "s/\"/'/g" ./data/title.basics.tsv

# ingest title.basics.tsv, clean up the table afterwards
# and finally remove the tsv file
.PHONY: db-ingest-title-basics
db-ingest-title-basics:
	exit 0; \
	docker exec -it zero2prod-db-1 \
		psql -U postgres -f /var/tmp/data-ingestion/ingest-title-basics.sql && \
	rm ./data/title.basics.tsv

# download name.basics.tsv
.PHONY: db-download-name-basics
db-download-name-basics:
	exit 0; \
	curl https://datasets.imdbws.com/name.basics.tsv.gz \
		-o ./data/name.basics.tsv.gz && \
	 gzip -d ./data/name.basics.tsv.gz

# ingest name.basics.tsv, clean up the table afterwards
# and finally remove the tsv file
.PHONY: db-ingest-name-basics
db-ingest-name-basics:
	exit 0; \
	docker exec -it zero2prod-db-1 \
		psql -U postgres -f /var/tmp/data-ingestion/ingest-name-basics.sql && \
	rm ./data/name.basics.tsv

# download title.principals.tsv.gz
.PHONY: db-download-title-principal
db-download-title-principal:
	exit 0; \
	curl https://datasets.imdbws.com/title.principals.tsv.gz \
		-o ./data/title.principals.tsv.gz && \
	 gzip -d ./data/title.principals.tsv.gz

# ingest title.principals.tsv, clean up the table afterwards
# and finally remove the tsv file
.PHONY: db-ingest-title-principal
db-ingest-title-principal:
	exit 0; \
	docker exec -it zero2prod-db-1 \
		psql -U postgres -f /var/tmp/data-ingestion/ingest-title-principal.sql && \
	rm ./data/title.principals.tsv

.PHONY: db-ingest-data
db-ingest-data: db-create-tables \
		db-download-title-basics db-fix-title-basics db-ingest-title-basics \
		db-download-name-basics db-ingest-name-basics \
		db-download-title-principal db-ingest-title-principal

.PHONY: db-clean-up
db-clean-up:
	docker exec -it zero2prod-db-1 \
		psql -U postgres -f /var/tmp/data-ingestion/clean-up.sql
