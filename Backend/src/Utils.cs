using System.ComponentModel.Design;
using Microsoft.AspNetCore.Identity;

namespace WebApp;
public static class Utils
{
    public static Arr CreateMockUsers()
    {
        var read = File.ReadAllText(FilePath("json", "mock-users.json"));
        Arr mockUsers = JSON.Parse(read);

        //Defines which mockUsers that's already in the database to make sure that the method doesn't encrypt all 1000 passwords everytime you run the funtion.
        Arr mockUsersNotInDb = Arr();
        foreach(var user in mockUsers)
        {
            Obj userExists = SQLQueryOne("SELECT count(*) FROM users WHERE email = $email", user);
            if(userExists["count(*)"] == 0)
            {
                mockUsersNotInDb.Push(user);
            }
        }

        Arr successfullyWrittenUsers = Arr();
        foreach (var user in mockUsersNotInDb)
        {
            //Adds 2024 before user email and changes first letter to uppercase
            user.password = $"2024{user.email[0].ToString().ToUpper()}{user.email.Substring(1)}";
            if (IsPasswordGoodEnough(user.password))
            {
                user.password = Password.Encrypt(user.password);
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
        Arr deletedMockUsers = Arr();

        foreach (var user in mockUsers)
        {
            Obj deletedUser = SQLQueryOne("SELECT * FROM users WHERE email = $email", user);
            try
            {
                deletedUser.Delete("password");
                SQLQueryOne("DELETE FROM users WHERE email = $email", user);
                deletedMockUsers.Push(deletedUser);
            }
            catch
            {
                continue;
            }
        }
        return deletedMockUsers;
    }

    public static bool IsPasswordGoodEnough(string password)
    {
        List<bool> bools = new List<bool>();
        bools.Add(password.Length > 7);
        bools.Add(password.Any(char.IsUpper));
        bools.Add(password.Any(char.IsLower));
        bools.Add(password.Any(ch => !char.IsLetterOrDigit(ch)));
        bools.Add(password.Any(char.IsDigit));

        return !bools.Contains(false);
    }

    public static string RemoveBadWords(string textToClean, string replacementString)
    {
        var read = File.ReadAllText(FilePath("json", "bad-words.json"));
        Arr badWords = JSON.Parse(read).badwords;
        var badWordsOrdered = badWords.OrderBy(word => word.ToString().Length).Reverse();
        string cleanText = textToClean;

        foreach (var word in badWordsOrdered)
        {
            cleanText = Regex.Replace(cleanText, word.ToString(), replacementString, RegexOptions.IgnoreCase);
        }

        return cleanText;
    }

    public static Obj CountDomainsFromUserEmails()
    {
        Arr user = SQLQuery("SELECT SUBSTRING(email, instr(email, '@') + 1, length(email)) AS domain, count(id) AS id FROM users GROUP BY domain");
        Obj countedDomains = Obj();
        foreach(var domain in user)
        {
            countedDomains[domain.domain] = domain.id;
        }
        return countedDomains;
    }
}
