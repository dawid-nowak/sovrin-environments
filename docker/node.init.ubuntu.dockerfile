# Development
FROM sovrincore

ARG nodename
ARG nport
ARG cport
ARG ips
ARG nodenum
ARG nodecnt
ARG clicnt=10

# Init sovrin-node


USER indy
RUN mkdir -p /home/indy
RUN mkdir -p /home/indy/.indy
RUN chown indy:indy /home/indy -R
RUN init_indy_node $nodename $nport $cport
EXPOSE $nport $cport
RUN if [ ! -z "$ips" ] && [ ! -z "$nodenum" ] && [ ! -z "$nodecnt" ]; then generate_indy_pool_transactions --nodes $nodecnt --clients $clicnt --nodeNum $nodenum --ips "$ips"; fi
USER root
CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]
#CMD ["/bin/bash"]
