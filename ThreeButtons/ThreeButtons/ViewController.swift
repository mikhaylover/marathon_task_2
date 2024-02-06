//

import UIKit

class ViewController: UIViewController {

    private lazy var firstButton: CustomButton = {
        makeButton(text: "First")
    }()

    private lazy var secondButton: CustomButton = {
        makeButton(text: "S  E  C  O  N  D")
    }()

    private lazy var thirdButton: CustomButton = {
        let button = makeButton(text: "Third (with action)")
        button.addTarget(self, action: #selector(showModalVC), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .white
        setLayout()
    }

    @objc
    private func showModalVC() {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        if let sheetController = controller.sheetPresentationController {
            sheetController.detents = [.large()]
        }
        present(controller, animated: true)
    }

    private func setLayout() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)

        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false

        firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0).isActive = true
        firstButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16.0).isActive = true
        firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true

        secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 32.0).isActive = true
        secondButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16.0).isActive = true
        secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true

        thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 32.0).isActive = true
        thirdButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16.0).isActive = true
        thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
    }

    private func makeButton(text: String) -> CustomButton {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.right.circle.fill")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)

        let button = CustomButton(configuration: configuration, primaryAction: nil)
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 8.0
        button.applyNormalDesign()
        return button
    }
}

class CustomButton: UIButton {
    struct Design {
        let tintColor: UIColor
        let backgroundColor: UIColor

        static let dimmed = Design(tintColor: .systemGray3, backgroundColor: .systemGray2)
        static let normal = Design(tintColor: .white, backgroundColor: .systemBlue)
    }

    func applyNormalDesign() {
        applyDesign(design: .normal)
    }

    private func applyDesign(design: Design) {
        setTitleColor(design.tintColor, for: .normal)
        setImage(UIImage(systemName: "arrow.right.circle.fill")?.withTintColor(design.tintColor, renderingMode: .alwaysOriginal), for: .normal)
        backgroundColor = design.backgroundColor
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        switch tintAdjustmentMode {
        case .dimmed:
            applyDesign(design: .dimmed)
        default:
            applyDesign(design: .normal)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.transform = CGAffineTransform.identity
        })
        super.touchesEnded(touches, with: event)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })
        super.touchesBegan(touches, with: event)
    }
}
