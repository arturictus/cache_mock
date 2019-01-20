RSpec.describe CacheMock do
  it "has a version number" do
    expect(CacheMock::VERSION).not_to be nil
  end

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
