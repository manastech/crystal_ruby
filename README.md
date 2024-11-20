crystal_ruby
============

> [!IMPORTANT]
> This library is no longer supported or updated by Manas.Tech,
> therefore we have archived the repository.
> 
> The contents are still available readonly and continue to work as a
> [shards](https://github.com/crystal-lang/shards/) dependency.
>
> If you wish to continue development yourself, we recommend you fork it.
> We can also arrange to transfer ownership.
>
> If you have further questions, please reach out on https://forum.crystal-lang.org
> or crystal@manas.tech


Write Ruby extensions in Crystal. This is just a [Proof of Concept](http://en.wikipedia.org/wiki/Proof_of_concept).

```
$ make test_ruby.bundle
crystal sample/test_ruby.cr --link-flags "-dynamic -bundle -Wl,-undefined,dynamic_lookup" -o test_ruby.bundle

$ make irb
irb -rtest_ruby -I.
irb(main):001:0> Foo.new.foo("hi!")
=> "From Crystal!! hi!"
```
