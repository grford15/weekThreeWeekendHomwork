require_relative('./models/customers.rb')
require_relative('./models/films.rb')
require_relative('./models/tickets.rb')

require('pry-byebug')

customer1 = Customer.new ({'name' => 'Greg', 'funds' => '20'})
customer1.save()

film1 = Film.new ({'title' => 'Goodfellas', 'price' => '8'})
film1.save() 


binding.pry
nil
