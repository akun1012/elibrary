<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">

$(function(){
	  $("#closepdf").click(function(){
			 $("#pdfviewer").hide(); 
		  });	  
	  
	  $("#closeimg").click(function(){
			 $("#imgviewer").hide(); 
		  });		  
});

function imgDel(delId) {
	Ext.Msg.confirm("Confirm", "Delete？",
		function(btn) {		    
			if (btn == "yes") {		
				Ext.Msg.alert("Notice","Completed!");
			}
		}
	);
};
var uploadPhotoId = "";
var categoryStore = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/listCategory.action",
	root:"nodes",
	fields:["categoryid","categoryname"] 
});
categoryStore.load();
var store = new Ext.data.JsonStore({
	url : "<%=request.getContextPath()%>/listLiterature.action", 
	root : "nodes",
	totalProperty : "total",
	fields:["literaturename","categoryid","author","press","price","num","lindex","literatureid","outnum"]
});
var limit=100;
var sm=new Ext.grid.CheckboxSelectionModel();
var cm = new Ext.grid.ColumnModel([
	sm,
	{
		header : "Name",
		dataIndex : "literaturename",
		width : 150,
		sortable : true
	},{
		header : "Category",
		dataIndex : "categoryid",
		width : 100,
		sortable : true,
		renderer:function(categoryid){
        var count = categoryStore.getCount();
        for(var i=0;i<=count;i++){
            var temp = categoryStore.getAt(i).get('categoryid');
        	if(temp==categoryid){
        	     return categoryStore.getAt(i).get('categoryname');  
        	}    
        }
	}
	},{
		header : "Index",
		dataIndex : "lindex",
		width : 50,
		sortable : true
	},{
		header : "Author",
		dataIndex : "author",
		width : 80,
		sortable : true
	},{
		header : "Press",
		dataIndex : "press",
		width : 50,
		sortable : true
	},{
		header : "Price",
		dataIndex : "price",
		width : 50,
		sortable : true
	},{
		header : "Number",
		dataIndex : "num",
		width : 50,
		sortable : true
	},{
		header : "BorrowedNum",
		dataIndex : "outnum",
		width : 70,
		sortable : true
	}
	,{
		header : "PDF",
		dataIndex : "outnum",
		width : 50,	
		renderer: function(){return "<img src='' alt='...' />";}
	},{
		header : "IMG",
		dataIndex : "outnum",
		width : 50,
	    renderer: function(value){
	        return "<img src='' alt='...' />";
	    }
	}
]);

var literatureGrid = new Ext.grid.EditorGridPanel({
	bodyStyle : "padding:0px 0px 0px 0px",
	height : 440,
	width : 785,
	height:470,
	autoScroll : true,
	cm : cm,
	sm : sm,
	store : store,
	listeners:
	{
		cellclick:function(obj, rowIndex, columnIndex, f)
		{
			//console.log(obj);
			//console.log(rowIndex);
			//console.log(columnIndex);
			var record = obj.getStore().getAt(rowIndex);
			var id = record.get('literatureid');
			var url = $("#contextPath").val();
			//console.log(id);
			if(columnIndex == 9)
			{//FileIMG
				$("#actualpdf").attr("data", url+"/elibrary/uploadedPDF/"+id+ "FilePDF.pdf");
				$("#pdfviewer").show();
			}
			else if(columnIndex == 10)
			{
				$("#actualimage").attr("src", url+"/elibrary/uploadedImages/"+id+ "FileImage.jpg");
				$("#imgviewer").show();
				
			}
			else{}
			
		}
	}
});
var literaturenameTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Name',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.literaturename",
	maxLengthText : "Maximum Length is 20"
});
var lindexTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Index',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"literature.lindex",
	maxLengthText : "Maximum Length is 10"
});
var authorTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Author',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 20,
	name:"literature.author",
	maxLengthText : "Maximum Length is 20"
});
var pressTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Press',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.press",
	maxLengthText : "Maximum Length is 50"
});
var priceTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Price',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 50,
	name:"literature.price",
	maxLengthText : "Maximum Length is 10"
});
var numTextFeild=new Ext.form.TextField({
	margins : '0 0 0 0',
	fieldLabel : '<font color = "red">*</font>Num',
	allowBlank: false,
	blankText: 'Cannot be blank!',
	width:220,
	anchor:'90%',
	maxLength : 10,
	name:"literature.num",
	maxLengthText : "Maximum Length is 10"
});
var categoryCombo=new Ext.form.ComboBox({
	margins:'0 0 0 0', 
	fieldLabel: '<font color = "red">*</font>Category',		    	
	allowBlank:false, 
	width:220,
	height: 25,
	anchor:'90%',
	editable : false,
	hiddenName:"category.categoryid",
	mode:'local',
	store:categoryStore,
	valueField: 'categoryid',
    displayField: 'categoryname',
	triggerAction : 'all'
});

