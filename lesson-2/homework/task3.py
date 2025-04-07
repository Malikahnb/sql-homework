import pyodbc

# Database connection
conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=WINDOWS-6LPFCL5;'
    'DATABASE=class2;'
    'Trusted_Connection=yes;'
)

cursor = conn.cursor()

# Retrieve the image
cursor.execute("SELECT image FROM photos WHERE id = 1")
row = cursor.fetchone()

if row and row.image:
    with open("retrieved_image.jpg", "wb") as file:
        file.write(row.image)
    print("Image saved as retrieved_image.jpg")
else:
    print("No image found.")

cursor.close()
conn.close()
