import csv
import sys

seen_entities = set()
ent_types = dict()


def parse_csv(filename):
    with open(filename, "r") as inf:
        reader = csv.DictReader(inf)
        for line in reader:
            if not line["name"].strip() or not line["name1"].strip():
                continue
            seen_entities.add(line["name"])
            seen_entities.add(line["name1"])
            if "_per" in filename:
                print("per")
                ent_types[line["name"]] = "person"
                ent_types[line["name1"]] = "person"
            elif "orgper" in filename:
                print("orgper")
                ent_types[line["name"]] = "org"
                ent_types[line["name1"]] = "person"
            elif "worksat" in filename:
                ent_types[line["name"]] = "person"
                ent_types[line["name1"]] = "org"
            else:
                print(filename)
                ent_types[line["name"]] = "org"
                ent_types[line["name1"]] = "org"
        input()

            # line["array_to_string"] = line["array_to_string"].replace("\\n", ", ")
            # line["array_to_string2"] = line["array_to_string2"].replace("\\n", ", ")


if __name__ == "__main__":
    with open("entities_orgs.csv", "w") as outf:
        fields = ["name", "type"]
        spamwriter = csv.writer(outf, delimiter=',')
        for arg in sys.argv[1:]:
            parse_csv(arg)

        for ent in seen_entities:
            if ent_types[ent] == "org":
                spamwriter.writerow([ent,ent_types[ent]])

    with open("entities_person.csv", "w") as outf:
        fields = ["name", "type"]
        spamwriter = csv.writer(outf, delimiter=',')
        for arg in sys.argv[1:]:
            parse_csv(arg)

        for ent in seen_entities:
            if ent_types[ent] == "person":
                spamwriter.writerow([ent,ent_types[ent]])
