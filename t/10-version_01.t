#!/usr/bin/perl

use strict;
use warnings;


use Test::More tests => 4;

BEGIN {
  use_ok('Tree::Create::DepthFirst');
}

my $tree_creator = Tree::Create::DepthFirst->new();
isa_ok($tree_creator, 'Tree::Create::DepthFirst');

my @nodes = (

  {depth => 0, val=>'0'          },
  {depth => 1, val=>'0.0'        },
  {depth => 1, val=>'0.1'        },
  {depth => 0, val=>'1'          },
  {depth => 1, val=>'1.0'        },
  {depth => 2, val=>'1.0.0'      },
  {depth => 2, val=>'1.0.1'      },
  {depth => 1, val=>'1.1'        },
  {depth => 2, val=>'1.1.0'      },
  {depth => 3, val=>'1.1.0.1'    },
  {depth => 4, val=>'1.1.0.1.0'  },
  {depth => 4, val=>'1.1.0.1.1'  },
  {depth => 4, val=>'1.1.0.1.2'  },
  {depth => 2, val=>'1.1.1'      },
  {depth => 2, val=>'1.1.2'      },
  {depth => 1, val=>'1.2'        },
  {depth => 0, val=>'2'          },
  {depth => 0, val=>'3'          },
  {depth => 1, val=>'3.0'        },
  {depth => 2, val=>'3.0.0'      },
  {depth => 3, val=>'3.0.0.0'    },
  {depth => 4, val=>'3.0.0.0.0'  },
  {depth => 0, val=>'4'          },

);

for my $node (@nodes) {
  $tree_creator->addNode($node->{depth}, $node->{val});
}

my $tree = $tree_creator->getTree();
isa_ok($tree, 'Tree::Simple');

$tree->traverse (sub {
  my $node = shift;

  my $next_expected = shift @nodes;

  die unless $next_expected->{depth} == $node->getDepth();
  die unless $next_expected->{val}   eq $node->getNodeValue();

});

ok(1, 'Traverse');
