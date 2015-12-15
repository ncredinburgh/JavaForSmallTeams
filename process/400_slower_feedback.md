### Slower feedback

Both the compile suite and the commit suite should also be run on a CI server, normally triggered by a commit/push to the repository.

In addition to the compile and commit suites other suites should also be created.

These suites may require resources not available on a local machine and/or take large amounts of time to execute. They may also re-run the same tests against more realistic dependencies. If an in memory database is normally used when running integration tests locally, the same tests might be run again against a production database. 

For a maven build these suites are likely to be implemented using profiles or as separate maven modules.

These suites will be run as frequently as possible. Most likely this will mean on a timed basis as it is likely they will consume too much time to be run on commit (too much time is defined as taking longer than the likely interval between commits/pushes to the monitored repository). Timed test runs also have the advantage of sometimes running the suites when no code changes have occurred - this can provide useful information when identifying flaky tests.
