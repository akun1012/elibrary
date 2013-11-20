<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Borrow Info</title>
<script type="text/javascript">
var borrowid = "";
var updateInfo = function(tempUpdate){
	var detailJsonArray = Ext.util.JSON.encode(tempUpdate);
	
	Ext.Ajax.request({
		url : '<%=request.getContextPath()%>/BorrowInfoSave.action',
		params : {
			"snumber" : studentNumber.getValue(),
			"detailJsonArray":detailJsonArray		
		},
		method : 'POST',
		failure : function(response, options) {
			Ext.MessageBox.alert('INFO', 'Illegal operation for circulation number more than inventory quantity.');
		},
		success : function(response, options) {
			var result = Ext.util.JSON.decode(response.responseText);
			if (result.error == 'false') {
				store.rejectChanges();
				Ext.MessageBox.alert('INFO', 'Data submitted！');
				loadpage("<%=request.getContextPath()%>/pages/userPages/borrowInfo.jsp");
			} else {
				Ext.Msg.alert('FAIL', "Operation failure!");
			}
		}
	});
};
function renderCol(data, cell, record, rowIndex, columnIndex, store) {  
    cell.attr = "style=background-color:#F5C0C0";   //set background-color for cell
    return data;  
  } 
var literatureIndex= new Ext.form.TextField({
	fieldLabel:'book index',
	anchor:"80%",
	allowBlank:false, 
	blankText:"Please enter the index number.",
	maxLength:25,
	maxLengthText : "Please enter valid index number.",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'Letter or number only.',
	width:80
});

var studentNumber= new Ext.form.TextField({
	fieldLabel:'student number',
	anchor:"80%",
	allowBlank:false, 
	blankText:"Please enter student number",
	maxLength:25,
	maxLengthText : "Please enter valid student number.",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'Letter or number only.',
	width:80
});


var info_input_ok= new Ext.Button({
	text:'confirm',
	handler:function(){
		if(!panel.form.isValid()){
			 Ext.Msg.alert('INFO', 'Incomplete information!');
			 return;
		}		
		var tempUpdate=[];
		var flag = true;
		emptyStore.each(function(record){
			//alert(record.get("borrownum"));
			if(!record.get("borrownum"))
			{        
				flag=false;
		    }else {
				tempUpdate.push(record.data);  
		    }   					 
		});
		if(emptyStore.getCount()<1)
		{
			Ext.Msg.alert("INFO","Quantity column cannot be empty!");
			return;
		}
		if(flag==false)
		{
			Ext.Msg.alert('INFO', 'Incomplete mandatory information, please check!');
			return;
		}
		Ext.Msg.confirm("INFO","Confirm to save?",function(btn){
			if(btn=='yes')
			{
				updateInfo(tempUpdate);
			}
		});
	}
});
var emptyStore = new Ext.data.JsonStore({//data source
	url : "<%=request.getContextPath()%>/returnEmptyJson.action", 
	root : "list",
	fields:["lindex1","literaturename1","categoryid1","author1","num1","outnum1","borrownum"]
    //fields:[]
    //fields:["literaturename1","categoryid1","author1","press1","price1","num1","lindex1","literatureid1","outnum1"]
});
emptyStore.load();
var sm=new Ext.grid.CheckboxSelectionModel({
	singleSelect:false
});
var borrowProInfoListCM = new Ext.grid.ColumnModel([
     new Ext.grid.RowNumberer(),
     sm,
     {
  		header : "index number",
  		dataIndex : "lindex1",
  		width : 50,
  		sortable : true
  	},{
 		header : "book name",
 		dataIndex : "literaturename1",
 		width : 150,
 		sortable : true
 	},{
 		header : "category",
 		dataIndex : "categoryid1",
 		width : 100,
 		sortable : true
 	},{
 		header : "author",
 		dataIndex : "author1",
 		width : 80,
 		sortable : true
 	},{
 		header : "press",
 		dataIndex : "press1",
 		width : 150,
 		sortable : true
 	},{
 		header : "num",
 		dataIndex : "num1",
 		width : 50,
 		sortable : true
 	},{
 		header : "loan",
 		dataIndex : "outnum1",
 		width : 70,
 		sortable : true
 	},{
 		header : "borrow number",
 		dataIndex : "borrownum",
 		width : 50,
 		sortable : true,
 		renderer: renderCol,
 		editor : new Ext.form.ComboBox({
		      typeAhead: true,
		      triggerAction: 'all',
		      lazyRender : true,
		      allowBlank : false,
		      blankText : "select the number",
		      selectOnFocus : true,
		      editable : true,
		      mode : 'remote',
		      store: [[1, '1'],[2, '2'],[3, '3'],[4, '4'],[5, '5'],[6, '6'],[7, '7'],[8, '8'],[9, '9'],[10, '10']],
		      displayField:'',
		      valueField:''
		      //hiddenName:"student.sex",
	})
 	}
	]);
