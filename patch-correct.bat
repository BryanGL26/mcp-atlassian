@echo off
echo === Aplicando parches CORRECTOS para FastMCP 2.13.0 ===
echo.

REM 1. Remover SOLO anotaciones de tipo ctx: Context (NO tocar Field descriptions)
echo Parcheando anotaciones de tipo ctx...
powershell -Command "(Get-Content 'src\mcp_atlassian\servers\confluence.py') -replace '    ctx: Context,', '    ctx,' | Set-Content 'src\mcp_atlassian\servers\confluence.py'"
powershell -Command "(Get-Content 'src\mcp_atlassian\servers\jira.py') -replace '    ctx: Context,', '    ctx,' | Set-Content 'src\mcp_atlassian\servers\jira.py'"
powershell -Command "(Get-Content 'src\mcp_atlassian\servers\dependencies.py') -replace '    ctx: Context,', '    ctx,' -replace '    ctx: Context\)', '    ctx)' | Set-Content 'src\mcp_atlassian\servers\dependencies.py'"

REM 2. Remover SOLO la línea description= de FastMCP() (líneas 18-19)
echo Removiendo description de FastMCP en confluence.py...
powershell -Command "$content = Get-Content 'src\mcp_atlassian\servers\confluence.py'; $content[18] = $content[18] -replace 'description=.*,', ''; $content | Set-Content 'src\mcp_atlassian\servers\confluence.py'"

echo Removiendo description de FastMCP en jira.py...
powershell -Command "$content = Get-Content 'src\mcp_atlassian\servers\jira.py'; $content[18] = $content[18] -replace 'description=.*,', ''; $content | Set-Content 'src\mcp_atlassian\servers\jira.py'"

REM 3. Actualizar pyproject.toml
echo Actualizando pyproject.toml...
powershell -Command "(Get-Content 'pyproject.toml') -replace '\"mcp>=1.8.0,<2.0.0\"', '\"mcp>=1.10.0\"' -replace '\"fastmcp>=2.3.4,<2.4.0\"', '\"fastmcp>=2.13.0\"' | Set-Content 'pyproject.toml'"

echo.
echo === Parches aplicados ===
