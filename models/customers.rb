require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customers = SqlRunner.run(sql, values).first
    @id = customers['id']
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM customers'
    customers = SqlRunner.run(sql)
    Customer.map_items()
  end

  def film
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def tickets
    sql = "SELECT tickets.* FROM tickets
    WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |result| Ticket.new(result)}
  end


  def self.map_items(stuff)
    result = stuff.map{|customer| Customer.new(customer)}
    return result
  end

end
