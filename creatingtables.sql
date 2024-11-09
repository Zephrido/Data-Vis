CREATE TABLE clients (
    Id_client INT,
    Total_amount INT,
    Gender CHAR(1),
    Age INT,
    Count_city INT,
    Response_communication INT,
    Communication_3month INT,
    Tenure INT
);

CREATE TABLE transactions (
    date_new DATE,
    Id_check INT,
    ID_client INT,
    Count_products NUMERIC,
    Sum_payment NUMERIC
);