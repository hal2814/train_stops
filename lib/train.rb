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

  # def self.find_by_name(name)
  #   queried_trains = DB.exec("SELECT * FROM trains;")
  #   queried_trains.each do |train|
  #     if name == train["name"]
  #       train_name = train["name"]
  #       id = train["id"].to_i
  #       train_obj = Train.new({:name => train_name, :id => id})
  #       return train_obj.id
  #     end
  #   end
  # end



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

  def self.find(id)
    Train.all().each do |train|
      if train.id().==(id)
        return train
      end
    end
    return nil
  end

  def self.find_by_name(name)
    Train.all().each do |train|
      if train.name().==(name)
        return train.name
      end
    end
    return false
  end

  def self.find_id(name)
    Train.all().each do |train|
      if train.name().==(name)
        return train.id
      end
    end
    return nil
  end

  def self.populateTrain(train_name)
    # train_list = Train.all()
    name = find_by_name(train_name)
    if !name
      train = Train.new({:name => train_name,:id => nil})
      train.save
    end
  end
end
