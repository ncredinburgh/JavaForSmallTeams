## The build file is truth, the IDE an approximation

While feedback from the IDE is fast and convenient it has some drawbacks. It may differ from developer machine to developer machine depending on the IDE configuration, and it can be easily ignored / overlooked. IDEs such as Eclipse may provide incorrect classpath when running tests (Eclipse has no concept of dependency scopes) and other problems may arise whereby things incorrectly appear to either work or not work.

For these reasons purely IDE centric work flows should be avoided and code should not be considered complete by a developer until tests have been run via the build file.
