FROM ruby:2.7.0-alpine


RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                yarn \
                                tzdata

ARG RAILS_MASTER_KEY


ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true


RUN mkdir /app
WORKDIR /app

COPY package.json yarn.lock Gemfile Gemfile.lock /app/
RUN gem install bundler:2.1.4

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3 --without development test && yarn install


COPY . /app

RUN RAILS_MASTER_KEY=${RAILS_MASTER_KEY} bundle exec rake assets:precompile \
  && RAILS_MASTER_KEY=${RAILS_MASTER_KEY} bundle exec rake assets:sync \
  && rm -rf node_modules/

EXPOSE 3000
CMD bundle exec rails s -p 3000

