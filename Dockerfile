################################################
#
#
#
#
#
################################################

FROM				ehudkaldor/alpine-s6:latest
MAINTAINER	Ehud Kaldor <ehud@unfairfunction.org>

# RUN					echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
						# apk add --update gnupg curl confd


RUN					apk add --update \
 							python3 \
							python3-dev \
							curl \
							g++ \
							make \
							automake \
							autoconf \
							libtool \
							bison \
							swig \
							linux-headers && \
						curl https://managedway.dl.sourceforge.net/project/cmusphinx/sphinxbase/5prealpha/sphinxbase-5prealpha.tar.gz -o sphinx.tar.gz && \
						tar -zxvf sphinx.tar.gz && \
						cd sphinxbase-5prealpha && \
						./autogen.sh && \
						make && \
						make check && \
						make install && \
						cd ../ && \
						curl https://iweb.dl.sourceforge.net/project/cmusphinx/pocketsphinx/5prealpha/pocketsphinx-5prealpha.tar.gz -o pocketsphinx.tar.gz && \
						tar -zxvf pocketsphinx.tar.gz && \
						cd pocketsphinx-5prealpha && \
						./autogen.sh && \
						make && \
						make check && \
						make install && \
						rm -rf /tmp/* && \
						rm -rf /var/cache/apk/*

# COPY				rootfs /

ENTRYPOINT	["/init"]
