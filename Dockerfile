
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

# We need to make these before we mount them to make sure the permissions are correct.
RUN mkdir node_modules && chown ${UNAME} node_modules && \
    mkdir grassroots-frontend && mkdir grassroots-backend && \
    mkdir grassroots-frontend/node_modules && chown ${UNAME} grassroots-frontend/node_modules && \
    mkdir grassroots-backend/node_modules && chown ${UNAME} grassroots-backend/node_modules &&\
    mkdir grassroots-frontend/dist && chown ${UNAME} grassroots-frontend/dist && \
    mkdir grassroots-backend/dist && chown ${UNAME} grassroots-backend/dist

USER ${UNAME}

# Vite
EXPOSE 5173
# Nest
EXPOSE 3003

RUN --mount=type=bind,source=.,target=/app/ \
  npm ci && cd grassroots-frontend && npm ci && cd ../grassroots-backend && npm ci

CMD ["npm", "run", "dev"]

# CMD ["sleep", "infinity"]