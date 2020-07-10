
usearch=$(dirname $(pwd))/bin/usearch11
out_dir=$(dirname $(pwd))/otu_data/clustered_sequences
input=$(dirname $(pwd))/otu_data/tree_data/query_cmsearched.fasta

$usearch -cluster_fast $input -consout $out_dir/cons.90.fasta -id 0.90 -uc $out_dir/cluster_members.90.txt
$usearch -cluster_fast $input -consout $out_dir/cons.95.fasta -id 0.95 -uc $out_dir/cluster_members.95.txt
