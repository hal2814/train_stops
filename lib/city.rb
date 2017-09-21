class City
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    queried_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    queried_cities.each do |city|
      name = city["name"]
      id = city["id"].to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def ==(another_city)
    (self.name==another_city.name).&(self.id==another_city.id)
  end

  def self.find(id)
    City.all().each do |city|
      if city.id().==(id)
        return city
      end
    end
    return nil
  end

  # def self.find_by_name(name)
  #   queried_cities = DB.exec("SELECT * FROM cities;")
  #   queried_cities.each do |city|
  #     if name == city["name"]
  #       city_name = city["name"]
  #       id = city["id"].to_i
  #       city_obj = City.new({:name => city_name, :id => id})
  #       return city_obj.id
  #     end
  #   end
  # end

  def save
    @id = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;").first().fetch("id").to_i()
  end

  def update(attributes)
    @name= attributes.fetch(:name)
    @id= self.id()
    DB.exec("UPDATE cities SET (name) = ('#{@name}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end

  def self.find_by_name(name)
    City.all().each do |city|
      if city.name().==(name)
        return city.name
      end
    end
    return false
  end

  def self.find_id(name)
    City.all().each do |city|
      if city.name().==(name)
        return city.id
      end
    end
    return nil
  end

  def self.populateCity(city_name)
    # city_list = City.all()
    name = find_by_name(city_name)
    if !name
      city = City.new({:name => city_name, :id => nil})
      city.save
    end
  end
end
