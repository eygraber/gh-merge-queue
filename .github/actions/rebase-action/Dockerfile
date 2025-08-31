FROM debian:11-slim

RUN apt-get update && apt-get install -y --no-install-recommends git wget ca-certificates

RUN wget -q https://github.com/cli/cli/releases/download/v2.14.2/gh_2.14.2_linux_amd64.deb && \
    dpkg -i gh_2.14.2_linux_amd64.deb && \
    rm gh_2.14.2_linux_amd64.deb

ADD rebase.sh /rebase.sh
RUN chmod +x /rebase.sh

ENTRYPOINT ["/rebase.sh"]
