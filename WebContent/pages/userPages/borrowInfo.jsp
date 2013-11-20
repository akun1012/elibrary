<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Borrow information</title>
<style type="text/css">
.x-grid-record-red {   
    background: #F5C0C0;   //change background color
    color:#000000;  //change font color
}
</style>
<script type="text/javascript">
	var pagerNumber=0;
	var selectModel =new Ext.grid.RowSelectionModel({
        singleSelect:true
		});
	var searchString = "";
	// format data
	function dateRender(value){
		if(value!="null"&&value){
			if (typeof value == "string") { 
				return value = value.substr(0,10); 		
			}
			return value.format("Y-m-d");
			//return value;
		}else{
			return '';
		}
	};
	var borrowInfoListCM = new Ext.grid.ColumnModel([
	{
		header : "Category name",
		dataIndex : "categoryname",
		width : 80,
		sortable : true
		//renderer: function(data, cell, record, rowIndex, columnIndex, store) { 
		//if(record.get("expired")==1){
	    //cell.attr = "style=background-color:#F5C0C0";
		//}
		//return record.get("categoryname"); 
	    //}
	},{
		header : "book name",
		dataIndex : "literaturename",
		width : 100,
		sortable : true
	},{
		header : "student name",
		dataIndex : "sname",
		width : 80
	},{
		header :"student number",
		dataIndex : "snumber",
		width : 80,
		sortable : true
	},{
		header : "borrow number",
		dataIndex : "num",									
		width : 50,
		renderer : dateRender,
		sortable : true
	},{
		header : "total",
		dataIndex : "totalnum",
		width : 50,
		sortable : true
	},{
		header : "borrow time",
		dataIndex : "borrowtime",
		width : 90,
		renderer : dateRender,
		sortable : true
	},{
		header : "due return time",
		dataIndex : "expectedreturntime",
		width : 90,
		renderer : dateRender,
		sortable : true
	},{
		header : "returned",
		dataIndex : "returned",
		width : 50,
		renderer:function(value){
          if(value==0){
            return "no";
          }else{
            return "yes";
          }
	    },
		sortable : true
	},{
		header : "return time",
		dataIndex : "returntime",
		width : 90,
		renderer : dateRender,
		sortable : true
	}]);

	var store = new Ext.data.JsonStore({
		url : "<%=request.getContextPath()%>/listBorrowList.action", 
		root : "list",
		totalProperty : "total",
		fields:["categoryname","literaturename","totalnum","num","returned","returntime","borrowtime","expectedreturntime","sname","snumber","borrowid","expired"]
	});
	var borrowInfoListGrid = new Ext.grid.GridPanel({
		id:'borrowInfoListGrid',
		autoScroll:true,
		bodyStyle:'padding:0px 0px 0px',
		height : 350,
		width : 785,
		forceFit : true,
		stripeRows:true,
		defaults : {
			autoHeight : true,
			autoWidth : true
		},
		cm:borrowInfoListCM,
		sm:selectModel,
		store:store,
		viewConfig : {
			 forceFit :true,
			 getRowClass : function(record,rowIndex,rowParams,store){
			  //alert(record.data.expired);
			 // alert(record.data.returned);
			  if(record.data.expired=='1'&&record.data.returned=="0"){
			   return 'x-grid-record-red';
			  }else{
			   return '';
			  }     
			 }
			}
	});

	var query = new Ext.form.TextField({
		id:"queryforlist",
		//name:'searchKey',
		anchor:'90%',
		enableKeyEvents : true,
		initEvents: function() {
		var keyPress = function(e){  
			if (e.getKey() == e.ENTER) {  
				store.load({
					params : {
						start : 0,
						limit : 15
					}
				});
			}  
		};  
		this.el.on("keypress", keyPress, this);}
	});
	store.on("beforeload", function(){
		store.baseParams.searchKey = query.getRawValue();
	});
	var queryLabel = new Ext.form.Label({
		text:'search by stunum:'
	});
	var queryButton = new Ext.Button({
		text:'search',
		width:'30',
		enableKeyEvents : true, 
		handler:function(){
			store.load({
				params:{
					start:0,
					limit:15
				}
			});
		}
	});
	var borrowInfoPanel = new Ext.Panel({
		title : '<center><p><font size=3>Borrow information</font></p></center>',
		region:'east',
		bodyStyle : "padding:0px 0px 0px",
		forceFit : true,
		autoscroll : true,
		frame : true,
		width : '768',
		tbar:[{
			text:"borrow",
			width:80,
			handler:function(){
				loadpage("<%=request.getContextPath()%>/pages/userPages/addBorrowInfo.jsp");
			}
		},'->',queryLabel,query,queryButton],
		items : [{
			columnWidth : 1,
			layout : 'form',
			border : false,
			items : [borrowInfoListGrid]
		}],
		bbar:new Ext.PagingToolbar({
			pageSize:15,
			store:store,
			displayInfo:true,
			displayMsg: 'display records from {0} to {1},{2} in total.',
			emptyMsg:'No record.'
		})
	});	 
	Ext.onReady(function(){
		Ext.QuickTips.init();
		borrowInfoPanel.render("borrowInfoDisPlay");
		store.reload({
			params:{
				start:0,
				limit:15
			}
		});
	});
</script>
</head>
<body>
<div id="borrowInfoDisPlay"></div>
</body>
</html>