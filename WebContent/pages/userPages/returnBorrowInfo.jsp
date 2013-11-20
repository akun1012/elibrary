<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Borrow Info</title>
<script type="text/javascript">
var borrowid = "";
var returnInfo = function(tempReturn){
	var detailJsonArray1 = Ext.util.JSON.encode(tempReturn);
	Ext.Ajax.request({
		url : '<%=request.getContextPath()%>/ReturnBorrowInfo.action',
		params : {
			"returnJsonArray":detailJsonArray1
		},
		method : 'POST',
		failure : function(response, options) {
			Ext.MessageBox.alert('INFO', 'Data sumbit failed!');
		},
		success : function(response, options) {
			var result = Ext.util.JSON.decode(response.responseText);
			if(result.forfeit>0){
				Ext.MessageBox.alert('INFO', "Book returned!	"+result.msg+"	Student number:"+snumberIndex.getValue());
			}else{
				Ext.MessageBox.alert('INFO', "Returned!");
			};	
			loadpage("<%=request.getContextPath()%>/pages/userPages/returnBorrowInfo.jsp");
			if (result.error == 'false') {
				store.rejectChanges();
				loadpage("<%=request.getContextPath()%>/pages/userPages/returnBorrowInfo.jsp");
			} else {
				Ext.Msg.alert('Failure', "Operation failed!");
			}
		}
	});
};
//format date
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
var emptyStore = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/returnEmptyJson.action", 
	root : "list",
	fields:["categoryname1","literaturename1","totalnum1","num1","returned1","returntime1","borrowtime1","expectedreturntime1","sname1","snumber1","borrowid","lindex1","lindex_snumber1"]
    //fields:[]
    //fields:["literaturename1","categoryid1","author1","press1","price1","num1","lindex1","literatureid1","outnum1"]
});
emptyStore.load();
var store = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/listBorrowListNotReturned.action", 
	root : "list",
	totalProperty : "total",
	fields:["categoryname","literaturename","totalnum","num","returned","returntime","borrowtime","expectedreturntime","sname","snumber","borrowid","lindex","lindex_snumber"]
});
store.load();
var literatureIndex= new Ext.form.TextField({
	fieldLabel:'index num',
	anchor:"80%",
	allowBlank:false, 
	blankText:"please enter index number",
	maxLength:25,
	maxLengthText : "please enter valid index number",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'letters and nums only',
	width:80
});
var snumberIndex= new Ext.form.TextField({
	fieldLabel:'student number',
	anchor:"80%",
	allowBlank:false, 
	blankText:"please enther student number",
	maxLength:25,
	maxLengthText : "please enter valid student number",
    regex:/^[\u4E00-\u9FA5A-Za-z0-9]+$/,
	regexText:'letters and nums only',
	width:80
});

var info_input_ok= new Ext.Button({
	text:'confirm',
	handler:function(){
		if(!panel.form.isValid()){
			 Ext.Msg.alert('INFO', 'incomplete information');
			 return;
		}		
		var tempReturn=[];
		var flag = true;
		emptyStore.each(function(record){
				tempReturn.push(record.data);  
		});
		if(emptyStore.getCount()<1)
		{
			Ext.Msg.alert("INFO","Num column should not be empty!");
			return;
		}
		Ext.Msg.confirm("INFO","Continue?",function(btn){
			if(btn=='yes')
			{
				returnInfo(tempReturn);
			}
		});
	}
});

var sm=new Ext.grid.CheckboxSelectionModel({
	singleSelect:false
});
var returnProInfoListCM = new Ext.grid.ColumnModel([
     new Ext.grid.RowNumberer(),
     sm,
     {
 		header : "category",
 		dataIndex : "categoryname1",
 		width : 80,
 		sortable : true
 	},{
 		header : "book name",
 		dataIndex : "literaturename1",
 		width : 100,
 		sortable : true
 	},{
 		header : "student name",
 		dataIndex : "sname1",
 		width : 80
 	},{
 		header :"student number",
 		dataIndex : "snumber1",
 		width : 80,
 		sortable : true
 	},{
 		header : "borrow time",
 		dataIndex : "borrowtime1",
 		width : 90,
 		renderer : dateRender,
 		sortable : true
 	},{
 		header : "due return time",
 		dataIndex : "expectedreturntime1",
 		width : 90,
 		renderer : dateRender,
 		sortable : true
 	},{
 		header : "return time",
 		dataIndex : "returntime1",
 		width : 90,
 		renderer : dateRender,
 		sortable : true
 	},{
 		header : "borrowid",
 		dataIndex : "borrowid",
 		hidden: true,
 		renderer : dateRender,
 		sortable : true
 	}
	]);


