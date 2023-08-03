import UIKit

extension String {
    func attributedStringWithBoldWords() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        let boldRegex = try? NSRegularExpression(pattern: "\\*\\*(.*?)\\*\\*", options: [])
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17)]

        if let boldRegex = boldRegex {
            let matches = boldRegex.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

            for match in matches {
                let range = match.range(at: 1)
                if let swiftRange = Range(range, in: self) {
                    let substring = String(self[swiftRange])
                    attributedString.addAttributes(boldAttributes, range: range)
                }
            }
        }

        return attributedString
    }
}
