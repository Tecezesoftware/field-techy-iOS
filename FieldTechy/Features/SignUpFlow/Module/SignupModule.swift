//
//  SignupModule.swift
//  FieldTechy
//
//  Created by Kowsalya on 10/08/26.
//

import Foundation

//MARK: - SignUp screen Structure
enum SignUpFieldType {
    case banner
    case logo
    case text
    case phone
    case photo
    case password
    case terms
    case socialLogin
    case submitButton
}

struct FormItem {
    let fieldType: SignUpFieldType
    let title: String
    let placeholder: String
    var isRequired: Bool = false
    var showDropDown: Bool = false
    var dropDownOptions: [String] = []
    var value: String?
}

struct SignUpFormDataSource {
    static func makeItems() -> [FormItem] {[
        FormItem(fieldType: .banner, title: "", placeholder: ""),
        FormItem(fieldType: .logo, title: "", placeholder: ""),
        FormItem(fieldType: .text, title: "First Name", placeholder: "Enter First Name", isRequired: true),
        FormItem(fieldType: .text, title: "Middle Name", placeholder: "Enter Middle Name"),
        FormItem(fieldType: .text, title: "Last Name", placeholder: "Enter Last Name", isRequired: true),
        FormItem(fieldType: .text, title: "Company Name",  placeholder: "Enter Company Name", isRequired: true),
        FormItem(fieldType: .text, title: "Email ID",  placeholder: "Enter Email ID", isRequired: true),
        FormItem(fieldType: .phone, title: "Mobile Number", placeholder: "Enter Mobile Number", isRequired: true),
        FormItem(fieldType: .text, title: "Country", placeholder: "Enter Country", isRequired: true, showDropDown: true, dropDownOptions: ["India", "USA", "UK", "Australia"]),
        FormItem(fieldType: .text, title: "Address", placeholder: "Enter here", isRequired: true),
        FormItem(fieldType: .text, title: "City / Location", placeholder: "Enter City / Location", isRequired: true),
        FormItem(fieldType: .text, title: "Postal Code",   placeholder: "Enter Postal Code", isRequired: true),
        FormItem(fieldType: .text, title: "How did you hear about us?", placeholder: "Select", isRequired: true, showDropDown: true, dropDownOptions: ["Google", "LinkedIn", "Friend", "Ad"]),
        FormItem(fieldType: .photo, title: "Take a picture", placeholder: "Capture a photo (Max 5MB)"),
        FormItem(fieldType: .password, title: "Password",  placeholder: "••••••••••••",     isRequired: true),
        FormItem(fieldType: .terms, title: "", placeholder: ""),
        FormItem(fieldType: .socialLogin, title: "", placeholder: ""),
        FormItem(fieldType: .submitButton, title: "", placeholder: "")
    ]}
}
