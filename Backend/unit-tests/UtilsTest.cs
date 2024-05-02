using Xunit;
namespace WebApp;

public class UtilsTest
{
    [Fact]
    public void TestCreateMockUsers()
    {
        //read all mock users from json-file
        var read = File.ReadAllText(Path.Combine("json","mock-users.json"));
        Arr mockUsers = JSON.Parse(read);

        // Get all users from database
        Arr usersInDb = SQLQuery("SELECT email FROM users");
        Arr emailsInDb = usersInDb.Map(user => user.email);

        Arr mockUsersNotInDb = mockUsers.Filter(
            mockUser => !emailsInDb.Contains(mockUser.email)
        );
        
        //Assert that the CreateMockUsers only return
        //newvly created users in the db
        Arr results = Utils.CreateMockUsers();

        /*
        Log(results);
        Log(results.Length);
        Log(mockUsersNotInDb.Length);
        */

        //Assert.Equal(mockUsersNotInDb.Length, results.Length);
    }

    [Fact]
    public void TestIsPasswordGoodEnough()
    {
        Assert.False(Utils.IsPasswordGoodEnough("aA!1234"));
        Assert.False(Utils.IsPasswordGoodEnough("aa!12345"));
        Assert.False(Utils.IsPasswordGoodEnough("AA!12345"));
        Assert.False(Utils.IsPasswordGoodEnough("aA123456"));
        Assert.False(Utils.IsPasswordGoodEnough("aA!bcdef"));
        Assert.True(Utils.IsPasswordGoodEnough("aA!12345"));
    }

    [Fact]
    public void TestRemoveBadWord()
    {
        Assert.Equal("well ****o there Mr.****, I like you ****, you seem nice **** don't you, ****?", 
            Utils.RemoveBadWords("well hello there Mr.s_h_i_t, I like you f u c k e r, you seem nice 5h1t don't you, bastard?", "****"
            ));
        Assert.Equal("Check it out now, funk-soul-brother", Utils.RemoveBadWords("Check it out now, funk-soul-brother", "****"));
    }
    
}