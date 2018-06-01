require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :films_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = ['customer_id']
    @films_id = ['films_id']
  end

end
