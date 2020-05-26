#conda install python=2.7 
#conda install -c conda-forge h5py biom-format

conda activate _faprotax
basedir=/Volumes/KeithSSD/CB_V4/otu_data/FAPROTAX_out
exe_dir=/Volumes/KeithSSD/CB_V4/bin/FAPROTAX_1.2.1


infile_s=$basedir/otu_taxa_silva.biom
outfile_s=$basedir/functional_taxa_silva.txt
report_s=$basedir/report_silva.txt
python $exe_dir/collapse_table.py -n rows_before_collapsing -i $infile_s -o $outfile_s --output_format_collapsed "classical" --out_groups2records_table $report_s --output_format_groups2records_table "classical" -g $exe_dir/FAPROTAX.txt --collapse_by_metadata "taxonomy" --force --verbose


infile_r=$basedir/otu_taxa_rdp.biom
outfile_r=$basedir/functional_taxa_rdp.txt
report_r=$basedir/report_rdp.txt
python $exe_dir/collapse_table.py -n rows_before_collapsing -i $infile_r -o $outfile_r --output_format_collapsed "classical" --out_groups2records_table $report_r --output_format_groups2records_table "classical" -g $exe_dir/FAPROTAX.txt --collapse_by_metadata "taxonomy" --force --verbose 

infile_g=$basedir/otu_taxa_gtdb.biom
outfile_g=$basedir/functional_taxa_gtdb.txt
report_g=$basedir/report_gtdb.txt
python $exe_dir/collapse_table.py -n rows_before_collapsing -i $infile_g -o $outfile_g --output_format_collapsed "classical" --out_groups2records_table $report_g --output_format_groups2records_table "classical" -g $exe_dir/FAPROTAX.txt --collapse_by_metadata "taxonomy" --force --verbose 




