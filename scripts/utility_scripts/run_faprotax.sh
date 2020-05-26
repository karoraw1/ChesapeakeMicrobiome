#conda create -n _faprotax
#conda activate _faprotax
#conda install python=2.7 
#conda install -c conda-forge h5py biom-format

conda activate _faprotax
basedir=/Volumes/KeithSSD/ChesapeakeMicrobiome/data/faprotax_data
exe_dir=/Volumes/KeithSSD/ChesapeakeMicrobiome/bin/FAPROTAX_1.2.1

infile_g=$basedir/otu_taxa_full.biom
outfile_g=$basedir/functional_taxa_silva.txt
report_g=$basedir/report_silva.txt

python $exe_dir/collapse_table.py -n rows_before_collapsing \
-i $infile_g -o $outfile_g \
--output_format_collapsed "classical" \
--out_groups2records_table $report_g \
--output_format_groups2records_table "classical" \
-g $exe_dir/FAPROTAX.txt \
--collapse_by_metadata "taxonomy" --force --verbose 




