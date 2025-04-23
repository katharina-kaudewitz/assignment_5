#!/usr/bin/env bash 

#make input file and create output directory 

input_file="$1"
output_dir="$2"

echo "input dir: $input_file"
echo "output dir: $output_dir" 

mkdir -p "$output_dir"

#create and activate conda bam2bed environment 
source $(dirname $(dirname $(which mamba)))/etc/profile.d/conda.sh

conda create -y -n bam2bed bedtools
conda activate bam2bed

#convert bam to bed
bam_file_name=$(basename "$input_file" .bam)
echo "BAM file name: $bam_file_name"

bed_file="$output_dir/${bam_file_name}.bed"
bedtools bamtobed -i "$input_file" > "$bed_file"

echo "BED file name: $bed_file"

#create bed file with only chromosome 1
file_chr1="$output_dir/${bam_file_name}_chr1.bed"

#select chromosome 1
grep -P "^Chr1\t" "$bed_file" > "$file_chr1"

#count lines
line_count=$(wc -l < "$file_chr1")
echo "$line_count"  > "$output_dir/bam2bed_number_of_rows.txt"

#my name
echo "This script was created by Katharina Kaudewitz"

 