var closeButton=new Ext.Button({
	text:'Close',				
	minWidth:80,
	handler:function(){
		addWindow.hide();
	}
});

//Image file type 
var img_reg = /\.([jJ][pP][gG]){1}$|\.([jJ][pP][eE][gG]){1}$|\.([gG][iI][fF]){1}$|\.([pP][nN][gG]){1}$|\.([bB][mM][pP]){1}$/;  

var win_uploadImage = new Ext.Window({  
    layout:'fit',  
    width:380,  
    closeAction:'hide',  
    height:380,  
    resizable:false,  
    shadow:false,  
    modal:true,  
    closable:true,  
    bodyStyle:'padding: 5 5 5 5',  
    animCollapse:true,  
    imageIndexName:'',  
    items:[{  
        xtype:'form',  
        id:'image-upload-form',  
        frame:true,  
        border:false,  
        isAdd:false,  
        enctype: 'multipart/form-data',  
        fileUpload : true,  
        layout : 'form',  
        items:[{  
           id : 'file-idx',  
           name : 'upload',  
           inputType : "file",  
           fieldLabel : 'Upload Photo',  
           xtype : 'textfield',  
           blankText:'Please select a photo first!',  
           anchor : '100%'   
        },{  
           xtype : 'box',     
           id : 'browseImage',  
           fieldLabel : "",//Preview     
           autoEl : {  
               width : 300,  
               height : 300,  
               tag : 'img',  
                // type : 'image',  
               src : Ext.BLANK_IMAGE_URL,  
               style : 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);',     
               complete : 'off',     
               id : 'imageBrowse'  
           }  
        }  
        ],  
        listeners : {     
            'render' : function(f) {  
                //  
                this.form.findField('file-idx').on('render', function() {  
                    Ext.get('file-idx').on('change',  
                        function(field, newValue, oldValue) {  
                        var url = 'file://'+ Ext.get('file-idx').dom.value;  
                        //alert("url = " + url);     
                        if (img_reg.test(url)) {  
                            if (Ext.isIE) {  
                                var image = Ext.get('imageBrowse').dom;     
                                image.src = Ext.BLANK_IMAGE_URL;  
                                image.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = url;     
                            } 
                            else {  
                            	//alert('not ie');
                            	alert(Ext.get('file-idx').dom.files.item(0).getAsDataURL());
                                Ext.get('imageBrowse').dom.src = Ext.get('file-idx').dom.files.item(0).getAsDataURL();  
                            }  
                        }  
                    }, this);     
                }, this);     
            }     
        },   
        buttons:[{  
           text:'Close',  
           handler:function(){  
        	    Ext.getCmp('image-upload-form').form.reset();
        	    Ext.getCmp('pdf-upload-form').form.reset();
                win_uploadImage.hide();  
           }  
           },{  
                text:'Upload',  
                handler:function() {  
                    var furl="";  
                    furl = Ext.getCmp('image-upload-form').form.findField('upload').getValue();  
                    var type = furl.substring(furl.length - 3).toLowerCase();  
                    if (furl == "" || furl == null) {  
                        return;  
                    }  
                    if (type != 'jpg' && type != 'bmp' && type != 'gif' && type != 'png') {  
                        alert('Only jpg、bmp、gif、png are accepted');  
                        return;  
                    }  
                    //alert(uploadId);
                    if (uploadId==""){
                    	alert('You have not select a book!');
                    }
                   Ext.getCmp('image-upload-form').form.submit({  
                        clienValidation:true,  
                        waitMsg:'Uploading...Please Wait.',  
                        waitTitle:'Notice',  
                        url:"<%=request.getContextPath()%>/uploadPhoto.action",
                        params: {uploadId: uploadId },
                        method:'POST',  
                        success:function(form,action){  
                            var picName = action.result.data;  
                            if(win_uploadImage.imageIndexName!=''){  
                                Ext.getCmp(win_uploadImage.imageIndexName).setValue(picName);  
                            }  
                            //reset form  
                            Ext.getCmp('image-upload-form').form.el.dom.reset();
                            Ext.getCmp('pdf-upload-form').form.reset();
                            if (Ext.isIE) {  
                                var i_image = Ext.get('imageBrowse').dom;  
                                i_image.src = Ext.BLANK_IMAGE_URL;  
                                i_image.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = Ext.BLANK_IMAGE_URL;  
                            }else{  
                                Ext.get('imageBrowse').dom.src = Ext.BLANK_IMAGE_URL;  
                            }  
                            alert("Success!");
                            win_uploadImage.hide();  
                            uploadId = "";
                        },  
                        failure:function(form,action){  
                            Ext.MessageBox.show({title: 'Error',msg: 'Sorray, there is an error.',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.ERROR});  
                        }  
                   });
                }  
           }  
       ]  
}]  
});  

