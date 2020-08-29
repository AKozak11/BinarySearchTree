package Node;

sub new () {
    
    my $type = shift;
    my $this = {};
    $this->{'value'} = shift;

    $this->{'left'} = undef;
    $this->{'right'} = undef;

    bless $this, $type;
    return $this;

}

1;