//
//  RaiseDisputeModule.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/09/26.
//

import Foundation

enum disputeFieldType{
    case text
    case dropDown
    case phoneNumber
    case upload
    case description
    case file
}

struct disputeFormItem {
    var id: Int
    var title: String?
    var placeholder: String?
    var type: disputeFieldType
    var options: [String]?
    var isRequired: Bool
    var isShowFileUpload: Bool?
}
struct disputeFormDataSource{
    static func makeItems() -> [disputeFormItem] {[
        disputeFormItem(id: 1, title: "Job ID", placeholder: "Enter Job ID", type: .text, isRequired: true),
        disputeFormItem(id: 2, title: "Select Job", placeholder: "Select", type: .dropDown,options: ["#ID-48821", "#ID-48822", "#ID-48823", "#ID-48824"], isRequired: true),
        disputeFormItem(id: 3, title: "Engineer Name", placeholder: "Enter Engineer Name", type: .text, isRequired: true),
        disputeFormItem(id: 4, title: "Dispute Reason", placeholder: "Enter Dispute Reason", type: .text, isRequired: true),
        disputeFormItem(id: 5, title: "Describe the Issue", placeholder: "Enter Describe the Issue", type: .description, isRequired: true),
        disputeFormItem(id: 6, title: "", placeholder: "Upload evidence", type: .upload, isRequired: true),
        disputeFormItem(id: 7, title: "Evidence Describe", placeholder: "Enter Evidence Describe", type: .description, isRequired: true),
        disputeFormItem(id: 8, title: "Uploaded Evidence", placeholder: "", type: .file, isRequired: true, isShowFileUpload: true),
    ]}
}
