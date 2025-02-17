<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>ASP.NET C# Test</title>
</head>
<body>
    <h1>Hello from ASP.NET with C#</h1>

    <% 
        // C# code block
        string name = "Janna";
        Response.Write("Hello, " + name + "!<br>");

        // Loop example
        for (int i = 1; i <= 5; i++)
        {
            Response.Write("Number: " + i + "<br>");
        }
    %>

</body>
</html>
