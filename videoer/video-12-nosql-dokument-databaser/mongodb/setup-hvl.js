// setup-hvl.js
// Script to create hvl_db database and teacher collection with sample data

// Switch to hvl_db database (creates it if it doesn't exist)
db = db.getSiblingDB('hvl_db');

// Drop the collection if it exists (for clean re-runs)
db.teacher.drop();
db.student.drop();

// Insert sample teachers (matching Cassandra example)
db.teacher.insertMany([
    {
        fornavn: "Lasse",
        etternavn: "Jenssen"
    },
    {
        fornavn: "Lars-Petter",
        etternavn: "Helland"
    },
    {
        fornavn: "Dag",
        etternavn: "Toppe Larsen"
    }
]);

// Print success message
print("\n✓ Teacher collection created successfully!");
print("\nInserted " + db.teacher.countDocuments() + " teachers.");

// Insert students
db.student.insertMany([    {
        fornavn: "Per",
        etternavn: "Olsen"
    },
    {
        fornavn: "Anne",
        etternavn: "Larsen"
    },
    {
        fornavn: "Erik",
        etternavn: "Johansen"
    },
    {
        fornavn: "Ingrid",
        etternavn: "Andersen"
    },
    {
        fornavn: "Thomas",
        etternavn: "Berg"
    }
]);

// Print success message
print("\n✓ Student collection created successfully!");
print("\nInserted " + db.student.countDocuments() + " students.");

// Display all teachers
print("\nAll teachers:");
db.teacher.find().forEach(printjson);

// Display all students
print("\nAll students:");
db.student.find().forEach(printjson);

// Create indexes for better query performance
db.teacher.createIndex({ fornavn: 1 });
db.teacher.createIndex({ etternavn: 1 });
db.student.createIndex({ fornavn: 1 });
db.student.createIndex({ etternavn: 1 });

print("\n✓ Indexes created on fornavn and etternavn");

