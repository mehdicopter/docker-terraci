FROM hashicorp/terraform:0.12.21

ENV TERRAGRUNT_VERSION=0.22.5
ENV TFLINT_VERSION=0.15.1
ENV TFSEC_VERSION=0.19.0
ENV TF_IN_AUTOMATION true

RUN apk add --no-cache --update curl

RUN curl -fsLS https://github.com/gruntwork-io/terragrunt/releases/download/v$TERRAGRUNT_VERSION/terragrunt_linux_amd64 -o /bin/terragrunt && chmod +x /bin/terragrunt
RUN curl -fsLS https://github.com/terraform-linters/tflint/releases/download/v$TFLINT_VERSION/tflint_linux_amd64.zip -o /tmp/tflint.zip && unzip /tmp/tflint.zip tflint -d /bin && chmod +x /bin/tflint
RUN curl -fsLS https://github.com/liamg/tfsec/releases/download/v$TFSEC_VERSION/tfsec-linux-amd64 -o /bin/tfsec && chmod +x /bin/tfsec

COPY tflint.hcl /etc
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["terragrunt"]
