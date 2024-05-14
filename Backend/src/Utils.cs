namespace WebApp;
public static class Utils
{
    private readonly static Arr mockUsers = JSON.Parse(File.ReadAllText(FilePath("json", "mock-users.json")));
  //  private readonly static Arr badWords = JSON.Parse(File.ReadAllText(FilePath("json", "bad-words.json")));
    public static Arr CreateMockUsers()
    {
        Arr successfullyWrittenUsers = Arr();
        foreach (var user in mockUsers)
        {
            if(IsPasswordGoodEnough(user.password.ToString()))
            {
                var result = SQLQueryOne(
                    @"INSERT INTO users(firstName, lastName, email, password)
                    VALUES ($firstName, $lastName, $email, $password)
                ", user);
                if (!result.HasKey("error"))
                {
                    user.Delete("password");
                    successfullyWrittenUsers.Push(user);
                }
            }
        }
        return successfullyWrittenUsers;
    }

    public static Arr RemoveMockUsers()
    {
        Arr usersInDb = SQLQuery("SELECT email FROM users");
        Arr emailsInDb = usersInDb.Map(user => user.email);
        Arr mockUsersInDb = mockUsers.Filter(mockUser => emailsInDb.Contains(mockUser.email));
        Arr deletedMockUsers = Arr();

        foreach (var user in mockUsersInDb)
        {
            SQLQueryOne("DELETE FROM users WHERE email = $email", user);
            deletedMockUsers.Push(user);
        }
        return deletedMockUsers;
    }

    public static bool IsPasswordGoodEnough(string password)
    {
        List<bool> bools =
        [
            password.Length > 7,
            password.Any(char.IsUpper),
            password.Any(char.IsLower),
            password.Any(ch => !char.IsLetterOrDigit(ch)),
            password.Any(char.IsDigit),
        ];
        return !bools.Contains(false);
    }

    public static string RemoveBadWords(string textToClean, string replacementString)
    {
        Arr badWords = JSON.Parse(File.ReadAllText(FilePath("json", "bad-words.json")));
        var badWordsOrdered = badWords.OrderByDescending(word => word.ToString().Length);

        foreach (var word in badWordsOrdered)
        {
            textToClean = Regex.Replace(textToClean, $"\\b{word.ToString()}\\b", replacementString, RegexOptions.IgnoreCase);
        }
        return textToClean;
    }

    public static Obj CountDomainsFromUserEmails()
    {
        Arr domains = SQLQuery("SELECT SUBSTRING(email, instr(email, '@') + 1, length(email)) AS domain, count(id) AS count FROM users GROUP BY domain");
        Obj countedDomains = Obj();
        foreach(var domain in domains)
        {
            countedDomains[domain.domain] = domain.count;
        }
        return countedDomains;
    }
}