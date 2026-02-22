# Build stage
FROM node:20-alpine AS build
WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm install

# Copy source
COPY . .

# Build Next.js app
RUN npm run build

# Runtime stage
FROM node:20-alpine
WORKDIR /app

# Copy only what we need
COPY --from=build /app/package*.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public

EXPOSE 3000

CMD ["npm", "run", "start"]