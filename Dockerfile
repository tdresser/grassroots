
ARG NODE_VERSION=23.0.0
FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
# ENV NODE_ENV=production

WORKDIR /app

# --omit=dev

# Run the application as a non-root user.
USER node

# Expose the port that the application listens on.
EXPOSE 5173

# Run the application.
# RUN --mount=type=bind,source=package.json,target=/app/package.json \
#RUN npm ci
#CMD ["npm", "run", "dev"]
CMD ["sleep", "infinity"]