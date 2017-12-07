import UIKit

public protocol TabViewDataSource {

    func numberOfItems(in tabView: TabView) -> Int

    func tabView(_ tabView: TabView, titleForItemAt index: Int) -> String?
}

open class TabView: UIScrollView {

    open var dataSource: TabViewDataSource!

    private(set) var itemViews: [TabItemView] = []

    fileprivate let containerView: UIStackView = .init()

    fileprivate var underlineView: UIView = .init()

    fileprivate var currentIndex: Int = 0

    fileprivate var options: SwipeMenuViewOptions.TabView = .init()

    public init(frame: CGRect, options: SwipeMenuViewOptions.TabView? = nil) {
        super.init(frame: frame)

        if let options = options {
            self.options = options
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func didMoveToSuperview() {
        setup()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        resetUnderlineViewPosition(index: currentIndex)
    }

    public func reset() {

        itemViews.forEach { $0.removeFromSuperview() }
        underlineView.removeFromSuperview()
        containerView.removeFromSuperview()
        itemViews = []
        currentIndex = 0
    }

    public func update(_ index: Int) {

        if currentIndex == index { return }

        currentIndex = index
        updateSelectedItem(by: currentIndex)
    }

    fileprivate func focus(on target: UIView, animated: Bool = true) {
        guard options.style == .flexible else { return }
        
        let offset = target.center.x + options.margin - self.frame.width / 2
        let contentWidth = containerView.frame.width + options.margin * 2
        if offset < 0 || self.frame.width > contentWidth {
            self.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
        } else if contentWidth - self.frame.width < offset {
            self.setContentOffset(CGPoint(x: contentWidth - self.frame.width, y: 0), animated: animated)
        } else {
            self.setContentOffset(CGPoint(x: offset, y: 0), animated: animated)
        }
    }

    // MARK: - Setup

    fileprivate func setup() {

        reset()
        setupScrollView()
        setupContainerView()
        setupTabItemViews()
        setupUnderlineView()
    }

    fileprivate func setupScrollView() {
        backgroundColor = options.backgroundColor
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isScrollEnabled = true
        isDirectionalLockEnabled = true
        alwaysBounceHorizontal = false
        scrollsToTop = false
        bouncesZoom = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate func setupContainerView() {

        containerView.alignment = .leading

        switch options.style {
        case .flexible:
            containerView.distribution = .fill
        case .segmented:
            containerView.distribution = .fillEqually
        }

        let itemCount = dataSource.numberOfItems(in: self)
        var containerHeight: CGFloat = 0.0

        switch options.addition {
        case .underline:
            containerHeight = frame.height - options.underlineView.height
        case .none:
            containerHeight = frame.height
        }

        switch options.style {
        case .flexible:
            let containerWidth = options.itemView.width * CGFloat(itemCount)
            contentSize = CGSize(width: containerWidth + options.margin * 2, height: options.height)
            containerView.frame = CGRect(x: 0, y: options.margin, width: containerWidth, height: containerHeight)
        case .segmented:
            contentSize = CGSize(width: frame.width, height: options.height)
            containerView .frame = CGRect(x: 0, y: options.margin, width: frame.width - options.margin * 2, height: containerHeight)
        }

        containerView.backgroundColor = .clear
        addSubview(containerView)
    }

    fileprivate func setupTabItemViews() {

        itemViews = []

        let itemCount = dataSource.numberOfItems(in: self)

        var xPosition: CGFloat = 0

        for index in 0..<itemCount {
            let tabItemView = TabItemView(frame: CGRect(x: xPosition, y: 0, width: options.itemView.width, height: containerView.frame.size.height))
            tabItemView.translatesAutoresizingMaskIntoConstraints = false
            tabItemView.backgroundColor = options.backgroundColor
            if let title = dataSource.tabView(self, titleForItemAt: index) {
                tabItemView.titleLabel.text = title
                tabItemView.titleLabel.font = options.itemView.font
                tabItemView.textColor = options.itemView.textColor
                tabItemView.selectedTextColor = options.itemView.selectedTextColor
            }

            tabItemView.isSelected = index == currentIndex

            switch options.style {
            case .flexible:
                if options.needsAdjustItemViewWidth {
                    var adjustCellSize = tabItemView.frame.size
                    adjustCellSize.width = tabItemView.titleLabel.sizeThatFits(containerView.frame.size).width + options.itemView.margin * 2
                    tabItemView.frame.size = adjustCellSize

                    containerView.addArrangedSubview(tabItemView)

                    NSLayoutConstraint.activate([
                        tabItemView.widthAnchor.constraint(equalToConstant: adjustCellSize.width)
                        ])
                } else {
                    containerView.addArrangedSubview(tabItemView)

                    NSLayoutConstraint.activate([
                        tabItemView.widthAnchor.constraint(equalToConstant: options.itemView.width)
                        ])
                }
            case .segmented:
                let adjustCellSize = CGSize(width: (frame.width - options.margin * 2) / CGFloat(itemCount), height: tabItemView.frame.size.height)
                tabItemView.frame.size = adjustCellSize

                containerView.addArrangedSubview(tabItemView)
            }

            itemViews.append(tabItemView)

            NSLayoutConstraint.activate([
                tabItemView.topAnchor.constraint(equalTo: containerView.topAnchor),
                tabItemView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])

            xPosition += tabItemView.frame.size.width
        }

        layout(containerView: containerView, containerWidth: xPosition)
        animateUnderlineView(index: currentIndex)
    }

    private func layout(containerView: UIView, containerWidth: CGFloat) {

        containerView.frame.size.width = containerWidth
        containerView.translatesAutoresizingMaskIntoConstraints = false

        switch options.style {
        case .flexible:
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: self.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: options.margin),
                containerView.widthAnchor.constraint(equalToConstant: containerWidth),
                containerView.heightAnchor.constraint(equalToConstant: options.height - options.underlineView.height)
                ])

            contentSize.width = containerWidth + options.margin * 2
        case .segmented:
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: self.topAnchor),
                containerView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: options.margin * -2),
                containerView.heightAnchor.constraint(equalToConstant: options.height - options.underlineView.height),
                containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                ])

            contentSize = .zero
        }
    }

    private func updateSelectedItem(by newIndex: Int) {
        for (i, itemView) in itemViews.enumerated() {
            itemView.isSelected = i == newIndex
        }
    }
}

