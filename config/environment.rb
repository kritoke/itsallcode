ENV['SINATRA_ENV'] ||= "production"

require 'bundler/setup'

Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end

configure :production do
 db = URI.parse('HEROKU_POSTGRESQL_PUCE_URL'|| 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end

set :database_file, 'database.yml'
require_all 'app'
