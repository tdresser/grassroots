
ARG NODE_VERSION=23.0.0
FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
# ENV NODE_ENV=production

# --omit=dev

# Run the application as a non-root user.
ARG UNAME=grassroots_dev
ARG UID=1000
ARG GID=1000

WORKDIR /app

# First remove the node user to avoid uid/gid conflicts, then we create our user.
RUN deluser node \
    && addgroup -g ${GID} ${UNAME} \
    && adduser -G ${UNAME} -u ${UID} ${UNAME} -D

USER ${UNAME}


# Expose the port that the application listens on.
EXPOSE 5173

# Run the application.
# RUN --mount=type=bind,source=package.json,target=/app/package.json \
#RUN npm ci
#CMD ["npm", "run", "dev"]

COPY ./docker/grassroots-dev-fix-permissions.sh /app/grassroots-dev-fix-permissions.sh
ENTRYPOINT ["/bin/sh", "grassroots-dev-fix-permissions.sh", ${UID}]

CMD ["sleep", "infinity"]