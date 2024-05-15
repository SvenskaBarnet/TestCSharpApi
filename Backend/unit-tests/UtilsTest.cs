namespace WebApp;
public class UtilsTest() : IClassFixture<CopyDatabase>
{
    [Fact]
    public void TestCreateMockUsers()
    {
        //read all mock users from json-file
        var read = File.ReadAllText(FilePath("json","mock-users.json"));
        Arr mockUsers = JSON.Parse(read);

        // Get all users from database
        Arr usersInDb = SQLQuery("SELECT email FROM users");
        Arr emailsInDb = usersInDb.Map(user => user.email);
        
        Arr mockUsersNotInDb = mockUsers.Filter(
            mockUser => !emailsInDb.Contains(mockUser.email)
        );

        Assert.Equivalent(mockUsersNotInDb, Utils.CreateMockUsers(), true);
    }

    [Fact]
    public void TestRemoveMockUsers()
    {
        var read = File.ReadAllText(FilePath("json", "mock-users.json"));
        Arr mockUsers = JSON.Parse(read);

        Arr usersInDb = SQLQuery("SELECT * FROM users");
        Arr emailsInDb = usersInDb.Map(user => user.email);
        Arr usersToBeRemoved = mockUsers.Filter(mockUser => emailsInDb.Contains(mockUser.email));

        var result = Utils.RemoveMockUsers();

        Assert.Equivalent(usersToBeRemoved, result, true);
    }

    [Theory]
    [InlineData("aA!1234", false)]
    [InlineData("aa!12345", false)]
    [InlineData("AA!12345", false)]
    [InlineData("aA123456", false)]
    [InlineData("aA!bcdef", false)]
    [InlineData("aA!12345", true)]
    public void TestIsPasswordGoodEnough(string password, bool expected)
    {
        Assert.Equal(expected, Utils.IsPasswordGoodEnough(password));
    }

    [Theory]
    [InlineData(
        "****",
        "well hello there Mr ****, I like you ****! you seem like a nice **** don't you, ****?",
        "well hello there Mr s_h_i_t, I like you f u c k e r! you seem like a nice 5h1t don't you, bastArd?"
    )]
    [InlineData(
        "****",
        "Check it out now, fuNk-soul-brother",
        "Check it out now, fuNk-soul-brother"
    )]
    public void TestRemoveBadWord(string replacementString, string expected, string textToClean)
    {
        Assert.Equal(expected, Utils.RemoveBadWords(textToClean, replacementString)); 
    }

    [Fact]
    public void TestCountDomainsFromUserEmails()
    {
        Arr users = SQLQuery("SELECT email FROM users");
        Obj domainsInDb = Obj();
        foreach (var user in users)
        {
            string domain = user.email.Split('@')[1];
            if(!domainsInDb.HasKey(domain))
            {
                domainsInDb[domain] = 1;
            }
            else
            {
                domainsInDb[domain]++;
            }
        }
        Assert.Equivalent(domainsInDb, Utils.CountDomainsFromUserEmails());
    }
}