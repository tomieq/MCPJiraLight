# Summary

Light Swift MCP server that allows fetching Jira tickets with comments.
Locally I develop the app on MacOS but the production code runs in docker linux Swift:6.1

# Project Structure
All new classes/structs/enums put in appropriate folder in separate file. Do not create long files with multiple definitions inside. Although you can add type's extensions in the same file as extended type. If you need extend some object to protocol, name file ObjectType+ProtocolName.swift.

# Available tools
You have docker with images:
- Swift for Linux: `swift:6.1`

# Bulding project
- Run `swift build` to build the project on local MacOS

# Change commit
Never commit anything, let user review changes.