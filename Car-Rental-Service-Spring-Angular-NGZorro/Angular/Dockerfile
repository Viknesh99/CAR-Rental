# ── Stage 1: Build ──────────────────────────────────────────────────────────
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build -- --configuration production

# ── Stage 2: Serve ───────────────────────────────────────────────────────────
FROM nginx:alpine

COPY --from=builder /app/dist/reatacar-angular /usr/share/nginx/html

# The official nginx image automatically runs envsubst on *.template files
# in /etc/nginx/templates/ and writes the result to /etc/nginx/conf.d/
# This injects BACKEND_URL at container start time (no rebuild needed).
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
