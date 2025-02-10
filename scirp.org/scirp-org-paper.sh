#!/bin/bash
set -e

# Check that a URL was provided.
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <SCIRP paper URL>"
  exit 1
fi

url="$1"

# Extract the paper ID from the URL (e.g., paperid=133503).
if [[ "$url" =~ paperid=([0-9]+) ]]; then
  id="${BASH_REMATCH[1]}"
else
  echo "Error: Could not extract paper ID from the URL."
  exit 1
fi

# Fetch the HTML page and extract the PDF URL.
pdf_url=$(curl -s "$url" | grep -Eo '<link rel="alternate" type="application/pdf" title="PDF Full-Text" href="[^"]+"' | sed -E 's/.*href="([^"]+)".*/https:\1/')

# Fix cases where SCIRP provides a relative URL (starts with `//` instead of `https://`)
if [[ "$pdf_url" =~ ^// ]]; then
  pdf_url="https:${pdf_url}"
fi

# Check if a PDF URL was found.
if [[ -z "$pdf_url" ]]; then
  echo "Error: Could not find the PDF URL on the SCIRP page."
  exit 1
fi

# Create and move into a directory named after the paper ID.
mkdir -p "$id"
cd "$id"

# Download the PDF, naming it using the SCIRP paper ID.
curl -o "$id.pdf" -L "$pdf_url"

# Run the marker_single command to produce markdown output.
marker_single --output_dir ./ --output_format markdown "$id.pdf"

# Move the markdown output (assumed to be in a subdirectory named after the id) to the current directory.
mv "$id"/* ./

# Clean up by removing the now-empty subdirectory and the downloaded PDF.
rmdir "$id"
rm "$id.pdf"

# Commit to Git.
git add -A "$id/*"
git commit -a -m "SCIRP paper $id added"
git push
