CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = ENV["ZXyBdv7W5oqaCoVideSAfckzjAQeyLk0AIjGq0YR"]
  config.qiniu_secret_key    = ENV["KOuukr3V8ka28nziaIJjA_M0ILvOK_-vDFh9ZtHs"]
  config.qiniu_bucket        = ENV[" jdstore"]
  config.qiniu_bucket_domain = ENV["p7jlvvges.bkt.clouddn.com"]
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
  qiniu_async_ops            = "http://up.qiniup.com"  #选择不同的区域时，"up.qiniug.com" 不同
end
