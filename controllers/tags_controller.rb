require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
also_reload('../models/*')

get'/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

get'/tags/new' do
  erb(:"tags/new")
end

get '/tags/summary' do
  @tags = Tag.all()
  @monthly_spend=Transaction.this_month_spend
  erb(:"tags/summary")
end

get '/tags/:id' do
  @tag = Tag.find_by_id(params[:id])
  @tag_transactions=@tag.transactions
  erb(:"tags/show")
end

post'/tags' do
  tag = Tag.new(params)
  tag.save()
  redirect to("/tags")
end
