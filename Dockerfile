# use a node base image
FROM hypriot/rpi-node

# set maintainer
LABEL maintainer "dev@teunis.dev"

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
#            CMD curl -f http://172.17.0.1:8000 || exit 1
            CMD  exit 1

# tell docker what port to expose
EXPOSE 8000
