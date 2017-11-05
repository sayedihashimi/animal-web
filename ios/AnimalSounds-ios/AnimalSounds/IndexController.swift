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
    
    var pageIndex: [AppHelper.Page] = [AppHelper.Page.Animals,
                                       AppHelper.Page.AnimalQuiz,
                                       AppHelper.Page.Letters,
                                       AppHelper.Page.Shapes,
                                       AppHelper.Page.Dinosaurs,
                                       AppHelper.Page.Numbers,
                                       AppHelper.Page.AnimalVideo]
    
    var pageNames: [AppHelper.Page: String] = [AppHelper.Page.Animals:AppHelper.PageId.Animals,
                                               AppHelper.Page.AnimalQuiz:AppHelper.PageId.AnimalQuiz,
                                               AppHelper.Page.AnimalVideo:AppHelper.PageId.AnimalVideo,
                                               AppHelper.Page.Dinosaurs:AppHelper.PageId.Dinosaurs,
                                               AppHelper.Page.Letters:AppHelper.PageId.Letters,
                                               AppHelper.Page.Numbers:AppHelper.PageId.Numbers,
                                               AppHelper.Page.Shapes:AppHelper.PageId.Shapes]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPage(page: pageIndex[indexPath.row])
    }

    func navigateToPage(page: AppHelper.Page){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewName = pageNames[page]
        let nextView = storyBoard.instantiateViewController(withIdentifier: nextViewName!)
        self.present(nextView, animated: true, completion: nil)
    }
    
}

















