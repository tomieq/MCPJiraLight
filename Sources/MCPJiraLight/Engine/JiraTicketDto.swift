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
    let attachment: [JiraAttachmentDto]?
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

struct JiraAttachmentDto: Codable {
    let mimeType: String
    let created: String
    let size: Int
    let filename: String
    let content: String?
    let attachmentID: String?
}

extension JiraTicketDto {
    func export(originalHost: String) -> JiraTicketDto {
        JiraTicketDto(key: self.key, fields: fields.export(originalHost: originalHost))
    }
}

extension JiraFieldsDto {
    func export(originalHost: String) -> JiraFieldsDto {
        JiraFieldsDto(
            summary: self.summary,
            created: self.created,
            description: self.description,
            comment: self.comment,
            attachment: self.attachment?.filter{ $0.mimeType == "text/plain" }.map { $0.export(originalHost: originalHost) },
            reporter: self.reporter
        )
    }
}

extension JiraAttachmentDto {
    func export(originalHost: String) -> JiraAttachmentDto {
        JiraAttachmentDto(
            mimeType: self.mimeType,
            created: self.created,
            size: self.size,
            filename: self.filename,
            content: nil,
            attachmentID: self.content?.replacingOccurrences(of: originalHost, with: ""))
    }
}
