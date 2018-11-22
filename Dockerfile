################################################
#
#
#
#
#
################################################

FROM				ehudkaldor/alpine-s6:latest
MAINTAINER	Ehud Kaldor <ehud@unfairfunction.org>

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
              alsa-lib-dev \
              pulseaudio-alsa \
              pulseaudio-dev \
							linux-headers && \
						curl https://managedway.dl.sourceforge.net/project/cmusphinx/sphinxbase/5prealpha/sphinxbase-5prealpha.tar.gz -o sphinx.tar.gz && \
						tar -zxvf sphinx.tar.gz && \
            rm -rf sphinx.tar.gz && \
						cd sphinxbase-5prealpha && \
						./autogen.sh && \
						make && \
						make check && \
						make install && \
						cd / && \
            rm -rf /sphinxbase-5prealpha && \
						curl https://iweb.dl.sourceforge.net/project/cmusphinx/pocketsphinx/5prealpha/pocketsphinx-5prealpha.tar.gz -o pocketsphinx.tar.gz && \
						tar -zxvf pocketsphinx.tar.gz && \
            rm -rf pocketsphinx.tar.gz && \
						cd pocketsphinx-5prealpha && \
						./autogen.sh && \
						make && \
						make check && \
						make install && \
            cd / && \
            rm -rf /pocketsphinx-5prealpha && \
            pip3 install -U pip && \
            pip install -U pocketsphinx && \
						rm -rf /tmp/* && \
						rm -rf /var/cache/apk/*

# COPY				rootfs /

ENTRYPOINT	["/init"]
