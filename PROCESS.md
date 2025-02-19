# Process

## Converting a PDF to markdown

cd into the organization, get the PDF and run:


```
marker_single --output_dir ./ --output_format markdown FILENAME.pdf
```

this will create a directory with the filename and put the markdown, images and meta data into the directory.

```
git add -A FILENAME/*
git commit -a -m "Added FILENAME"
git push
```
