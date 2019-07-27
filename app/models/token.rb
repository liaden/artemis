class Token
  def self.devtest_token(data)
    secret    = auth_middleware_options[:secret]
    algorithm = auth_middleware_options[:options][:algorithm]

    JWT.encode(data, secret, algorithm)
  end

  def self.auth_middleware_options
    if Rails.env.production? || ENV['JWT_SECRET']
      { verify: true, secret: ENV['JWT_RSA_PUBLIC'], options: { algorithm: 'RS512' } }
    else
      { verify: false, options: { algorithm: 'none' } }
    end
  end
end

