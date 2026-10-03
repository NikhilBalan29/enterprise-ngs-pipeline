#!/bin/bash
# Day 56: Error Handling in Bash
set -e
set -o pipefail

echo "Starting Enterprise NGS Pipeline..."

# Directories set karna
RAW_DIR="raw_data"
RES_DIR="results"

# Day 55: Bash Automation
echo "Running FastQC..."
fastqc $RAW_DIR/raw_reads.fq -o $RES_DIR/

echo "Running BWA Alignment..."
bwa mem $RAW_DIR/ref.fasta $RAW_DIR/raw_reads.fq > $RES_DIR/aligned.sam

echo "Running Samtools..."
samtools sort $RES_DIR/aligned.sam > $RES_DIR/sorted.bam
samtools index $RES_DIR/sorted.bam

echo "Running bcftools (Variant Calling)..."
bcftools mpileup -f $RAW_DIR/ref.fasta $RES_DIR/sorted.bam | bcftools call -mv -Ov -o $RES_DIR/output.vcf

echo "Pipeline run complete! Checking results..."