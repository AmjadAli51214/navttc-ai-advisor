-- ============================================================
-- seed.sql  — NAVTTC PMYSD  (DEFINITIVE SINGLE FILE)
-- Compatible with: SQLite, Cloudflare D1 (Wrangler), Python
-- Every parent table is inserted BEFORE any child that refs it.
-- ============================================================

-- ============================================================
-- 1. PROGRAMS  (4 rows)
-- ============================================================
INSERT INTO programs (name) VALUES
    ('STVP Batch-II'),                       -- 1
    ('High Impact Training'),                 -- 2
    ('PMYSD Batch-I 2023-24 Conventional'),   -- 3
    ('PMYSD Batch-I 2023-24 High-End');       -- 4

-- ============================================================
-- 2. SECTORS  (10 rows)
-- ============================================================
INSERT INTO sectors (name) VALUES
    ('Information Technology'),    -- 1
    ('Artificial Intelligence'),   -- 2
    ('Construction & Plumbing'),   -- 3
    ('Hospitality & Culinary Arts'),-- 4
    ('Automotive & Mechatronics'), -- 5
    ('Agriculture & Livestock'),   -- 6
    ('Fashion & Textile'),         -- 7
    ('Language & Soft Skills'),    -- 8
    ('Media & Creative Arts'),     -- 9
    ('Health & Social Care');      -- 10

-- ============================================================
-- 3. DISTRICTS  (10 rows)
-- ============================================================
INSERT INTO districts (name) VALUES
    ('Islamabad'),   -- 1
    ('Rawalpindi'),  -- 2
    ('Lahore'),      -- 3
    ('Karachi'),     -- 4
    ('Peshawar'),    -- 5
    ('Quetta'),      -- 6
    ('Multan'),      -- 7
    ('Faisalabad'),  -- 8
    ('Sialkot'),     -- 9
    ('Hyderabad');   -- 10

