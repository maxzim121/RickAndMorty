import UIKit
extension UIStackView {
    static func createCustomStack(
        views: [UIView]
    ) -> UIStackView {
        let stackView = UIStackView()
        views.forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
}
