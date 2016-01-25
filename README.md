# README

This application crashes Ruby 2.3.0!

    git clone git@github.com:sbleon/ruby230-activerecord-crash
    cd ruby230-activerecord-crash
    ruby crash.rb

## Output

    crash.rb:5: [BUG] Stack consistency error (sp: 3, bp: 4)
    ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin13]

    [snip]

    -- Control frame information -----------------------------------------------
    c:0002 p:0050 s:0003 E:001a80 EVAL   crash.rb:5 [FINISH]
    c:0001 p:0000 s:0002 E:000cd0 (none) [FINISH]

    -- Ruby level backtrace information ----------------------------------------
    crash.rb:5:in `<main>'

    -- C level backtrace information -------------------------------------------
    0   ruby                                0x000000010a3aa1e4 rb_vm_bugreport + 388
    1   ruby                                0x000000010a248aa5 rb_bug + 485
    2   ruby                                0x000000010a38abc3 vm_exec_core + 13315
    3   ruby                                0x000000010a39b1f9 vm_exec + 121
    4   ruby                                0x000000010a251ef4 ruby_exec_internal + 148
    5   ruby                                0x000000010a251e1e ruby_run_node + 78
    6   ruby                                0x000000010a20820f main + 79

## Expected output

    crash.rb:5:in `dig': #<Class:ActiveRecord::Base> does not have #dig method (TypeError)

## Notes

In addition to crashing when trying to `dig` into `ActiveRecord::Base`,
it will crash trying to dig into a child class of `ActiveRecord::Base`,
or into an instance of a child class of `ActiveRecord::Base`. Putting
AR objects into hashes is probably a common practice in Rails apps, and
users will `dig` too far into those hashes by accident (as I did!)

More realistic production code could look more like:

    class User < ActiveRecord::Base; end
    { foo: User.first }.dig(:foo, :bar)

This bug has also been reproduced on:
`ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-linux-gnu]`

