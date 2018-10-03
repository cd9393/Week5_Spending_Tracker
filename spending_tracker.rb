require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative("./controllers/transactions_controller")
require_relative("./controllers/merchant_controller")
require_relative("./controllers/tags_controller")


get'/' do
  @monthly_spend=Transaction.this_month_spend
  @monthly_transactions = Transaction.this_month
  @sorted_transactions = @monthly_transactions.sort_by{|transaction|transaction.transaction_date}.reverse
  @budget = Tag.total_budget()
  @remaining = @budget-@monthly_spend
  erb(:index)
end
