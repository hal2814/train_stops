# require('train')
# require('city')

class Stop
  attr_reader :id,:city,:train,:arrival,:train_id,:city_id

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @city = attributes.fetch(:city)
    @train = attributes.fetch(:train)
    @city_id = attributes.fetch(:city_id)
    @arrival = attributes.fetch(:arrival)
    @train_id = attributes.fetch(:train_id)
  end

  def self.all
    queried_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    queried_stops.each do |stop|
      id = stop["id"].to_i
      city = stop["city"]
      train = stop["train"]
      city_id = stop["city_id"].to_i
      arrival = stop["arrival"]
      train_id = stop["train_id"].to_i
      stops.push(Stop.new({:id => id,:city => city,:train => train,:city_id => city_id,:arrival => arrival,:train_id => train_id}))
    end
    stops
  end

  def ==(another_stop)
    (self.city==another_stop.city).&(self.id==another_stop.id).&(self.train==another_stop.train).&(self.arrival==another_stop.arrival).&(self.train_id==another_stop.train_id).&(self.city_id==another_stop.city_id)
  end

  def self.find(id)
    Stop.all().each do |stop|
      if stop.id().==(id)
        return stop
      end
    end
    return nil
  end

  def save
    @id = DB.exec("INSERT INTO stops (city,train,arrival,city_id, train_id) VALUES ('#{@city}','#{@train}','#{@arrival}', #{@city_id}, #{@train_id}) RETURNING id;").first().fetch("id").to_i()
  end

  def updateCity(attributes) #need to update city_id and train_id
    @id= self.id()
    @city= attributes.fetch(:city)
    DB.exec("UPDATE stops SET (city) = ('#{@city}') WHERE id = #{@id};")
  end

  def updateTrain(attributes)
    @id= self.id()
    @train= attributes.fetch(:train)
    DB.exec("UPDATE stops SET (train) = ('#{@train}') WHERE id = #{@id};")
  end

  def updateArrival(attributes)
    @id= self.id()
    @arrival= attributes.fetch(:arrival)
    DB.exec("UPDATE stops SET (arrival) = ('#{@arrival}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM stops WHERE id = #{self.id()};")
  end

  def self.stopExists?(stop_to_compare)
    Stop.all().each do |stop|
      if (stop.city.==(stop_to_compare.city)).&(stop.train.==(stop_to_compare.train)).&(stop.arrival.==(stop_to_compare.arrival))
        return true
      end
    end
    return false
  end

  def self.populateStop(city_name,train_name,time)
    id_for_city = City.find_id(city_name)
    id_for_train = Train.find_id(train_name)
    stop = Stop.new({:city => city_name,:train => train_name,:arrival => time, :train_id => id_for_train, :city_id => id_for_city, :id=>nil})
    if !(Stop.stopExists?(stop))
      stop.save
    end
  end

  def self.seed()
    City.populateCity("Seattle")
    City.populateCity("Portland")
    City.populateCity("Seattle")
    Train.populateTrain("Amtrak line1")
    Train.populateTrain("BNSF line1")
    Train.populateTrain("Amtrak line1")
    City.populateCity("Phoenix")
    Train.populateTrain("Amtrak line2")
    City.populateCity("Los Angeles")
    Train.populateTrain("BNSF line5")
    self.populateStop("Seattle","Amtrak line1","12:30:00")
    self.populateStop("Portland","Amtrak line1","16:45:00")
    self.populateStop("Phoenix","BNSF line1","08:30:00")
    self.populateStop("Los Angeles","BNSF line5","13:00:00")

  end
end
