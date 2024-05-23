namespace WebApp;
using System;
using System.Diagnostics;

public static class ScriptRunner
{
    public static void Run()
    {
        Process process = new Process();
        process.StartInfo.WorkingDirectory = FilePath("..", "ui-tests");
        process.StartInfo.FileName = "bash";
        process.StartInfo.Arguments = "db-data-to-feature.sh";
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;

        process.OutputDataReceived += (sender, args) => Console.WriteLine(args.Data);
        process.ErrorDataReceived += (sender, args) => {
            if(args.Data != null)
                {
                    Console.WriteLine("ERROR: " + args.Data);
                }
            };

        process.Start();
        process.BeginOutputReadLine();
        process.BeginErrorReadLine();

        process.WaitForExit();

        int exitCode = process.ExitCode;
        if (exitCode != 0)
        {
            Console.WriteLine($"Script exited with code {exitCode}");
        }
    }
}