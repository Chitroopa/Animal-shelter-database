require('spec_helper')

describe(Animal) do
  describe('#==') do
    it("is the same animal if it has the same name,type,gender,date of admittance,beed") do
      animal1 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>"2017-05-02", :type=>'cat', :breed => "persian"})
      animal2 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>"2017-05-02", :type=>'cat', :breed => "persian"})
      expect(animal1).to(eq(animal2))
    end
  end

  describe('#attr_reader') do
    it('returns the details of the animal') do
      animal1 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>"2017-05-02", :type=>'cat', :breed => "persian"})
      expect(animal1.name()).to(eq('Belladonna'))
      expect(animal1.gender()).to(eq('female'))
      expect(animal1.date_of_admittance()).to(eq("2017-05-02"))
      expect(animal1.type()).to(eq('cat'))
      expect(animal1.breed()).to(eq('persian'))
    end
  end

  describe('.all') do
    it('returns all the animals in the animals list') do
      animal1 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'cat', :breed => "persian"})
      animal1.save()
      expect(Animal.all()).to(eq([animal1]))
    end
  end

  describe('.sort_breed') do
    it('returns all the animals in the animals list in sorted order') do
      animal1 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'cat', :breed => "siamese"})
      animal1.save()
      animal2 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'cat', :breed => "persian"})
      animal2.save()
      expect(Animal.sort_breed()).to(eq([animal2, animal1]))
    end
  end

  describe('.sort_type') do
    it('returns all the animals in the animals list in sorted order') do
      animal1 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'dog', :breed => "siamese"})
      animal1.save()
      animal2 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'cat', :breed => "persian"})
      animal2.save()
      expect(Animal.sort_type()).to(eq([animal2, animal1]))
    end
  end

  describe('.sort_name') do
    it('returns all the animals in the animals list in sorted order') do
      animal1 = Animal.new({:name => "David", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'dog', :breed => "siamese"})
      animal1.save()
      animal2 = Animal.new({:name => "Belladonna", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'cat', :breed => "persian"})
      animal2.save()
      expect(Animal.sort_name()).to(eq([animal2, animal1]))
    end
  end
end

describe(Customer) do
  describe('#attr_reader') do
    it('returns the details of the customer') do
      customer1 = Customer.new(:name => 'Max', :phone => '18001234567', :animal_type_preference => 'cat', :breed_preference => 'persian')
      expect(customer1.name()).to eq('Max')
      expect(customer1.phone()).to eq('18001234567')
      expect(customer1.animal_type_preference()).to eq('cat')
      expect(customer1.breed_preference()).to eq('persian')
    end
  end

  describe('#==') do
    it('checks for the same customer if the details are the same') do
      customer1 = Customer.new(:name => 'Max', :phone => '18001234567', :animal_type_preference => 'cat', :breed_preference => 'persian')
      customer2 = Customer.new(:name => 'Max', :phone => '18001234567', :animal_type_preference => 'cat', :breed_preference => 'persian')
      expect(customer1).to eq(customer2)
    end
  end

  describe('.all') do
    it('checks for the same customer if the details are the same') do
      customer1 = Customer.new(:name => 'Max', :phone => "2341234567", :animal_type_preference => 'cat', :breed_preference => 'persian')
      customer1.save()
      expect(Customer.all()).to eq([customer1])
    end
  end

end
