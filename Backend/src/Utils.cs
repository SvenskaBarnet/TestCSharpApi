namespace WebApp;
public static class Utils
{
    private readonly static Arr mockUsers = JSON.Parse(File.ReadAllText(FilePath("json", "mock-users.json")));
    private readonly static List<string> badWords = [.. 
        JsonDocument.Parse(
        File.ReadAllText(FilePath("json", "bad-words.json")))
        .RootElement.EnumerateArray().Where(element => element.ValueKind == JsonValueKind.String)
        .Select(element => element.GetString())
        .OrderByDescending(word => word.Length)
        ];
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
                    successfullyWrittenUsers.Push(user);
                }
            }
        }
        return successfullyWrittenUsers;
    }

    public static Arr RemoveMockUsers()
    {
        Arr usersInDb = SQLQuery("SELECT * FROM users");

        Arr mockUserEmails = Arr();
        mockUsers.ForEach(mockUser => mockUserEmails.Push(mockUser.email));

        Arr mockUsersInDb = usersInDb.Filter(user => mockUserEmails.Contains(user.email));

        Arr deletedMockUsers = Arr();
        foreach (var user in mockUsersInDb)
        {
            var result = SQLQueryOne("DELETE FROM users WHERE email = $email", user);
            if(result.rowsAffected != 0)
            {
                user.Delete("password");
                deletedMockUsers.Push(user);
            }
        }
        return deletedMockUsers;
    }

    public static bool IsPasswordGoodEnough(string password)
    {
        List<bool> bools =
        [
            password.Length >= 8,
            password.Any(char.IsUpper),
            password.Any(char.IsLower),
            password.Any(ch => !char.IsLetterOrDigit(ch)),
            password.Any(char.IsDigit),
        ];
        return !bools.Contains(false);
    }

    public static string RemoveBadWords(string textToClean, string replacementString)
    {
        foreach (var word in badWords)
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