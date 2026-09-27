import UIKit

class BottomSheetPresentationController: UIPresentationController {

    private let sheetHeight: CGFloat

    init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        height: CGFloat
    ) {
        self.sheetHeight = height
        super.init(
            presentedViewController: presentedViewController,
            presenting: presentingViewController
        )
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }

        return CGRect(
            x: 0,
            y: containerView.bounds.height - sheetHeight,
            width: containerView.bounds.width,
            height: sheetHeight
        )
    }
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        let dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        containerView.insertSubview(
            dimmingView,
            belowSubview: presentedView!
        )
    }
}
