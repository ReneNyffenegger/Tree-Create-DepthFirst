#_{ Encoding and name
=encoding utf8
=head1 NAME
Tree::Create::DepthFirst - Create a Tree::Simple in the order as the created tree will traverse its nodes when traversing it depth first.
=cut
package Tree::Create::DepthFirst;

use strict;
use warnings;

#_}
#_{ Version
=head1 VERSION
Version 0.02
=cut
our $VERSION = '0.01';
#_}
#_{ Synopsis

     use Tree::Create::DepthFirst;

     my $tree_creator = Tree::Create::DepthFirst->new();
     $tree_creator -> addNode(0, 'child 1');
     $tree_creator -> addNode(0, 'child 2');
     $tree_creator -> addNode(1, 'grand chhild 1');
     $tree_creator -> addNode(1, 'grand chhild 2');
     $tree_creator -> addNode(2, 'grand-grand chhild 2');

     my $tree_simple = $tree_creator->getTree();

#_}

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
