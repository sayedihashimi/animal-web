//
//  IndexController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/22/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import AVFoundation

class IndexController : UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var pageToNavigateTo = AppHelper.Page.Animals
        // navigate to the correct page
        switch indexPath.row {
        case 0:
            pageToNavigateTo = .Animals
        case 1:
            pageToNavigateTo = .Numbers
        case 2:
            pageToNavigateTo = .Letters
        case 3:
            pageToNavigateTo = .Shapes
        default:
            pageToNavigateTo = .Animals
        }
        
        navigateToPage(page: pageToNavigateTo)
    }
    
    func navigateToPage(page: AppHelper.Page){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        var nextViewName = AppHelper.PageId.Animals
        switch page{
        case .Animals:
            nextViewName = AppHelper.PageId.Animals
        case .Numbers:
            nextViewName = AppHelper.PageId.Numbers
        case .Letters:
            nextViewName = AppHelper.PageId.Letters
        case .Shapes:
            nextViewName = AppHelper.PageId.Shapes
        default:
            nextViewName = AppHelper.PageId.Animals
        }
        
        let nextView = storyBoard.instantiateViewController(withIdentifier: nextViewName)
        self.present(nextView, animated: true, completion: nil)
    }
    
}

















