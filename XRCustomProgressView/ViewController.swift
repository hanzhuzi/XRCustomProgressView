//
//  ViewController.swift
//  XRCustomProgressView
//
//  Created by xuran on 2017/10/1.
//  Copyright © 2017年 xuran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainTableView: UITableView!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orange
        
        self.navigationItem.title = "XRCustomProgressView"
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .automatic
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
        self.initializationTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        
        debugPrint("statusBar: \(UIApplication.shared.statusBarFrame) \n navigationBar: \(self.navigationController!.navigationBar.frame) \n self.view: \(self.view.frame) \n self.tableView: \(self.mainTableView.frame)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initialization
    func initializationTableView() {
        
        self.mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height - 88), style: .grouped)
        self.mainTableView.backgroundColor = UIColor.gray
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        self.view.addSubview(self.mainTableView)
        
        if #available(iOS 11.0, *) {
            self.mainTableView.contentInsetAdjustmentBehavior = .never
        }
        
        // register cells
        self.mainTableView.register(MainCustomTableViewCell.classForCoder(), forCellReuseIdentifier: "MainCustomTableViewCell")
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        headerView.backgroundColor = UIColor.blue
        self.mainTableView.tableHeaderView = headerView
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor.green
        self.mainTableView.tableFooterView = footerView
        
        UITableView.appearance().estimatedRowHeight = 0
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
    }
    
    
    // MARK: - Action
    
    // MARK: - Notifications
    
    // MARK: - Oberses
    
    // MARK: - Requests
    
    // MARK: - Delegates
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MainCustomTableViewCell", for: indexPath) as? MainCustomTableViewCell
        
        if nil == cell {
            cell = MainCustomTableViewCell(style: .default, reuseIdentifier: "MainCustomTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.yearEarningsPrecentView.beginProgressAnimateWithPrecent(precent: 0.93, duration: 2.0, delayTime: 0, animate: true)
        cell?.paillarProgressView.animateForProgressView(duration: 2.0, delayTime: 0, progress: 0.93, animate: true)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        footer.contentView.backgroundColor = UIColor.brown
        footer.textLabel?.textColor = UIColor.white
        footer.textLabel?.text = "section footer"
        return footer
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        header.contentView.backgroundColor = UIColor.purple
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.text = "section header"
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}

