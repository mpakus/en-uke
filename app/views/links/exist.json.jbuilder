if @link.nil?
  json.status do
    json.code  403
    json.error 'Invalid user token'
  end
else
  json.link do
    json.(@link, :url, :title, :state, :created_at)
  end
  json.status do
    json.code  200
    json.msg 'OK'
  end
end