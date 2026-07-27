import Foundation
import Swifter
import Logger
import Dispatch
import MCPServer
import Env


#if os(Linux)
setvbuf(stdout, nil, _IONBF, 0)
#endif

let logger = Logger("MCPServer")
let config = MCPServerConfig(
    serverName: "Jira MCP",
    engines: [
        JiraEngine()
    ]
)
let mcp = MCPServer(config: config)
let port: UInt16
if let configuredPort = Env.shared.int("localPort") {
    port = UInt16(configuredPort)
} else {
    port = 8080
}
try mcp.server.start(port, forceIPv4: true)
logger.i("Server started on port \(try mcp.server.port)")
RunLoop.main.run()
