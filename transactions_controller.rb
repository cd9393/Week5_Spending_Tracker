require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative("./models/merchant")
require_relative("./models/tag")
require_relative("./models/transaction")
also_reload('./models/*')

get'/transactions' do
  @transactions = Transaction.all()
  erb(:index)
end

get'/transactions/new' do
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:new)
end

post'/transactions' do
  transaction = Transaction.new(params)
  transaction.save()
  redirect to("/transactions")
end
