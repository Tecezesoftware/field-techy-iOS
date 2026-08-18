//
// SignupModule.swift
// FieldTechy
//
// Created by Kowsalya on 10/08/26.
//

import Foundation
import UIKit

//MARK: - SignUp screen Structure
enum ClientSignUpFieldType {
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
    let fieldType: ClientSignUpFieldType
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
        FormItem(fieldType: .text, title: "Company Name", placeholder: "Enter Company Name", isRequired: true),
        FormItem(fieldType: .text, title: "Email ID", placeholder: "Enter Email ID", isRequired: true),
        FormItem(fieldType: .phone, title: "Mobile Number", placeholder: "Enter Mobile Number", isRequired: true),
        FormItem(fieldType: .text, title: "Country", placeholder: "Enter Country", isRequired: true, showDropDown: true, dropDownOptions: ["India", "USA", "UK", "Australia"]),
        FormItem(fieldType: .text, title: "Address", placeholder: "Enter here", isRequired: true),
        FormItem(fieldType: .text, title: "City / Location", placeholder: "Enter City / Location", isRequired: true),
        FormItem(fieldType: .text, title: "Postal Code",  placeholder: "Enter Postal Code", isRequired: true),
        FormItem(fieldType: .text, title: "How did you hear about us?", placeholder: "Select", isRequired: true, showDropDown: true, dropDownOptions: ["Google", "LinkedIn", "Friend", "Ad"]),
        FormItem(fieldType: .photo, title: "Take a picture", placeholder: "Capture a photo (Max 5MB)"),
        FormItem(fieldType: .password, title: "Password", placeholder: "••••••••••••",   isRequired: true),
        FormItem(fieldType: .terms, title: "", placeholder: ""),
        FormItem(fieldType: .socialLogin, title: "", placeholder: ""),
        FormItem(fieldType: .submitButton, title: "", placeholder: "")
    ]}
}

// MARK: - Engineer Model
class EngineerSignUpModel {
    
    // Step 1 — Personal Details
    var firstName:  String = ""
    var middleName:  String = ""
    var lastName:   String = ""
    var email:    String = ""
    var mobile:    String = ""
    var countryCode: String = "+91"
    var address:   String = ""
    var city:     String = ""
    var postalCode:  String = ""
    var country:   String = ""
    var profilePhoto: UIImage?
    var password:   String = ""
    
    // Step 2 — Skills & Rates
    var selectedSkills:    [String] = []
    var skillLevel: String  = ""
    var totalExperience:   String  = ""
    var education:  String  = ""
    var specialization:    String  = ""
    var minHourlyRate:    String  = ""
    var maxHourlyRate:    String  = ""
    var currency:  String  = "₹"
    var certifications:    String  = ""
    var availableTools:    [String] = []
    var resumeDocument:    UIImage?
    var coverLetter: UIImage?
    var workExpiryDate:    Date?
    var workEligibilityDoc:  UIImage?
    
    // Step 3 — Preferences & Bank
    var onsiteJobs: Bool  = true
    var remoteJobs: Bool  = true
    var willingToTravel:   Bool  = false
    var dispatchUrgent:    Bool  = false
    var fullTimeContracts:  Bool  = false
    var pushNotifications:  Bool  = true
    var jobRadiusKm: String = ""
    var accountNumber:    String = ""
    var accountHolderName:  String = ""
    var bankName:  String = ""
    var ifscCode:  String = ""
    var branchName: String = ""
}

//MARK: - Engineer Data source - Field Types
enum EngineerFieldType: Equatable {
    case text
    case splitAs2Fields
    case email
    case phone
    case password
    case multiSelectChips([String])
    case photo
    case datePicker
    case toggle
    case rateField  // ₹ + textfield
    case sectionHeader
    case submitActions
}

// MARK: - Form Item
struct EngineerFormItem {
    let id: String
    var fieldType: EngineerFieldType
    var title: String
    var titleSplitField: String = ""
    var placeholder: String
    var placeholderSplitField: String = ""
    var isRequired: Bool   = false
    var isRequiredSplitField: Bool   = false
    var value: String     = ""
    var selectedValues: [String] = []
    var toggleValue: Bool   = false
    var subtitle: String   = ""
    var showDropDown: Bool = false
    var dropDownOptions: [String] = []
}

// MARK: - Step Data Sources
struct EngineerFormDataSource {
    
    // MARK: Step 1 — Personal Details
    static func step1Items() -> [EngineerFormItem] {[
        EngineerFormItem(id: "sectionTitle", fieldType: .sectionHeader, title: "Personal Details",   placeholder: ""),
        EngineerFormItem(id: "firstName",   fieldType: .text, title: "First Name",  placeholder: "Enter First Name",  isRequired: true),
        EngineerFormItem(id: "middleName",  fieldType: .text, title: "Middle Name", placeholder: "Enter Middle Name"),
        EngineerFormItem(id: "lastName",   fieldType: .text, title: "Last Name",  placeholder: "Enter Last Name"),
        EngineerFormItem(id: "email",     fieldType: .email,     title: "Email Address",     placeholder: "Enter Email Address",   isRequired: true),
        EngineerFormItem(id: "mobile",    fieldType: .phone,     title: "Mobile Number",     placeholder: "Enter Mobile Number", isRequired: true),
        EngineerFormItem(id: "address",    fieldType: .text, title: "Address",   placeholder: "Enter Your Address",  isRequired: true),
        EngineerFormItem(id: "city", fieldType: .text, title: "City / Location",    placeholder: "Enter City",  isRequired: true),
        EngineerFormItem(id: "postalCodeAndCountry",  fieldType: .splitAs2Fields, title: "Postal Code", titleSplitField: "Country", placeholder: "Enter Postal Code", placeholderSplitField: "Enter Your Country", isRequired: true, isRequiredSplitField: true, showDropDown: true, dropDownOptions: ["India", "USA", "UK", "Australia"]),
        EngineerFormItem(id: "photo",     fieldType: .photo,     title: "Take a picture",    placeholder: "Capture a photo (Max 5MB)"),
        EngineerFormItem(id: "password",   fieldType: .password,   title: "Password",   placeholder: "••••••••••",  isRequired: true)
    ]}
    
