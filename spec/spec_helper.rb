require('rspec')
require('pg')
require('pry')
require('city')
require('train')
require('stop')

DB = PG.connect({:dbname => "train_stops_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM stops *;")
    # DB.exec('ALTER SEQUENCE "doctorés_id_seq" RESTART WITH 1;');
  end
end
