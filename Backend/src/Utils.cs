namespace WebApp;
public static class Utils
{
    public static Arr CreateMockUsers()
    {
        var read = File.ReadAllText(FilePath("json", "mock-users.json"));
        Arr mockUsers = JSON.Parse(read);

        //Defines which mockUsers that's already in the database to make sure that the method only encrypts passwords for those users that's to be added.
        Arr mockUsersNotInDb = Arr();
        foreach(var user in mockUsers)
        {
            Obj userExists = SQLQueryOne("SELECT count(*) FROM users WHERE email = $email", user);
            if(userExists["count(*)"] == 0)
            {
                mockUsersNotInDb.Push(user);
            }
        }

        // I declare a generic password here and comment out the proper code to generate a password for each user.
        // I do this to make the tests run faster and smoother since encrypting every users password takes a lot of time.
        string encryptedGenericPassword = Password.Encrypt("Aa!12345");

        Arr successfullyWrittenUsers = Arr();
        foreach (var user in mockUsersNotInDb)
        {
            //Adds 2024 before user email and changes first letter to uppercase
            //user.password = $"2024{user.email[0].ToString().ToUpper()}{user.email.Substring(1)}";

            //Checks if the password is good enough
            //if (IsPasswordGoodEnough(user.password))
            if(IsPasswordGoodEnough(encryptedGenericPassword))
            {
                //user.password = Password.Encrypt(user.password);
                user.password = encryptedGenericPassword;
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
        var read = File.ReadAllText(FilePath("json", "mock-users.json"));
        Arr mockUsers = JSON.Parse(read);
        Arr usersInDb = SQLQuery("SELECT email FROM users");
        Arr emailsInDb = usersInDb.Map(user => user.email);
        Arr mockUsersInDb = mockUsers.Filter(mockUser => emailsInDb.Contains(mockUser.email));
        Arr deletedMockUsers = Arr();

        foreach (var user in mockUsersInDb)
        {
            user.Delete("password");
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
        var read = File.ReadAllText(FilePath("json", "bad-words.json"));
        Arr badWords = JSON.Parse(read).badwords;
        var badWordsOrdered = badWords.OrderByDescending(word => word.ToString().Length);
        string cleanText = textToClean;

        foreach (var word in badWordsOrdered)
        {
            cleanText = Regex.Replace(cleanText, word.ToString(), replacementString, RegexOptions.IgnoreCase);
        }

        return cleanText;
    }

    public static Obj CountDomainsFromUserEmails()
    {
        Arr domains = SQLQueryOne("SELECT SUBSTRING(email, instr(email, '@') + 1, length(email)) AS domain, count(id) AS count FROM users GROUP BY domain");
        Obj countedDomains = Obj();
        foreach(var domain in domains)
        {
            countedDomains[domain.domain] = domain.count;
        }
        return countedDomains;
    }
}