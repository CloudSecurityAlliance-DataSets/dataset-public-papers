#!/usr/bin/env python3.12

import os
import argparse
from openai import OpenAI

# Ensure API key is set
if not os.getenv("OPENAI_API_KEY"):
    raise ValueError("API key is missing. Set the OPENAI_API_KEY environment variable.")

# Initialize OpenAI client
client = OpenAI()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--prompt", required=True, help="Path to the prompt file")
    parser.add_argument("--input", required=True, help="Path to the input document file")
    args = parser.parse_args()

    # Read files
    with open(args.prompt, "r", encoding="utf-8") as f:
        prompt_text = f.read()
    with open(args.input, "r", encoding="utf-8") as f:
        input_text = f.read()

    # Prepare messages for the chat completion
    messages = [
        {
            "role": "system",
            "content": (
                "You are ChatGPT. "
                "Please provide a concise summary of the user's document. "
                "Do not include your chain-of-thought reasoning. "
                "Only provide the final summarized text."
            )
        },
        {
            "role": "user",
            "content": f"{prompt_text}\n\n---\n\n{input_text}"
        }
    ]

    # Call the OpenAI Chat API using the provided model name "o1"
    response = client.chat.completions.create(
        model="o1",
        messages=messages
    )

    # Extract summary from response
    summary = response.choices[0].message.content.strip()

    # Construct output filename based on the provided --input argument
    input_filename = os.path.splitext(args.input)[0]  # Remove extension
    output_filename = f"{input_filename}-summary-chatgpt-o1.md"

    # Write summary to the generated filename
    with open(output_filename, "w", encoding="utf-8") as f:
        f.write(summary)

    print(f"Summary written to: {output_filename}")

if __name__ == "__main__":
    main()

