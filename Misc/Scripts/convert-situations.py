import csv

input_csv = '../CSV/situations.csv'
output_sql = '../SQL/02_data-situations.sql'

type_map = {
    'Infó': 'Info',
    'Párbeszéd': 'Conversation',
    'Döntés': 'Decision',
    'Minijáték': 'Minigame',
    'Spéci': 'Special'
}

def sql_value(val):
    if val == '':
        return 'NULL'
    if val.lower() == 'true':
        return 'TRUE'
    if val.lower() == 'false':
        return 'FALSE'
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
        row = (row + [''] * 9)[:9]
        if len(row) > 7 and row[7] in type_map: # Map situation type
            row[7] = type_map[row[7]]
        values = [sql_value(col) for col in row]
        records.append(f"({', '.join(values)})")

with open(output_sql, 'w', encoding='utf-8') as sqlfile:
    sqlfile.write("BEGIN;\n\n")
    sqlfile.write("INSERT INTO situations (id, title, situation_text, illustration, is_starter, is_halftime, is_terminal, situation_type, next_situation_id) VALUES\n")
    sqlfile.write(",\n".join(records))
    sqlfile.write(";\n")
    sqlfile.write("\nCOMMIT;\n")