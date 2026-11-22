ARG NODE_VERSION=20-alpine

FROM node:${NODE_VERSION} AS frontend-builder

WORKDIR /app

COPY package.json package-lock.json ./
COPY frontend/package.json frontend/package-lock.json ./frontend/

RUN npm ci
RUN npm ci --prefix frontend

COPY frontend/ ./frontend
RUN npm run build --prefix frontend


FROM node:${NODE_VERSION} AS backend-dependencies
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev


FROM node:${NODE_VERSION} AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=5000

COPY package.json package-lock.json ./
COPY --from=backend-dependencies /app/node_modules ./node_modules
COPY backend ./backend
COPY --from=frontend-builder /app/frontend/dist ./frontend/dist

USER node

EXPOSE 5000

CMD ["node", "backend/server.js"]