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
    @id = DB.exec("INSERT INTO stops (city,train,arrival) VALUES ('#{@city}','#{@train}','#{@arrival}') RETURNING id;").first().fetch("id").to_i()
  end

  def update(attributes)
    @city= attributes.fetch(:city)
    @train= attributes.fetch(:train)
    @arrival= attributes.fetch(:arrival)
    @id= self.id()
    DB.exec("UPDATE stops SET (city,train,arrival) = ('#{@city}','#{@train}','#{@arrival}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM stops WHERE id = #{self.id()};")
  end
end
