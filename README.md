# HashiCorp Vault

vault-rubyのサンプル

---

# 参考

## 公式
[hashicorp/vault\-ruby: The official Ruby client for HashiCorp's Vault](https://github.com/hashicorp/vault-ruby)

## Qiita
[RubyからHashiCorp Vaultの機密情報を読み書きする \- Qiita](https://qiita.com/NaokiIshimura/items/3cb7d2c009c6b714a444)

---

# 準備

## gem install

```shell
$ gem install vault
```

## 環境変数

```shell
$ export VAULT_ADDR='http://127.0.0.1:8200'
$ export VAULT_TOKEN='xxxxx-xxxxx-xxxxx-xxxxx-xxxxx'
```

# 実行

```shell
$ ruby sample.rb

===SealStatus===
unseal
===Write===
SecretPath: secret/bacon
{:delicious=>true, :cooktime=>"11"}
===Read===
SecretPath: secret/bacon
{:cooktime=>"11", :delicious=>true}
```
