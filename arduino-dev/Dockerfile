# Arduino
FROM ros:indigo-rosserial-arduino

MAINTAINER Lionel ATTY <lionel.atty@ign.fr>

WORKDIR /root/

COPY run.sh /root/run.sh
COPY entry-point.sh /root/entry-point.sh
RUN chmod +x /root/*.sh

# CMD ["/root/run.sh"]
# ENTRYPOINT ["/root/entry-point.sh"]
