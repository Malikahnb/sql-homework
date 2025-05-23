DECLARE @HTML NVARCHAR(MAX);

SET @HTML = 
    '<html>
    <head>
        <style>
            table { border-collapse: collapse; width: 100%; }
            th, td { border: 1px solid #dddddd; text-align: left; padding: 8px; }
            th { background-color: #f2f2f2; }
        </style>
    </head>
    <body>
        <h3>Index Metadata Report</h3>
        <table>
            <tr>
                <th>Table Name</th>
                <th>Index Name</th>
                <th>Index Type</th>
                <th>Column Name</th>
                <th>Column Type</th>
            </tr>';

SELECT @HTML = @HTML + '
            <tr>
                <td>' + s.name + '.' + t.name + '</td>
                <td>' + i.name + '</td>
                <td>' + i.type_desc + '</td>
                <td>' + c.name + '</td>
                <td>' + ty.name + '</td>
            </tr>'
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN sys.indexes i ON t.object_id = i.object_id AND i.is_hypothetical = 0
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
INNER JOIN sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY s.name, t.name, i.name;

SET @HTML = @HTML + '
        </table>
    </body>
    </html>';



EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'FirstMail',
    @recipients = 'mkhasanboeva@gmail.com',
    @subject = 'Test Email from SQL Server',
    @body = 'If you received this email, Database Mail is working!';




