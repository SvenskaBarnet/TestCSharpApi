namespace WebApp;

public class CopyDatabase : IDisposable
{
    private string dbTemplatePath = FilePath("DbTemplate", "_db.sqlite3").Regplace(Regex.Escape("Backend\\"), "");
    public CopyDatabase()
    {
        File.Copy(dbTemplatePath, FilePath("_db.sqlite3"), true);
    }

    public void Dispose()
    {
        File.Copy(dbTemplatePath, FilePath("_db.sqlite3"), true);
    }
}