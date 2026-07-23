# MCPJiraLight

MCPJiraLight is a lightweight Model Context Protocol server that exposes Jira ticket lookup to AI agents through a single MCP tool: `get_jira_ticket`.

The server starts a small HTTP API using Swifter and listens on `/mcp`. Copilot can initialize the server, list available tools, and call the Jira tool to fetch issue data from a Jira instance.

## What it does

- Serves as an MCP server for Jira-related lookups.
- Exposes one tool, `get_jira_ticket`.
- Fetches Jira issue details by key, such as `ISSUE-37808`.
- Returns ticket content as text, including fields like reporter, description, created date, status, summary, comments, and attachments.

## Environment Variables

The project uses a `.env` file. You can use `local.env` as the starting point for your own `.env` file.

Required for Jira access:

| Variable | Required | Description |
| --- | --- | --- |
| `JIRA_TOKEN` | Yes | Bearer token used to authenticate requests to Jira. |
| `JIRA_HOST` | Yes | Base URL of the Jira instance, for example `https://jira-host.com/`. The code trims a trailing slash if present. |

Optional:

| Variable | Required | Description |
| --- | --- | --- |
| `LOCAL_PORT` | No | Port the server listens on. The template uses `LOCAL_PORT`; the code reads the configured port value and falls back to `8080` when it is not set. |

## Example `.env`

```env
LOCAL_PORT=8080

JIRA_TOKEN=token_here
JIRA_HOST=https://jira-host.com/
```

## Running the server

1. Create a `.env` file in the project root.
2. Fill in `JIRA_TOKEN` and `JIRA_HOST`.
3. Set `LOCAL_PORT` if you want to override the default port.
4. Run the executable with Swift Package Manager:

```bash
swift run
```

The server will start on the configured port and expose the MCP endpoint at `POST /mcp`.

## MCP behavior

On initialization, the server advertises itself as `JiraMCP` and reports that it provides Jira ticket content. The available tool is:

- `get_jira_ticket`: accepts a required `jiraID` argument and returns the matching Jira issue payload.

If `JIRA_TOKEN` or `JIRA_HOST` is missing, the server still starts, but the Jira tool returns an error message explaining that Jira is not configured.