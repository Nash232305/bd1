package weather;

import picocli.CommandLine;

/**
 *
 * @author henge
 */
public class App {

    public static void main(String[] args) {
        
        CommandLine cmd = new CommandLine(new MainCommand());
        cmd.setExecutionStrategy(new CommandLine.RunAll());
        cmd.execute(args);
        
        if (args.length == 0) {
            cmd.usage(System.out);
        }

    }
}
