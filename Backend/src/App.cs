// Global settings

using System.ComponentModel.DataAnnotations;

Globals = Obj(new
{
    debugOn = true,
    detailedAclDebug = false,
    aclOn = true,
    isSpa = true,
    port = 3001,
    serverName = "SvenskaBarnets server",
    frontendPath = FilePath("..", "Frontend"),
    sessionLifeTimeHours = 2
});

try
{
ScriptRunner.Run();
}
catch(Exception ex)
{
    Console.WriteLine($"An error occured: {ex.Message}");
}
Server.Start();