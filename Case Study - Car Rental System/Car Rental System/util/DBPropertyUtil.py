import pyodbc

class PropertyUtil:
    @staticmethod
    def getPropertyString():
        server_name = "SRIKAR"
        database_name = "Car Rental System"
        trusted_connection = "yes"
        return f"Driver={{SQL Server}};Server={server_name};Database={database_name};Trusted_Connection={trusted_connection};"
