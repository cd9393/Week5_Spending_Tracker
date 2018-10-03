require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
also_reload('../models/*')

get'/merchants' do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

get'/merchants/:id' do
  @merchant = Merchant.find_by_id(params[:id])
  @merchant_transactions= @merchant.transactions
  @sorted_transactions = @merchant_transactions.sort_by{|transaction|transaction.transaction_date}.reverse
  erb(:"merchants/show")
end

get'/merchants/new' do
  erb(:"merchants/new")
end

post'/merchants' do
  merchant = Merchant.new(params)
  merchant.save()
  redirect to("/merchants")
end
