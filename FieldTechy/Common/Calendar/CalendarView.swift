//
//  CalendarView.swift
//  FieldTechy
//
//  Created by Kowsalya on 31/08/26.
//

import UIKit

final class CalendarView: UIView {

    // MARK: - UI

    private let previousButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private let monthLabel = UILabel()

    private let weekdayStackView = UIStackView()
    private let collectionView: UICollectionView

    // MARK: - Properties

    private var currentMonth = Date()
    private var calendar = Calendar.current
    private var dates: [Date] = []
    private var selectedDates: Set<Date> = []
    var onDateSelected: ((Date) -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {

        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        super.init(frame: frame)

        setupUI()
        generateDates()
    }

    required init?(coder: NSCoder) {

        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        super.init(coder: coder)

        setupUI()
        generateDates()
    }

    // MARK: - Setup

    private func setupUI() {

        backgroundColor = .white

        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor

        setupHeader()
        setupWeekdays()
        setupCollectionView()
    }

    // MARK: - Header

    private func setupHeader() {

        previousButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.translatesAutoresizingMaskIntoConstraints = false

        previousButton.setImage(
            UIImage(systemName: "chevron.left"),
            for: .normal
        )

        nextButton.setImage(
            UIImage(systemName: "chevron.right"),
            for: .normal
        )

        previousButton.tintColor = .darkText
        nextButton.tintColor = .darkText

        monthLabel.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )

        monthLabel.textAlignment = .center

        addSubview(previousButton)
        addSubview(nextButton)
        addSubview(monthLabel)

        NSLayoutConstraint.activate([

            previousButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 28
            ),

            previousButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24
            ),

            previousButton.widthAnchor.constraint(
                equalToConstant: 40
            ),

            previousButton.heightAnchor.constraint(
                equalToConstant: 40
            ),

            nextButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -28
            ),

            nextButton.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 24
            ),

            nextButton.widthAnchor.constraint(
                equalToConstant: 40
            ),

            nextButton.heightAnchor.constraint(
                equalToConstant: 40
            ),

            monthLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor
            ),

            monthLabel.centerYAnchor.constraint(
                equalTo: previousButton.centerYAnchor
            )
        ])

        previousButton.addTarget(
            self,
            action: #selector(previousMonth),
            for: .touchUpInside
        )

        nextButton.addTarget(
            self,
            action: #selector(nextMonth),
            for: .touchUpInside
        )

        updateMonthTitle()
    }

    // MARK: - Weekdays

    private func setupWeekdays() {

        weekdayStackView.translatesAutoresizingMaskIntoConstraints = false

        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .fillEqually

        let weekdays = [
            "S", "M", "T", "W", "T", "F", "S"
        ]

        for day in weekdays {

            let label = UILabel()

            label.text = day
            label.textAlignment = .center

            label.font = .systemFont(
                ofSize: 14,
                weight: .medium
            )

            label.textColor = .systemGray

            weekdayStackView.addArrangedSubview(label)
        }

        addSubview(weekdayStackView)

        NSLayoutConstraint.activate([

            weekdayStackView.topAnchor.constraint(
                equalTo: previousButton.bottomAnchor,
                constant: 24
            ),

            weekdayStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),

            weekdayStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),

            weekdayStackView.heightAnchor.constraint(
                equalToConstant: 30
            )
        ])
    }

    // MARK: - Collection View

    private func setupCollectionView() {

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .clear

        collectionView.showsVerticalScrollIndicator = false

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            CalendarCollectionViewCell.self,
            forCellWithReuseIdentifier: "CalendarCell"
        )

        addSubview(collectionView)

        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(
                equalTo: weekdayStackView.bottomAnchor,
                constant: 12
            ),

            collectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),

            collectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),

            collectionView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -20
            )
        ])
    }

    // MARK: - Date Generation

    private func generateDates() {

        dates.removeAll()

        guard let monthInterval = calendar.dateInterval(
            of: .month,
            for: currentMonth
        ) else {
            return
        }

        let firstDay = monthInterval.start

        let weekday = calendar.component(
            .weekday,
            from: firstDay
        )

        // Previous month dates
        let leadingDays = weekday - 1

        for index in stride(
            from: leadingDays,
            through: 1,
            by: -1
        ) {

            if let date = calendar.date(
                byAdding: .day,
                value: -index,
                to: firstDay
            ) {
                dates.append(date)
            }
        }

        // Current month
        var date = firstDay

        while date < monthInterval.end {

            dates.append(date)

            date = calendar.date(
                byAdding: .day,
                value: 1,
                to: date
            )!
        }

        // Next month dates
        while dates.count < 42 {

            if let lastDate = dates.last,
               let nextDate = calendar.date(
                byAdding: .day,
                value: 1,
                to: lastDate
               ) {

                dates.append(nextDate)
            }
        }

        collectionView.reloadData()
    }

    // MARK: - Month

    private func updateMonthTitle() {

        let formatter = DateFormatter()

        formatter.dateFormat = "MMMM"

        monthLabel.text = formatter.string(
            from: currentMonth
        )
    }

    @objc private func previousMonth() {

        currentMonth = calendar.date(
            byAdding: .month,
            value: -1,
            to: currentMonth
        )!

        updateMonthTitle()
        generateDates()
    }

    @objc private func nextMonth() {

        currentMonth = calendar.date(
            byAdding: .month,
            value: 1,
            to: currentMonth
        )!

        updateMonthTitle()
        generateDates()
    }

    // MARK: - Selection

    func setSelectedDate(_ date: Date?) {

        selectedDates.removeAll()

        if let date = date {

            selectedDates.insert(
                calendar.startOfDay(for: date)
            )
        }

        collectionView.reloadData()
    }
}

extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CalendarCell",
            for: indexPath
        ) as! CalendarCollectionViewCell

        let date = dates[indexPath.item]

        let isCurrentMonth =
            calendar.component(.month, from: date) ==
            calendar.component(.month, from: currentMonth)

        let normalizedDate =
            calendar.startOfDay(for: date)

        let isSelected =
            selectedDates.contains(normalizedDate)

        cell.configure(
            date: date,
            isCurrentMonth: isCurrentMonth,
            isSelected: isSelected
        )

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let date = dates[indexPath.item]

        let normalizedDate =
            calendar.startOfDay(for: date)

        selectedDates.removeAll()
        selectedDates.insert(normalizedDate)

        collectionView.reloadData()

        onDateSelected?(date)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width / 7

        return CGSize(
            width: width,
            height: 40
        )
    }
}
