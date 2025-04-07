CREATE TABLE data_types_demo (
    id INT,
    name CHAR(10),
    description VARCHAR(100),
    price DECIMAL(10, 2),
    rating FLOAT,
    is_active BIT,
    created_date DATE,
    created_datetime DATETIME,
    image VARBINARY(MAX),
    uid UNIQUEIDENTIFIER
);


INSERT INTO data_types_demo (
    id, name, description, price, rating, is_active, created_date, created_datetime, image, uid
)
VALUES (
    1,
    'ItemOne',
    'This is a test item with multiple data types.',
    49.99,
    4.7,
    1,
    '2025-04-07',
    GETDATE(),
    CONVERT(VARBINARY(MAX), 'FakeBinaryData'),
    NEWID()
);

SELECT * FROM data_types_demo;
