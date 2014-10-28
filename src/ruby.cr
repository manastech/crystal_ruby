require "lib_ruby"

struct Nil
  def to_ruby
    Pointer(Void).new(8_u64) as LibRuby::VALUE
  end
end

struct Bool
  def to_ruby
    Pointer(Void).new(self ? 0_u64 : 20_u64) as LibRuby::VALUE
  end
end

class String
  def to_ruby
    LibRuby.rb_str_new_cstr(self)
  end
end

module Ruby
  ID_TO_S = LibRuby.rb_intern("to_s")

  struct Class
    def initialize(name)
      @class = LibRuby.rb_define_class(name, LibRuby.rb_cObject)
    end

    def def(name, args, f)
      LibRuby.rb_define_method(@class, name, f.pointer, args)
    end
  end

  struct Value
    @value :: LibRuby::VALUE

    def initialize(@value : LibRuby::VALUE)
    end

    def to_unsafe
      @value
    end

    def to_s(io : IO)
      str = LibRuby.rb_funcall(self, ID_TO_S, 0)
      c_str = LibRuby.rb_string_value_cstr(pointerof(str))
      io.write Slice.new(c_str, C.strlen(c_str))
    end
  end

  def self.global_def(name, args, f)
    LibRuby.rb_define_global_function(name, f.pointer, args)
  end
end

macro ruby_extension(name, code)
  {{ run "processor", name, code }}
end
