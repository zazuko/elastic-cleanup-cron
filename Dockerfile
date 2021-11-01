FROM docker.io/library/alpine:3.14

ENV ELASTIC_INSTANCE=http://elasticsearch-master:9200

RUN apk add --no-cache curl grep
WORKDIR /app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

CMD [ "./entrypoint.sh" ]
