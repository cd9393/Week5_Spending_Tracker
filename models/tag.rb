require_relative('../db/sql_runner')

class Tag

  attr_accessor :category, :budget
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @category = options["category"]
    @budget = options["budget"]
  end

  def save()
    sql = "INSERT INTO tags (category,budget) VALUES ($1, $2) RETURNING id"
    values = [@category,@budget]
    result = SqlRunner.run(sql,values)
    @id = result.first["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET (category,budget) = ($1,$2) WHERE id = $3"
    values = [@category, @budget,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end


  def transactions()
    sql = "SELECT * FROM transactions WHERE tag_id = $1"
    values = [@id]
    transactions = SqlRunner.run(sql,values)
    result = transactions.map{|transaction| Transaction.new(transaction)}
    return result
  end

  def money_spent()
    money = transactions.map{|transaction|transaction.amount.to_f}
    total = money.reduce(:+)
    return total
  end

  def check_budget()
    if money_spent > @budget
      return true
    else
      return false
    end
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values).first
    tag =   Tag.new(result)
    return tag
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    result = tags.map{|tag|Tag.new(tag)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def self.total_budget()
    budget_array = all.map{|tag|tag.budget.to_f}
    total_budget = budget_array.reduce(:+)
    return total_budget
  end
end
