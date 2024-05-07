// Global settings
using Xunit.Sdk;

Globals = Obj(new
{
    debugOn = true,
    detailedAclDebug = false,
    aclOn = true,
    isSpa = true,
    port = 3001,
    serverName = "Ironboy's Minimal API Server",
    frontendPath = FilePath("..", "Frontend"),
    sessionLifeTimeHours = 2
});

//Server.Start();
/*
while(true)
{
Console.Write("Enter Password: ");
string password = Console.ReadLine();
Log(WebApp.Utils.IsPasswordGoodEnough(password));
}
*/
//WebApp.Utils.CountDomainsFromUserEmails();
//WebApp.Utils.CreateMockUsers();
//WebApp.Utils.RemoveMockUsers();
