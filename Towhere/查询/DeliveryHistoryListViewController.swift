//
//  DeliveryHistoryListViewController.swift
//  Towhere
//
//  Created by ai966669 on 15/10/17.
//  Copyright © 2015年 elephant. All rights reserved.
//

import UIKit

class DeliveryHistoryListViewController: UIViewController {
    var arrMDeliveryHistory:[MDeliveryHistory]!
        @IBOutlet var btnEdit: UIButton!
    @IBOutlet var tableviewDeliveryHistroy: UITableView!
    @IBAction func goBack(){
        navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func edit(){
        tableviewDeliveryHistroy.setEditing(!tableviewDeliveryHistroy.editing, animated: true)
        if tableviewDeliveryHistroy.editing{
            btnEdit.setTitle("完成", forState: UIControlState.Normal)
        }else{
            btnEdit.setTitle("编辑", forState: UIControlState.Normal)
        }
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let aMDeliveryHistory=arrMDeliveryHistory[sourceIndexPath.row]
        arrMDeliveryHistory.removeAtIndex(sourceIndexPath.row)
        arrMDeliveryHistory.insert(aMDeliveryHistory, atIndex: destinationIndexPath.row)
        tableviewDeliveryHistroy.reloadData()
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
         return "删除"
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        DatabaseDelivery.deleteDeliveryHistroyByUseridAndNumber(arrMDeliveryHistory[indexPath.row].userId, number: arrMDeliveryHistory[indexPath.row].number)
        arrMDeliveryHistory.removeAtIndex(indexPath.row)
        tableviewDeliveryHistroy.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        initCell()
        initData()
        // Do any additional setup after loading the view.
    }
    func   initData(){
        arrMDeliveryHistory=DatabaseDelivery.getDeliveryHistroy()
    }
    let DeliveryHistoryListTableViewCellIdentifier="DeliveryHistoryListTableViewCell"
    func initCell(){
        tableviewDeliveryHistroy.registerNib(UINib(nibName: "DeliveryHistoryListTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: DeliveryHistoryListTableViewCellIdentifier)
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
extension DeliveryHistoryListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 80
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrMDeliveryHistory.count
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let  aDetailDeliveryViewController=DetailDeliveryViewController(nibName: "DetailDeliveryViewController", bundle: nil)

        self.navigationController?.pushViewController(aDetailDeliveryViewController, animated: true)
        
        
        aDetailDeliveryViewController.aMDeliveryHistory=arrMDeliveryHistory[indexPath.row]
        
        aDetailDeliveryViewController.initData()
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(DeliveryHistoryListTableViewCellIdentifier, forIndexPath: indexPath) as! DeliveryHistoryListTableViewCell
        let aMDeliveryHistory = arrMDeliveryHistory[indexPath.row]
        cell.detail.text=getNameByCode(arrMDeliveryHistory[indexPath.row].code)+"  \(arrMDeliveryHistory[indexPath.row].number)"
        cell.img.image=UIImage(named: "\(aMDeliveryHistory.code)")
        cell.time.text=aMDeliveryHistory.time
        return cell
    }
}
