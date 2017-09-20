require 'spec_helper'

RSpec.describe(Train) do

  describe(".all") do
    it "will be empty at first" do
      expect(Train.all()).to eq([])
    end
  end

  describe("#==") do
    it "will compare two trains; they will share the same name and id" do
      train = Train.new({:name => "Amtrak line1", :id => nil})
      train2 = Train.new({:name => "Amtrak line1",:id => nil})
      expect(train).to eq(train2)
    end
  end

  describe('.save') do
    it "will save info to database" do
      train = Train.new({:name => "Amtrak line1",:id => nil})
      train.save
      expect(Train.all()).to eq([train])
    end
  end

  describe('.find') do
    it "return id from train" do
      train_id1 = Train.new({:name=> "Amtrak line1", :id=>nil})
      train_save = train_id1.save
      expect(Train.find(train_save)).to(eq(Train.new({:name=> "Amtrak line1",:id=>train_save})))
    end
  end

  # describe('#') do
  #   it "will pull thbelonging to the train" do
  #     house = Train.new({:name => "House", :specialty => "M.D.", :id => nil})
  #     doc_house_id = house.save # Train SAVE
  #     walter = Patient.new({:name => "Little Walter", :birthday => "2005-08-25", :train_id => doc_house_id})
  #     walter.save # Patient SAVE
  #     dr_house = Train.find(doc_house_id.to_i)
  #     expect(dr_house.patients).to eq([walter])
  #   end
  # end

  describe("#update") do
    it("update trains") do
      train1= Train.new({:name=>"Amtrak line1",:id=> nil})
      train1.save()
      train1.update({:name=>"BNSF rail2"})
      expect(train1.name).to(eq("BNSF rail2"))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      train = Train.new({:name => "Amtrak line1",:id => nil})
      train.save()
      train.delete()
      expect(Train.all()).to(eq([]))
    end
  end
end
