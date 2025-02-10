#!/bin/bash
set -e

# Check that a URL was provided.
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <PDF URL>"
  exit 1
fi

url="$1"

# Extract the arXiv identifier from the URL.
# This sed command assumes the URL is of the form .../pdf/<id> or .../pdf/<id>.pdf
id=$(echo "$url" | sed -E 's#.*/pdf/([^/]+)(\.pdf)?#\1#')

# Create and move into a directory named after the identifier.
mkdir "$id"
cd "$id"

# Download the PDF, naming it using the arXiv id.
wget -O "$id.pdf" "$url"

# Run the marker_single command to produce markdown output.
marker_single --output_dir ./ --output_format markdown "$id.pdf"

# Move the markdown output (assumed to be in a subdirectory named after the id) to the current directory.
mv "$id"/* ./

# Clean up by removing the now-empty subdirectory and the downloaded PDF.
rmdir "$id"
rm "$id.pdf"
