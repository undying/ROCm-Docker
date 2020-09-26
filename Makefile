
NAME := ai
IMAGE := pytorch:local

DOCKER_CMD := docker run \
			-it --rm \
			--name $(NAME) \
			--network=host \
			--ipc=host \
			--shm-size 16G \
			--device=/dev/kfd \
			--device=/dev/dri \
			--group-add video \
			--cap-add=SYS_PTRACE \
			--security-opt seccomp=unconfined \
			--workdir=/data \
			-v ${PWD}/data:/data \
			$(IMAGE)

%:
	$(DOCKER_CMD) $@

exec:
	docker exec -it $(NAME) bash

jupyter:
	$(DOCKER_CMD) /root/anaconda3/bin/jupyter notebook \
				--notebook-dir=/data \
				--allow-root --port=8889

pytorch:
	docker build \
		-t $@:local \
		-f Dockerfile.$@ .

