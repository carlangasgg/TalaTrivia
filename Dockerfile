# Base image
FROM ruby:3.1.3

# Set environment variables
ENV RAILS_ENV=development

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the work directory inside the container
WORKDIR /TalaTrivia-api

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose the port on which Rails will run
EXPOSE 3000

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]
