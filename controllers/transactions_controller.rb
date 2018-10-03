require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
also_reload('../models/*')

get'/transactions' do
  @transactions = Transaction.all()
  @total_spent = Transaction.total()
  @sorted_transactions = @transactions.sort_by{|transaction|transaction.transaction_date}.reverse
  @tags = Tag.all()
  @budget = Tag.total_budget()
  erb(:"transactions/index")
end

get'/transactions/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:"transactions/new")
end

post'/transactions' do
  transaction = Transaction.new(params)
  transaction.save()
  @transactions = Transaction.all()
  @total_spent = Transaction.total()
  @budget = Tag.total_budget()
  if @total_spent < @budget
    redirect to("/transactions")
  else
    erb(:"transactions/over_budget")
  end
end

post'/transactions/date' do
  @date = Date.strptime(params["filter-date"],"%Y-%m")
  month = @date.month
  year = @date.year
  @transactions = Transaction.find_by_date(month,year)
  @sorted_transactions = @transactions.sort_by{|transaction|transaction.transaction_date}.reverse
  erb(:"transactions/dates")
end
