require('pry')

class Animal
  attr_reader(:id, :name, :gender, :date_of_admittance, :type, :breed, :customer_id)

  def initialize(attributes)
    @name = attributes[:name]
    @gender = attributes[:gender]
    @date_of_admittance = attributes[:date_of_admittance]
    @type = attributes[:type]
    @breed = attributes[:breed]
    @id = attributes[:id]
    @customer_id = attributes[:customer_id]
  end

  def ==(another_animal)
    (self.name() == another_animal.name()) && (self.gender() == another_animal.gender()) && (self.date_of_admittance() == another_animal.date_of_admittance()) && (self.type()  == another_animal.type()) && (self.breed() == another_animal.breed())
  end

  def save
    result = DB.exec("INSERT INTO animals (name, gender, date_of_admittance, type, breed) VALUES ('#{@name}', '#{@gender}', '#{@date_of_admittance}', '#{@type}', '#{@breed}' ) RETURNING id;")
    @id = result.first().fetch("id").to_i()
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
      id = animal.fetch("id").to_i()
      customer_id = animal.fetch("customer_id").to_i()
      animals.push(Animal.new({:name => name, :gender => gender, :date_of_admittance=>date_of_admittance, :type=>type, :breed => breed, :id=>id, :customer_id=> customer_id}))
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

  def self.sort_by_admittance
    animal_list = Animal.all()
    animal_sort_admittance = animal_list.sort_by(&:date_of_admittance)
    return animal_sort_admittance
  end

  def self.find(id)
    found_animal = nil
    Animal.all().each() do |animal|
      if animal.id().to_i() == id
        found_animal = animal
      end
    end
    found_animal
  end

  def save_customer_id(id)
    @customer_id = id.to_i()
    DB.exec("INSERT INTO animals (customer_id) VALUES ('#{@customer_id}');")
    return @customer_id
  end

  def owner
    found_customers = []
    customers = DB.exec("SELECT * FROM customers WHERE id = #{self.id()};")
    customers.each() do |customer|
      customer_id = customer.fetch("id").to_i
      customer_name = customer.fetch("name")
      customer_phone = customer.fetch("phone")
      customer_animal_type_preference = customer.fetch("animal_type_preference")
      customer_breed_preference = customer.fetch("breed_preference")
      found_customer = Customer.new(:id =>customer_id, :name => customer_name, :phone => customer_phone, :animal_type_preference => customer_animal_type_preference, :breed_preference => customer_breed_preference)
    end
    found_customers
  end

  def self.find_customer(name)
    found_customer = nil
    customers = DB.exec("SELECT * FROM customers WHERE name = '#{name}';")
    customers.each() do |customer|
      customer_id = customer.fetch("id").to_i
      customer_name = customer.fetch("name")
      customer_phone = customer.fetch("phone")
      customer_animal_type_preference = customer.fetch("animal_type_preference")
      customer_breed_preference = customer.fetch("breed_preference")
      found_customer = Customer.new(:id =>customer_id, :name => customer_name, :phone => customer_phone, :animal_type_preference => customer_animal_type_preference, :breed_preference => customer_breed_preference)
    end
    found_customer
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
      customers.push(Customer.new(:name => name, :phone => phone, :animal_type_preference => animal_type_preference, :breed_preference => breed_preference, :id => id))
    end
    customers
  end

  def self.sort_breed_preference
    customer_list = Customer.all()
    customer_sort_breed_preference = customer_list.sort_by(&:breed_preference)
    return customer_sort_breed_preference
  end

  def self.find(id)
    found_customer = nil
    Customer.all().each() do |customer|
      if customer.id().to_i() == id
        found_customer = customer
      end
    end
    found_customer
  end

end
