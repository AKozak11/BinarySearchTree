package BST;

use lib '/mnt/c/BST/';

use List::Util qw[min max];
use strict;
use warnings;

use BinarySearchTree::Node;

sub new() {

    my $type = shift;
    my $this = {};
    my @list = @_;

    $this->{'unordered_list'} = \@list;
    $this->{'root'} = undef;

    bless($this, $type);
    return $this;
    
}

sub Insert(){

    my $this = shift;
    my $root = shift;
    my $node = shift;

    if(!${$root}) {
        
        $$root = $node;

    } elsif($node->{'value'} > ${$root}->{'value'}) {

        $this->Insert(\${$root}->{'right'}, $node);

    } else {

        $this->Insert(\${$root}->{'left'}, $node)
        
    } 

}

sub NewNode(){

    my $this = shift;
    my $value = shift;

    my $node = Node->new($value);

    return $node;

}

sub BuildUnbalancedTree(){

    my $this = shift;
    my $root = shift;

    foreach my $key (@{$this->{'unordered_list'}}){

        my $newnode = $this->NewNode($key);
        $this->Insert(\$this->{'root'}, $newnode);

    }

}

sub SortBSTNodes(){

    my $this = shift;
    my $root = shift;
    my $sorted = shift;

    if($$root){
        $this->SortBSTNodes(\${$root}->{'left'}, $sorted);
        push(@{$sorted}, ${$root});
        $this->SortBSTNodes(\${$root}->{'right'}, $sorted);
    }
    
}

sub BuildTree() {

    my $this = shift;
    my $nodes = shift;
    my $start = shift;
    my $end = shift;

    if($start > $end){
        return;
    }

    my $mid = int(($start + $end)/2);
    my $node = $nodes->[$mid];

    $node->{'left'} = $this->BuildTree($nodes, $start, $mid-1);
    $node->{'right'} = $this->BuildTree($nodes, $mid+1, $end);

    return $node;

}

sub BalanceTree(){

    my $this = shift;
    my $sorted_list = [];
    
    $this->SortBSTNodes(\$this->{'root'}, $sorted_list);

    my $len = scalar(@{$sorted_list});

    $this->{'root'} = $this->BuildTree($sorted_list, 0, ( $len - 1 ) );

}

sub Height(){

    my $this = shift;
    my $root = shift;

    if(!$$root){
        return 0;
    }

    return 1 + max($this->Height(\$$root->{'right'}), $this->Height(\$$root->{'left'}));  

}

sub IsBalanced() {

    my $this = shift;

    return $this->VerifyBalance(\$this->{'root'});

}

sub VerifyBalance(){

    my $this = shift;
    my $root = shift;

    if(!$$root){
        return 1;
    }

    my $lh = $this->Height(\$$root->{'left'});
    my $rh = $this->Height(\$$root->{'right'}); 

    if(abs($lh-$rh) <= 1 && $this->VerifyBalance(\$$root->{'left'}) && $this->VerifyBalance(\$$root->{'right'})) {
        return 1;
    }

    return 0;

}

sub TraverseInOrder(){

    my $this = shift;
    my $root = shift;

    if($root){
        $this->TraverseInOrder($root->{'left'});
        print("$root->{'value'}\n");
        $this->TraverseInOrder($root->{'right'});
    }

}

1;