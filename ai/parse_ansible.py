#!/usr/bin/env python3

import json
import re
import sys
from pathlib import Path


def extract_play_recap(log_text):
    """
    Extract host statistics from the PLAY RECAP section.
    Returns a list of dictionaries.
    """

    pattern = re.compile(
        r"^(?P<host>\S+)\s+:\s+"
        r"ok=(?P<ok>\d+)\s+"
        r"changed=(?P<changed>\d+)\s+"
        r"unreachable=(?P<unreachable>\d+)\s+"
        r"failed=(?P<failed>\d+)\s+"
        r"skipped=(?P<skipped>\d+)\s+"
        r"rescued=(?P<rescued>\d+)\s+"
        r"ignored=(?P<ignored>\d+)",
        re.MULTILINE,
    )

    hosts = []

    for match in pattern.finditer(log_text):
        data = match.groupdict()

        hosts.append(
            {
                "host": data["host"],
                "ok": int(data["ok"]),
                "changed": int(data["changed"]),
                "failed": int(data["failed"]),
                "unreachable": int(data["unreachable"]),
                "skipped": int(data["skipped"]),
                "rescued": int(data["rescued"]),
                "ignored": int(data["ignored"]),
            }
        )

    return hosts


def build_summary(hosts):

    return {
        "total_hosts": len(hosts),
        "successful_hosts": sum(
            1 for h in hosts
            if h["failed"] == 0 and h["unreachable"] == 0
        ),
        "failed_hosts": sum(
            1 for h in hosts
            if h["failed"] > 0
        ),
        "changed_hosts": sum(
            1 for h in hosts
            if h["changed"] > 0
        ),
    }


def save_json(output_path, payload):

    output_path.parent.mkdir(parents=True, exist_ok=True)

    with output_path.open("w") as f:
        json.dump(payload, f, indent=4)


def main():

    if len(sys.argv) != 2:
        print("Usage: python parse_ansible.py <ansible.log>")
        sys.exit(1)

    log_file = Path(sys.argv[1])

    log_text = log_file.read_text()

    hosts = extract_play_recap(log_text)

    summary = build_summary(hosts)

    payload = {
        "hosts": hosts,
        "summary": summary
    }

    output = Path("../reports/deployment.json")

    save_json(output, payload)

    print(f"Deployment report written to {output}")


if __name__ == "__main__":
    main()