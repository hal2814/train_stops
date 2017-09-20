require('spec_helper')

RSpec.describe(City) do

  describe(".all") do
    it "will be empty at first" do
      expect(City.all()).to eq([])
    end
  end

  describe("#==") do
    it "will compare two cities; they will share the same name and id" do
      city = City.new({:name => "Seattle", :id => nil})
      city2 = City.new({:name => "Seattle",:id => nil})
      expect(city).to eq(city2)
    end
  end

  describe('.save') do
    it "will save info to database" do
      city = City.new({:name => "Seattle",:id => 1})
      city.save
      expect(City.all()).to eq([city])
    end
  end

  describe('.find') do
    it "return id from city" do
      city_id1 = City.new({:name=> "Seattle", :id=>nil})
      city_save = city_id1.save
      expect(City.find(city_save)).to(eq(City.new({:name=> "Seattle",:id=>city_save})))
    end
  end

  # describe('#') do
  #   it "will pull thbelonging to the city" do
  #     house = City.new({:name => "House", :specialty => "M.D.", :id => nil})
  #     doc_house_id = house.save # City SAVE
  #     walter = Patient.new({:name => "Little Walter", :birthday => "2005-08-25", :city_id => doc_house_id})
  #     walter.save # Patient SAVE
  #     dr_house = City.find(doc_house_id.to_i)
  #     expect(dr_house.patients).to eq([walter])
  #   end
  # end

  describe("#update") do
    it("update cities") do
      city1= City.new({:name=>"Seattle",:id=> nil})
      city1.save()
      city1.update({:name=>"Portland"})
      expect(city1.name).to(eq("Portland"))
    end
  end

  describe("#delete") do
    it("lets you delete a city from the database") do
      city = City.new({:name => "Seattle",:id => nil})
      city.save()
      city.delete()
      expect(City.all()).to(eq([]))
    end
  end
end
