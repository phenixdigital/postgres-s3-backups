FROM ubuntu:24.04
ARG POSTGRES_VERSION

RUN apt update && apt install -y curl gzip unzip

# install Postgres
RUN apt -y install postgresql-$POSTGRES_VERSION

# install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
	./aws/install

COPY backup.sh .
ENTRYPOINT [ "./backup.sh" ]
