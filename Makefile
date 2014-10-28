test_ruby.bundle: sample/test_ruby.cr
	crystal sample/test_ruby.cr --link-flags "-dynamic -bundle -Wl,-undefined,dynamic_lookup" -o test_ruby.bundle

irb: test_ruby.bundle
	irb -rtest_ruby -I.

clean:
	rm -f test_ruby.bundle
