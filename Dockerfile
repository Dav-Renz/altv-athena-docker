
FROM ubuntu:focal-20220415

COPY ./.docker/scripts/entrypoint.sh /root/

SHELL ["/bin/bash", "-c"]

######
# Install and setup prerequisites
######

RUN apt-get update && \
    apt-get install -y git curl wget ufw libatomic1 %% \
	mkdir -p /opt/altv && \
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
	source ~/.nvm/nvm.sh h && \
	nvm install 17 && \
    nvm use 17 && \
	ufw allow 22 &&\
	ufw allow ssh &&\
	ufw allow 7788 &&\
	ufw enable
	
######
# Install Athena
######

WORKDIR /opt/altv/

RUN git -C /opt/altv clone https://github.com/Dav-Renz/altv-athena-public.git athena-server && \
    cd /opt/altv/athena-server && \
	npm install && \
	npm run update
	
WORKDIR /opt/altv/athena-server/
	
ENTRYPOINT [ "/root/entrypoint.sh" ]