package Eselsohr::Model::Bookmarks;

sub count_all {
    my ($self, $id) = @_;

    Eselsohr::Model::Bookmarks->count('WHERE user_id=?', $id);
}

sub select_all {
    my ($self, @args_hash) = @_;
    my $args = { @args_hash };

    my $query  = 'WHERE user_id=? AND desc LIKE ? ORDER BY id DESC LIMIT ? OFFSET ?';
    my $offset = (($args->{page} - 1) * $args->{limit});

    my @result = Eselsohr::Model::Bookmarks->select($query, $args->{user_id},
                     $args->{query}, $args->{limit}, $offset);
    my $count  = Eselsohr::Model::Bookmarks->count('WHERE user_id=? AND desc LIKE ?',
                                                   $args->{user_id}, $args->{query});

    return ($count, \@result);
}

1;
