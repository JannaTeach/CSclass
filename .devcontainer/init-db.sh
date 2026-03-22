#!/bin/bash
set -e

# -------------------------------------------------------
# Install sqlcmd (Microsoft SQL Server command-line tool)
# -------------------------------------------------------
if ! command -v sqlcmd &>/dev/null; then
    echo "Installing sqlcmd..."
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - 2>/dev/null
    curl -fsSL https://packages.microsoft.com/config/ubuntu/22.04/prod.list \
        | sudo tee /etc/apt/sources.list.d/mssql-release.list > /dev/null
    sudo apt-get update -q
    sudo ACCEPT_EULA=Y apt-get install -y -q mssql-tools18 unixodbc-dev
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
fi

SQLCMD=/opt/mssql-tools18/bin/sqlcmd
SA_PASS="YourPassword123!"

# -------------------------------------------------------
# Wait for SQL Server to be ready (up to 60 seconds)
# -------------------------------------------------------
echo "Waiting for SQL Server to start..."
for i in {1..30}; do
    $SQLCMD -S db -U sa -P "$SA_PASS" -C -Q "SELECT 1" &>/dev/null && break
    echo "  Attempt $i/30 — retrying in 2s..."
    sleep 2
done

# -------------------------------------------------------
# Create database and tables
# -------------------------------------------------------
echo "Creating SchoolDB database..."
$SQLCMD -S db -U sa -P "$SA_PASS" -C \
    -Q "IF NOT EXISTS (SELECT * FROM sys.databases WHERE name='SchoolDB') CREATE DATABASE SchoolDB"

echo "Running DatabaseSetup.sql..."
$SQLCMD -S db -U sa -P "$SA_PASS" -C -d SchoolDB \
    -i /workspaces/CSclass/DatabaseSetup.sql

echo ""
echo "Done! SQL Server is ready."
echo "Connection string for DatabaseExample.aspx:"
echo "  Server=db;Database=SchoolDB;User Id=sa;Password=YourPassword123!;TrustServerCertificate=True;"
