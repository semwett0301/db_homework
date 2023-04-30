create table if not exists sample
(
    id    serial PRIMARY KEY,
    name  VARCHAR(64) NOT NULL,
    data  text,
    value int default 0
);

create FUNCTION sample_trigger() RETURNS TRIGGER AS
'
    BEGIN
        IF (SELECT value FROM sample where id = NEW.id ) > 1000
           THEN
           RAISE SQLSTATE ''23503'';
           END IF;
        RETURN NEW;
    END;
' LANGUAGE plpgsql;

create TRIGGER sample_value
    AFTER insert
    ON sample
    FOR EACH ROW
EXECUTE PROCEDURE sample_trigger();


CREATE TABLE IF NOT EXISTS PRODUCT
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(256) NOT NULL,
    description TEXT,
    brand_name VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS COMPANY
(
    name  VARCHAR(256) PRIMARY KEY,
    phone_number VARCHAR(256) NOT NULL UNIQUE CHECK ( phone_number ~ '^([0-9]{11})$'),
    city VARCHAR(256),
    zip_code int CHECK ( zip_code > 0 ),
    street_info VARCHAR(256)

    CONSTRAINT equalZipCodeMeanEqualCity
    CHECK ( )
);

CREATE TABLE IF NOT EXISTS COMPANY_EMAIL
(
    company_name VARCHAR(256),
    email VARCHAR(256) CHECK ( email ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' ),
    PRIMARY KEY (company_name, email),
    FOREIGN KEY (company_name) REFERENCES COMPANY(name)
);

CREATE TABLE IF NOT EXISTS PRODUCE
(
    company_name VARCHAR(256),
    product_id INT CHECK ( product_id > 0 ),
    capacity INT NOT NULL CHECK ( capacity > 0 ),
    PRIMARY KEY (company_name, product_id),
    FOREIGN KEY (company_name) REFERENCES Company (name),
    FOREIGN KEY (product_id) REFERENCES Product (id)
);

CREATE TABLE IF NOT EXISTS TRANSACTION
(
    company_name VARCHAR(256),
    product_id INT CHECK ( product_id > 0 ),
    order_date TIMESTAMP,
    amount INT NOT NULL CHECK ( amount > 0 ),
    PRIMARY KEY (company_name, product_id, order_date),
    FOREIGN KEY (company_name) REFERENCES Company (name),
    FOREIGN KEY (product_id) REFERENCES Product (id)
);
