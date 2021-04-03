//
//  Animator.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import Foundation
import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // B2 - 9
    static let duration: TimeInterval = 0.5
    
    private let type: PresentationType
    private let firstViewController: MainViewController
    private let secondViewController: DetailViewController
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    private let cellLabelRect: CGRect
    
    // B2 - 10
    init?(type: PresentationType, firstViewController: MainViewController, secondViewController: DetailViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
              let selectedCell = firstViewController.selectedCell
        else { return nil }
        
        // B2 - 11
        self.cellImageViewRect = selectedCell.avatarImage.convert(selectedCell.avatarImage.bounds, to: window)
        
        // 46
        self.cellLabelRect = selectedCell.titleLabel.convert(selectedCell.titleLabel.bounds, to: window)
        
        
    }
    
    // B2 - 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    // B2 - 13
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        // 19
        guard let toView = secondViewController.view
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        containerView.addSubview(toView)
        
        // 21
        guard
            let selectedCell = firstViewController.selectedCell,
            let window = firstViewController.view.window ?? secondViewController.view.window,
            let cellImageSnapshot = selectedCell.avatarImage.snapshotView(afterScreenUpdates: true),
            let cellLabelSnapshot = selectedCell.titleLabel.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = secondViewController.avatarImage.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let isPresenting = type.isPresenting
        
        // 40
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.view.backgroundColor
        
        // 33
        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot
            
            // 41
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }
        
        // 23
        toView.alpha = 0
        
        // 34
        // 42
        // 48
        // 54
        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }
        
        // 25
        let controllerImageViewRect = secondViewController.avatarImage.convert(secondViewController.avatarImage.bounds, to: window)
        // 49
        let controllerLabelRect = secondViewController.loginLabel.convert(secondViewController.loginLabel.bounds, to: window)
        
        
        
        
        
        // 35
        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
            
            // 59
            $0.layer.cornerRadius = isPresenting ? 12 : 0
            $0.layer.masksToBounds = true
        }
        
        // 36
        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        
        // 37
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0
        
        // 50
        cellLabelSnapshot.frame = isPresenting ? cellLabelRect : controllerLabelRect
        
        
        // 56
        
        
        // 27
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                // 38
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                
                // 43
                fadeView.alpha = isPresenting ? 1 : 0
                
                // 51
                cellLabelSnapshot.frame = isPresenting ? controllerLabelRect : self.cellLabelRect
                
                // 60
                [controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                    $0.layer.cornerRadius = isPresenting ? 0 : 12
                }
            }
            
            // 39
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
            }
            
        }, completion: { _ in
            // 29
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            // 44
            backgroundView.removeFromSuperview()
            // 52
            cellLabelSnapshot.removeFromSuperview()
            // 58
            // 30
            toView.alpha = 1
            
            
            
            // 31
            transitionContext.completeTransition(true)
        })
        
    }
}

// B2 - 14
enum PresentationType {
    
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
