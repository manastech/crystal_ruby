require "../src/ruby"

ruby_extension "test_ruby",
class Foo
  def foo(a)
    "From Crystal!! #{a}"
  end
end
