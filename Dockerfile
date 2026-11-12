FROM node:22-alpine AS base

WORKDIR /app

COPY package.json package-lock.json* bun.lock* ./
RUN npm ci || npm install

COPY . .

RUN npm run build

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD wget -qO- http://localhost:3000/api/health || exit 1

CMD ["npm", "run", "start"]
