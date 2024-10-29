build:
	docker build -t my-tailscale:latest .

run:
	docker run -it --rm my-tailscale
