Product
============
- *Product (id, name, description, brand_name)*
- ***PRIMARY KEY (Product)** = \<id\>*
- ***Product (name)** cannot be NULL*

Company
============
- *Company (name, phone_number, country, city, zip_code, street_info)*
- ***PRIMARY KEY (Company)** = \<name\>*
- ***CANDIDATE KEY (Company)** = <phone_number>*
- ***Company (phone_number)** cannot be NULL*

CompanyEmail
============
- *CompanyEmail (company_name, email)*
- ***PRIMARY KEY (CompanyEmail)** = <company_name, email>*
- ***FOREIGN KEY CompanyEmail(company_name)** REFERENCES Company(name)*

Produce
============
- *Produce (company_name, product_name, capacity)*
- ***PRIMARY KEY (Produce)** = <company_name, product_id>*
- ***FOREIGN KEY Produce (company_name)** REFERENCES Company (name)*
- ***FOREIGN KEY Produce (product_id)** REFERENCES Product (id)*
- ***Produce (capacity)** cannot be NULL*

Transaction
============
- *Transaction (company_name, product_id, order_date, amount)*
- ***PRIMARY KEY (Transaction)** = <company_name, product_id, order_date>*
- ***FOREIGN KEY Transaction (company_name)** REFERENCES Company (name)*
- ***FOREIGN KEY Transaction (product_id)** REFERENCES Product (id)*
- ***Transaction (capacity)** cannot be null*

