require('spec_helper')


RSpec.describe(Stop) do

  describe(".all") do
    it "will be empty at first" do
      expect(Stop.all()).to eq([])
    end
  end

  describe('.save') do
    it "will save info to database" do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1,:id => nil})
      stop.save
      expect(Stop.all()).to eq([stop])
    end
  end

  describe("#==") do
    it "will compare two cities; they will share the same city and id" do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1, :id => 1})
      stop2 = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1,:id => 1})
      expect(stop).to eq(stop2)
    end
  end

  describe('.save') do
    it "will save info to database" do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1,:id => nil})
      stop.save
      expect(Stop.all()).to eq([stop])
    end
  end

  describe('.find') do
    it "return id from stop" do
      stop_id1 = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1, :id => 1})
      stop_save = stop_id1.save
      expect(Stop.find(stop_save)).to(eq(Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1, :id=>stop_save})))
    end
  end

  # describe('#') do
  #   it "will pull thbelonging to the stop" do
  #     house = Stop.new({:city => "House", :specialty => "M.D.", :id => nil})
  #     doc_house_id = house.save # Stop SAVE
  #     walter = Patient.new({:city => "Little Walter", :birthday => "2005-08-25", :stop_id => doc_house_id})
  #     walter.save # Patient SAVE
  #     dr_house = Stop.find(doc_house_id.to_i)
  #     expect(dr_house.patients).to eq([walter])
  #   end
  # end

  describe("#updateCity") do
    it("updates city") do
      stop1= Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1, :id=>nil})
      stop1.save()
      stop1.updateCity({:city => "Portland"})
      expect(stop1.city).to(eq("Portland"))
    end
  end

  describe("#updateTrain") do
    it("updates train") do
      stop1= Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1, :id=>nil})
      stop1.save()
      stop1.updateTrain({:train => "BNSF line1"})
      expect(stop1.train).to(eq("BNSF line1"))
    end
  end

  describe("#updateArrival") do
    it("updates arrival") do
      stop1= Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1, :id=>nil})
      stop1.save()
      stop1.updateArrival({:arrival => "05:30:00"})
      expect(stop1.arrival).to(eq("05:30:00"))
    end
  end

  describe("#delete") do
    it("lets you delete a stop from the database") do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "03:00:00", :train_id => 1, :city_id => 1 ,:id => nil})
      stop.save()
      stop.delete()
      expect(Stop.all()).to(eq([]))
    end
  end
end
