#!/usr/bin/env powershell
[Environment]::SetEnvironmentVariable("ADMINDOJO_TESTING", "true", "User")
# Note that these definitions take effect in future sessions (processes), so in order to define the variable for the current process as well
# https://stackoverflow.com/questions/38928342/how-do-i-set-an-env-variable-in-powershell-if-it-doesnt-exist
[Environment]::SetEnvironmentVariable('ADMINDOJO_TESTING', 'true', 'Process')