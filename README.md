# CacheMock

Very basic cache implementation for testing purposes only.

__This is not a production Cache.__

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cache_mock'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cache_mock

## Usage

```ruby
RSpec.describe CacheMock do

  subject { described_class.new }
  before do
    subject.clear
  end
  it "writing and reading to the cache" do
    expect(subject.fetch("foo") { "bar" }).to eq "bar"
    expect(subject.write("bar", "foo")).to eq "foo"
    expect(subject.read("foo")).to eq "bar"
    expect(subject.read("no_foo")).to be nil
    expect(subject.exist?("foo")).to be true
    expect(subject.exist?("no_foo")).to be false
  end

  it "#clear resets the whole db" do
    expect(subject.write("bar", "foo")).to eq "foo"
    expect(subject.read("bar")).to eq "foo"
    subject.clear
    expect(subject.read("bar")).to be nil
    expect(subject.db).to eq({})
  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cache_mock. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the CacheMock project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arturictus/cache_mock/blob/master/CODE_OF_CONDUCT.md).
