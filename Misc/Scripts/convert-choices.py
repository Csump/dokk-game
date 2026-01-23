import csv

input_csv = '../CSV/choices.csv'
output_sql = '../SQL/03_data-choices.sql'

def sql_value(val):
    if val == '':
        return 'NULL'
    try:
        return str(int(val))
    except ValueError:
        safe_val = val.replace("'", "''")
        return f"'{safe_val}'"

records = []
with open(input_csv, newline='', encoding='utf-8') as csvfile:
    reader = csv.reader(csvfile, delimiter=';')
    next(reader)  # Skip header row
    for row in reader:
        row = (row + [''] * 11)[:11]
        values = [sql_value(col) for col in row]
        records.append(f"({', '.join(values)})")

with open(output_sql, 'w', encoding='utf-8') as sqlfile:
    sqlfile.write("BEGIN;\n\n")
    sqlfile.write("INSERT INTO choices (id, situation_id, choice_text, next_situation_id, delta_energy, delta_selfreflection, delta_competency, delta_initiative, delta_creativity, delta_cooperation, delta_motivation) VALUES\n")
    sqlfile.write(",\n".join(records))
    sqlfile.write(";\n")
    sqlfile.write("\nCOMMIT;\n")