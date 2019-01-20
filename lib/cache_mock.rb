require "cache_mock/version"

class CacheMock
  attr_reader :db
  def initialize()
    @db = {}
  end

  def fetch(key, options = {}, &block)

    if exist?(key)
      # fetch and return result
      puts "fetch from cache and will expire in #{db[key][:expiration_time] - Time.now.to_i}"
      db[key][:value]
    else
      if block_given?
        # make the DB query and create a new entry for the request result
        puts "did not find key in cache, executing block ..."
        db[key] = build_record(options, &block)
        db[key][:value]
      else
        # no block given, do nothing
        nil
      end
    end
  end

  def clear
    @db = {}
  end

  def exist?(key)
    db.key?(key) && (db[key][:expiration_time] > Time.now.to_i)
  end

  def read(key)
    db[key][:value] if exist?(key)
  end

  def write(key, value, options = {})
    db[key] = build_record(options) { value }
    value
  end

  private

  def build_record(opts = {}, &block)
    options = default_options.merge(opts)
    expires_in = options[:expires_in]
    {value: yield(block), expiration_time: Time.now.to_i + expires_in}
  end


  def default_options
    { expires_in: 30 }
  end
end


# cleanup, clear
# decrement, delete, delete_matched
# exist?
# fetch, fetch_multi
# increment
# key_matcher
# mute
# new
# read, read_multi
# silence!
# write, write_multi
# end
