FROM ruby:2.6.1-alpine

RUN apk add --update alpine-sdk
RUN gem install bundler
RUN gem install tzinfo-data
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

CMD ["rake", "start"]