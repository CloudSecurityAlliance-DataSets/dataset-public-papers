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


####

latest_file=$(ls -t ../../prompts | head -n 1)
latest_file_path="../../prompts/$latest_file"

if [[ -n "$latest_file" ]]; then
    echo "Latest file: $latest_file_path"
else
    echo "No files found in the directory."
fi

../../utils/summarize-md-paper-with-chatgpt-o1.py --prompt "$latest_file_path" --input "$id".md

git add -A "*"
git commit -a -m "arxiv paper $id added"
git push
