FROM ubuntu
RUN apt-get -y update \
	&& apt-get -y install \
	bsdmainutils \
	util-linux \
	curl \
	jq
COPY lib /root/vmc
RUN ln -s /root/vmc/drv.core /usr/bin/vmc
RUN mkdir -p /cfg
ENV SDDCDIR "/cfg"
ENTRYPOINT ["vmc"]
