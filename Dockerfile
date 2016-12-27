FROM ruby:2.3.1-slim

MAINTAINER roman@codeship.com

# Install curl
RUN apt-get update && apt-get install -y \
  curl

# Update packagelist
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install further requirements to run ruby on rails
RUN apt-get update && apt-get install -y \
  build-essential \
  libsqlite3-dev \
  nodejs \
  yarn

# Configure the main working directory
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without production

# Same for npm packages
COPY package.json yarn.lock ./
RUN yarn

# Copy the main application.
COPY . ./

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000
WORKDIR /app

CMD bundle exec rails s -b 0.0.0.0
