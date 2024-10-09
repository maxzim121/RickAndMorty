import UIKit
extension UILabel {
    static func createCustomLabel(
        text: String? = nil,
        fontSize: CGFloat,
        textColor: UIColor?,
        alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Chalkduster", size: fontSize)
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = 0
        return label
    }
}