var win_uploadPDF = new Ext.Window({  
    layout:'fit',  
    width:380,  
    closeAction:'hide',  
    height:380,  
    resizable:false,  
    shadow:false,  
    modal:true,  
    closable:true,  
    bodyStyle:'padding: 5 5 5 5',  
    animCollapse:true,  
    pdfIndexName:'',  
    items:[{  
        xtype:'form',  
        id:'pdf-upload-form',  
        frame:true,  
        border:false,  
        isAdd:false,  
        enctype: 'multipart/form-data',  
        fileUpload : true,  
        layout : 'form',  
        items:[{  
           id : 'file-idxpdf',  
           name : 'upload',  
           inputType : "file",  
           fieldLabel : 'Upload PDF',  
           xtype : 'textfield',  
           blankText:'Please select a pdf file first!',  
           anchor : '100%'   
        }
        ],  
        buttons:[{  
           text:'Close',  
           handler:function(){  
        	    Ext.getCmp('pdf-upload-form').form.reset();
        	    Ext.getCmp('image-upload-form').form.reset();
                win_uploadPDF.hide();  
           }  
           },{  
                text:'Upload',  
                handler:function() {  
                    var furl="";  
                    furl = Ext.getCmp('pdf-upload-form').form.findField('upload').getValue();  
                    var type = furl.substring(furl.length - 3).toLowerCase();  
                    if (furl == "" || furl == null) {  
                        return;  
                    }  
                    if (type != 'pdf') {  
                        alert('Only pdf files are accepted');  
                        return;  
                    }  
                    if (uploadId==""){
                    	alert('You have not select a book!');
                    }
                   Ext.getCmp('pdf-upload-form').form.submit({  
                        clienValidation:true,  
                        waitMsg:'Uploading...Please Wait.',  
                        waitTitle:'Notice',  
                        url:"<%=request.getContextPath()%>/uploadPDF.action",
                        params: {uploadId: uploadId },
                        method:'POST',  
                        success:function(form,action){  
                            var pdfName = action.result.data;  
                            if(win_uploadPDF.pdfIndexName!=''){  
                                Ext.getCmp(win_uploadPDF.pdfIndexName).setValue(pdfName);  
                            }  
                            //reset form  
                            alert("Success!");
                            Ext.getCmp('pdf-upload-form').form.el.dom.reset();
                            Ext.getCmp('image-upload-form').form.reset();
                            win_uploadPDF.hide();  
                            uploadId = "";
                        },  
                        failure:function(form,action){  
                            Ext.MessageBox.show({title: 'Error',msg: 'Sorray, there is an error.',buttons: Ext.MessageBox.OK,icon: Ext.MessageBox.ERROR});  
                        }  
                   });
                }  
           }  
       ]  
}]  
});  