-- ============================================================
-- 4. TRADES  (133 rows)
-- Block 1: original 20 from seed.sql
-- Block 2: 24 remaining Conventional trades
-- Block 3: 52 High-End trades
-- Block 4: 37 High-Tech IT trades
-- ============================================================
INSERT INTO trades (name) VALUES
    -- Original 20
    ('Web Development'),                                        -- 1
    ('Full Stack Development'),                                 -- 2
    ('Cyber Security'),                                         -- 3
    ('Cloud Computing - AWS'),                                  -- 4
    ('Mobile Application Development'),                         -- 5
    ('Data Analytics & Business Intelligence'),                 -- 6
    ('Artificial Intelligence & Machine Learning'),             -- 7
    ('AI Robotics'),                                            -- 8
    ('Digital Marketing & SEO'),                                -- 9
    ('Graphic Design & Video Editing'),                         -- 10
    ('Plumbing & Pipe Fitting'),                                -- 11
    ('General Electrician'),                                    -- 12
    ('Solar PV & UPS Technician'),                              -- 13
    ('HVACR Technician'),                                       -- 14
    ('AutoCAD (Civil & Mechanical)'),                           -- 15
    ('Professional Chef & Culinary Arts'),                      -- 16
    ('Barista & Fast Food Management'),                         -- 17
    ('Restaurant & Hospitality Management'),                    -- 18
    ('Auto Mechanic (Diesel & Petrol)'),                        -- 19
    ('Automotive Mechatronics'),                                -- 20
    -- Conventional (remaining 24)
    ('Advanced Welding SMAW & GTAW 6G & 6GR'),                 -- 21
    ('Artificial Insemination'),                                -- 22
    ('Bakery & Pastry Making'),                                 -- 23
    ('Beautician'),                                             -- 24
    ('Computer Applications Jaws Software'),                    -- 25
    ('Computerized Accounting Peachtree Quickbook'),            -- 26
    ('Driver HTV'),                                             -- 27
    ('Farm Manager & Tunnel Farming'),                          -- 28
    ('Fashion Design & Dress Making'),                          -- 29
    ('Front Desk Manager & Receptionist'),                      -- 30
    ('Fruit Plants Pruning Budding & Layering'),                -- 31
    ('Gemstone Cutting and Polishing'),                         -- 32
    ('Hand & Machine Embroidery'),                              -- 33
    ('Heavy Machinery Operator Bulldozer Loader Crane'),        -- 34
    ('Home Appliance Repair & Maintenance'),                    -- 35
    ('Hybrid Seed Production & Contract Farming'),              -- 36
    ('Machinist'),                                              -- 37
    ('Motorcycle Mechanic'),                                    -- 38
    ('Plumbing & Solar Water Heating Technician'),              -- 39
    ('Professional Chef'),                                      -- 40
    ('Security Guard'),                                         -- 41
    ('Tissue Culture'),                                         -- 42
    ('Veterinary Poultry & Dairy Assistants'),                  -- 43
    ('Welder TIG SMAW MIG SAW ARC'),                           -- 44
    -- High-End (52)
    ('3D Animation Realistic Rendering'),                       -- 45
    ('Advanced CAD CAM'),                                       -- 46
    ('Advanced CNC'),                                           -- 47
    ('Advanced Electronics PCB Design & Fabrication'),          -- 48
    ('Amazon Virtual Assistant'),                               -- 49
    ('Artificial Intelligence Machine Learning Deep Learning'), -- 50
    ('Artificial Intelligence Robotics'),                       -- 51
    ('Automotive Mechatronics High-End'),                       -- 52
    ('Barista Skills Fast Food'),                               -- 53
    ('Block Chain Programming'),                                -- 54
    ('Care Worker'),                                            -- 55
    ('Certificate in IT Web Development'),                      -- 56
    ('Certificate in Korean Language'),                         -- 57
    ('Computerized Braille Composition'),                       -- 58
    ('Cooking Chef High-End'),                                  -- 59
    ('Culinary Arts Chef De Partie'),                           -- 60
    ('Culinary Arts Professional Cook'),                        -- 61
    ('Customer Services & Sales Representation'),               -- 62
    ('Data Mining & Business Intelligence'),                    -- 63
    ('Digital and Precision Agriculture'),                      -- 64
    ('Digital Marketing & SEO High-End'),                       -- 65
    ('Documentary & Film Making Digital Broadcasting'),         -- 66
    ('Domestic Electrical Appliances Technician'),              -- 67
    ('Drone Applications in Agriculture'),                      -- 68
    ('Early Childhood Education'),                              -- 69
    ('eCommerce'),                                              -- 70
    ('Electric Arc Welding & CO2 For Ship Building'),           -- 71
    ('Energy Efficiency Management'),                           -- 72
    ('English Language IELTS PSL'),                             -- 73
    ('Fiber Optic Technician'),                                 -- 74
    ('German Language B5'),                                     -- 75
    ('Graphic Design Print Media'),                             -- 76
    ('Graphic Design and Video Editing'),                       -- 77
    ('Graphic Designing UI UX Designer'),                       -- 78
    ('Gym Trainer'),                                            -- 79
    ('High-tech Automotive Technician'),                        -- 80
    ('Industrial Automation PLC HMI SCADA'),                    -- 81
    ('Industrial Electrician'),                                 -- 82
    ('Industrial Stitching Machine Operator'),                  -- 83
    ('Intelligent Hybrid & Electric Vehicles'),                 -- 84
    ('Interior Designing'),                                     -- 85
    ('Internet of Things IoT System Development'),              -- 86
    ('Japanese Language N4'),                                   -- 87
    ('Network Administrator CISCO HUAWEI IBM'),                 -- 88
    ('Overhead Crane Operator Shipping Industry'),              -- 89
    ('Professional Photography Documentary Ad Making'),         -- 90
    ('Programmable Logical Controller PLC'),                    -- 91
    ('Restaurant Manager'),                                     -- 92
    ('Smart IoT Technologies for Agriculture'),                 -- 93
    ('Sports Trainer'),                                         -- 94
    ('Textile Designing with CAD'),                             -- 95
    ('Travel and Tourism Manager Program'),                     -- 96
    -- High-Tech IT (37)
    ('Advance Python Programming & Applications'),              -- 97
    ('Advance Web Application Development'),                    -- 98
    ('Advanced Programming Machine Learning Data Mining'),      -- 99
    ('Agile Certified Practitioner PMI-ACP'),                   -- 100
    ('Android Java & Database'),                                -- 101
    ('Big Data Analytic Technique'),                            -- 102
    ('Certificate in SAP ERP'),                                 -- 103
    ('Certified Project Management Professional'),              -- 104
    ('Certified ScrumMaster CSM'),                              -- 105
    ('Cloud Computing'),                                        -- 106
    ('Cloud Computing AWS'),                                    -- 107
    ('Cloud Computing Google'),                                 -- 108
    ('Cloud Computing Microsoft'),                              -- 109
    ('Cyber Security CEH CHFI'),                                -- 110
    ('Database Administration DBA Track'),                      -- 111
    ('Digital Forensic & Cyber Security'),                      -- 112
    ('Docker Certified Associate'),                             -- 113
    ('Full Stack Development High-Tech'),                       -- 114
    ('Game Development'),                                       -- 115
    ('Google UX Design'),                                       -- 116
    ('iOS Objective C'),                                        -- 117
    ('ISTQB Certified Tester Foundation Level'),                -- 118
    ('Javascript Fullstack MEAN MERN'),                         -- 119
    ('Microsoft .Net Angular React'),                           -- 120
    ('Microsoft Certified Azure'),                              -- 121
    ('Microsoft Dynamics 365'),                                 -- 122
    ('Mobile Application Development High-Tech'),               -- 123
    ('Oracle Database SQL PL SQL'),                             -- 124
    ('Oracle Java Angular'),                                    -- 125
    ('Power BI'),                                               -- 126
    ('Project Management PMP Certification'),                   -- 127
    ('Python Django Angular React'),                            -- 128
    ('React Native'),                                           -- 129
    ('Salesforce Certified Administrator'),                     -- 130
    ('Tableau'),                                                -- 131
    ('Unity Certified Game Development'),                       -- 132
    ('Unreal Engine Certification');                            -- 133

