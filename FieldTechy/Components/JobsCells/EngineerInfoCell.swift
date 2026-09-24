//
//  EngineerInfoCell.swift
//  FieldTechy
//
//  Created by Kowsalya on 28/08/26.
//

import UIKit
import CoreLocation
import MapLibre

class EngineerInfoCell: UITableViewCell {

    //MARK: - IBOutlet Properties
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var engineerIdLabel: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    
    //MARK: - Start Date And Time View
    @IBOutlet weak var startDTView: UIView!
    @IBOutlet weak var startDTTitleLabel: UILabel!
    @IBOutlet weak var startDTDateField: UITextField!
    @IBOutlet weak var startDTDateButton: UIButton!
    @IBOutlet weak var startDTTimeField: UITextField!
    @IBOutlet weak var startDTtimeButton: UIButton!
    
    //MARK: - End Date And Time View
    @IBOutlet weak var endDTView: UIView!
    @IBOutlet weak var endDTTitleLabel: UILabel!
    @IBOutlet weak var endDTDateField: UITextField!
    @IBOutlet weak var endDTDateButton: UIButton!
    @IBOutlet weak var endDTTimeField: UITextField!
    @IBOutlet weak var endDTTimeButton: UIButton!
    
    //MARK: - Work Scheduling Types of View
    @IBOutlet weak var workSchedulingTypeView: UIView!
    @IBOutlet weak var scheduleAlldayButton: UIButton!
    @IBOutlet weak var recurringButton: UIButton!
    
    //MARK: - Shift Timing View
    @IBOutlet weak var shiftTimingView: UIView!
    @IBOutlet weak var shiftTimeLabel: UILabel!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var endTimeField: UITextField!
    @IBOutlet weak var endTimeButton: UIButton!
    
    //MARK: - FieldView with DropDown Button
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fieldView: UITextField!
    @IBOutlet weak var dropDownButton: UIButton!
    
    //MARK: - End Date View
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var endDateTitleLabel: UILabel!
    @IBOutlet weak var endDateField: UITextField!
    @IBOutlet weak var endDateButton: UIButton!
    
    //MARK: - Calendra, Map and Add Another Engineer View
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var MapContainerView: UIView!
    @IBOutlet weak var addEngineerView: DashedBorderView!
    @IBOutlet weak var addEngineerButton: UIButton!
    
    //MARK: - Address View
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var countryFieldView: UITextField!
    @IBOutlet weak var countryDropDownButton: UIButton!
    @IBOutlet weak var postCodeFieldView: UITextField!
    @IBOutlet weak var cityFieldView: UITextField!
    @IBOutlet weak var unitFieldView: UITextField!
    @IBOutlet weak var stateFieldView: UITextField!
    @IBOutlet weak var stateDropDownButton: UIButton!
    @IBOutlet weak var streetNumFieldView: UITextField!
    
