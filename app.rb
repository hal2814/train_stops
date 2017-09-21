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
  @cities = City.all()
  erb(:city_list)
end

get('/train_list') do
  @trains = Train.all()
  erb(:train_list)
end

get('/city/:id') do
  @city = City.find(params.fetch("id").to_i)
  @cities = Stop.findAllCities(params.fetch("id").to_i)
  erb(:city)
end

post('/city/:id')do
  train = params['train']
  time = params['time'] + ':00'
  @cities = Stop.findAllCities(params.fetch("id").to_i)
  @city = City.find(params.fetch("id").to_i)
  city = @city.name
  Train.populateTrain(train)
  stop = Stop.populateStop(city,train,time)
  erb(:city)
end

get('/train/:id') do
  @train = Train.find(params.fetch("id").to_i)
  @trains = Stop.findAllTrains(params.fetch("id").to_i)
  erb(:train)
end

post('/train/:id')do
  city = params['city']
  time = params['time'] + ':00'
  @trains = Stop.findAllTrains(params.fetch("id").to_i)
  @train = Train.find(params.fetch("id").to_i)
  train = @train.name
  City.populateCity(city)
  stop = Stop.populateStop(city,train,time)
  erb(:train)
end
