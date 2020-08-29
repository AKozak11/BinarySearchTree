use lib '/mnt/c/BST/';

# use QuickSort::QuickSort;
use BinarySearchTree::BST;

print("Add numbers to array for BST insertion. Type 'done' when finished entering values...\n");

$nums = [];

while(<>){
    
    chomp;

    my $num;

    if($_ eq 'done'){
        print("List size = ", scalar(@{$nums}), "\n");
        last;
    }

    eval {
        $num = int($_);
    } or do {
        print("What are you tryna pull? Enter a number.\n");
        next;
    };

    push(@{$nums}, $num);
    
}

$bst = BST->new(@{$nums});
$bst->BuildUnbalancedTree();

print("\nPre-Balance :\n");
print($bst->IsBalanced() ? "True\n" : "False\n");

$bst->BalanceTree();

print("Post-Balance :\n");
print($bst->IsBalanced() ? "True\n\n" : "False\n\n");

my $GREEN = "\e[32m";
print("Ordered tree traversal :\n$GREEN");
$bst->TraverseInOrder($bst->{'root'});