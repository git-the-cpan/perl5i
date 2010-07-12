#!/usr/bin/perl

use perl5i::2;
use Test::More;

# Test def
{
    def add($this, $that) { return $this + $that }
    is add(2, 3), 5;
}


# Test func
{
    func minus($this, $that) { return $this - $that }
    is minus(2, 3), -1;
}


# Test method
{
    {
        package Foo;
        use perl5i::2;

        method new ($class: %args) {
            return bless \%args, $class;
        }
        method get ($thing) {
            return unless @_;  # just to shut up warnings
            return $self->{$thing};
        }
    }

    my $obj = Foo->new( this => 42, that => 23 );
    isa_ok $obj, "Foo";
    is $obj->get("this"), 42;
    is $obj->get("wibble"), undef;

    # When we get required parameters this should use them.
    is $obj->get(), undef;
}




done_testing();
