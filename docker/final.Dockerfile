# See the file "COPYING" in the main distribution directory for copyright.

# Final layer containing all artifacts.
FROM debian:12.5-slim

RUN echo 'Acquire::Retries "3";' > /etc/apt/apt.conf.d/80-retries

RUN apt-get -q update \
 && apt-get install -q -y --no-install-recommends \
     ca-certificates \
     git \
     libmaxminddb0 \
     libnode108 \
     libpython3.11 \
     libpcap0.8 \
     libssl3 \
     libuv1 \
     libz1 \
     python3-minimal \
     python3-git \
     python3-semantic-version \
     python3-websocket \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy over Zeek installation from build
COPY --from=zeek-build /usr/local/zeek /usr/local/zeek
ENV PATH "/usr/local/zeek/bin:${PATH}"
ENV PYTHONPATH "/usr/local/zeek/lib/zeek/python:${PYTHONPATH}"