-- ============================================================
-- 5. INSTITUTES  (60 rows)
-- district_id: 1=Islamabad 2=Rawalpindi 3=Lahore  4=Karachi
--              5=Peshawar  6=Quetta    7=Multan   8=Faisalabad
--              9=Sialkot   10=Hyderabad
-- ============================================================
INSERT INTO institutes (name, address, district_id) VALUES
    -- Original 30
    ('TechPro Institute of Modern Sciences',          'Plot 14, Street 5, G-9 Markaz, Islamabad',                         1),  -- 1
    ('Federal Polytechnic Institute Islamabad',       'House 22, Sector H-8/4, Islamabad',                                1),  -- 2
    ('Capital IT Academy',                            'Office 301, Rehmat Plaza, Blue Area, Islamabad',                   1),  -- 3
    ('Apex Vocational Training Centre Rawalpindi',    'Shop 7, Murree Road, Saddar, Rawalpindi',                          2),  -- 4
    ('Punjab Technical Institute Rawalpindi',         'Opposite GPO, Committee Chowk, Rawalpindi',                        2),  -- 5
    ('National Skills Academy Rawalpindi',            'Block C, Satellite Town, Rawalpindi',                              2),  -- 6
    ('Punjab Vocational Training Centre Lahore',      '12-A, Gulberg III, Main Boulevard, Lahore',                        3),  -- 7
    ('Lahore Institute of Technology & Management',   '45 Ferozepur Road, near Thokar Niaz Baig, Lahore',                 3),  -- 8
    ('Al-Rehman Technical Institute Lahore',          'Plot 88, Township Sector A-2, Lahore',                             3),  -- 9
    ('Superior Polytechnic College Lahore',           '17 Queen''s Road, Civil Lines, Lahore',                            3),  -- 10
    ('Karachi Institute of Applied Sciences',         'Block 4, Clifton, near KPT Interchange, Karachi',                  4),  -- 11
    ('Sindh Technical Board Training Centre',         'ST-11, Sector 5-C/3, North Karachi, Karachi',                      4),  -- 12
    ('DHA Vocational Institute Karachi',              'Plot 22, Phase 4 Commercial Area, DHA Karachi',                    4),  -- 13
    ('Skyline IT Academy Karachi',                    'Room 502, Ocean Centre, I.I. Chundrigar Road, Karachi',            4),  -- 14
    ('Peshawar Institute of Modern Technology',       'University Road, near Khyber Medical College, Peshawar',           5),  -- 15
    ('KP Skill Development Centre Peshawar',          'Opposite Shoba Bazaar, Ring Road, Peshawar',                       5),  -- 16
    ('Frontier Polytechnic Institute',                'Warsak Road, Industrial Estate, Peshawar',                         5),  -- 17
    ('Balochistan Vocational Training Centre',        'Jinnah Road, near Press Club, Quetta',                             6),  -- 18
    ('Btevte Skill Hub Quetta',                       'Western Bypass, Block 5, Quetta',                                  6),  -- 19
    ('Quetta Institute of Professional Studies',      '14 Samungli Road, Quetta Cantonment, Quetta',                      6),  -- 20
    ('Multan Institute of Technical Education',       'Bosan Road, near Chungi No. 9, Multan',                            7),  -- 21
    ('South Punjab Vocational Centre Multan',         'Vehari Chowk, Model Town B, Multan',                               7),  -- 22
    ('City Tech Academy Multan',                      'Plot 33, Gulgasht Colony, Multan',                                 7),  -- 23
    ('Faisalabad Technical Institute',                'Jaranwala Road, D-Type Colony, Faisalabad',                        8),  -- 24
    ('Chenab Polytechnic Institute Faisalabad',       '203 Susan Road, Madina Town, Faisalabad',                          8),  -- 25
    ('Sialkot Institute of Vocational Sciences',      'Paris Road, near Allama Iqbal Town, Sialkot',                      9),  -- 26
    ('Export Industries Skill Centre Sialkot',        'Daska Road, Sialkot Industrial Estate, Sialkot',                   9),  -- 27
    ('Hyderabad Institute of Technology',             'Auto Bhan Road, Latifabad Unit 9, Hyderabad',                     10),  -- 28
    ('Sindh VTC Hyderabad',                           'Qasimabad, Main Road, Hyderabad',                                 10),  -- 29
    ('Indus Vocational Academy Hyderabad',            'Plot 5, Hirabad Industrial Area, Hyderabad',                      10),  -- 30
    -- Additional 30
    ('Islamabad Model Technical Institute',           'Plot 9, Street 12, I-10/3 Industrial Area, Islamabad',             1),  -- 31
    ('NAVTTC Regional Training Centre Islamabad',     'H-9/4, Kirthar Road, near NAVTTC HQ, Islamabad',                  1),  -- 32
    ('Rawalpindi Polytechnic Institute',              'Tipu Road, near Rawalpindi Railway Station, Rawalpindi',            2),  -- 33
    ('Prime Skills Academy Rawalpindi',               'Westridge III, near Askari-14, Rawalpindi',                        2),  -- 34
    ('TEVTA Centre of Excellence Lahore',             '54 Ferozpur Road, Kot Lakhpat Industrial Estate, Lahore',          3),  -- 35
    ('Government College of Technology Lahore',       'GT Road, Sanda, near Bhati Gate, Lahore',                          3),  -- 36
    ('Noor Vocational Institute Lahore',              'Block P, Phase 2, DHA Lahore',                                     3),  -- 37
    ('Karachi Polytechnic Institute',                 'Bihar Colony, Karachi West, Karachi',                              4),  -- 38
    ('NED Skill Development Centre Karachi',          'University Road, NED Campus, Karachi',                             4),  -- 39
    ('Federal Urdu Vocational Centre Karachi',        'Stadium Road, Federal B Area, Karachi',                            4),  -- 40
    ('Khyber Polytechnic Institute Peshawar',         'Dabgari Gardens, near Cunningham Clock Tower, Peshawar',           5),  -- 41
    ('NAVTTC Regional Centre Peshawar',               'Hayatabad Phase 6, Industrial Estate, Peshawar',                   5),  -- 42
    ('Balochistan Institute of Technology Quetta',    'Brewery Road, near Quetta Serena Hotel, Quetta',                   6),  -- 43
    ('NAVTTC Regional Centre Quetta',                 'Airport Road, near Quetta International Airport, Quetta',          6),  -- 44
    ('Multan Polytechnic Institute',                  'Abdali Road, near Chungi No. 6, Multan',                           7),  -- 45
    ('TEVTA VTC Multan',                              'New Multan, near DHQ Hospital, Multan',                            7),  -- 46
    ('Government College of Technology Faisalabad',   'Kohinoor Road, near Lyallpur Textile Mill, Faisalabad',            8),  -- 47
    ('Faisalabad Skills Development Centre',          'Peoples Colony No. 1, Satiana Road, Faisalabad',                   8),  -- 48
    ('Sialkot Polytechnic Institute',                 'Kutchery Road, near District Courts, Sialkot',                     9),  -- 49
    ('Surgical & Sports Goods Skills Centre Sialkot', 'Sambrial Road, near Sialkot Dry Port, Sialkot',                    9),  -- 50
    ('Hyderabad Polytechnic Institute',               'Tilak Incline Road, Hirabad, Hyderabad',                          10),  -- 51
    ('Sindh Skills Development Institute Hyderabad',  'Qasimabad Main Boulevard, Hyderabad',                             10),  -- 52
    ('Gujranwala Technical Training Centre',          'G.T. Road, Satellite Town, Gujranwala',                            3),  -- 53
    ('Abbottabad Institute of Modern Sciences',       'Mandian, near Ayub Medical Complex, Abbottabad',                   5),  -- 54
    ('Dera Ghazi Khan Vocational Centre',             'Bypass Road, near DHQ Hospital, Dera Ghazi Khan',                  7),  -- 55
    ('Sargodha Polytechnic Institute',                'University Road, near UOS Campus, Sargodha',                       8),  -- 56
    ('Gujrat Skills Academy',                         'Kunjah Road, near Chenab University, Gujrat',                      9),  -- 57
    ('Larkana Vocational Training Centre',            'Station Road, near Civil Hospital, Larkana',                      10),  -- 58
    ('Mardan Technical Institute',                    'GT Road, near Mardan Medical Complex, Mardan',                     5),  -- 59
    ('Turbat Vocational Centre Balochistan',          'Coastal Highway Road, near Turbat Airport, Turbat',                6);  -- 60