// MARK: - UnderlineView

extension TabView {

    public enum Direction {
        case forward
        case reverse
    }

    fileprivate func setupUnderlineView() {

        if itemViews.isEmpty { return }

        switch options.addition {
        case .underline:
            let itemView = itemViews[currentIndex]
            underlineView = UIView(frame: CGRect(x: itemView.frame.origin.x + options.underlineView.margin, y: itemView.frame.height, width: itemView.frame.width - options.underlineView.margin * 2, height: options.underlineView.height))
            underlineView.backgroundColor = options.underlineView.backgroundColor
            containerView.addSubview(underlineView)
        case .none:
            underlineView.backgroundColor = .clear
        }



        jump(to: currentIndex)
    }

    fileprivate func resetUnderlineViewPosition(index: Int) {
        guard options.style == .segmented else { return }
        let adjustCellWidth = (frame.width - options.margin * 2) / CGFloat(dataSource.numberOfItems(in: self)) - options.underlineView.margin * 2
        underlineView.frame.origin.x = adjustCellWidth * CGFloat(index) - options.underlineView.margin
        underlineView.frame.size.width = adjustCellWidth
    }

    public func animateUnderlineView(index: Int, completion: ((Bool) -> Swift.Void)? = nil) {

        update(index)

        UIView.animate(withDuration: 0.3, animations: { _ in
            let target = self.currentItem

            self.underlineView.frame.origin.x = target.frame.origin.x + self.options.underlineView.margin

            if self.options.needsAdjustItemViewWidth {
                let cellWidth = self.itemViews[index].frame.width
                self.underlineView.frame.size.width = cellWidth - self.options.underlineView.margin * 2
            }

            self.focus(on: target)
        }, completion: completion)
    }

    public func moveUnderlineView(index: Int, ratio: CGFloat, direction: Direction) {

        update(index)

        switch direction {
        case .forward:
            underlineView.frame.origin.x = currentItem.frame.origin.x + (nextItem.frame.origin.x - currentItem.frame.origin.x) * ratio + options.underlineView.margin
            underlineView.frame.size.width = currentItem.frame.size.width + (nextItem.frame.size.width - currentItem.frame.size.width) * ratio - options.underlineView.margin * 2
            if options.needsConvertTextColorRatio {
                nextItem.titleLabel.textColor = options.itemView.textColor.convert(to: options.itemView.selectedTextColor, multiplier: ratio)
                currentItem.titleLabel.textColor = options.itemView.selectedTextColor.convert(to: options.itemView.textColor, multiplier: ratio)
            }
        case .reverse:
            underlineView.frame.origin.x = previousItem.frame.origin.x + (currentItem.frame.origin.x - previousItem.frame.origin.x) * ratio + options.underlineView.margin
            underlineView.frame.size.width = previousItem.frame.size.width + (currentItem.frame.size.width - previousItem.frame.size.width) * ratio - options.underlineView.margin * 2
            if options.needsConvertTextColorRatio {
                previousItem.titleLabel.textColor = options.itemView.selectedTextColor.convert(to: options.itemView.textColor, multiplier: ratio)
                currentItem.titleLabel.textColor = options.itemView.textColor.convert(to: options.itemView.selectedTextColor, multiplier: ratio)
            }
        }

        focus(on: underlineView, animated: false)
    }
}

extension TabView {
    var currentItem: TabItemView {
        return itemViews[currentIndex]
    }

    var nextItem: TabItemView {
        if currentIndex < itemViews.count - 1 {
            return itemViews[currentIndex + 1]
        }
        return itemViews[currentIndex]
    }

    var previousItem: TabItemView {
        if currentIndex > 0 {
            return itemViews[currentIndex - 1]
        }
        return itemViews[currentIndex]
    }

    func jump(to index: Int) {
        update(index)

        if options.addition == .underline {
            underlineView.frame.origin.x = currentItem.frame.origin.x
            underlineView.frame.size.width = currentItem.frame.size.width
        }

        focus(on: currentItem, animated: false)
    }
}
