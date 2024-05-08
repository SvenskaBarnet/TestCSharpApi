namespace WebApp;


public class UtilsTest : IClassFixture<CopyDatabase>
{
    CopyDatabase copyDatabase;

    public UtilsTest(CopyDatabase copyDatabase)
    {
        this.copyDatabase = copyDatabase;
    }

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

        Assert.Equivalent(mockUsersNotInDb, Utils.CreateMockUsers());
    }

    [Fact]
    public void TestRemoveMockUsers()
    {
        var read = File.ReadAllText(FilePath("json", "mock-users.json"));
        Arr mockUsers = JSON.Parse(read);
        Arr usersToBeRemoved = Arr();

        foreach (var user in mockUsers)
        {
            Obj userExists = SQLQueryOne("SELECT * FROM users WHERE id = 1");
            if(userExists != null)
            {
                usersToBeRemoved.Push(userExists);
            }
        }
        Assert.Equivalent(usersToBeRemoved, Utils.RemoveMockUsers());
    }

    [Theory]
    [InlineData("aA!1234")]
    [InlineData("aa!12345")]
    [InlineData("AA!12345")]
    [InlineData("aA123456")]
    [InlineData("aA!bcdef")]
    public void TestIsPasswordGoodEnough(string password)
    {
        Assert.False(Utils.IsPasswordGoodEnough(password));
    }

    [Fact]
    public void TestRemoveBadWord()
    {
        Assert.Equal("well ****o there Mr.****, I like you****, you seem nice **** don't you, ****?", 
            Utils.RemoveBadWords("well hello there Mr.s_h_i_t, I like youf u c k e r, you seem nice 5h1t don't you, bastArd?", "****"
            ));
        Assert.Equal("Check it out now, fuNk-soul-brother", Utils.RemoveBadWords("Check it out now, fuNk-soul-brother", "****"));
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