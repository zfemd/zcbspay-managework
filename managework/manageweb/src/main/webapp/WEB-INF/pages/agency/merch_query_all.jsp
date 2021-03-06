<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:include page="../../top.jsp"></jsp:include>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<body>
	<style type="text/css">
table tr td {
	height: 25px
}

table tr td input {
	height: 15px
}

table tr td select {
	height: 20px
}
</style>
	<div style="margin: 5px; border:" id="continer">
		<div id="p" class="easyui-panel" title="查询条件"
			style="height: 100px; padding: 10px; background: #fafafa;"
			iconCls="icon-save" collapsible="true">
			<form id="theForm" method="post">
				<input type="hidden" id="flag_ins" value="${flag}" />
				<table width="100%">
					<tr>
						<td align="right" width="10%">机构编号</td>
						<td align="left" style="padding-left: 5px" width="15%"><input
							id="merchId_ins" maxlength="15" /></td>
						<td align="right" width="10%">机构名称</td>
						<td align="left" style="padding-left: 5px" width="15%"><input
							id="memberName_ins" maxlength="50" /></td>
						<td align="right" width="10%">机构状态</td>
						<td align="left" style="padding-left: 5px" width="15%"><select
							id="status_ins" class="easyui-validatebox">
								<option value='00'>在用</option>
								<option value='12'>注册待完善信息</option>
								<option value='10'>注册待初审</option>
								<option value='11'>注册初审未过</option>
								<option value='19'>注册初审终止</option>
								<option value='20'>注册待复审</option>
								<option value='21'>注册复审未过</option>
								<option value='29'>注册复审终止</option>
								<option value='30'>变更待初审</option>
								<option value='32'>变更待完善信息</option>
								<option value='31'>变更初审未过</option>
								<option value='39'>变更初审终止</option>
								<option value='40'>变更待复审</option>
								<option value='41'>变更复审未过</option>
								<option value='49'>变更复审终止</option>
								<option value="02">变更待生效</option>
						</select></td>
						<td align="right">
						<a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">查询</a> 
						<a href="javascript:resize()" class="easyui-linkbutton" iconCls="icon-redo">清空</a></td>
					</tr>

				</table>
			</form>
		</div>
		<div style="margin-top: 5px">
			<table id="test"></table>
		</div>
	</div>



</body>

<script>
  	var width = $("#continer").width();
		$(function(){
			flag=$('#flag_ins').val();
				$('#test').datagrid({
					title:'机构信息列表',
					iconCls:'icon-save',
					height:600,
					singleSelect:true,
					nowrap: false,
					striped: true,
					url:'agency/queryMerch?flag='+flag,
					remoteSort: false,
					columns:[
					[
						{field:'MEMBER_ID',title:' 机构编号',align:'center',width:120},
						{field:'ENTERPRISE_NAME',title:'机构名称',width:120,align:'center'},
						{field:'LICENCE_NO',title:'营业执照号',width:120,align:'center'},
						{field:'CORPORATION',title:'法人名称',width:120,align:'center'}, 
						{field:'CONTACT',title:'联系人',width:120,align:'center'},
						{field:'STATUS',title:'状态',width:100,align:'center',
							formatter:function(value,rec){
								if(value=="00"){
									return "在用";
								}else if(value=="99"){
									return "机构归档";
								}else if(value=="10"){
									return "注册待初审";
								}else if(value=="11"){
									return "注册初审未过";
								}else if(value=="19"){
									return "机构注册终止";
								}else if(value=="20"){
									return "注册待复审";
								}else if(value=="21"){
									return "注册复审未过";
								}else if(value=="29"){
									return "注册审核终止";
								}else if(value=="30"){
									return "变更待初审";
								}else if(value=="31"){
									return "变更初审未过"; 
								}else if(value=="39"){
									return "变更初审终止"; 
								}else if(value=="40"){
									return "变更待复审";
								}else if(value=="41"){
									return "变更复审未过";
								}else if(value=="49"){
									return "变更复审终止";
								}else if(value=="50"){
									return "注销待初审";
								}else if(value=="51"){
									return "注销初审未过";
								}else if(value=="60"){
									return "注销待复审";
								}else if(value=="61"){
									return "注销复审未过";
								}else if(value=="69"){
									return "注销审核终止";
								}else if(value=="02"){
									return "变更待生效"; 
								}
						   }
					    },	
						{field:'DEPT_ID',title:'操作',width:150,align:'center',
						formatter:function(value,rec){
							if(flag=='10'){
								if(rec.STATUS=='00'){
// 									return '<a href="javascript:toMerchMk('+rec.MEMBER_ID+')" style="color:blue;margin-left:10px">秘钥下载</a>&nbsp<a href="javascript:toMerchDetail('+rec.SELF_ID+')" style="color:blue;margin-left:10px">详情</a>';									       							      
									return '<a href="javascript:toMerchDetail('+rec.SELF_ID+')" style="color:blue;margin-left:10px">详情</a>';									       							      
								}else{
									return '<a href="javascript:toMerchDetail('+rec.SELF_ID+')" style="color:blue;margin-left:10px">详情</a>';
								}
							}else if(flag=='2'){
								return '<a href="javascript:toMerchAudit('+rec.MERCHID+')" style="color:blue;margin-left:10px">审核</a>';
							}else{
								return '<a href="javascript:toMerchAudit('+rec.MERCHID+')" style="color:blue;margin-left:10px">复核</a>';
							}
							
							
						}
					}
					]],
						pagination:true,
						rownumbers:true
				});
			
			var p = $('#test').datagrid('getPager');
			$.extend($.fn.validatebox.defaults.rules, {   
			    minLength: {   
			        validator: function(value, param){ 
						var re =  /^\d+$/; 
		        		if(!re.test(value)){
							return false;
			        	}  
			            return value.length >= param[0];   
			        },   
			        message: '请输入4位数字的部门代码'  
			    }
			   
			});  
		});
		function search(){
			//var url="agency/queryMerch?flag="+$("#flag").val();
			var data={
					'memberId':$('#merchId_ins').val(),
					'memberName':$('#memberName_ins').val(),
					'merchStatus':$('#status_ins').val()
					};
			$('#test').datagrid('load',data);
		}
		function resize(){
			$('#theForm :input').val('');
		}

		function toMerchDetail(id,isApply){
			window.location.href= "<%=basePath%>" +'/agency/toMerchDetail?merchApplyId='+id;
			window.event.returnValue = false;
		}
		function toMerchMk(memberId){
			window.location.href= "<%=basePath%>" +'/agency/loadMerchMk?memberId='+memberId;
	    	window.event.returnValue = false;
            
		}
		function toMerchModify(id){
			window.location.href= "<%=basePath%>" +'agency/toMerchModify?merchApplyId='+id;
			window.event.returnValue = false;
		}
		
		function toActivateStatus(memberId) {
			if(($("#"+memberId).attr("value"))!=0){
				alert("您刚刚已经申请过发送邮件了");
				return ;
			}
		
			$.ajax({
				type : "POST",
				url : "<%=basePath%>" +"/pages/active/replayEmailActiveStatusAction.action?memberId="+memberId,
				data : "",
				dataType : "json",
				success : function(json) {
					var dataArray = eval(json);
					alert(dataArray.messg)
					$("#"+memberId).attr("value",01);

				}
			});
			
			setTimeout("remove("+memberId+")",5000);
		}
		
	function remove(memberId){
		$("#"+memberId).attr("value",120000);
	}
		
	</script>
</html>
