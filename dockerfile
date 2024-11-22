FROM ubuntu:24.04
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

COPY install.sh /app/install.sh
RUN apt-get update && \
    apt-get install -y sudo wget unzip dos2unix python3 && \
    apt-get clean

RUN dos2unix /app/install.sh
RUN chmod +x /app/install.sh

# wrapper that ensures volume is writable
RUN echo '#!/bin/bash\n\
mkdir -p /opt/xui\n\
chmod 777 /opt/xui\n\
if [ ! -f "/opt/xui/.installed" ]; then\n\
    echo "Y" | ./install.sh\n\
    touch /opt/xui/.installed\n\
else\n\
    echo "XUI already installed, starting service..."\n\
fi\n\
tail -f /dev/null' > /app/wrapper.sh && \
chmod +x /app/wrapper.sh

VOLUME ["/var/lib/mysql", "/opt/xui"]
ENTRYPOINT ["/app/wrapper.sh"]