    // MARK: Step 2 — Skills & Rates
    static func step2Items() -> [EngineerFormItem] {[
        EngineerFormItem(id: "sectionTitle",  fieldType: .sectionHeader,    title: "Skills & Rates",    placeholder: ""),
        EngineerFormItem(id: "skills", fieldType: .multiSelectChips(["React Js", "Angular Js", "HTML 5", "Vue Js", "Swift", "Kotlin", "Flutter"]), title: "Select your skills",  placeholder: "",   isRequired: true),
        EngineerFormItem(id: "skillLevel",   fieldType: .text, title: "Skill Level", placeholder: "L1 (0-3)",   isRequired: true, showDropDown: true, dropDownOptions: ["L1 (0-3)", "L2 (3-5)", "L3 (5+)"]),
        EngineerFormItem(id: "experience",   fieldType: .text,
                         title: "Total Experience",   placeholder: "3-5 years",  isRequired: true, showDropDown: true, dropDownOptions: ["0-1 years", "1-3 years", "3-5 years", "5-10 years", "10+ years"]),
        EngineerFormItem(id: "education",    fieldType: .text, title: "Education Qualification", placeholder: "Bachelors degree", showDropDown: true, dropDownOptions: ["Bachelors degree", "Master's degree", "PhD", "Diploma", "Certificate"]),
        EngineerFormItem(id: "specialization", fieldType: .text,    title: "Specialization",    placeholder: "Computer science"),
        EngineerFormItem(id: "minRate",     fieldType: .rateField,  title: "Minimum Hourly Rate",  placeholder: "1200",     isRequired: true),
        EngineerFormItem(id: "maxRate",     fieldType: .rateField,  title: "Maximum Hourly Rate",  placeholder: "1200",     isRequired: true),
        EngineerFormItem(id: "certifications", fieldType: .text,    title: "Certifications",    placeholder: "CEH, CompTIA A+"),
        EngineerFormItem(id: "tools", fieldType: .multiSelectChips(["Figma", "Microsoft License", "Jira", "Slack", "GitHub"]),
                         title: "Available Tools",    placeholder: "",  isRequired: true),
        EngineerFormItem(id: "resume", fieldType: .photo,    title: "Upload Resume",     placeholder: "Capture a photo (Max 5MB)", isRequired: true),
        EngineerFormItem(id: "coverLetter",   fieldType: .photo,    title: "Upload Cover Letter",  placeholder: "Capture a photo (Max 5MB)", isRequired: true),
        EngineerFormItem(id: "workExpiry",   fieldType: .datePicker, title: "Work Expiry Date",   placeholder: "DD/MM/YYYY",  isRequired: true),
        EngineerFormItem(id: "workEligibility", fieldType: .photo,    title: "Work Eligibility Document Upload", placeholder: "Capture a photo (Max 5MB)", isRequired: true)
    ]}
    
    // MARK: Step 3 — Preferences & Bank
    static func step3Items() -> [EngineerFormItem] {[
        EngineerFormItem(id: "prefTitle",    fieldType: .sectionHeader,    title: "Preferences", placeholder: ""),
        EngineerFormItem(id: "onsiteJobs",   fieldType: .toggle,   title: "Onsite jobs", placeholder: "", toggleValue: true, subtitle: "Accept jobs at client locations"),
        EngineerFormItem(id: "remoteJobs",   fieldType: .toggle,   title: "Remote jobs", placeholder: "", toggleValue: true, subtitle: "Accept work-from-home jobs"),
        EngineerFormItem(id: "travel", fieldType: .toggle,   title: "Willing to travel",   placeholder: "", toggleValue: false, subtitle: "Open to travel when required"),
        EngineerFormItem(id: "dispatch",    fieldType: .toggle,   title: "Dispatch (urgent)",   placeholder: "", toggleValue: false, subtitle: "Same-day job requests"),
        EngineerFormItem(id: "fullTime",    fieldType: .toggle,   title: "Full-time contracts",  placeholder: "", toggleValue: false, subtitle: "Multi-week engagements"),
        EngineerFormItem(id: "pushNotif",    fieldType: .toggle,   title: "Push Notifications",  placeholder: "", toggleValue: true, subtitle: "Get alerted for new jobs"),
        EngineerFormItem(id: "jobRadius",    fieldType: .text,    title: "Job Radius (km)",    placeholder: "25", isRequired: true),
        EngineerFormItem(id: "bankTitle",    fieldType: .sectionHeader,    title: "Bank Details", placeholder: ""),
        EngineerFormItem(id: "accountNumber",  fieldType: .text,    title: "Account Number",    placeholder: "Enter Account Number"),
        EngineerFormItem(id: "accountHolder",  fieldType: .text,    title: "Account Holder Name",  placeholder: "Enter Account Holder Name"),
        EngineerFormItem(id: "bankName",    fieldType: .text,    title: "Bank Name",  placeholder: "Enter Bank Name"),
        EngineerFormItem(id: "ifscCode",    fieldType: .text,    title: "IFSC Code",  placeholder: "Enter IFSC Code"),
        EngineerFormItem(id: "branchName",   fieldType: .text,    title: "Branch Name", placeholder: "Enter Branch Name")
    ]}
}
