# Datadog-lambda-instrumentation-script

Contains a script to deploy the Datadog Lambda tracer via CLI.

Notes:

This script should be executed from the AWS Cloud Shell. If executing from a local terminal, the user will need to first authenticate into their AWS account using "aws configure." Please make sure the user has the proper permissions to make changes to Lambda configurations.

Error handling & logging has been built into the script. The user may have to first make the log files (see line 4 & 5). After running the script, any functions that fail to instrument will be written to instrumentation_error_log.txt.

As of May 2024, the Datadog CLI supports Python, .NET, Node.js, and Java. GO and Ruby are not supported by the CLI. Please note that the framework version will also matter (i.e. only Python 3.8+ is supported).

If a Lambda function is already instrumented with the Datadog tracer, the CLI will skip the function. No changes will be made to the function, even if it is running an old tracer version.

Tracer versions can be controlled with the -v and -e tags in step 5.

To uninstrument any Lambda functions, simply replace the command "instrument" on Line 29 with "uninstrument."
