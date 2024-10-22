<<<<<<< HEAD
#!/bin/bash

# Define log file paths
INFO_LOG="instrumentation_info_log.txt"
ERROR_LOG="instrumentation_error_log.txt"

# Step 1: Install the Datadog CLI client
npm install -g @datadog/datadog-ci

# Step 2: Configure the Datadog site. For US1 this is "datadoghq.com"
export DATADOG_SITE="<DATADOG_SITE>"

# Step 3: Export the AWS Secrets Manager ARN for the Datadog API key
# (this can be found in the AWS console in 'AWS Secrets Manager')
# export DATADOG_API_KEY_SECRET_ARN="<DATADOG_API_KEY_SECRET_ARN>"
# OR use plain-text API key
export DATADOG_API_KEY="<DATADOG_API_KEY>"

# Step 4: Use AWS CLI to gather a list of all Lambda function names
echo "Retrieving list of Lambda functions..." >> $INFO_LOG
function_names=$(aws lambda list-functions --query 'Functions[*].FunctionName' --output text)
#echo "List of Lambda functions:"
#echo "$function_names"

# Step 5: Iterate through function names to instrument each function with Datadog CLI
echo "Instrumenting Lambda functions..." >> $INFO_LOG
for function_name in $function_names; do
    # Instrument the function
    if datadog-ci lambda instrument -f $function_name -r <aws_region> -v 94 -e 57; then
        echo "Instrumented function $function_name successfully." >> $INFO_LOG
    else
        echo "Failed to instrument function $function_name." >> $ERROR_LOG
    fi
done

echo "Instrumentation complete for all Lambda functions." >> $INFO_LOG
=======
#!/bin/bash

# Define log file paths
INFO_LOG="instrumentation_info_log.txt"
ERROR_LOG="instrumentation_error_log.txt"

# Step 1: Install the Datadog CLI client
npm install -g @datadog/datadog-ci

# Step 2: Configure the Datadog site. For US1 this is "datadoghq.com"
export DATADOG_SITE="<DATADOG_SITE>"

# Step 3: Export the AWS Secrets Manager ARN for the Datadog API key
# (this can be found in the AWS console in 'AWS Secrets Manager')
# export DATADOG_API_KEY_SECRET_ARN="<DATADOG_API_KEY_SECRET_ARN>"
# OR use plain-text API key
export DATADOG_API_KEY="<DATADOG_API_KEY>"

# Step 4: Use AWS CLI to gather a list of all Lambda function names
echo "Retrieving list of Lambda functions..." >> $INFO_LOG
function_names=$(aws lambda list-functions --query 'Functions[*].FunctionName' --output text)
#echo "List of Lambda functions:"
#echo "$function_names"

# Step 5: Iterate through function names to instrument each function with Datadog CLI
echo "Instrumenting Lambda functions..." >> $INFO_LOG
for function_name in $function_names; do
    # Instrument the function
    if datadog-ci lambda instrument -f $function_name -r <aws_region> -v 94 -e 57; then
        echo "Instrumented function $function_name successfully." >> $INFO_LOG
    else
        echo "Failed to instrument function $function_name." >> $ERROR_LOG
    fi
done

echo "Instrumentation complete for all Lambda functions." >> $INFO_LOG
>>>>>>> 6dc08b992d80596ae61950991e840f63862ebb85
