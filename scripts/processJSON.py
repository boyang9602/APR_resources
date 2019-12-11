#!/usr/bin/python3
import sys
import json
filename = sys.argv[1]
firstfile = filename.split('-')[1][:-7]
secondfile = filename.split('-')[2][:-12]
with open(filename, 'r') as file:
    difffile = json.load(file)
root = {
    "name": filename.replace(".output", "").replace(".json", ""),
    "children": [
        {
            "name": "commonPpts",
            "children": []
        },
        {
            "name": "Ppts only in " + firstfile,
            "children": []
        },
        {
            "name": "Ppts only in " + secondfile,
            "children": []
        }
    ]
}
for obj in difffile["commonPpts"]:
    root["children"][0]["children"].append({
            "name": obj["name"],
            "children": [
                {
                    "name": "Invs only in " + firstfile,
                    "children": [{ "name": v } for v in obj["left"]["invs"]]
                },
                {
                    "name": "Invs only in " + secondfile,
                    "children": [{ "name": v } for v in obj["right"]["invs"]] 
                }
            ]
        })
for obj in difffile["leftPpts"]:
    root["children"][1]["children"].append({
            "name": obj["name"],
            "children": [{ "name": v } for v in obj["invs"]]
        })
print(json.dumps(root))