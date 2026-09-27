import UIKit

class CustomBadgeCardView: UIView {
    
    // MARK: - UI Components
    private let cardContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 6
        view.layer.masksToBounds = false // Allow shadow to show
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Inner content view that clips bounds for the slanted ribbon
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true // Crucial for clipping the ribbon edges
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a product card built entirely in Swift using UIKit, featuring a beautiful slanted corner ribbon badge."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ribbonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed // UIkit red label style
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ribbonLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(cardContainerView)
        cardContainerView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ribbonContainer)
        ribbonContainer.addSubview(ribbonLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Card Container Constraints
            cardContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            // Content View Constraints (matches container)
            contentView.topAnchor.constraint(equalTo: cardContainerView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor),
            
            // Labels Constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60), // Room for badge
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Ribbon Container Layout Constraints (Fixed Width & Height for accurate rotation positioning)
            ribbonContainer.widthAnchor.constraint(equalToConstant: 140),
            ribbonContainer.heightAnchor.constraint(equalToConstant: 24),
            // Position near the top right corner
            ribbonContainer.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            ribbonContainer.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            
            // Ribbon Text Constraints
            ribbonLabel.centerXAnchor.constraint(equalTo: ribbonContainer.centerXAnchor),
            ribbonLabel.centerYAnchor.constraint(equalTo: ribbonContainer.centerYAnchor)
        ])
    }
    
    // MARK: - Layout Subviews (Apply Rotation Matrix here)
    override func layoutSubviews() {
        super.layoutSubviews()
        // Rotate the ribbon container by 45 degrees to create the slanted badge look
        let radians = CGFloat(45.0 * .pi / 180.0)
        ribbonContainer.transform = CGAffineTransform(rotationAngle: radians)
    }
}
