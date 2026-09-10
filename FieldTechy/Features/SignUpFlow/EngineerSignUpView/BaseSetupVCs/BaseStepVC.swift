//
//  BaseStepVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 17/08/26.
//

import UIKit

class BaseStepVC: UIViewController {
    
    
    // MARK: - UI Components (Programmatic — no IBOutlets needed)
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle             = .none
        tv.backgroundColor            = .clear
        tv.keyboardDismissMode        = .onDrag
        tv.showsVerticalScrollIndicator = false
        tv.contentInsetAdjustmentBehavior = .never
        tv.sectionHeaderTopPadding    = 0
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.alignment = .center
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius =  24
        view.clipsToBounds = true
        view.backgroundColor = AppTheme.neutralLight500
        return view
    }()
    
    private let continueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.backgroundColor = AppTheme.primaryButtonBGColor
        return view
    }()
    
    private let backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Back"
        label.textColor = AppTheme.primaryTextColor
        label.font = AppFonts.SemiBold(size: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let continueContentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = AppTheme.primaryButtonLabelColor
        label.font = AppFonts.SemiBold(size: 40)
        label.textAlignment = .left
        return label
    }()
    
//    private let arrowImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "WhiteRightPointer")
//        imageView.backgroundColor = .black
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.style = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.style = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var sharedModel = EngineerSignUpModel()
    var dropDown    = DropDown()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
        setupActions()
        setupKeyboard()
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        registerCells()   // subclass overrides
        configure()       // subclass overrides
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        bottomView.addSubview(stackView)
        
        stackView.addArrangedSubview(backView)
        stackView.addArrangedSubview(continueView)
        
        backView.addSubview(backLabel)
        backView.addSubview(backButton)
        
        continueView.addSubview(continueContentStackView)

        continueContentStackView.addArrangedSubview(continueLabel)
//        continueContentStackView.addArrangedSubview(arrowImageView)
        
        continueView.addSubview(continueButton)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            // TableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            // Bottom View
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 82),
            
            //stackView
            stackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor,constant: -34),
            
            // Back View
            backView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            backView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            backView.heightAnchor.constraint(equalToConstant: 48),
            
            // Continue View
            continueView.leadingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0),
            continueView.bottomAnchor.constraint(equalTo: backView.bottomAnchor),
            continueView.heightAnchor.constraint(equalTo: backView.heightAnchor),
            
            // Back Label
            backLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            backLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            
            // Continue Content StackView
//            continueContentStackView.centerXAnchor.constraint(equalTo: continueView.centerXAnchor),
//            continueContentStackView.centerYAnchor.constraint(equalTo: continueView.centerYAnchor),
            
            continueContentStackView.leadingAnchor.constraint(equalTo: continueView.leadingAnchor, constant: 20),
            continueContentStackView.trailingAnchor.constraint(equalTo: continueView.trailingAnchor, constant: -60),
            continueContentStackView.topAnchor.constraint(equalTo: continueView.topAnchor, constant: 12),
            continueContentStackView.bottomAnchor.constraint(equalTo: continueView.bottomAnchor, constant: -12),

            // Arrow Image
//            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
//            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Buttons
            backButton.topAnchor.constraint( equalTo: backView.topAnchor ),
            backButton.bottomAnchor.constraint( equalTo: backView.bottomAnchor ),
            backButton.leadingAnchor.constraint( equalTo: backView.leadingAnchor ),
            backButton.trailingAnchor.constraint( equalTo: backView.trailingAnchor ),
            
            continueButton.topAnchor.constraint( equalTo: continueView.topAnchor ),
            continueButton.bottomAnchor.constraint( equalTo: continueView.bottomAnchor ),
            continueButton.leadingAnchor.constraint( equalTo: continueView.leadingAnchor ),
            continueButton.trailingAnchor.constraint( equalTo: continueView.trailingAnchor
            )
        ])
    }
    
    // MARK: - Actions
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    // MARK: - Public API
    func showBackButton(_ show: Bool) {
        backView.isHidden = !show
    }
    
    func setContinueTitle(_ title: String) {
        continueButton.setTitle(title, for: .normal)
    }
    
    func setContinueEnabled(_ enabled: Bool) {
        continueButton.isEnabled = enabled
        continueButton.alpha     = enabled ? 1.0 : 0.6
    }
    
    // MARK: - Override in Subclasses
    func configure() {}
    func registerCells() {}
    
    // MARK: - Navigation
    @objc func continueTapped() {
        (parent as? EngineerSignUpContainerVC)?.goToNextStep()
    }
    
    @objc func backTapped() {
        (parent as? EngineerSignUpContainerVC)?.goToPreviousStep()
    }
    
    // MARK: - Keyboard
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? CGRect else { return }
        tableView.contentInset.bottom          = frame.height
        tableView.scrollIndicatorInsets.bottom = frame.height
    }
    
    @objc private func keyboardWillHide() {
        tableView.contentInset.bottom          = 0
        tableView.scrollIndicatorInsets.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - TableView Placeholder (Subclasses override)
extension BaseStepVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
