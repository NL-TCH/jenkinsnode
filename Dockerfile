# use a node base image
FROM node

# set maintainer
LABEL maintainer "academy@release.works"
COPY . /usr/src/app
RUN npm install

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8000 || exit 1

# tell docker what port to expose
EXPOSE 8000
CMD ["npm start"]
