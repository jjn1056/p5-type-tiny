package Type::Coercion::FromMoose;

use 5.006001;
use strict;
use warnings;

BEGIN {
	$Type::Coercion::FromMoose::AUTHORITY = 'cpan:TOBYINK';
	$Type::Coercion::FromMoose::VERSION   = '0.029_01';
}

use Scalar::Util qw< blessed >;
use Types::TypeTiny ();

sub _croak ($;@) { require Type::Exception; goto \&Type::Exception::croak }

require Type::Coercion;
our @ISA = 'Type::Coercion';

sub type_coercion_map
{
	my $self = shift;
	
	my @from = @{ $self->type_constraint->moose_type->coercion->type_coercion_map };

	my @return;
	while (@from)
	{
		my ($type, $code) = splice(@from, 0, 2);
		$type = Moose::Util::TypeConstraints::find_type_constraint($type)
			unless ref $type;
		push @return, Types::TypeTiny::to_TypeTiny($type), $code;
	}
	
	return \@return;
}

sub add_type_coercions
{
	my $self = shift;
	_croak "Adding coercions to Type::Coercion::FromMoose not currently supported" if @_;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Type::Coercion::FromMoose - a set of coercions borrowed from Moose

=head1 DESCRIPTION

This package inherits from L<Type::Coercion>; see that for most documentation.
The major differences are that C<add_type_coercions> always throws an
exception, and the C<type_coercion_map> is automatically populated from
Moose.

This is mostly for internal purposes.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=Type-Tiny>.

=head1 SEE ALSO

L<Type::Coercion>.

L<Moose::Meta::TypeCoercion>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
