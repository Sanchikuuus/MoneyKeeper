//
//  WalletsViewController.swift
//  Moneykeeper
//
//  Created by Sashko Shel on 6/23/19.
//  Copyright © 2019 Sashko Shel. All rights reserved.
//

import UIKit

class WalletsViewController: UIViewController {
    
    private var currentPage = 0
    private var delta: CGFloat = 0
    private var startFingerCoordinates: CGFloat = 0
    private var fingerCoordinates: CGFloat = 0
    private var wallets: [WalletUIView] = []
    private let animDuration = 0.5
    private let swipeDelta:CGFloat = 50
    @IBOutlet weak var walletView1: WalletUIView!
    @IBOutlet weak var walletView2: WalletUIView!
    @IBOutlet weak var walletView3: WalletUIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wallets = [walletView1!, walletView2!, walletView3!]
        pageControl.numberOfPages = wallets.count
        wallets[0].frame.origin.x = 40
        for i in 1..<wallets.count {
            wallets[i].frame.origin.x = UIScreen.main.bounds.width
        }
    }
    
    @IBAction func panGestureAction(_ sender: UIPanGestureRecognizer) {
        
        fingerCoordinates = sender.location(in: self.view).x
        
        switch sender.state {
        case .possible, .cancelled, .failed:
            break
        case .began:
            fingerCoordinates = sender.location(in: self.view).x
            startFingerCoordinates = fingerCoordinates
            delta = fingerCoordinates - self.wallets[currentPage].frame.origin.x - self.wallets[currentPage].frame.width / 2
        case .changed:
            fingerCoordinates = sender.location(in: self.view).x
            self.wallets[currentPage].frame.origin.x = fingerCoordinates - delta - self.wallets[currentPage].frame.width / 2
            
            if IsCanMoveRight() {
                self.wallets[currentPage + 1].frame.origin.x =  fingerCoordinates - startFingerCoordinates + UIScreen.main.bounds.width
            } else if IsCanMoveLeft() {
                self.wallets[currentPage - 1].frame.origin.x = fingerCoordinates - startFingerCoordinates - UIScreen.main.bounds.width + 80
            }
        case .ended:
            if IsCanMoveRight(swipeDelta)  {
                move(-1, 80)
            } else if IsCanMoveLeft(swipeDelta) {
                move(1)
            } else {
                UIView.animate(withDuration: animDuration) {
                    self.wallets[self.currentPage].frame.origin.x = 40
                }
                if IsCanMoveRight() {
                    UIView.animate(withDuration: animDuration) {
                        self.wallets[self.currentPage + 1].frame.origin.x = UIScreen.main.bounds.width
                    }
                } else if IsCanMoveLeft() {
                    UIView.animate(withDuration: animDuration) {
                        self.wallets[self.currentPage - 1].frame.origin.x = -UIScreen.main.bounds.width + 80
                    }
                }
            }
        @unknown default:
            break
        }
    }
    
    private func move(_ direction: CGFloat, _ correction: CGFloat = 0) {
        let position = UIScreen.main.bounds.width
        UIView.animate(withDuration: animDuration) {
            self.wallets[self.currentPage].frame.origin.x = direction * position + correction
        }
        currentPage = currentPage - Int(direction)
        pageControl.currentPage = currentPage
        UIView.animate(withDuration: animDuration) {
            self.wallets[self.currentPage].frame.origin.x = 40
        }
    }
    
    private func IsCanMoveRight(_ delta: CGFloat = 0) -> Bool {
        if startFingerCoordinates - fingerCoordinates > delta, currentPage != (wallets.count - 1) {
            return true
        }
       return false
    }
    
    private func IsCanMoveLeft(_ delta: CGFloat = 0) -> Bool {
        if startFingerCoordinates - fingerCoordinates < -delta, currentPage != 0 {
            return true
        }
        return false
    }
    
}