-- ============================================================
-- 6. COURSE OFFERINGS
-- Columns: program_id, sector_id, trade_id, institute_id,
--          stipend_eligible, hostel_available
--
-- Facility policy:
--   program_id 1-2 (original seed, no explicit facility flag) → 0,0
--   program_id 3   Conventional  → stipend=1, hostel=1
--   program_id 4   High-End / IT → stipend=1, hostel=0
-- ============================================================

-- ----------------------------------------------------------
-- ORIGINAL 53 offerings from seed.sql (programs 1 & 2)
-- stipend_eligible=0, hostel_available=0  (pre-extension rows)
-- ----------------------------------------------------------
INSERT INTO course_offerings (program_id, sector_id, trade_id, institute_id, stipend_eligible, hostel_available) VALUES
    (1, 1,  1,  1, 0, 0),
    (1, 1,  2,  1, 0, 0),
    (2, 2,  7,  1, 0, 0),
    (1, 1,  3,  2, 0, 0),
    (2, 1,  4,  2, 0, 0),
    (1, 1,  9,  3, 0, 0),
    (2, 1, 10,  3, 0, 0),
    (1, 1,  5,  4, 0, 0),
    (2, 2,  8,  4, 0, 0),
    (1, 3, 11,  5, 0, 0),
    (1, 3, 12,  5, 0, 0),
    (2, 3, 13,  6, 0, 0),
    (1, 3, 15,  6, 0, 0),
    (1, 1,  1,  7, 0, 0),
    (2, 1,  2,  7, 0, 0),
    (1, 1,  6,  8, 0, 0),
    (2, 2,  7,  8, 0, 0),
    (1, 4, 16,  9, 0, 0),
    (2, 4, 17,  9, 0, 0),
    (1, 5, 19, 10, 0, 0),
    (2, 5, 20, 10, 0, 0),
    (1, 1,  3, 11, 0, 0),
    (2, 1,  4, 11, 0, 0),
    (1, 3, 14, 12, 0, 0),
    (2, 3, 11, 12, 0, 0),
    (1, 4, 18, 13, 0, 0),
    (2, 4, 16, 13, 0, 0),
    (1, 1,  9, 14, 0, 0),
    (2, 1, 10, 14, 0, 0),
    (1, 2,  8, 15, 0, 0),
    (2, 1,  5, 15, 0, 0),
    (1, 3, 12, 16, 0, 0),
    (2, 3, 13, 16, 0, 0),
    (1, 5, 19, 17, 0, 0),
    (2, 5, 20, 17, 0, 0),
    (1, 3, 11, 18, 0, 0),
    (2, 3, 15, 18, 0, 0),
    (1, 1,  1, 19, 0, 0),
    (2, 1,  6, 19, 0, 0),
    (1, 4, 17, 20, 0, 0),
    (2, 4, 18, 20, 0, 0),
    (1, 1,  2, 21, 0, 0),
    (2, 2,  7, 21, 0, 0),
    (1, 3, 14, 22, 0, 0),
    (2, 5, 19, 22, 0, 0),
    (1, 1,  9, 23, 0, 0),
    (2, 3, 12, 24, 0, 0),
    (1, 5, 20, 25, 0, 0),
    (1, 1, 10, 26, 0, 0),
    (2, 4, 16, 27, 0, 0),
    (1, 1,  3, 28, 0, 0),
    (2, 3, 11, 29, 0, 0),
    (1, 4, 18, 30, 0, 0);

