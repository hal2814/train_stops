require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('./lib/stop')
also_reload('lib/**/*.rb')
require("pg")
require('pry')

DB = PG.connect({:dbname => "train_stops"})

Stop.seed()

get('/') do
  @train = Train.all()
  @city = City.all()
  @stop = Stop.all()
  erb(:index)
end

get('/operator') do
  erb(:operator)
end

get('/city_list') do
  erb(:city_list)
end

get('/train_list') do
  erb(:train_list)
end
