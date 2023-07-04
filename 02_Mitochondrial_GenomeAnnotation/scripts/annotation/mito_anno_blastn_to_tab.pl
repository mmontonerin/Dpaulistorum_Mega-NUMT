#! /usr/bin/perl -w

use Bio::SeqIO;
use Bio::Seq;
use Bio::Tools::Run::StandAloneBlast;
use Bio::SearchIO;

unless ($ARGV[0]) {
  die "\nYou must specify an input file/files\!\n\n\t
Runs blastn with the fastafile against the specified database and \n\t
parses the blast output\n\tor\n\t
Parsing is done directly on the specified blastfile\n\n
blastn_to_tab.pl 'fastafile' 'database name'\n
blastn_to_tab.pl 'blastfile'\n
\n\n";
}

if (defined $ARGV[1])  {
  $fasta = Bio::SeqIO->new(-file => "$ARGV[0]",
                           -format => 'Fasta');
  while (my $entry = $fasta->next_seq()) {
    push @seq_array, $entry;
  }
  system 'export BLASTDB=$ARGV[1]';
  $database=$ARGV[1];
  @params = ('program' => 'blastp',
             'database' => $database,
             'outfile' => 'ut.blastp',
             'F' => 'F',
             '_READMETHOD' => 'Blast');
  $factory = Bio::Tools::Run::StandAloneBlast->new(@params);
  $blast_report = $factory->blastall(\@seq_array);
}else {
  $blast_report =Bio::SearchIO->new(-file => "$ARGV[0]",
                                    -format => 'blast');
}

while( my $result = $blast_report->next_result ) {
  $j=0;
  my $id = $result->query_name();
  my $num_hits=$result->num_hits;
  my $name_q =$result->query_description();
  #my $query_length = $result->query_length;
  my $q_length = $result->query_length();
  if ($num_hits == 0) {
  }
  while( my $hit = $result->next_hit ) {
    my $desc = $hit->name();
    my $hit_desc = $hit->description;
    my $hit_length = $hit->length;
    while( my $hsp = $hit->next_hsp ) {
      my $evalue= $hsp->evalue();
      my $length= $hsp->length('hit');
      my $length2= $hsp->length('query');
      my $start_hit=$hsp->start('hit');
      my $end_hit=$hsp->end('hit');
      my $start_query=$hsp->start('query');
      my $end_query=$hsp->end('query');
      my $percentid = $hsp->percent_identity();
      my $strand = $hsp->strand('hit');
      my $short_percent = sprintf "%.0f", $percentid;
      if ($evalue =~ /^e-\d*/) {
                $evalue =~ s/e/1e/;
      }
      if ($length2 >= 0.60*$q_length && $percentid >= 85 && $evalue <= 1e-05 && $j==0) {# || $length >= 19 && $percentid >= 85 ) {#|| $length2 >= 0.70*$q_length && $id ne $desc) {
        $j++;
#       print $id,"\t",$name_q,"\t",$q_length,"\t",$desc,"\t",$evalue,"\t",$short_percent,"\t",$start_hit,"\t",$end_hit,"\t",$hit_length,"\t",$start_query,"\t",$end_query,"\t",$length2,"\t",$hit_desc,"\t",$strand,"\n";
        if ($name_q =~ /(.+)\s+\d+\:\d+\s+[forward|reverse]/) {
            $product = $1;
        }
        if ($strand == 1 && $id =~ /CDS/) {
            print "FT   gene            ",$start_hit,"..",$end_hit,"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT   CDS             ",$start_hit,"..",$end_hit,"\n";
            print "FT                   /product=\"",$product,"\"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT                   /note=\"percent id ",$short_percent,"\"\n";
            print "FT                   /note=\"HSP: ",$start_query,"-",$end_query,"\"\n";
            print "FT                   /note=\"length ",$q_length,"\"\n";
        }elsif ($strand eq "-1" && $id =~ /CDS/) {
            print "FT   gene            complement(",$end_hit,"..",$start_hit,")\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT   CDS             complement(",$end_hit,"..",$start_hit,")\n";
            print "FT                   /product=\"",$product,"\"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT                   /note=\"percent id ",$short_percent,"\"\n";
            print "FT                   /note=\"HSP: ",$start_query,"-",$end_query,"\"\n";
            print "FT                   /note=\"length ",$q_length,"\"\n";
        }elsif ($strand == 1 && $id =~ /tRNA/) {
            print "FT   gene            ",$start_hit,"..",$end_hit,"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT   tRNA            ",$start_hit,"..",$end_hit,"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT                   /note=\"percent id ",$short_percent,"\"\n";
            print "FT                   /note=\"HSP: ",$start_query,"-",$end_query,"\"\n";
            print "FT                   /note=\"length ",$q_length,"\"\n";
        }elsif ($strand eq "-1" && $id =~ /tRNA/) {
            print "FT   gene            complement(",$end_hit,"..",$start_hit,")\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT   tRNA            complement(",$end_hit,"..",$start_hit,")\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT                   /note=\"percent id ",$short_percent,"\"\n";
            print "FT                   /note=\"HSP: ",$start_query,"-",$end_query,"\"\n";
            print "FT                   /note=\"length ",$q_length,"\"\n";
        }elsif ($strand == 1 && $id =~ /rRNA/) {
            print "FT   gene            ",$start_hit,"..",$end_hit,"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT   rRNA            ",$start_hit,"..",$end_hit,"\n";
            print "FT                   /product=\"",$product,"\"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT                   /note=\"percent id ",$short_percent,"\"\n";
            print "FT                   /note=\"HSP: ",$start_query,"-",$end_query,"\"\n";
            print "FT                   /note=\"length ",$q_length,"\"\n";
        }elsif ($strand eq "-1" && $id =~ /rRNA/) {
            print "FT   gene            complement(",$end_hit,"..",$start_hit,")\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT   rRNA            complement(",$end_hit,"..",$start_hit,")\n";
            print "FT                   /product=\"",$product,"\"\n";
            print "FT                   /locus_tag=\"",$id,"\"\n";
            print "FT                   /note=\"percent id ",$short_percent,"\"\n";
            print "FT                   /note=\"HSP: ",$start_query,"-",$end_query,"\"\n";
            print "FT                   /note=\"length ",$q_length,"\"\n";
        }

      } elsif ($j == 0 && $id ne $desc ) {
#       print "$id\t$product\t$q_length\tNo hit\t$evalue\n";
        $j=1;
      }
    }
  }
}