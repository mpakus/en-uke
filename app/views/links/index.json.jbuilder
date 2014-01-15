if @links.nil?
  json.status do
    json.code  403
    json.error 'Invalid user token'
  end
else
  json.links @links do |link|
    json.(link, :url, :title, :state, :created_at)
  end
  json.status do
    json.code  200
    json.msg 'OK'
  end
end