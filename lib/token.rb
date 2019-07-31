class Token
  def self.devtest_token(data)
    secret    = config[:secret]
    algorithm = config[:options][:algorithm]

    JWT.encode(data, secret, algorithm)
  end

  cattr_accessor :config
end
