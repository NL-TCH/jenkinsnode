# use a node base image
FROM hypriot/rpi-node

# set maintainer
LABEL maintainer "academy@release.works"

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
#            CMD curl -f http://127.0.0.1:8000 || exit 1
            CMD exit 1

EXPOSE 8000
CMD [ "npm", "start" ]
