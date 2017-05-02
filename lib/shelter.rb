require('pry')

class Animal
  attr_reader(:id, :name, :gender, :date_of_admittance, :type, :breed)

  def initialize(attributes)
    @name = attributes[:name]
    @gender = attributes[:gender]
    @date_of_admittance = attributes[:date_of_admittance]
    @type = attributes[:type]
    @breed = attributes[:breed]
  end

  def ==(another_animal)
    (self.name() == another_animal.name()) && (self.gender() == another_animal.gender()) && (self.date_of_admittance() == another_animal.date_of_admittance()) && (self.type()  == another_animal.type()) && (self.breed() == another_animal.breed())
  end

  def save
    DB.exec("INSERT INTO animals (name, gender, date_of_admittance, type, breed) VALUES ('#{@name}', '#{@gender}', '#{@date_of_admittance}', '#{@type}', '#{@breed}')")
  end

  def self.all
    animal_list = DB.exec("SELECT * FROM animals;")
    animals = []
    animal_list.each() do |animal|
      name = animal.fetch("name")
      gender = animal.fetch("gender")
      date_of_admittance = animal.fetch("date_of_admittance")
      type = animal.fetch("type")
      breed = animal.fetch("breed")
      animals.push(Animal.new({:name => name, :gender => gender, :date_of_admittance=>date_of_admittance, :type=>type, :breed => breed}))
    end
    animals
  end

  def self.sort_breed
    animal_list = Animal.all()
    animal_sort_breed = animal_list.sort_by(&:breed)
    return animal_sort_breed
  end

  def self.sort_type
    animal_list = Animal.all()
    animal_sort_type = animal_list.sort_by(&:type)
    return animal_sort_type
  end

  def self.sort_name
    animal_list = Animal.all()
    animal_sort_name = animal_list.sort_by(&:name)
    return animal_sort_name
  end

end

class Customer
  attr_reader(:id, :name, :phone, :animal_type_preference, :breed_preference)

  def initialize(attributes)
    @name = attributes[:name]
    @phone = attributes[:phone]
    @animal_type_preference = attributes[:animal_type_preference]
    @breed_preference = attributes[:breed_preference]
    @id = attributes[:id]
  end

  def ==(another_customer)
    (self.name() == another_customer.name()) && (self.phone() == another_customer.phone()) && (self.animal_type_preference() == another_customer.animal_type_preference()) && (self.breed_preference() == another_customer.breed_preference())
  end

  def save
    result = DB.exec("INSERT INTO customers (name, phone, animal_type_preference, breed_preference) VALUES ('#{@name}', '#{@phone}', '#{@animal_type_preference}', '#{@breed_preference}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    customer_list = DB.exec("SELECT * FROM customers;")
    customers = []
    customer_list.each() do |customer|
      name = customer.fetch("name")
      phone = customer.fetch("phone")
      animal_type_preference = customer.fetch("animal_type_preference")
      breed_preference = customer.fetch("breed_preference")
      id = customer.fetch("id").to_i()
      customers.push(Customer.new(:name => name, :phone => phone, :animal_type_preference => animal_type_preference, :breed_preference => breed_preference))
    end
    customers
  end


end
