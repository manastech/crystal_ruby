lib LibRuby
  type VALUE = Void*
  type ID = Void*

  $rb_cObject : VALUE

  fun rb_define_global_function(name : UInt8*, f : Void*, args : Int32)
  fun rb_eval_string(str : UInt8*) : VALUE
  fun rb_str_new_cstr(str : UInt8*) : VALUE
  fun rb_define_class(name : UInt8*, parent : VALUE) : VALUE
  fun rb_define_method(clazz : VALUE, name : UInt8*, f : Void*, args : Int32)
  fun rb_any_to_s(v : VALUE) : VALUE
  fun rb_string_value_cstr(v : VALUE*) : UInt8*
  fun rb_intern(name : UInt8*) : ID
  fun rb_funcall(obj : VALUE, func : ID, args : Int32, ...) : VALUE
end