-- ----------------------------------------------------------
-- BLOCK A: CONVENTIONAL TRADES (21–44) → stipend=1, hostel=1
-- ----------------------------------------------------------
INSERT INTO course_offerings (program_id, sector_id, trade_id, institute_id, stipend_eligible, hostel_available) VALUES
    -- Advanced Welding SMAW & GTAW (21) 6 months
    (3, 3, 21, 31, 1, 1),
    (3, 3, 21, 33, 1, 1),
    (3, 3, 21, 38, 1, 1),
    (3, 3, 21, 41, 1, 1),
    (3, 3, 21, 45, 1, 1),
    -- Artificial Insemination (22) 6 months
    (3, 6, 22, 32, 1, 1),
    (3, 6, 22, 55, 1, 1),
    (3, 6, 22, 59, 1, 1),
    -- Bakery & Pastry Making (23) 3 months
    (3, 4, 23, 35, 1, 1),
    (3, 4, 23, 40, 1, 1),
    (3, 4, 23, 46, 1, 1),
    -- Beautician (24) 3 months
    (3, 7, 24, 36, 1, 1),
    (3, 7, 24, 39, 1, 1),
    (3, 7, 24, 49, 1, 1),
    (3, 7, 24, 52, 1, 1),
    -- Computer Applications Jaws Software (25) 3 months
    (3, 1, 25, 31, 1, 1),
    (3, 1, 25, 44, 1, 1),
    (3, 1, 25, 51, 1, 1),
    -- Computerized Accounting (26) 3 months
    (3, 1, 26, 33, 1, 1),
    (3, 1, 26, 47, 1, 1),
    (3, 1, 26, 56, 1, 1),
    -- Driver HTV (27) 3 months
    (3, 5, 27, 34, 1, 1),
    (3, 5, 27, 42, 1, 1),
    (3, 5, 27, 58, 1, 1),
    -- Farm Manager & Tunnel Farming (28) 6 months
    (3, 6, 28, 32, 1, 1),
    (3, 6, 28, 54, 1, 1),
    (3, 6, 28, 60, 1, 1),
    -- Fashion Design & Dress Making (29) 6 months
    (3, 7, 29, 35, 1, 1),
    (3, 7, 29, 50, 1, 1),
    (3, 7, 29, 52, 1, 1),
    -- Front Desk Manager & Receptionist (30) 3 months
    (3, 4, 30, 36, 1, 1),
    (3, 4, 30, 40, 1, 1),
    (3, 4, 30, 46, 1, 1),
    -- Fruit Plants Pruning Budding & Layering (31) 3 months
    (3, 6, 31, 54, 1, 1),
    (3, 6, 31, 55, 1, 1),
    (3, 6, 31, 60, 1, 1),
    -- Gemstone Cutting and Polishing (32) 6 months
    (3, 3, 32, 43, 1, 1),
    (3, 3, 32, 44, 1, 1),
    (3, 3, 32, 59, 1, 1),
    -- Hand & Machine Embroidery (33) 3 months
    (3, 7, 33, 37, 1, 1),
    (3, 7, 33, 49, 1, 1),
    (3, 7, 33, 57, 1, 1),
    -- Heavy Machinery Operator (34) 6 months
    (3, 5, 34, 33, 1, 1),
    (3, 5, 34, 42, 1, 1),
    (3, 5, 34, 45, 1, 1),
    -- Home Appliance Repair & Maintenance (35) 6 months
    (3, 3, 35, 31, 1, 1),
    (3, 3, 35, 48, 1, 1),
    (3, 3, 35, 51, 1, 1),
    -- Hybrid Seed Production & Contract Farming (36) 3 months
    (3, 6, 36, 32, 1, 1),
    (3, 6, 36, 55, 1, 1),
    (3, 6, 36, 58, 1, 1),
    -- Machinist (37) 6 months
    (3, 3, 37, 33, 1, 1),
    (3, 3, 37, 38, 1, 1),
    (3, 3, 37, 47, 1, 1),
    -- Motorcycle Mechanic (38) 6 months
    (3, 5, 38, 34, 1, 1),
    (3, 5, 38, 41, 1, 1),
    (3, 5, 38, 53, 1, 1),
    -- Plumbing & Solar Water Heating Technician (39) 6 months
    (3, 3, 39, 31, 1, 1),
    (3, 3, 39, 35, 1, 1),
    (3, 3, 39, 43, 1, 1),
    -- Professional Chef (40) 6 months
    (3, 4, 40, 36, 1, 1),
    (3, 4, 40, 39, 1, 1),
    (3, 4, 40, 46, 1, 1),
    -- Security Guard (41) 3 months
    (3, 8, 41, 32, 1, 1),
    (3, 8, 41, 38, 1, 1),
    (3, 8, 41, 44, 1, 1),
    -- Tissue Culture (42) 3 months
    (3, 6, 42, 32, 1, 1),
    (3, 6, 42, 54, 1, 1),
    (3, 6, 42, 60, 1, 1),
    -- Veterinary Poultry & Dairy Assistants (43) 3 months
    (3, 6, 43, 34, 1, 1),
    (3, 6, 43, 55, 1, 1),
    (3, 6, 43, 59, 1, 1),
    -- Welder TIG SMAW MIG SAW ARC (44) 6 months
    (3, 3, 44, 33, 1, 1),
    (3, 3, 44, 38, 1, 1),
    (3, 3, 44, 47, 1, 1),
    (3, 3, 44, 50, 1, 1);

