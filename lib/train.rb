class Train
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    queried_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    queried_trains.each do |train|
      name = train["name"]
      id = train["id"].to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def ==(another_train)
    (self.name==another_train.name).&(self.id==another_train.id)
  end

  def self.find(id)
    Train.all().each do |train|
      if train.id().==(id)
        return train
      end
    end
    return nil
  end

  def save
    @id = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;").first().fetch("id").to_i()
  end

  def update(attributes)
    @name= attributes.fetch(:name)
    @id= self.id()
    DB.exec("UPDATE trains SET (name) = ('#{@name}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end
end
