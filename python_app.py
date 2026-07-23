import sqlite3
from pathlib import Path


DATABASE_PATH = Path(__file__).with_name("hospital.db")


def connect_database() -> sqlite3.Connection:
    """Create and return a connection to the SQLite database."""
    connection = sqlite3.connect(DATABASE_PATH)
    connection.row_factory = sqlite3.Row
    connection.execute("PRAGMA foreign_keys = ON;")
    return connection


def print_rows(rows: list[sqlite3.Row]) -> None:
    """Print database rows in a simple readable format."""
    if not rows:
        print("\nNo records found.\n")
        return

    columns = rows[0].keys()

    print()
    print(" | ".join(columns))
    print("-" * 80)

    for row in rows:
        print(" | ".join(str(row[column]) for column in columns))

    print()


def view_patients(connection: sqlite3.Connection) -> None:
    rows = connection.execute(
        """
        SELECT
            patient_id,
            first_name,
            last_name,
            birth_date,
            gender,
            phone,
            email,
            address
        FROM Patients
        ORDER BY last_name, first_name;
        """
    ).fetchall()

    print_rows(rows)


def view_doctors(connection: sqlite3.Connection) -> None:
    rows = connection.execute(
        """
        SELECT
            D.doctor_id,
            D.first_name,
            D.last_name,
            D.specialty,
            DP.department_name
        FROM Doctors AS D
        JOIN Departments AS DP
            ON D.department_id = DP.department_id
        ORDER BY DP.department_name, D.last_name;
        """
    ).fetchall()

    print_rows(rows)


def view_appointments(connection: sqlite3.Connection) -> None:
    rows = connection.execute(
        """
        SELECT
            A.appointment_id,
            P.first_name || ' ' || P.last_name AS patient,
            D.first_name || ' ' || D.last_name AS doctor,
            D.specialty,
            A.appointment_date,
            A.appointment_time,
            A.reason,
            A.status
        FROM Appointments AS A
        JOIN Patients AS P
            ON A.patient_id = P.patient_id
        JOIN Doctors AS D
            ON A.doctor_id = D.doctor_id
        ORDER BY A.appointment_date, A.appointment_time;
        """
    ).fetchall()

    print_rows(rows)


def search_patient(connection: sqlite3.Connection) -> None:
    search_term = input("Enter patient first name or last name: ").strip()

    if not search_term:
        print("\nPlease enter a name.\n")
        return

    rows = connection.execute(
        """
        SELECT
            patient_id,
            first_name,
            last_name,
            birth_date,
            phone,
            email,
            address
        FROM Patients
        WHERE first_name LIKE ?
           OR last_name LIKE ?
        ORDER BY last_name, first_name;
        """,
        (f"%{search_term}%", f"%{search_term}%"),
    ).fetchall()

    print_rows(rows)


def show_statistics(connection: sqlite3.Connection) -> None:
    statistics = connection.execute(
        """
        SELECT
            (SELECT COUNT(*) FROM Patients) AS total_patients,
            (SELECT COUNT(*) FROM Doctors) AS total_doctors,
            (SELECT COUNT(*) FROM Departments) AS total_departments,
            (SELECT COUNT(*) FROM Appointments) AS total_appointments,
            (
                SELECT COUNT(*)
                FROM Appointments
                WHERE status = 'Completed'
            ) AS completed_appointments,
            (
                SELECT COUNT(*)
                FROM Appointments
                WHERE status = 'Scheduled'
            ) AS scheduled_appointments;
        """
    ).fetchone()

    print("\nHospital Database Statistics")
    print("-" * 30)

    for column in statistics.keys():
        print(f"{column}: {statistics[column]}")

    print()


def display_menu() -> None:
    print(
        """
=================================
 Hospital Database Management
=================================
1. View patients
2. View doctors
3. View appointments
4. Search patient
5. Show statistics
6. Exit
"""
    )


def main() -> None:
    if not DATABASE_PATH.exists():
        print(f"Database not found: {DATABASE_PATH}")
        return

    try:
        with connect_database() as connection:
            while True:
                display_menu()
                choice = input("Select an option: ").strip()

                if choice == "1":
                    view_patients(connection)
                elif choice == "2":
                    view_doctors(connection)
                elif choice == "3":
                    view_appointments(connection)
                elif choice == "4":
                    search_patient(connection)
                elif choice == "5":
                    show_statistics(connection)
                elif choice == "6":
                    print("\nGoodbye.")
                    break
                else:
                    print("\nInvalid option. Please select 1–6.\n")

    except sqlite3.Error as error:
        print(f"\nDatabase error: {error}")


if __name__ == "__main__":
    main()
