#!/usr/bin/env powershell
#[Environment]::SetEnvironmentVariable("ADMINDOJO", "false", "User")
#[Environment]::SetEnvironmentVariable("ADMINDOJO", "false", "Process")
Remove-Item Env:\ADMINDOJO_TESTING
