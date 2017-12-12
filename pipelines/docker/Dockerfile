FROM ruby:2.4.2-alpine3.7

MAINTAINER  Cloudtechiae <mingatcgi@gmail.com>

ENV BBL_CLI_VERSION 5.7.3
ENV OM_CLI_VERSION 0.28.0 
ENV BOSH2_CLI_VERSION 2.0.45
#ENV CREDHUB_CLI_VERSION 1.5.1

# update and install base packages
RUN apk  update && apk upgrade 
RUN apk --no-cache add curl wget bash terraform python py-pip jq

# install bbl
RUN wget -O bbl "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v${BBL_CLI_VERSION}/bbl-v${BBL_CLI_VERSION}_linux_x86-64"
RUN chmod +x bbl
RUN mv bbl /usr/local/bin

# install opsman cli
RUN wget -O om-linux "https://github.com/pivotal-cf/om/releases/download/${OM_CLI_VERSION}/om-linux"
RUN chmod +x om-linux
RUN mv om-linux /usr/local/bin

# install bosh2 cli
RUN wget -O bosh "https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSH2_CLI_VERSION}-linux-amd64"
RUN chmod +x bosh
RUN mv bosh /usr/local/bin

# install credhub cli
#RUN wget -qO-  "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_CLI_VERSION}/credhub-linux-${CREDHUB_CLI_VERSION}.tgz" | tar -xvz
#RUN chmod +x credhub
#RUN mv credhub /usr/local/bin

# install fly
ADD assets /tmp/assets
RUN chmod +x /tmp/assets/fly
RUN mv /tmp/assets/fly /usr/local/bin
RUN rm -rf /tmp/assets

# install cf cli
RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
RUN mv cf /usr/local/bin

# install aws cli
RUN pip install awscli && export PATH=~/.local/bin:$PATH

# clean cache
RUN apk --purge -v del py-pip && rm -rf /var/cache/apk/*

CMD bash

