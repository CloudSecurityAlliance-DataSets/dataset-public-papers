#!/usr/bin/env bash
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
#marker_single --output_dir ./ --output_format markdown "$id.pdf"
#
# Use the script:
#
~/GitHub/CSA-utils/utils/convert-pdf-to-markdown.sh --input "$id.pdf"


# Move the markdown output (assumed to be in a subdirectory named after the id) to the current directory.
mv "$id"/* ./

# Clean up by removing the now-empty subdirectory and the downloaded PDF.
rmdir "$id"
rm "$id.pdf"


# Find the latest file in the prompt directory using -t
#
#     -t      Sort by descending time modified (most recently modified first).  If two files have the same modification timestamp, sort their names in ascending lexicographical
#             order.  The -r option reverses both of these sort orders.
#

latest_file=$(ls -t ../../prompts | head -n 1)
latest_file_path="../../prompts/$latest_file"

if [[ -n "$latest_file" ]]; then
    echo "Latest file: $latest_file_path"
else
    echo "No files found in the directory."
fi

#
# Run the chatgpt script that takes a prompt and input file and feeds them into the o1 model, and writes just the output to the --input filename with -summary-chatgpt-o1 added to the end.
#
../../utils/summarize-md-paper-with-chatgpt-o1.py --prompt "$latest_file_path" --input "$id".md

#
# Add al the files to git and commit.
#

git add -A "*"
git commit -a -m "arxiv paper $id added"
git push
