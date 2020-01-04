## POST BLAST WORKFLOW 

1. Change the BLAST output file extensions from .out to .tsv. Place all files in a foldeR on either Stoltzy's drive or the big hard drive, but remember to change the path in the script.
	SCRIPT: "01change_file_ext.R"
	INPUT: all of the blast.out files
	OUTPUT: all of the blast out files with .tsv extensions

2. Combine the multiple BLAST output files. Place all files in a folder called "blast_out" on either Stoltzy's drive or the big hard drive, but remember to change the path in the script.  
	SCRIPT: "01combine_output.R
	INPUT: all of the .tsv blast out files 
	OUTPUT: "all_output.tsv"

3. Find best values based on a) evalue, b) coverage, c) intersection of both. **based on the .p1, .p2 sequences.
	SCRIPT: "03best_hits.R"
	INPUT: "full_seq_ids.R" + "all_output.tsv" 
	OUTPUT: "best_evalue_hits.tsv" + "best_covg_hits.tsv" + "best_eval_covg_hits.tsv"

4. Get one BLAST hit (best based on evalue) for each truncated TRINITY ID. This script adds the truncated ID into a new column. 
	SCRIPT: "04update_evalue_table_truncid.R"
	INPUT: "best_evalue_hits.tsv" 
	OUTPUT: "best_evalue_hits_updated.tsv"

5. Find the best evalue BLAST hit per truncated TRINTIY ID. 
	SCRIPT: "05get_one_to_one_hit_evalue.R"
	INPUT: "best_evalue_hits_updated.tsv" + "seq_ids.tsv"
	OUTPUT: "best_hit_per_seq.tsv"

6. Add the MSTRG ID to the blast table
	SCRIPT: "06get_mstrg_id.R"
	INPUT: "stringtie_merge_with_mstrgids.tsv" + "best_hit_per_seq.tsv" + "seq_ids.tsv"
	OUTPUT: "besthitperseq_mstrg_ids.tsv"

7. Add the stringtie raw counts to the blast table. 
	SCRIPT: "07combine_blastp_abundance_counts.R"
	INPUT: "mstrg_ids.tsv" + "best_hit_per_seq_mstrg_ids.tsv" + "keel_raw_counts.tsv" + "mantle_raw_counts.tsv" + "nuchal_raw_counts.tsv"
	OUTPUT: "count_blast_table.tsv"

8. Add edgeR normalized counts to blast table. ***THIS FILE IS FINAL FILE FOR ABUNDANCE ANALYZING***
	SCRIPT: "08add_normalized_counts.R"
	INPUT: "count_blast_table.tsv" + "edgeR_normcounts.tsv" + "mstrg_ids.tsv"
	OUTPUT: "blastp_allcounts.tsv"

9. Add BLAST information to the combined de table.
	SCRIPT: "09combine_de_blast.R"
	INPUT: "de_combined_with_trinids.tsv" + "mstrg_ids.tsv" + "besthitperseq_mstrg_ids.tsv"
	OUTPUT: "de_blast_out.tsv"

10. > sum(is.na(de$query_seq_id))
[1] 31952















