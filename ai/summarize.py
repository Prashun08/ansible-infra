from google import genai
from dotenv import load_dotenv

import json
import os
from pathlib import Path

load_dotenv()

client = genai.Client(
    api_key=os.getenv("GEMINI_API_KEY")
)

prompt = Path("prompts/deployment_prompt.txt").read_text()

deployment = Path("../reports/deployment.json").read_text()

response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents=f"""
{prompt}

Deployment JSON

{deployment}
"""
)

report = response.text

Path("../reports/deployment-report.md").write_text(report)

print(report)