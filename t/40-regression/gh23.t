=pod

=encoding utf-8

=head1 PURPOSE

Test that Tuple and ArrayRef are not parents to each other

=head1 SEE ALSO

L<https://github.com/tobyink/p5-type-tiny/issues/23>,

=head1 AUTHOR

John Napiorkowski (jjnapiork@cpan.org)

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013-2014 by Richard Simões.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

use strict;
use warnings;

use Test::More;
use Test::TypeTiny;
use Types::Standard qw/ArrayRef Tuple Int/;

ok (Tuple->is_a_type_of(ArrayRef), "ArrayRef is a parent to Tuple");
ok ((my $tc = Tuple[Int, Int])->is_a_type_of(ArrayRef), "ArrayRef is a parent to Tuple[Int, Int]");

# These two are for the reported github issue of circular parentage.
ok ! ArrayRef->is_a_type_of(Tuple), "ArrayRef is not a Tuple";
ok ! (my $tc =ArrayRef[Int])->is_a_type_of(Tuple), "ArrayRef is not a Tuple";

done_testing;
