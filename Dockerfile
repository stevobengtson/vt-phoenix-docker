FROM ubuntu:latest

# Coppied from https://hub.docker.com/r/marcelocg/phoenix/~/dockerfile/
MAINTAINER Steven Bengtson <steven.bengtson@me.com>

ENV PHOENIX_VERSION 1.2.0

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget git make sudo bzip2 \
 && touch /etc/init.d/couchdb \
 && wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
 && dpkg -i erlang-solutions_1.0_all.deb \
 && apt-get update \
 && apt-get install -y elixir erlang-dev erlang-parsetools && rm erlang-solutions_1.0_all.deb \
 && mix local.hex --force \
 && mix local.rebar --force \
 && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez \
 && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && sudo apt-get install -y nodejs \
 && npm install -g node-gyp phantomjs-prebuilt

WORKDIR /code
