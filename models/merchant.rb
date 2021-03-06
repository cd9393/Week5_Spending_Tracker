require_relative('../db/sql_runner')

class Merchant

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql,values)
    @id = result.first["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def transactions()
    sql = " SELECT * FROM transactions where merchant_id = $1"
    value = [@id]
    result = SqlRunner.run(sql,value)
    transactions = result.map{|transaction|Transaction.new(transaction)}
    return transactions
  end

  def money_spent()
    money_array = transactions.map{|transaction|transaction.amount.to_f}
    total_spent = money_array.reduce(:+)
    return total_spent
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values).first
    merchant =   Merchant.new(result)
    return merchant
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    results = merchants.map{|merchant|Merchant.new(merchant)}
    return results
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end
end
