require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
also_reload('../models/*')

get'/transactions' do
  @transactions = Transaction.all()
  @total_spent = Transaction.total()
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
  redirect to("/transactions")
end

get '/transactions/sort' do
  @transactions = Transaction.all()
  @total_spent = Transaction.total()
  @sorted_transactions = @transactions.sort_by{|transaction|transaction.transaction_date}.reverse
  erb(:"transactions/sort")
end
