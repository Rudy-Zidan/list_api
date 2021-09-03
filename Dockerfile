FROM ruby:2.6.0

WORKDIR /app/

Copy . /app/

RUN bundle install

EXPOSE 3000

CMD ["rails", "s"]
