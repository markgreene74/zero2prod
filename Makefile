.PHONY: curl-health-check
curl-health-check:
	curl -v http://127.0.0.1:8080/health_check; echo

.PHONY: curl-test-query
curl-test-query:
	curl -v -X POST \
		-H "Content-Type: application/x-www-form-urlencoded" \
		-d "name=joe%20miller&media=the%20expanse" \
		http://127.0.0.1:8080/query; echo
