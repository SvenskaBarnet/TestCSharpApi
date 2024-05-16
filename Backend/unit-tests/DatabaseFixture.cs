namespace WebApp;

public class DatabaseFixture: IDisposable
{
    private string dbTemplatePath = FilePath("DbTemplate", "_db.sqlite3").Regplace(Regex.Escape("Backend\\"), "");
    public DatabaseFixture()
    {
        File.Copy(dbTemplatePath, FilePath("_db.sqlite3"), true);
    }

    public void Dispose()
    {
        File.Copy(dbTemplatePath, FilePath("_db.sqlite3"), true);
    }
}