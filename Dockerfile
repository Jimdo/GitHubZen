FROM ruby:2.3.0

EXPOSE 8808

RUN mkdir -p /opt/app
WORKDIR /opt/app

# Separate Gemfile ADD so that `bundle install` can be cached more effectively
ADD Gemfile      /opt/app/
ADD Gemfile.lock /opt/app/
RUN bundle install --jobs=4 --retry=3

ADD . /opt/app

CMD puma -C config/puma.rb
