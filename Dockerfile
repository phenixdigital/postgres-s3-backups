FROM ubuntu:24.04
ARG POSTGRES_VERSION

RUN apt update && apt install -y curl gzip unzip wget gnupg

# install Postgres
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(. /etc/os-release && echo $VERSION_CODENAME)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
RUN apt update && apt upgrade -y
RUN apt -y install postgresql-$POSTGRES_VERSION

# install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
	./aws/install

COPY backup.sh .
ENTRYPOINT [ "./backup.sh" ]
