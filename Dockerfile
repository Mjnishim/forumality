# https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile starter, latest node
FROM node:22-alpine3.21 AS base

FROM base AS deps
WORKDIR /app
COPY .npmrc ./
COPY package* ./
RUN npm ci

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_STANDALONE=1
RUN npm run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nextjs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder --chown=nextjs:nextjs /app/.next/standalone ./

# Next recommends that these go directly to CDN for actual prod deploy
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nextjs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3000
ENV PORT=3000

ENV HOSTNAME="0.0.0.0"
CMD ["node", "server.js"]