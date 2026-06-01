import json

# The exact clean data you provided earlier
mock_data = {
    "program": "STVP Batch-II",
    "sector": "Information Technology",
    "district": "Rawalpindi",
    "trade": "Computer Application & Office Professional",
    "institute": "Hasna Welfare and Development Organization",
    "address": "H.No J-838, Street No:7, Near pakistan pharmacy Dhoke khabba Rawalpindi"
}

def create_sql_files():
    # 1. Create the Schema File (Table Structures)
    schema = """
DROP TABLE IF EXISTS course_offerings;
DROP TABLE IF EXISTS institutes;
DROP TABLE IF EXISTS trades;
DROP TABLE IF EXISTS districts;
DROP TABLE IF EXISTS sectors;
DROP TABLE IF EXISTS programs;

CREATE TABLE programs (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
CREATE TABLE sectors (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
CREATE TABLE districts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
CREATE TABLE trades (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
CREATE TABLE institutes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, address TEXT, district_id INTEGER, FOREIGN KEY (district_id) REFERENCES districts(id));
CREATE TABLE course_offerings (id INTEGER PRIMARY KEY AUTOINCREMENT, program_id INTEGER, sector_id INTEGER, trade_id INTEGER, institute_id INTEGER, FOREIGN KEY (program_id) REFERENCES programs(id), FOREIGN KEY (sector_id) REFERENCES sectors(id), FOREIGN KEY (trade_id) REFERENCES trades(id), FOREIGN KEY (institute_id) REFERENCES institutes(id));
"""
    with open("schema.sql", "w", encoding="utf-8") as f:
        f.write(schema)

    # 2. Create the Seed File (Inserting your data)
    seed = f"""
INSERT INTO programs (name) VALUES ('{mock_data['program']}');
INSERT INTO sectors (name) VALUES ('{mock_data['sector']}');
INSERT INTO districts (name) VALUES ('{mock_data['district']}');
INSERT INTO trades (name) VALUES ('{mock_data['trade']}');

-- Get the ID of Rawalpindi (which will be 1) and insert the institute
INSERT INTO institutes (name, address, district_id) VALUES ('{mock_data['institute']}', '{mock_data['address']}', 1);

-- Link them all together in the course_offerings table
INSERT INTO course_offerings (program_id, sector_id, trade_id, institute_id) VALUES (1, 1, 1, 1);
"""
    with open("seed.sql", "w", encoding="utf-8") as f:
        f.write(seed)

    print("✅ Successfully generated schema.sql and seed.sql!")

if __name__ == "__main__":
    create_sql_files()