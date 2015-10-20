//
//  DetailDeliveryViewController.swift
//  Towhere
//
//  Created by ai966669 on 15/10/17.
//  Copyright © 2015年 elephant. All rights reserved.
//

import UIKit

class DetailDeliveryViewController: UIViewController {
    
   
    @IBOutlet var detail: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var detailTableview: UITableView!
    var aHelpFromOc=helpFromOc()
    var aMDeliveryHistory:MDeliveryHistory!
    var DetailDeliveryTableViewCellIdentify="DetailDeliveryTableViewCell"
    var _mutarrDataList=[]
    @IBAction func goBack(){
        navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
        aHelpFromOc.aHelpFromOcDelegate = self
        // Do any additional setup after loading the view.
    }
    func initTable(){
        detailTableview.registerNib(UINib(nibName: "DetailDeliveryTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: DetailDeliveryTableViewCellIdentify)
    }
    func initData(){
        if (aMDeliveryHistory != nil){
            aHelpFromOc.loadDataFromNetBycodeAndNumber(aMDeliveryHistory.code, aMDeliveryHistory.number)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
extension DetailDeliveryViewController:HelpFromOcDelegate{
    func dataLoadDone(mutarrDataList: NSMutableArray!) {
        
        _mutarrDataList=mutarrDataList
        detailTableview.reloadData()
        img.image=UIImage(named: "\(aMDeliveryHistory.code)")
        detail.text = getNameByCode(aMDeliveryHistory.code)+aMDeliveryHistory.number
        
    }
}
extension DetailDeliveryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func getNameByCode(code:String)->String{
        switch (code) {
        case "ems":
            return "EMS快递"
        case "huitong":
            return "汇通快递"
        case "shentong":
            return "申通快递"
        case "shunfeng":
            return "顺丰快递"
        case "tiantian":
            return "天天快递"
        case "yuantong":
            return "圆通快递"
        case "yunda":
            return "韵达快递"
        case "zhongtong":
            return "中通快递"
        default:
            return "EMS快递"
            
        }
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 60
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        img.image=UIImage(named: "\(aMDeliveryHistory.code)")
        detail.text = getNameByCode(aMDeliveryHistory.code)+aMDeliveryHistory.number
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _mutarrDataList.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(DetailDeliveryTableViewCellIdentify, forIndexPath: indexPath) as! DetailDeliveryTableViewCell
        let  lsBean:ListBean1 = _mutarrDataList.objectAtIndex(indexPath.row) as! ListBean1
        cell.location.text=lsBean.detail
        cell.time.text=lsBean.time
        return cell
    }
}
