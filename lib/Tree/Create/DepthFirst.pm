package Tree::Create::DepthFirst;

use strict;
use warnings;

our $VERSION = '0.01';

use Tree::Simple;

sub new { #_{
	my ($_class, $input) = @_;
	my $class = ref($_class) || $_class;

  my $self = {};
  bless $self, $class;

  $self->{tree} = Tree::Simple->new('root', Tree::Simple->ROOT);
  $self->{current_tree} = $self->{tree};

  return $self;
} #_}

sub addNode { #_{

#
#    Note the similarity to parts of Tree::Parser's sub _parse
#

  my $self      = shift;
  my $depth     = shift;
  my $nodeValue = shift;

  my $new_tree = Tree::Simple->new($nodeValue);

  if ($self->{current_tree}->isRoot()) {
    $self->{current_tree}->addChild($new_tree);
    $self->{current_tree}=$new_tree;
    return $self->{tree};
  }

  my $tree_depth = $self->{current_tree}->getDepth();
  if ($depth == $tree_depth) {
     $self->{current_tree}->addSibling($new_tree);
     $self->{current_tree} = $new_tree;
  }
  elsif ($depth > $tree_depth) {

    if ($depth - $tree_depth > 1) {
      die "Passed depth (=$depth) must not be greater than current current_tree depth (=$tree_depth) + 1";
    }

    $self->{current_tree}->addChild($new_tree);
    $self->{current_tree}=$new_tree;

  }
  else {
    $self->{current_tree} = $self->{current_tree}->getParent() while ($depth < $self->{current_tree}->getDepth());

    $self->{current_tree}->addSibling($new_tree);
    $self->{current_tree}=$new_tree;

  }
  return $self->{tree};

} #_}

sub getTree { #_{

  my $self      = shift;

  return $self->{tree};

} #_}

"tq84";
