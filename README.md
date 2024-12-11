A homework task for GP Transco

Start Redis locally before starting the application by calling:

redis-server

Commands to run from the project root directory:

bundle exec sidekiq
ruby bin/rails db:migrate
ruby bin/rails db:seed
ruby bin/rails server
cd alertable
npm run start