//
//  JiraTicketDto.swift
//  MCPJiraLight
// 
//  Created by: tomieq on 23/07/2026
//

struct JiraTicketDto: Codable {
    let key: String
    let fields: JiraFieldsDto
}

struct JiraFieldsDto: Codable {
    let summary: String
    let created: String
    let description: String
    let comment: JiraCommentDataDto?
    let reporter: JiraAuthorDto
}

struct JiraCommentDataDto: Codable {
    let comments: [JiraCommentDto]
}

struct JiraCommentDto: Codable {
    let body: String
    let created: String
    let author: JiraAuthorDto
}

struct JiraAuthorDto: Codable {
    let displayName: String
}
