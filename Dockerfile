FROM debian:buster-slim

ENV TERRAFORM_VERSION 0.14.8
ENV TERRAGRUNT_VERSION=0.28.7
ENV TF_IN_AUTOMATION true
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    unzip \
    git \
    ca-certificates \
    ssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsLS https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o /tmp/terraform.zip && unzip /tmp/terraform.zip terraform -d /bin && chmod +x /bin/terraform
RUN curl -fsLS https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -o /bin/terragrunt && chmod +x /bin/terragrunt

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["terragrunt"]
