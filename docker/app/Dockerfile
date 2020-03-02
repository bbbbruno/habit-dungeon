FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
  apt-get update -qq && \
  apt-get install -y build-essential nodejs yarn postgresql-client && \
  apt-get install -y vim
ENV RAILS_ROOT /srv/habit-dungeon/
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile.lock package.json yarn.lock $RAILS_ROOT
COPY Gemfile.lock $RAILS_ROOT/Gemfile.lock
RUN gem update bundler
RUN bundle install && yarn install
COPY . $RAILS_ROOT
RUN mkdir -p tmp/sockets

# Add a script to be executed every time the container starts.
COPY ./docker/app/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
