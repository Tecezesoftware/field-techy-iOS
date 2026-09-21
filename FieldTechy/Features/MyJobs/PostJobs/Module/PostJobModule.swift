//
//  PostJobModule.swift
//  FieldTechy
//
//  Created by Kowsalya on 01/09/26.
//


enum jobTypes: String{
    case dispatch = "Dispatch"
    case fulltime = "Full Time"
    case scheduled = "Scheduled"
}

enum jobsFieldType{
    case text
    case dropDown
    case multiChoice
    case buttonStack
    case toggle
    case engData
    case checklist
    case phoneNumber
    case upload
    case JD
    case cost
}

struct jobsFormItem {
    var id: Int
    var title: String?
    var placeholder: String?
    var type: jobsFieldType
    var options: [String]?
    var isRequired: Bool
}

struct jobsFormDataSource{
    static func makeItems() -> [jobsFormItem] {[
        jobsFormItem(id: 1, title: "Job Title", placeholder: "Enter here", type: .text, isRequired: true),
        jobsFormItem(id: 2, title: "Skill Level", placeholder: "Enter select", type: .dropDown, options: ["level 01", "level 02", "level 03", "level 04", "level 05"], isRequired: true),
        jobsFormItem(id: 3, title: "Job Skill", placeholder: "Enter or Select", type: .multiChoice, options: ["React JS", "Angular JS", "Swift"], isRequired: true),
        jobsFormItem(id: 4, title: "Job Mode", type: .buttonStack, isRequired: true),
        jobsFormItem(id: 5, title: "Payment Terms", placeholder: "Select", type: .dropDown, options: ["Term 01", "Term 02", "Term 03"], isRequired: true),
        jobsFormItem(id: 6, title: "Number of Engineers Required", placeholder: "Select", type: .dropDown, options: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10"], isRequired: true),
        jobsFormItem(id: 7, title: "Same Data for All Engineers", type: .toggle, isRequired: true),
        jobsFormItem(id: 8, type: .engData, isRequired: true),
        jobsFormItem(id: 9, type: .checklist, isRequired: true),
        jobsFormItem(id: 10, title: "SPOC Name",placeholder: "Enter SPOC Name" , type: .text, isRequired: true),
        jobsFormItem(id: 11, title: "SPOC Email",placeholder: "Enter SPOC Email", type: .text, isRequired: true),
        jobsFormItem(id: 12, title: "SPOC Phone Number",placeholder: "Enter SPOC Phone Number", type: .phoneNumber, isRequired: true),
        jobsFormItem(id: 13, title: "Reporting Manager Name", placeholder: "Enter Reporting Manager Name", type: .text, isRequired: true),
        jobsFormItem(id: 14, title: "Reporting Manager Email",placeholder: "Enter Reporting Manager Email", type: .text, isRequired: true),
        jobsFormItem(id: 15, title: "Reporting Manager Phone Number", placeholder: "Enter Reporting Manager Phone Number", type: .phoneNumber, isRequired: true),
        jobsFormItem(id: 16, title: "Tool Required ",placeholder: "Enter or Select" , type: .multiChoice, isRequired: true),
        jobsFormItem(id: 17, title: "Tool Cost", placeholder: "Enter Tool Cost", type: .text, isRequired: true),
        jobsFormItem(id: 18, title: "Job Description", placeholder: "Enter Job Description", type: .JD, isRequired: true),
        jobsFormItem(id: 19, type: .upload, isRequired: true),
        jobsFormItem(id: 20, title: "Job Cost", type: .cost, isRequired: true),
        
    ]}
}