-- ----------------------------------------------------------
-- BLOCK B: HIGH-END TRADES (45–96) → stipend=1, hostel=0
-- ----------------------------------------------------------
INSERT INTO course_offerings (program_id, sector_id, trade_id, institute_id, stipend_eligible, hostel_available) VALUES
    (4, 9, 45, 31, 1, 0),(4, 9, 45, 35, 1, 0),(4, 9, 45, 39, 1, 0),
    (4, 3, 46, 33, 1, 0),(4, 3, 46, 47, 1, 0),(4, 3, 46, 49, 1, 0),
    (4, 3, 47, 33, 1, 0),(4, 3, 47, 38, 1, 0),(4, 3, 47, 47, 1, 0),
    (4, 3, 48, 31, 1, 0),(4, 3, 48, 35, 1, 0),(4, 3, 48, 41, 1, 0),
    (4, 1, 49, 32, 1, 0),(4, 1, 49, 36, 1, 0),(4, 1, 49, 48, 1, 0),
    (4, 2, 50, 31, 1, 0),(4, 2, 50, 35, 1, 0),(4, 2, 50, 39, 1, 0),(4, 2, 50, 42, 1, 0),
    (4, 2, 51, 32, 1, 0),(4, 2, 51, 35, 1, 0),(4, 2, 51, 38, 1, 0),
    (4, 5, 52, 33, 1, 0),(4, 5, 52, 41, 1, 0),(4, 5, 52, 45, 1, 0),
    (4, 4, 53, 36, 1, 0),(4, 4, 53, 40, 1, 0),(4, 4, 53, 46, 1, 0),
    (4, 1, 54, 31, 1, 0),(4, 1, 54, 35, 1, 0),(4, 1, 54, 39, 1, 0),
    (4,10, 55, 32, 1, 0),(4,10, 55, 36, 1, 0),(4,10, 55, 43, 1, 0),
    (4, 1, 56, 31, 1, 0),(4, 1, 56, 48, 1, 0),(4, 1, 56, 52, 1, 0),
    (4, 8, 57, 32, 1, 0),(4, 8, 57, 35, 1, 0),(4, 8, 57, 39, 1, 0),
    (4, 1, 58, 31, 1, 0),(4, 1, 58, 44, 1, 0),(4, 1, 58, 51, 1, 0),
    (4, 4, 59, 36, 1, 0),(4, 4, 59, 39, 1, 0),(4, 4, 59, 46, 1, 0),
    (4, 4, 60, 35, 1, 0),(4, 4, 60, 38, 1, 0),(4, 4, 60, 53, 1, 0),
    (4, 4, 61, 36, 1, 0),(4, 4, 61, 40, 1, 0),(4, 4, 61, 58, 1, 0),
    (4, 8, 62, 31, 1, 0),(4, 8, 62, 36, 1, 0),(4, 8, 62, 48, 1, 0),
    (4, 1, 63, 32, 1, 0),(4, 1, 63, 35, 1, 0),(4, 1, 63, 39, 1, 0),
    (4, 6, 64, 32, 1, 0),(4, 6, 64, 54, 1, 0),(4, 6, 64, 60, 1, 0),
    (4, 1, 65, 31, 1, 0),(4, 1, 65, 35, 1, 0),(4, 1, 65, 39, 1, 0),(4, 1, 65, 48, 1, 0),
    (4, 9, 66, 32, 1, 0),(4, 9, 66, 35, 1, 0),(4, 9, 66, 39, 1, 0),
    (4, 3, 67, 33, 1, 0),(4, 3, 67, 47, 1, 0),(4, 3, 67, 51, 1, 0),
    (4, 6, 68, 32, 1, 0),(4, 6, 68, 42, 1, 0),(4, 6, 68, 54, 1, 0),
    (4,10, 69, 36, 1, 0),(4,10, 69, 40, 1, 0),(4,10, 69, 52, 1, 0),
    (4, 1, 70, 31, 1, 0),(4, 1, 70, 35, 1, 0),(4, 1, 70, 48, 1, 0),
    (4, 3, 71, 38, 1, 0),(4, 3, 71, 39, 1, 0),(4, 3, 71, 40, 1, 0),
    (4, 3, 72, 31, 1, 0),(4, 3, 72, 33, 1, 0),(4, 3, 72, 43, 1, 0),
    (4, 8, 73, 32, 1, 0),(4, 8, 73, 35, 1, 0),(4, 8, 73, 39, 1, 0),(4, 8, 73, 44, 1, 0),
    (4, 1, 74, 31, 1, 0),(4, 1, 74, 38, 1, 0),(4, 1, 74, 42, 1, 0),
    (4, 8, 75, 32, 1, 0),(4, 8, 75, 35, 1, 0),(4, 8, 75, 39, 1, 0),
    (4, 9, 76, 31, 1, 0),(4, 9, 76, 36, 1, 0),(4, 9, 76, 48, 1, 0),
    (4, 9, 77, 31, 1, 0),(4, 9, 77, 35, 1, 0),(4, 9, 77, 39, 1, 0),
    (4, 1, 78, 32, 1, 0),(4, 1, 78, 35, 1, 0),(4, 1, 78, 48, 1, 0),
    (4,10, 79, 34, 1, 0),(4,10, 79, 36, 1, 0),(4,10, 79, 53, 1, 0),
    (4, 5, 80, 33, 1, 0),(4, 5, 80, 41, 1, 0),(4, 5, 80, 45, 1, 0),
    (4, 3, 81, 31, 1, 0),(4, 3, 81, 38, 1, 0),(4, 3, 81, 47, 1, 0),
    (4, 3, 82, 33, 1, 0),(4, 3, 82, 41, 1, 0),(4, 3, 82, 49, 1, 0),
    (4, 7, 83, 35, 1, 0),(4, 7, 83, 50, 1, 0),(4, 7, 83, 53, 1, 0),
    (4, 5, 84, 31, 1, 0),(4, 5, 84, 38, 1, 0),(4, 5, 84, 47, 1, 0),
    (4, 9, 85, 32, 1, 0),(4, 9, 85, 35, 1, 0),(4, 9, 85, 39, 1, 0),
    (4, 2, 86, 31, 1, 0),(4, 2, 86, 35, 1, 0),(4, 2, 86, 48, 1, 0),
    (4, 8, 87, 32, 1, 0),(4, 8, 87, 35, 1, 0),(4, 8, 87, 39, 1, 0),
    (4, 1, 88, 31, 1, 0),(4, 1, 88, 35, 1, 0),(4, 1, 88, 38, 1, 0),(4, 1, 88, 42, 1, 0),
    (4, 5, 89, 38, 1, 0),(4, 5, 89, 39, 1, 0),(4, 5, 89, 40, 1, 0),
    (4, 9, 90, 31, 1, 0),(4, 9, 90, 35, 1, 0),(4, 9, 90, 39, 1, 0),
    (4, 3, 91, 33, 1, 0),(4, 3, 91, 41, 1, 0),(4, 3, 91, 47, 1, 0),
    (4, 4, 92, 36, 1, 0),(4, 4, 92, 40, 1, 0),(4, 4, 92, 46, 1, 0),
    (4, 6, 93, 32, 1, 0),(4, 6, 93, 42, 1, 0),(4, 6, 93, 54, 1, 0),
    (4,10, 94, 34, 1, 0),(4,10, 94, 36, 1, 0),(4,10, 94, 53, 1, 0),
    (4, 7, 95, 35, 1, 0),(4, 7, 95, 50, 1, 0),(4, 7, 95, 57, 1, 0),
    (4, 4, 96, 32, 1, 0),(4, 4, 96, 35, 1, 0),(4, 4, 96, 39, 1, 0);