var categoryStore = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/listCategory.action",
	root:"nodes",
	fields:["categoryid","categoryname"] 
});
categoryStore.load();


var store = new Ext.data.JsonStore({//data source
	url : "<%=request.getContextPath()%>/listLiterature.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["literaturename","categoryid","author","press","price","num","lindex","literatureid","outnum"]
});
store.load();

var borrowProrInfoListCM = new Ext.grid.EditorGridPanel({
	id:'borrowProrInfoListCM',
	clicksToEdit:1,
	autoScroll:true,
	bodyStyle:'padding:0px 0px 0px',
	height : 240,
	width:760,
	stripeRows:true,
	cm:borrowProInfoListCM,
	sm:sm,
	store:emptyStore
	//store:store
});
borrowProrInfoListCM.on("afteredit", afterEdit, borrowProrInfoListCM);  

function afterEdit(obj){
	var record = obj.record;//get the updated line
	var row = obj.field;
};
var borrowProPanel = new Ext.Panel({
	title : 'book list',
	region:'east',
	bodyStyle : "padding:0px 0px 0px",
	frame : true,
	width : '100%',
	height:310,
	tbar:[{
		xtype :"button",
		width:80,
		text:"add",
		handler:function(){

		var index = store.find('lindex',literatureIndex.getValue());   

		     
		//alert(store.getAt(index).get('literaturename')); 
        
	        var plant = borrowProrInfoListCM.getStore().recordType;
	        //var plant = borrowProrInfoListCM.cm.recordType;
	        var newPlant = new plant({
	        	literaturename1:store.getAt(index).get('literaturename'),
	        	categoryid1:store.getAt(index).get('categoryid'),
	        	lindex1:store.getAt(index).get('lindex'),
	        	author1:store.getAt(index).get('author'),
	        	press1:store.getAt(index).get('press'),
	        	price1:store.getAt(index).get('price'),
	        	num1:store.getAt(index).get('num'),
	        	outnum1:store.getAt(index).get('outnum')
	        });
	        borrowProrInfoListCM.stopEditing();
	        emptyStore.insert(0, newPlant);
	        borrowProrInfoListCM.startEditing(0, 1);
		}
		},'-',{
			xtype:"button",
			text:"reset",
			width:80,
			handler:function(){
				store.reload();
			}
		},'-',{
			xtype :"button",
			width:80,
			text:"delete",
			handler:function(){
				if(borrowProrInfoListCM.getSelectionModel().getSelected()==null){
					Ext.Msg.alert("INFO","Please select one line.");
					return;
				}else{
					if(store.getCount()<=1){
						Ext.Msg.alert("INFO","Please select one data at least.");
						return;
					}
					var selections = borrowProrInfoListCM.getSelectionModel().getSelections();
					var length = selections.length;
					if(length==store.getCount()){
						Ext.Msg.alert("INFO","At least one line should be kept!");
						return;
					}
					Ext.Msg.confirm("INFO","Confirm?",function(btn){
						if(btn=="yes"){								
							store.remove(selections);										
						}
					});
				}
			}
		}
	],
	items : borrowProrInfoListCM		
});
var info_input_back= new Ext.Button({
	text:'back',
	handler:function(){
		loadpage("<%=request.getContextPath()%>/pages/userPages/borrowInfo.jsp");
	}
});
var panel = new Ext.FormPanel({
	fileUpload:true,
	frame:true,
	title: '<center><p><font size=3>borrow column</font></p></center>', 
	bodyStyle:'padding:0 0 0 0', 
	width : 790,
	autoHeight : true,
	layout:"column",
	//autoScroll: true,
	buttonAlign:'right',
	labelAlign : 'right',
	waitMsgTarget : true,
	labelWidth:80,
	items:[{
		columnWidth:.5,
		layout: 'form',
		border:false,
		items:literatureIndex
	},{
		columnWidth:.5,
		layout:'form',
		border:false,
		items:studentNumber
	},{
		columnWidth:1,
		layout:'column',
		height:300,
		border:false,
		items:borrowProPanel
	}],
	buttons:[info_input_ok,info_input_back]
});

Ext.onReady(function(){
	Ext.QuickTips.init("");
	Ext.form.Field.prototype.msgTarget = 'under';
	panel.render("addBorrowPanel");
});
</script>
</head>
<body>
<div id="addBorrowPanel"></div>
</body>
</html>