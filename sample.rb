require "vault"

Vault.configure do |config|
  # The address of the Vault server, also read as ENV["VAULT_ADDR"]
  config.address = ENV['VAULT_ADDR']

  # The token to authenticate with Vault, also read as ENV["VAULT_TOKEN"]
  config.token = ENV['VAULT_TOKEN']

end

# Sealステータスを取得する

seal_status = Vault.sys.seal_status
# => <Vault::SealStatus:0x007faf3c827448 @sealed=false, @t=1, @n=1, @progress=0>

puts "===SealStatus==="
puts seal_status.sealed? == true ? "seal" : "unseal"

# Vaultへ機密情報を書き込む

secret_path = "secret/bacon"
write_secret = { delicious: true, cooktime: "11" }

Vault.with_retries(Vault::HTTPConnectionError) do
  Vault.logical.write(secret_path, write_secret)

  puts "===Write==="
  puts "SecretPath: #{secret_path}"
  puts write_secret
end



# Vaultから機密情報を読み出す

Vault.with_retries(Vault::HTTPConnectionError) do
  read_secret = Vault.logical.read(secret_path)

  read_secret
  # => #<Vault::Secret:0x007fa1088d99a0
  #      @auth=nil,
  #      @data={:cooktime=>"11", :delicious=>true},
  #      @lease_duration=2764800, @lease_id="",
  #      @renewable=false, @warnings=nil, @wrap_info=nil>

  read_secret.data
  # {:cooktime=>"11", :delicious=>true}

  read_secret.data[:delicious]
  # => true
  read_secret.data[:cooktime]
  # => "11"

  puts "===Read==="
  puts "SecretPath: #{secret_path}"
  puts read_secret.data

end
