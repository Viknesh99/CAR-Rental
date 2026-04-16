# ── Stage 1: Build ──────────────────────────────────────────────────────────
FROM node:18-alpine AS builder

# Build configuration: "docker" (fast, low-resource) or "production" (full AOT)
ARG BUILD_CONFIG=docker

WORKDIR /app

# Copy dependency manifests first for better Docker layer caching.
# npm ci only re-runs when package*.json changes.
COPY package*.json ./
RUN npm ci

# Copy source code (changes here don't invalidate the npm ci layer)
COPY . .

# Cap Node heap to 512 MB so the build doesn't OOM on small instances
ENV NODE_OPTIONS="--max-old-space-size=512"

RUN npx ng build --configuration ${BUILD_CONFIG}

# ── Stage 2: Serve ───────────────────────────────────────────────────────────
FROM nginx:alpine

COPY --from=builder /app/dist/reatacar-angular /usr/share/nginx/html

# The official nginx image automatically runs envsubst on *.template files
# in /etc/nginx/templates/ and writes the result to /etc/nginx/conf.d/
# This injects BACKEND_URL at container start time (no rebuild needed).
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
