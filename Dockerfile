
FROM node:17.9-bullseye

COPY ./.docker/scripts/entrypoint.sh /root/

SHELL ["/bin/bash", "-c"]

######
# Install and setup prerequisites
######

RUN apt-get update && \
    apt-get install -y git curl wget libatomic1 && \
    mkdir -p /opt/altv && \
	git -C /opt/altv clone https://github.com/Dav-Renz/altv-athena-public.git athena-server && \
    cd /opt/altv/athena-server && \
    npm install && \
    npm run update && \
    chmod +x /opt/altv/athena-server /root/entrypoint.sh
	
######source ~/.bashrc  && \
# Install Athena
######
#
#WORKDIR /opt/altv/
#
#RUN git -C /opt/altv clone https://github.com/Dav-Renz/altv-athena-public.git athena-server && \
#    cd /opt/altv/athena-server && \
#    npm install && \
#    npm run update
	
WORKDIR /opt/altv/athena-server/
	
ENTRYPOINT [ "/root/entrypoint.sh" ]
