FROM node:18.20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

######### Stage 2: Run the application ###########

FROM timbru31/node-chrome

WORKDIR /app

COPY --from=builder /app/dist /app/dist

COPY --from=builder /app/node_modules /app/node_modules

COPY --from=builder /app/package*.json /app/package*.json

EXPOSE 8014

CMD ["node", "dist/server.js"]



