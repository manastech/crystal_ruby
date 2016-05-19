require "compiler/crystal/**"

include Crystal

class MyVisitor < Visitor
  def initialize(name)
    @str = MemoryIO.new
    @str << %(redefine_main("Init_#{name}") { |main| {{main}} }\n)
  end

  def visit(node : ClassDef)
    @str << %(_class = Ruby::Class.new "#{node.name}"\n)
  end

  def visit(node : Def)
    @str << %(_class.def "#{node.name}", #{node.args.size}, )
    @str << %[->(self : LibRuby::VALUE, ]
    node.args.each do |arg|
      @str << %(_#{arg.name} : LibRuby::VALUE, )
    end
    @str << %[) do\n]
    node.args.each do |arg|
      @str << %(#{arg.name} = Ruby::Value.new(_#{arg.name})\n)
    end
    @str << "begin\n"
    @str << node.body
    @str << "\n"
    @str << "end.to_ruby"
    @str << %(\nend)
    false
  end

  def visit(node : Nop)
  end

  def visit(node : ASTNode)
    raise "Unexpected node: #{node}"
  end

  def to_s(io : IO)
    io << @str
  end
end

name, code = ARGV

node = Parser.parse(code.gsub(/\\n/, "\n"))
visitor = MyVisitor.new(name)
node.accept visitor
visitor.to_s(STDOUT)