-- ----------------------------------------------------------
-- BLOCK C: HIGH-TECH IT TRADES (97–133) → stipend=1, hostel=0
-- ----------------------------------------------------------
INSERT INTO course_offerings (program_id, sector_id, trade_id, institute_id, stipend_eligible, hostel_available) VALUES
    (4, 1, 97,  31, 1, 0),(4, 1, 97,  35, 1, 0),(4, 1, 97,  39, 1, 0),
    (4, 1, 98,  32, 1, 0),(4, 1, 98,  36, 1, 0),(4, 1, 98,  48, 1, 0),
    (4, 2, 99,  31, 1, 0),(4, 2, 99,  35, 1, 0),(4, 2, 99,  42, 1, 0),
    (4, 1, 100, 31, 1, 0),(4, 1, 100, 35, 1, 0),
    (4, 1, 101, 31, 1, 0),(4, 1, 101, 36, 1, 0),(4, 1, 101, 39, 1, 0),
    (4, 2, 102, 32, 1, 0),(4, 2, 102, 35, 1, 0),
    (4, 1, 103, 31, 1, 0),(4, 1, 103, 35, 1, 0),(4, 1, 103, 39, 1, 0),
    (4, 1, 104, 32, 1, 0),(4, 1, 104, 35, 1, 0),
    (4, 1, 105, 31, 1, 0),(4, 1, 105, 36, 1, 0),
    (4, 1, 106, 31, 1, 0),(4, 1, 106, 35, 1, 0),(4, 1, 106, 39, 1, 0),
    (4, 1, 107, 31, 1, 0),(4, 1, 107, 35, 1, 0),(4, 1, 107, 48, 1, 0),
    (4, 1, 108, 32, 1, 0),(4, 1, 108, 36, 1, 0),(4, 1, 108, 42, 1, 0),
    (4, 1, 109, 31, 1, 0),(4, 1, 109, 35, 1, 0),(4, 1, 109, 39, 1, 0),
    (4, 1, 110, 31, 1, 0),(4, 1, 110, 35, 1, 0),(4, 1, 110, 38, 1, 0),(4, 1, 110, 42, 1, 0),
    (4, 1, 111, 32, 1, 0),(4, 1, 111, 36, 1, 0),(4, 1, 111, 48, 1, 0),
    (4, 1, 112, 31, 1, 0),(4, 1, 112, 35, 1, 0),(4, 1, 112, 39, 1, 0),
    (4, 1, 113, 31, 1, 0),(4, 1, 113, 36, 1, 0),(4, 1, 113, 42, 1, 0),
    (4, 1, 114, 31, 1, 0),(4, 1, 114, 35, 1, 0),(4, 1, 114, 39, 1, 0),(4, 1, 114, 48, 1, 0),
    (4, 1, 115, 31, 1, 0),(4, 1, 115, 35, 1, 0),(4, 1, 115, 53, 1, 0),
    (4, 1, 116, 32, 1, 0),(4, 1, 116, 35, 1, 0),(4, 1, 116, 48, 1, 0),
    (4, 1, 117, 31, 1, 0),(4, 1, 117, 35, 1, 0),
    (4, 1, 118, 32, 1, 0),(4, 1, 118, 36, 1, 0),
    (4, 1, 119, 31, 1, 0),(4, 1, 119, 35, 1, 0),(4, 1, 119, 39, 1, 0),
    (4, 1, 120, 31, 1, 0),(4, 1, 120, 35, 1, 0),(4, 1, 120, 42, 1, 0),
    (4, 1, 121, 31, 1, 0),(4, 1, 121, 35, 1, 0),(4, 1, 121, 48, 1, 0),
    (4, 1, 122, 32, 1, 0),(4, 1, 122, 36, 1, 0),(4, 1, 122, 39, 1, 0),
    (4, 1, 123, 31, 1, 0),(4, 1, 123, 35, 1, 0),(4, 1, 123, 39, 1, 0),(4, 1, 123, 48, 1, 0),
    (4, 1, 124, 31, 1, 0),(4, 1, 124, 35, 1, 0),(4, 1, 124, 42, 1, 0),
    (4, 1, 125, 32, 1, 0),(4, 1, 125, 36, 1, 0),(4, 1, 125, 48, 1, 0),
    (4, 1, 126, 31, 1, 0),(4, 1, 126, 35, 1, 0),
    (4, 1, 127, 32, 1, 0),(4, 1, 127, 36, 1, 0),
    (4, 1, 128, 31, 1, 0),(4, 1, 128, 35, 1, 0),(4, 1, 128, 39, 1, 0),
    (4, 1, 129, 31, 1, 0),(4, 1, 129, 35, 1, 0),
    (4, 1, 130, 32, 1, 0),(4, 1, 130, 36, 1, 0),
    (4, 2, 131, 31, 1, 0),(4, 2, 131, 35, 1, 0),
    (4, 1, 132, 31, 1, 0),(4, 1, 132, 35, 1, 0),(4, 1, 132, 39, 1, 0),
    (4, 1, 133, 31, 1, 0),(4, 1, 133, 35, 1, 0),(4, 1, 133, 48, 1, 0);
