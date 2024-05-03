// Global settings
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
var a = new UtilsTest();
//a.TestCreateMockUsers();
/*
while(true)
{
Console.Write("Enter Password: ");
string password = Console.ReadLine();
Log(WebApp.Utils.IsPasswordGoodEnough(password));
}
*/
//a.TestRemoveBadWord();
a.TestCountDomainsFromUserEmails();