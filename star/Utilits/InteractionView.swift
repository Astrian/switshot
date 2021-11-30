import SwiftUI

extension View {
    func contextMenuWithPreview<Content: View>(
        actions: [UIAction],
        @ViewBuilder preview: @escaping () -> Content
    ) -> some View {
        self.overlay(
            InteractionView(
                preview: preview,
                menu: UIMenu(title: "", children: actions),
                didTapPreview: {}
            )
        )
    }
}

private struct InteractionView<Content: View>: UIViewRepresentable {
    @ViewBuilder let preview: () -> Content
    let menu: UIMenu
    let didTapPreview: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let menuInteraction = UIContextMenuInteraction(delegate: context.coordinator)
        view.addInteraction(menuInteraction)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            preview: preview(),
            menu: menu,
            didTapPreview: didTapPreview
        )
    }
    
    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        let preview: Content
        let menu: UIMenu
        let didTapPreview: () -> Void
        
        init(preview: Content, menu: UIMenu, didTapPreview: @escaping () -> Void) {
            self.preview = preview
            self.menu = menu
            self.didTapPreview = didTapPreview
        }
        
        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            configurationForMenuAtLocation location: CGPoint
        ) -> UIContextMenuConfiguration? {
            UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: { [weak self] () -> UIViewController? in
                    guard let self = self else { return nil }
                    return UIHostingController(rootView: self.preview)
                },
                actionProvider: { [weak self] _ in
                    guard let self = self else { return nil }
                    return self.menu
                }
            )
        }
        
        func contextMenuInteraction(
            _ interaction: UIContextMenuInteraction,
            willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
            animator: UIContextMenuInteractionCommitAnimating
        ) {
            animator.addCompletion(self.didTapPreview)
        }
    }
}