var returnProrInfoListCM = new Ext.grid.EditorGridPanel({
	id:'returnProrInfoListCM',
	clicksToEdit:1,
	autoScroll:true,
	bodyStyle:'padding:0px 0px 0px',
	height : 240,
	width:760,
	stripeRows:true,
	cm:returnProInfoListCM,
	sm:sm,
	store:emptyStore
});
returnProrInfoListCM.on("afteredit", afterEdit, returnProrInfoListCM);  

function afterEdit(obj){
	var record = obj.record;//get the updated line
	var row = obj.field;
};
var returnProPanel = new Ext.Panel({
	title : 'book list',
	region:'east',
	bodyStyle : "padding:0px 0px 0px",
	frame : true,
	width : '100%',
	height:310,
	
	items : returnProrInfoListCM		
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
	title: '<center><p><font size=3>book return page</font></p></center>', 
	bodyStyle:'padding:0 0 0 0', 
	width : 790,
	autoHeight : true,
	layout:"column",
	//autoScroll: true,
	buttonAlign:'right',
	labelAlign : 'right',
	waitMsgTarget : true,
	labelWidth:80,
	tbar:[{
		xtype :"button",
		width:80,
		text:"add",
		handler:function(){
		var lindex_snumber = literatureIndex.getValue()+snumberIndex.getValue();
		var index = store.find('lindex_snumber',lindex_snumber);
	        var plant = returnProrInfoListCM.getStore().recordType;
	        var newPlant = new plant({
	        	categoryname1:store.getAt(index).get('categoryname'),
	        	literaturename1:store.getAt(index).get('literaturename'),
	        	sname1:store.getAt(index).get('sname'),
	        	snumber1:store.getAt(index).get('snumber'),
	        	borrowtime1:store.getAt(index).get('borrowtime'),
	        	expectedreturntime1:store.getAt(index).get('expectedreturntime'),
	        	returntime1:store.getAt(index).get('returntime'),
	        	borrowid:store.getAt(index).get('borrowid')
	        	
	        });
	        returnProrInfoListCM.stopEditing();
	        emptyStore.insert(0, newPlant);
	        returnProrInfoListCM.startEditing(0, 1);
		}
		},"-",{
			xtype:"button",
			text:"reset",
			width:80,
			handler:function(){
				store.reload();
			}
		},"-",{
			xtype :"button",
			width:80,
			text:"delete",
			handler:function(){
				if(returnProrInfoListCM.getSelectionModel().getSelected()==null){
					Ext.Msg.alert("INFO","Please select one line.");
					return;
				}else{
					if(store.getCount()<=1){
						Ext.Msg.alert("INFO","Please select one data at least.");
						return;
					}
					var selections = returnProrInfoListCM.getSelectionModel().getSelections();
					var length = selections.length;
					if(length==store.getCount()){
						Ext.Msg.alert("INFO","At least one data should be kept!");
						return;
					}
					Ext.Msg.confirm("INFO","Confirm to delete?",function(btn){
						if(btn=="yes"){								
							store.remove(selections);										
						}
					});
				}
			}
		}
	],
	items:[{
		columnWidth:.5,
		layout: 'form',
		border:false,
		items:literatureIndex
	},{
		columnWidth:.5,
		layout: 'form',
		border:false,
		items:snumberIndex
	},{
		columnWidth:1,
		layout:'column',
		height:300,
		border:false,
		items:returnProPanel
	}],
	buttons:[info_input_ok,info_input_back]
});

Ext.onReady(function(){
	Ext.QuickTips.init();
	panel.render("returnBorrowPanel");
	store.load({params : {key:''}});
});
</script>
</head>
<body>
<div id="returnBorrowPanel"></div>
</body>
</html>