
FROM ruby:alpine
RUN apk --no-cache upgrade && apk --no-cache add build-base linux-headers git nodejs yarn sqlite-dev tzdata && rm -rf /var/cache/apk/*
RUN mkdir /hkick-dashboard
WORKDIR /hkick-dashboard
COPY . /hkick-dashboard
RUN git describe --always > VERSION
RUN bundle install --jobs $(nproc) --without development test --path vendor/bundle --deployment
RUN NODE_ENV=production bundle exec yarn install --non-interactive
RUN NODE_ENV=production SECRET_KEY_BASE=precompile CPS_CONFIG_PATH=config/cable.yml RAILS_ENV=production bundle exec rails assets:precompile
RUN date +%s > BUILD_DATE