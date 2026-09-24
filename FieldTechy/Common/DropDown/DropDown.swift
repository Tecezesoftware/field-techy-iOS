//
//  DropDown.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//
import UIKit

// MARK: - Delegate Protocol
protocol DropDownDelegate: AnyObject {
    func dropDown(_ dropDown: DropDown, didSelectItem item: String, at index: Int)
    func dropDownDidDismiss(_ dropDown: DropDown)
}

// MARK: - AppDropDown
final class DropDown: UIView {

    // MARK: - UI Components
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor    = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds      = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font      = UIFont(name: "Poppins-Regular", size: 16) ?? .systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "9CA3AF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image       = UIImage(systemName: "chevron.up")
        iv.tintColor   = UIColor(hex: "6B7280")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "F3F4F6")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle  = .none
        tv.backgroundColor = .white
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    // MARK: - Properties
    private var options: [String]  = []
    private var placeholder: String = ""
    private var selectedIndex: Int? = nil

    // Selected State Colors
    private let selectedBgColor = UIColor(hex: "827F7F")
    private let selectedFgColor = UIColor(hex: "26272C")
    private let normalFgColor   = UIColor(hex: "26272C")
    private let normalBgColor   = UIColor.white

    // Config
    private let rowHeight: CGFloat   = 52
    private let headerHeight: CGFloat = 56
    private let maxVisibleRows: Int  = 5
    private let cellReuseID          = "DropDownOptionCell"

    // MARK: - Callbacks
    var onSelect: ((Int, String) -> Void)?
    var onDismiss: (() -> Void)?
    weak var delegate: DropDownDelegate?

    // MARK: - Anchor reference
    private weak var anchorView: UIView?
    private weak var parentVC: UIViewController?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupComponents()
    }

    // MARK: - Component Setup
    private func setupComponents() {
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(
            DropDownOptionCell.self,
            forCellReuseIdentifier: cellReuseID
        )

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleOverlayTap))
        overlayView.addGestureRecognizer(tap)
        overlayView.isUserInteractionEnabled = true
    }

    // MARK: - Layout
    private func setupLayout(in parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)

        // Self fills parent
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])

        // Overlay
        addSubview(overlayView)
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        // Container
        addSubview(containerView)
        let dropdownHeight = calculateDropdownHeight()

        // Position container relative to anchor view
        let anchorFrame = anchorView.flatMap {
            $0.superview?.convert($0.frame, to: parentView)
        } ?? CGRect(x: 20, y: 200, width: parentView.bounds.width - 40, height: 52)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: anchorFrame.minY),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: anchorFrame.minX),
            containerView.widthAnchor.constraint(equalToConstant: anchorFrame.width),
            containerView.heightAnchor.constraint(equalToConstant: dropdownHeight)
        ])

        // Header inside container
        containerView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight)
        ])

        // Header label
        headerView.addSubview(headerLabel)
        headerView.addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),

            arrowImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Separator
        containerView.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])

        // TableView
        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    // MARK: - Height Calculation
    private func calculateDropdownHeight() -> CGFloat {
        let visibleRows    = min(options.count, maxVisibleRows)
        let optionsHeight  = CGFloat(visibleRows) * rowHeight
        return headerHeight + 1 + optionsHeight // 1 = separator
    }

    // MARK: - Show
    func show(
        options: [String],
        placeholder: String,
        selectedIndex: Int?     = nil,
        anchorView: UIView,
        in viewController: UIViewController
    ) {
        self.options       = options
        self.placeholder   = placeholder
        self.selectedIndex = selectedIndex
        self.anchorView    = anchorView
        self.parentVC      = viewController

        // Update header
        if let index = selectedIndex {
            headerLabel.text      = options[safe: index] ?? placeholder
            headerLabel.textColor = UIColor(hex: "26272C")
        } else {
            headerLabel.text      = placeholder
            headerLabel.textColor = UIColor(hex: "9CA3AF")
        }

        // Setup layout
        guard let parentView = viewController.view else { return }
        setupLayout(in: parentView)
        tableView.reloadData()

        // Scroll to selected
        if let index = selectedIndex {
            tableView.scrollToRow(
                at: IndexPath(row: index, section: 0),
                at: .middle,
                animated: false
            )
        }

        // Animate in
        overlayView.alpha    = 0
        containerView.alpha  = 0
        containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.overlayView.alpha       = 1
            self.containerView.alpha     = 1
            self.containerView.transform = .identity
        }
    }

    // MARK: - Dismiss
    func dismiss() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.overlayView.alpha       = 0
            self.containerView.alpha     = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            self.removeFromSuperview()
            self.onDismiss?()
        })
    }

    // MARK: - Actions
    @objc private func handleOverlayTap() {
        dismiss()
    }
}

// MARK: - UITableViewDataSource
extension DropDown: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseID,
            for: indexPath
        ) as? DropDownOptionCell else {
            return UITableViewCell()
        }

        let isSelected = indexPath.row == selectedIndex
        cell.configure(
            text: options[indexPath.row],
            isSelected: isSelected,
            selectedBgColor: selectedBgColor,
            selectedFgColor: selectedFgColor,
            normalBgColor: normalBgColor,
            normalFgColor: normalFgColor
        )
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DropDown: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = options[indexPath.row]
        selectedIndex = indexPath.row

        // Update header
        headerLabel.text      = selected
        headerLabel.textColor = UIColor(hex: "26272C")

        // Reload to update highlighted cell
        tableView.reloadData()

        // Callback
        onSelect?(indexPath.row, selected)
        delegate?.dropDown(self, didSelectItem: selected, at: indexPath.row)

        // Dismiss after short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.dismiss()
        }
    }
}
