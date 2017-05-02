require('sinatra')
require('sinatra/reloader')
require('pg')
require('pry')
require('./lib/shelter')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "animal_shelter_test"})

get("/") do
  erb(:index)
end

get("/animals") do
  animal1 = Animal.new({:name => "David", :gender => "female", :date_of_admittance=>'2017-05-02', :type=>'cat', :breed => "siamese", :id=> nil})
  animal1.save()
  @animals_list = Animal.all()
  erb(:animals)
end

get("/animal/:id") do
  @animal = Animal.find(params.fetch("id").to_i())
  erb(:animal)
end

post("/animal/:id") do
  @animal = Animal.find(params.fetch("id").to_i())
  @owner = Animal.find_customer(params.fetch("owner"))
  id = @owner.id()
  @animal.save_customer_id(id)
  erb(:adopted)
end

get('/animals/new') do
  erb(:animal_form)
end

post('/animals') do
  name = params.fetch('name')
  gender = params.fetch('gender')
  date = params.fetch('date')
  type = params.fetch('type')
  breed = params.fetch('breed')
  new_animal = Animal.new(:name => name, :gender => gender, :date_of_admittance=> date, :type=> type, :breed => breed, :id=> nil)
  new_animal.save()
  @animals_list = Animal.all()
  erb(:animals)
end

get('/customers') do
  @customers_list = Customer.all()
  erb(:customers)
end

get('/customer/new') do
  erb(:customer_form)
end

post('/customers') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  preferred_type = params.fetch('preferred_type')
  preferred_breed = params.fetch('preferred_breed')
  new_customer = Customer.new(:name => name, :phone => phone, :animal_type_preference=> preferred_type, :breed_preference => preferred_breed, :id=> nil)
  new_customer.save()
  @customers_list = Customer.all()
  erb(:customers)
end

get('/customer/:id') do
  @customer = Customer.find(params.fetch("id").to_i())
  erb(:customer)
end
