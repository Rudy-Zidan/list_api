FROM ruby:2.6.0

WORKDIR /app/

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}"

Copy . /app/

RUN bundle install

EXPOSE 3000

CMD ["rails", "s"]
