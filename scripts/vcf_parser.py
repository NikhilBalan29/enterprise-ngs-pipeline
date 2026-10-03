import polars as pl
import os

print("Starting VCF Parsing with Polars...")

vcf_path = "results/output.vcf"
output_csv = "results/significant_mutations.csv"

try:
    if os.path.exists(vcf_path):
        # Load data (assuming clean headers without '#')
        df = pl.read_csv(vcf_path, separator="\t")
        
        # Day 54: Filter out low-confidence variants (keep QUAL > 30)
        clean_df = df.filter(pl.col("QUAL") > 30)
        
        # Save to CSV
        clean_df.write_csv(output_csv)
        print(f"Success! Found {len(clean_df)} high-confidence mutations.")
        print(f"Saved perfectly to {output_csv}")
    else:
        print("Error: output.vcf file not found in results directory.")
except Exception as e:
    print(f"Error during VCF parsing: {e}")