crystal_ruby
============

Write Ruby extensions in Crystal. This is just a [Proof of Concept](http://en.wikipedia.org/wiki/Proof_of_concept).

```
$ make test_ruby.bundle
crystal sample/test_ruby.cr --link-flags "-dynamic -bundle -Wl,-undefined,dynamic_lookup" -o test_ruby.bundle

$ make irb
irb -rtest_ruby -I.
irb(main):001:0> Foo.new.foo("hi!")
=> "From Crystal!! hi!"
```
