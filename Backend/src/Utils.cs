using Microsoft.AspNetCore.Identity;

namespace WebApp;
public static class Utils
{
    public static Arr CreateMockUsers()
    {
        var read = File.ReadAllText(Path.Combine("json", "mock-users.json"));
        Arr mockUsers = JSON.Parse(read);
        Arr successfullyWrittenUsers = Arr();

        foreach (var user in mockUsers)
        {
            user.password = "12345678";
            var result = SQLQueryOne(
                @"INSERT INTO users(firstName, lastName, email, password)
                VALUES ($firstName, $lastName, $email, $password)
                ", user);
            if(!result.HasKey("error"))
            {
                user.Delete("password");
                successfullyWrittenUsers.Push(user);
            }
        }
        return successfullyWrittenUsers;
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
        var read = File.ReadAllText(Path.Combine("json", "bad-words.json"));
        Arr badWords = JSON.Parse(read).badwords;
        var badWordsOrdered = badWords.OrderBy(word => word.ToString().Length).Reverse();
        string cleanText = textToClean;

        foreach (var word in badWordsOrdered)
        {
            cleanText = Regex.Replace(cleanText, word.ToString(), replacementString, RegexOptions.IgnoreCase);
        }

        return cleanText;
    }
}