var addPanel = new Ext.form.FormPanel( {
	url : "<%=request.getContextPath()%>/addLiterature.action",
	method : "post",
	buttonAlign : 'center',
	labelAlign : 'right',				
	width : 500,
	//height : 1000,
	autoHeight:true,
	layout : "column",
	items:[{
		columnWidth : 1,
		layout : 'form',
		height : 30,
		border : false
		
	}, {
		//Name
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : literaturenameTextFeild
	},{
		//Index
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : lindexTextFeild
	},{
		//Category
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : categoryCombo
	}, {
		//Author 
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : authorTextFeild
	},{
		//Press
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : pressTextFeild
	}, {
		//Price
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : priceTextFeild
	},{
		//Sumnum
		columnWidth : 1,
		layout : 'form',
		height : 40,
		border : false,
		items : numTextFeild
	}]
});
var addWindow = new Ext.Window( {
	layout : 'fit',
	hidden : true,
	width : 400,
	closeAction : 'hide',
	//height : 260,
	autoHeight:true,
	resizable : false,
	shadow : true,
	modal : true,
	closable : true,
	draggable :false,
	bodyStyle : 'padding:5 5 5 5',
	animCollapse : true,
	items : [ addPanel ]
});

var query = new Ext.form.TextField({
	id:"queryforlist",
	anchor:'90%',
	enableKeyEvents : true,
	initEvents: function() {
		var keyPress = function(e){  
			if (e.getKey() == e.ENTER) {  
				store.reload({
					params : {
						key : query.getValue(),
						start : 0,
						limit : limit
					}
				});
			} 
		};  
		this.el.on("keypress", keyPress, this);
	}
});
store.on("beforeload", function(){
	store.baseParams.searchAddition = query.getRawValue();
});
var queryLabel = new Ext.form.Label({
	text:'Category：'
});

var queryButton = new Ext.Button({
	text:'Search',
	width:'30',
	handler:function(){
		var queryValue = query.getValue();
		store.reload({
			params :{key:queryValue,start:0,limit:limit}
		});
	}
});

