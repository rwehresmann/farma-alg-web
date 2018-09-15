FROM ruby:2.5.1-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
build-essential nodejs libpq-dev imagemagick git-all

ENV INSTALL_PATH /farma_alg

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile ./

ENV BUNDLE_PATH /app-gems

COPY . .

ENTRYPOINT ["bundle", "exec"]