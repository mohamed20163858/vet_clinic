CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    status VARCHAR(100) NOT NULL,
    patient_id BIGINT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients (id)
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE medical_treatments (
    treatment_id BIGINT NOT NULL,
    medical_histories_id BIGINT NOT NULL,
    FOREIGN KEY (treatment_id) REFERENCES treatments (id),
    FOREIGN KEY (medical_histories_id) REFERENCES medical_histories (id),
    PRIMARY KEY (treatment_id, medical_histories_id)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL(10, 2) NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    paid_at TIMESTAMP NOT NULL,
    medical_history_id INT UNIQUE,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    invoice_id BIGINT NOT NULL,
    treatment_id BIGINT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices (id),
    FOREIGN KEY (treatment_id) REFERENCES treatments (id)
);
CREATE INDEX patient_id_index ON medical_histories(patient_id);
CREATE INDEX medical_histories_id_index ON medical_treatments(medical_histories_id);
CREATE INDEX treatment_id_index ON medical_treatments(treatment_id);
CREATE INDEX invoice_id_index ON invoice_items(invoice_id);
CREATE INDEX medical_history_id_index ON invoices(medical_history_id);
CREATE INDEX treatment_id_index_2 ON invoice_items(treatment_id);