var literaturePanel = new Ext.Panel( {
	title : "<center><p><font size=3>Book Management</font></p></center>",
	width : "768",
	frame : true,
	height : 510,
	autoScroll: true,
	tbar : [
	'-', {
		text : "Upload Photo",
		width:80,
		handler : function() {					
			var wh =  literatureGrid.getSelectionModel().getSelections();
			if(wh.length<1 || wh.length>1){
				Ext.Msg.alert('Notice', 'Please selece only one record!');
				return;
			}
			uploadId =wh[0].get("literatureid");
			win_uploadImage.show();
			win_uploadImage.setTitle('Upload Photo');							
		}
	},'-', {
		text : "Upload PDF",
		width:80,
		handler : function() {					
			var wh =  literatureGrid.getSelectionModel().getSelections();
			if(wh.length<1 || wh.length>1){
				Ext.Msg.alert('Notice', 'Please selece only one record!');
				return;
			}
			uploadId =wh[0].get("literatureid");
			win_uploadPDF.show();
			win_uploadPDF.setTitle('Upload PDF');							
		}
	},
	 /*        '-', {
		text : "Upload Photo",
		width:80,
		handler : function() {					
			var wh =  literatureGrid.getSelectionModel().getSelections();
			if(wh.length<1 || wh.length>1){
				Ext.Msg.alert('Notice', 'Please selece only one record!');
				return;
			}
			uploadPhotoId =wh[0].get("literatureid");
			win_uploadImage.show();
			win_uploadImage.setTitle('Upload Photo');							
		}
	}, */
	"->",{//Search
		xtype :"label",
		text:"Book name keywords:",
		width:120
	},query,"&nbsp",queryButton],
	items:[{
		columnWidth : 1,
		layout : 'form',
		border : false,
		items : literatureGrid
	}],
	bbar : new Ext.PagingToolbar( {
		pageSize : 15,
		displayInfo : true,
		displayMsg : 'List {0} to {1} records，total {2} ',
		store:store,
		emptyMsg : "No record."
	}),	
	buttons :[
	{
		text:'Save',
		xtype:'button',
		handler : function() {
			var mr = store.getModifiedRecords(); 
			if (mr.length > 0) {
				var tempUpdate = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("lindex").trim() != null
					 && mr[i].get("lindex").trim() != ""&&mr[i].get("literaturename").trim() != null
					  && mr[i].get("literaturename").trim() != "") {
						var data="{";
						data+='"literatureid":"'+mr[i].get("literatureid")+' ",';
						data+='"literaturename":"'+mr[i].get("literaturename")+' ",';
						data+='"lindex":"'+mr[i].get("lindex")+' ",';
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"author":"' + mr[i].get("author")+' ",';
						data+='"press":"'+mr[i].get("press")+' ",';
						data+='"price":"'+mr[i].get("price")+' ",';
						data+='"num":"' + mr[i].get("num")+' ",';
						data+="}";
						tempUpdate+=data+",";
					}
				}
				if(tempUpdate != "["){
					tempUpdate=tempUpdate.substring(0,tempUpdate.length-1);
				}
				tempUpdate+="]";
				var tempUpdate2 = "[";
				for (var i = 0; i < mr.length; i++) {
					if (mr[i].get("lindex").trim() != null
					 && mr[i].get("lindex").trim() != ""&&mr[i].get("literaturename").trim() != null
					  && mr[i].get("literaturename").trim() != "") {
						var data="{";
						data+='"literaturename":"'+mr[i].get("literaturename")+' ",';
						data+='"lindex":"'+mr[i].get("lindex")+' ",';
						data+='"categoryid":"'+mr[i].get("categoryid")+' ",';
						data+='"author":"' + mr[i].get("author")+' ",';
						data+='"press":"'+mr[i].get("press")+' ",';
						data+='"price":"'+mr[i].get("price")+' ",';
						data+='"num":"' + mr[i].get("num")+' ",';
						data+="}";
						tempUpdate2+=data+",";
					}
				}
				if(tempUpdate2 != "["){
					tempUpdate2=tempUpdate2.substring(0,tempUpdate.length-1);
				}
				tempUpdate2+="]";
				if (tempUpdate.length >2) {
					Ext.Ajax.request({
						url : '<%=request.getContextPath()%>/updateLiterature.action',
						params : {
							updateList : tempUpdate,
							updateList2 : tempUpdate2
						},
						method : 'POST',
						success: function(res){
							Ext.Msg.alert('Notice', res.responseText);
							store.reload();
							mr.length=0;			  											
						},
						failure : function(response, options) {}
					});
				}
			}
		}
	}]
});

Ext.onReady(function() {
	Ext.QuickTips.init();
	Ext.form.Field.prototype.msgTarget = 'under';
	literaturePanel.render("literatureListPanel");
	store.load({params : {key:''}});
});
	
</script>
</head>
<body>
<input id="contextPath" type="hidden" value="<%request.getContextPath(); %>"/>
<div id="imgviewer">
	<button id="closeimg">Close</button>
	<img id="actualimage" src="" alt="..."/>
</div>
<div id="pdfviewer">
<button id="closepdf">Close</button>
<object id="actualpdf" data="<%=request.getContextPath()%>/PDF/test.pdf" type="application/pdf" width="100%" height="100%">

  <p>It appears you don't have a PDF plugin for this browser.
  No biggie... you can <a href="myfile.pdf">click here to
  download the PDF file.</a></p>	

</object>
</div>
<div id="literatureListPanel"></div>
</body>
</html>