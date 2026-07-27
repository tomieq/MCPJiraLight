//
//  JiraEngine.swift
//  MCPServer
// 
//  Created by: tomieq on 22/04/2026
//
import Swifter
import Logger
import Env
import WebResponse
import MCPServer

enum JiraCommand: String, Codable {
    case get_jira_ticket
}

extension JiraCommand: CustomStringConvertible {
    var description: String {
        rawValue
    }
}

class JiraEngine: Engine {
    private let logger = Logger(JiraEngine.self)
    let instructions = "Use this tool to get JIRA ticket details."
    
    func command(for rawValue: String) -> JiraCommand? {
        JiraCommand(rawValue: rawValue)
    }
    
    func canHandle(_ command: String) -> Bool {
        self.command(for: command).notNil
    }
    let tools: [ToolsList.Schema] = [
        .init(JiraCommand.get_jira_ticket,
              description: "Returns Jira ticket info for given jiraID (jiraID might look like: CLOUD-1234 or SEES-1234)",
              inputSchema:
                ToolParameter(type: .object,
                              properties: ["jiraID": .init(type: .string, description: "jiraID")],
                              required: ["jiraID"])
             )
       ]
    
    func call(_ command: String, body: HttpRequestBody) throws -> ToolResult {
        guard let command = self.command(for: command) else {
            return ToolResult([])
        }
        let dto: ToolResult
        switch command {
        case .get_jira_ticket:
            struct JiraInfo: Codable {
                let jiraID: String
            }
            let command: Command<JiraInfo> = try body.decode()
            guard let jiraID = command.params?.arguments?.jiraID else {
                logger.e("Missing jiraID")
                dto = ToolResult(["Missing jiraID"])
                break
            }
            guard let token = Env.shared.get("JIRA_TOKEN") else {
                dto = ToolResult(["MCP Server is not configured to use Jira. Check environment variables"])
                break
            }
            guard let jiraHost = Env.shared.get("JIRA_HOST")?.trimming("/") else {
                dto = ToolResult(["MCP Server is not configured to use Jira. Check environment variables"])
                break
            }
            
            let url = "\(jiraHost)/rest/api/2/issue/\(jiraID)?fields=reporter,description,created,status,summary,comment,attachment"
            let result = WebResponse<JiraTicketDto>
                .default
                .get(url: url, headers: [
                    "Authorization": "Bearer \(token)"
                ])
            switch result {
            
            case .failure(let error):
                dto = ToolResult(["Problem accessing Jira: \(error)"])
            case .response(let jiraDto, _):
                dto = ToolResult([jiraDto.jsonOneLine ?? "nil"])
            }
        }
        return dto
    }
}

