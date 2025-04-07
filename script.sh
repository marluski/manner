#!/bin/bash

# Check arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <man_section_number> <output_directory>"
  exit 1
fi

SECTION=$1
OUTDIR=$2

# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Get list of man pages in the section
MANPAGES=$(man -k . | awk -v sec="($SECTION)" '$2 == sec { print $1 }' | sort | uniq)

echo "Converting man section $SECTION to HTML in $OUTDIR..."

# Loop through man pages and convert to HTML
for cmd in $MANPAGES; do
  echo "Processing $cmd ($SECTION)..."
  # Convert and save HTML
  man -Thtml $SECTION $cmd >"$OUTDIR/${cmd}.html"
done

echo "Done! HTML files saved to $OUTDIR."
