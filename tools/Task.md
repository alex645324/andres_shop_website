🎯 GOAL:
Connect the existing Flutter project to Firebase and ensure all data from the “Book Today” section is stored and managed properly.

🧩 CONTEXT:
- Some initial Firebase setup has already been completed.
- The “Book Today” section allows users to create entries such as walk-ins, appointments, or other session types.
- The system should categorize and store these entries based on what the user selects.

🛠️ TASKS TO EXECUTE:
1. Connect the current project to Firebase (use Firestore as the main database if not already done).
2. Create a collection to store all data submitted from the “Book Today” section.
3. Each entry should include:
   - User ID
   - Selected type (e.g., Appointment, Walk-in, or custom label)
   - Date and time
   - Additional details entered by the user
4. Store the data in Firebase in a structured way (e.g., `/bookings/{userId}/entries/{entryId}`).
5. Ensure this data can later be accessed and managed by the admin dashboard.

📋 OUTPUT:
A working Firebase connection with proper data storage structure for “Book Today” submissions that supports admin management of walk-ins and appointments.
