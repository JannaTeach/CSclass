<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<html>
<head>
    <title>ASP.NET + SQL Example</title>
    <style>
        body  { font-family: Arial, sans-serif; margin: 30px; }
        table { border-collapse: collapse; width: 60%; }
        th, td { border: 1px solid #aaa; padding: 8px 12px; text-align: left; }
        th    { background-color: #4a90d9; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Student List — SQL Example</h1>
    <p>
        This page connects to a SQL Server database using <strong>ADO.NET</strong>
        and reads data from the <code>Students</code> table.
    </p>

    <%
        // -------------------------------------------------------
        // 1. Connection String — choose one option:
        //
        // Option A: GitHub Codespaces (devcontainer)
        //   string connectionString =
        //       "Server=db;Database=SchoolDB;User Id=sa;Password=YourPassword123!;TrustServerCertificate=True;";
        //
        // Option B: Local SQL Server Express / LocalDB
        //   string connectionString =
        //       "Server=(localdb)\\MSSQLLocalDB;Database=SchoolDB;Integrated Security=true;";
        //
        // Option C: Remote server
        //   string connectionString =
        //       "Server=YOUR_SERVER;Database=SchoolDB;User Id=YOUR_USER;Password=YOUR_PASSWORD;";
        // -------------------------------------------------------
        string connectionString =
            "Server=db;Database=SchoolDB;User Id=sa;Password=YourPassword123!;TrustServerCertificate=True;";

        // -------------------------------------------------------
        // 2. SQL query
        // -------------------------------------------------------
        string query = "SELECT Id, Name, Grade, Email FROM Students ORDER BY Grade DESC";

        try
        {
            // 3. Open connection
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // 4. Create command
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // 5. Execute and read results
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        Response.Write("<table>");
                        Response.Write("<tr><th>ID</th><th>Name</th><th>Grade</th><th>Email</th></tr>");

                        while (reader.Read())
                        {
                            int    id    = (int)    reader["Id"];
                            string name  = (string) reader["Name"];
                            int    grade = (int)    reader["Grade"];
                            string email = reader["Email"] != DBNull.Value
                                           ? (string)reader["Email"]
                                           : "—";

                            Response.Write(
                                "<tr>" +
                                "<td>" + id    + "</td>" +
                                "<td>" + name  + "</td>" +
                                "<td>" + grade + "</td>" +
                                "<td>" + email + "</td>" +
                                "</tr>"
                            );
                        }

                        Response.Write("</table>");
                    }
                }
            }
        }
        catch (SqlException ex)
        {
            // Show a friendly error message (never show full exceptions in production!)
            Response.Write("<p class='error'>Database error: " + ex.Message + "</p>");
        }
    %>

    <hr/>
    <h2>Key Concepts</h2>
    <ul>
        <li><strong>SqlConnection</strong> — opens the connection to SQL Server</li>
        <li><strong>SqlCommand</strong>    — holds the SQL query to run</li>
        <li><strong>SqlDataReader</strong> — reads rows one by one (forward-only)</li>
        <li><strong>using(...)</strong>    — automatically closes/disposes resources</li>
    </ul>

</body>
</html>