    private var mapView: MLNMapView!
    private let calendarView = CalendarView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMap()
        setupCalendar()
    }

    func configureUI(jobType: jobTypes) {
        
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.5
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        view.layer.masksToBounds = true
        
        switch jobType {
        case .dispatch:
            configureUiForDispatch()
        case .fulltime:
            configureUiForFullTime()
        case .scheduled:
            configureUiForScheduled()
        }
    }
    
    private func configureUiForDispatch() {
        startDTView.isHidden = false
        addStyleForTitleAndFields(label: startDTTitleLabel, fields: [startDTDateField, startDTTimeField], isRequired: true, title: "Start Date & Time", placeHolder: [startDTDateField: "MM/DD/YYYY", startDTTimeField: "HH:MM"])
        
        endDTView.isHidden = false
        addStyleForTitleAndFields(label: endDTTitleLabel, fields: [endDTDateField, endDTTimeField], isRequired: true, title: "End Date & Time", placeHolder: [endDTDateField: "MM/DD/YYYY", endDTTimeField: "HH:MM"])
        
        dropDownView.isHidden = false
        addStyleForTitleAndFields(label: titleLabel, fields: [fieldView], isRequired: true, title: "Total Hours", placeHolder: [fieldView: "Enter Total Hours"])
        dropDownButton.isHidden = true
        
        addressView.isHidden = false
        addStyleForTitleAndFields(label: addressTitleLabel, fields: [countryFieldView, postCodeFieldView, cityFieldView, unitFieldView, stateFieldView, streetNumFieldView], isRequired: true, title: "Address", placeHolder: [countryFieldView: "Select Country", postCodeFieldView: "Enter Postal Code", cityFieldView: "Enter City", unitFieldView: "Enter Apt./Unit#",stateFieldView: "Select State", streetNumFieldView: "Enter the Street Number and Name"])
        
        MapContainerView.isHidden = false
        MapContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        MapContainerView.layer.borderWidth = 1.5
        
        //MARK: - Hiding not required View's from Stack View
        workSchedulingTypeView.isHidden = true
        shiftTimingView.isHidden = true
        endDateView.isHidden = true
        calendarContainerView.isHidden = true
    }
    
    private func configureUiForFullTime() {
        startDTView.isHidden = false
        addStyleForTitleAndFields(label: startDTTitleLabel, fields: [startDTDateField], isRequired: true, title: "Start Date", placeHolder: [startDTDateField: "MM/DD/YYYY"])
        
        shiftTimingView.isHidden = false
        addStyleForTitleAndFields(label: shiftTimeLabel, fields: [startTimeField, endTimeField], isRequired: true, title: "Shift Time", placeHolder: [startTimeField: "HH:MM", endTimeField: "HH:MM"])
        
        endDTView.isHidden = false
        addStyleForTitleAndFields(label: endDTTitleLabel, fields: [endDTDateField, endDTTimeField], isRequired: true, title: "End Date & Time", placeHolder: [endDTDateField: "MM/DD/YYYY", endDTTimeField: "HH:MM"])
        
        dropDownView.isHidden = false
        addStyleForTitleAndFields(label: titleLabel, fields: [fieldView], isRequired: true, title: "Choose Months", placeHolder: [fieldView: "Select Months"])
        dropDownButton.isHidden = false
        
        endDateView.isHidden = false
        addStyleForTitleAndFields(label: endDateTitleLabel, fields: [endDateField], isRequired: true, title: "End Date", placeHolder: [endDateField: "MM/DD/YYYY"])
        
        addressView.isHidden = false
        addStyleForTitleAndFields(label: addressTitleLabel, fields: [countryFieldView, postCodeFieldView, cityFieldView, unitFieldView, stateFieldView, streetNumFieldView], isRequired: true, title: "Address", placeHolder: [countryFieldView: "Select Country", postCodeFieldView: "Enter Postal Code", cityFieldView: "Enter City", unitFieldView: "Enter Apt./Unit#",stateFieldView: "Select State", streetNumFieldView: "Enter the Street Number and Name"])
        
        MapContainerView.isHidden = false
        MapContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        MapContainerView.layer.borderWidth = 1.5
        
        //MARK: - Hiding not required View's from Stack View
        startDTTimeField.isHidden = true
        startDTtimeButton.isHidden = true
        workSchedulingTypeView.isHidden = true
        calendarContainerView.isHidden = true
    }
    
    private func configureUiForScheduled() {
        startDTView.isHidden = false
        addStyleForTitleAndFields(label: startDTTitleLabel, fields: [startDTDateField], isRequired: true, title: "Start Date", placeHolder: [startDTDateField: "MM/DD/YYYY"])
        
        endDTView.isHidden = false
        addStyleForTitleAndFields(label: endDTTitleLabel, fields: [endDTDateField], isRequired: true, title: "End Date", placeHolder: [endDTDateField: "MM/DD/YYYY"])
        
        workSchedulingTypeView.isHidden = false
        
        shiftTimingView.isHidden = false
        addStyleForTitleAndFields(label: shiftTimeLabel, fields: [startTimeField, endTimeField], isRequired: true, title: "Shift Time", placeHolder: [startTimeField: "HH:MM", endTimeField: "HH:MM"])
        
        dropDownView.isHidden = false
        addStyleForTitleAndFields(label: titleLabel, fields: [fieldView], isRequired: true, title: "Repeat For Every", placeHolder: [fieldView: "Day"])
        dropDownButton.isHidden = false
        
        calendarContainerView.isHidden = false
        
        addressView.isHidden = false
        addStyleForTitleAndFields(label: addressTitleLabel, fields: [countryFieldView, postCodeFieldView, cityFieldView, unitFieldView, stateFieldView, streetNumFieldView], isRequired: true, title: "Address", placeHolder: [countryFieldView: "Select Country", postCodeFieldView: "Enter Postal Code", cityFieldView: "Enter City", unitFieldView: "Enter Apt./Unit#",stateFieldView: "Select State", streetNumFieldView: "Enter the Street Number and Name"])
        
        MapContainerView.isHidden = false
        MapContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        MapContainerView.layer.borderWidth = 1.5
        
        //MARK: - Hiding not required View's from Stack View
        startDTTimeField.isHidden = true
        startDTtimeButton.isHidden = true
        endDTTimeField.isHidden = true
        endDTTimeButton.isHidden = true
        endDateView.isHidden = true
    }
    
    
    private func setupMap() {

        mapView = MLNMapView(frame: .zero)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsLogoView = false
        mapView.showsAttributionButton = false
        mapView.layer.cornerRadius = 20.0
        mapView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        mapView.layer.borderWidth = 1.5

        MapContainerView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: MapContainerView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: MapContainerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: MapContainerView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: MapContainerView.bottomAnchor),
        ])

        let location = CLLocationCoordinate2D(
            latitude: 13.0827,
            longitude: 80.2707
        )
        mapView.allowsScrolling = true
        
        let styleURLString = "https://api.maptiler.com/maps/streets/style.json?key=geDBuqxjyGVxZPMQbj1x#1.0/3.51342/35.50781"
        guard let url = URL(string: styleURLString) else { return }
        mapView.styleURL = url
        
        mapView.setCenter(
            location,
            zoomLevel: 14,
            animated: false
        )
    }
    
    private func setupCalendar() {

        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarContainerView.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(
                equalTo: calendarContainerView.topAnchor
            ),

            calendarView.leadingAnchor.constraint(
                equalTo: calendarContainerView.leadingAnchor
            ),

            calendarView.trailingAnchor.constraint(
                equalTo: calendarContainerView.trailingAnchor
            ),

            calendarView.bottomAnchor.constraint(
                equalTo: calendarContainerView.bottomAnchor
            )
        ])

        calendarView.onDateSelected = { [weak self] date in

            guard let self = self else {
                return
            }

            print("Selected date:", date)
        }
    }
    
    private func addStyleForTitleAndFields(label:UILabel, fields:[UITextField], isRequired:Bool, title:String, placeHolder:[UITextField: String]){
        if isRequired == true {
            let attr = NSMutableAttributedString(string: title,
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            
            attr.append(NSAttributedString(
                string: " *",
                attributes: [.foregroundColor: UIColor.red, .font: AppFonts.Regular(size: 12.0)]
            ))
            label.attributedText = attr
        } else {
            let attr = NSMutableAttributedString(string: title,
                                                 attributes: [.foregroundColor: AppTheme.primaryTextColor, .font: AppFonts.Regular(size: 12.0)])
            label.attributedText = attr
        }
        for field in fields{
            field.layer.cornerRadius = 5
            field.layer.borderWidth = 1.5
            field.layer.borderColor = AppTheme.borderColorOfViews.cgColor
            field.layer.masksToBounds = true
            
            if field.text?.isEmpty == true, let placeholder = placeHolder[field] {
                field.placeholder = placeholder
            }
        }
    }
}
