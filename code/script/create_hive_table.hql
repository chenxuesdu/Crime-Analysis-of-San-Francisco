CREATE EXTERNAL TABLE IF NOT EXISTS incidents (
    incidentNum  INT,
    category STRING,
    descript STRING,
    dayofweek TINYINT,
    time BIGINT,
    district STRING,
    address STRING,
    resolution STRING,
    x FLOAT,
    y FLOAT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/user/chenxue/warehouse/incidents/';
