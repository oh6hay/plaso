build:
	docker build -t log2timeline/plaso .

push:
	docker tag log2timeline/plaso:latest ${REGISTRY}/log2timeline/plaso:latest
	docker push ${REGISTRY}/log2timeline/plaso
