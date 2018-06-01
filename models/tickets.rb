require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :films_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @films_id = options['films_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, films_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @films_id]
    tickets = SqlRunner.run(sql, values)
    @id = tickets.first['id']
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql "UPDATE tickets SET (customer_id, films_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @films_id, @id]
    SqlRunner.run(sql, values)
  end
  
  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return tickets.map { |ticket| Ticket.new(ticket)}
  end

end
