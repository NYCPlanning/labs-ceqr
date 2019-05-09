FROM ruby:2.6

RUN apt-get update -qq && apt-get install -qq \
    postgresql \
    && apt-get clean \

RUN mkdir /app
WORKDIR /app

ADD Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD [ "rails", "server", "-b", "0.0.0.0"]
