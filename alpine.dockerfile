FROM alpine
RUN apk --no-cache add \
	bash \
	util-linux \
	curl \
	jq
COPY lib /root/vmc
RUN ln -s /root/vmc/drv.core /usr/bin/vmc
RUN mkdir -p /cfg
ENV SDDCDIR "/cfg"
ENTRYPOINT ["vmc"]
