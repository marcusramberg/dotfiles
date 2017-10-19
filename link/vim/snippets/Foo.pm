package MyMoos;

use Mojo::Base -base;
use Mojo::JSON;

has 'Ponies' => sub {
  my $self=shift;
  $self->frobs;
} };

sub frobs {
  my $self=shift;
  return 1;
}



1;
