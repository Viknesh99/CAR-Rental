# ── Stage 1: Build ──────────────────────────────────────────────────────────
FROM node:18-alpine AS builder

# API_URL is injected at build time via Railway service variable
ARG API_URL=http://localhost:8080

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

# Replace the placeholder URL with the real backend URL before building
RUN sed -i "s|http://localhost:8080|${API_URL}|g" src/environments/environment.prod.ts

RUN npm run build -- --configuration production

# ── Stage 2: Serve ───────────────────────────────────────────────────────────
FROM nginx:alpine

COPY --from=builder /app/dist/reatacar-angular /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
