require_relative('../db/sql_runner')
require "date"

class Transaction

  attr_accessor :merchant_id, :tag_id, :amount, :transaction_date
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i
    @amount = options["amount"]
    @transaction_date = Date.parse(options["transaction_date"])
  end

  def save()
    sql = "INSERT INTO transactions (merchant_id, tag_id, amount,transaction_date) VALUES ($1,$2, $3,$4) RETURNING id"
    values = [@merchant_id, @tag_id, @amount,@transaction_date]
    result = SqlRunner.run(sql,values)
    @id = result.first["id"].to_i
  end

  def merchant()
    sql = "SELECT * FROM merchants where id = $1"
    value = [@merchant_id]
    result = SqlRunner.run(sql,value).first
    return Merchant.new(result)
  end

  def tag()
    sql = "SELECT * FROM tags where id = $1"
    value = [@tag_id]
    result = SqlRunner.run(sql,value).first
    tag = Tag.new(result)
    return tag
  end

  # def self.find_by_month(month)
  #
  # sql = " SELECT * FROM transactions WHERE transaction_date = $1"
  # value
  #   # user inputs a month
  #   # find all transactions where date == month
  #   # # return an array of transactions
  # end


  # def update()
  #   sql = "UPDATE transactions SET (merchant_id, tag_id, amount) = ($1, $2, $3) WHERE id = $4"
  #   values = [@merchant_id, @tag_id, @amount, @id]
  #   SqlRunner.run(sql,values)
  # end
  #
  # def delete()
  #   sql = "DELETE FROM transactions WHERE id = $1"
  #   values = [@id]
  #   SqlRunner.run(sql,values)
  # end
  #

  def self.find_by_date(month)
    sql = "SELECT * FROM transactions WHERE EXTRACT(MONTH FROM transaction_date) = $1"
    values = [month]
    result = SqlRunner.run(sql,values)
    transactions = result.map{|transaction|Transaction.new(transaction)}
    return transactions
  end


  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    transactions = results.map{|transaction|Transaction.new(transaction)}
    return transactions
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end


    def self.total()
      transactions = Transaction.all
      amount_array = transactions.map{|transaction|transaction.amount.to_f}
      total_amount= amount_array.reduce(:+)
      return total_amount
    end
end
