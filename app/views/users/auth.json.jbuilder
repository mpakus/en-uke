if @user.nil?
  json.status do
    json.code  403
    json.error 'Invalid email or password'
  end
else
  json.user do
    json.(@user, :email, :token, :avatar)
  end
  json.status do
    json.code  200
    json.msg 'OK'
  end
end