FROM alpine:3.9 as builder
RUN apk add --no-cache build-base
ADD endlessh.c Makefile /
RUN make


FROM alpine:3.9
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /endlessh /
ADD util/docker/default_config /etc/endlessh/config

EXPOSE 2222/tcp

USER appuser:appgroup
ENTRYPOINT ["/endlessh"]