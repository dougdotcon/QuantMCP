# Dockerfile para QuantMCP
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile

COPY . .

# Build do projeto (assumindo uso de TypeScript)
RUN pnpm run build || true

FROM node:20-alpine AS runner
WORKDIR /app

COPY --from=builder /app /app

ENV NODE_ENV=production

EXPOSE 3000

CMD ["pnpm", "start"] 