require('spec_helper')

RSpec.describe(Stop) do

  describe(".all") do
    it "will be empty at first" do
      expect(Stop.all()).to eq([])
    end
  end

  describe("#==") do
    it "will compare two cities; they will share the same city and id" do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "3:00", :train_id => nil, :city_id => nil :id => nil})
      stop2 = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "3:00", :train_id => nil, :city_id => nil:id => nil})
      expect(stop).to eq(stop2)
    end
  end

  describe('.save') do
    it "will save info to database" do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "3:00", :train_id => nil, :city_id => nil:id => nil})
      stop.save
      expect(Stop.all()).to eq([stop])
    end
  end

  describe('.find') do
    it "return id from stop" do
      stop_id1 = Stop.new({:city=> "Seattle", :id=>nil})
      stop_save = stop_id1.save
      expect(Stop.find(stop_save)).to(eq(Stop.new({:city=> "Seattle",:id=>stop_save})))
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

  describe("#update") do
    it("update cities") do
      stop1= Stop.new({:city=>"Seattle",:id=> nil})
      stop1.save()
      stop1.update({:city=>"Portland"})
      expect(stop1.city).to(eq("Portland"))
    end
  end

  describe("#delete") do
    it("lets you delete a stop from the database") do
      stop = Stop.new({:city => "Seattle",:train => "Amtrak line1",:arrival => "3:00", :train_id => nil, :city_id => nil:id => nil})
      stop.save()
      stop.delete()
      expect(Stop.all()).to(eq([]))
    end
  end
end
