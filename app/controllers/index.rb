get '/' do
  @urls = Url.all.sort { |a,b| b.click_count <=> a.click_count}
  erb :index
  # Look in app/views/index.erb
end

post '/urls' do
  @url = Url.new(:long => params['long'])
  if @url.save
    redirect to ('/')
  else
    erb :error
  end
end

get '/:short_url' do
  puts params["short_url"]
  url = Url.find_by_short(params["short_url"])
  url.update_attributes :click_count => url.click_count + 1
  redirect to (url.long)
end
