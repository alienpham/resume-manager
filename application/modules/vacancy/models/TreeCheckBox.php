<?php
class Vacancy_Model_TreeCheckBox {
	var $htmlstr;
	function treeview($id) //,$imgid,$childid,$txt,$def
	{
		$this->htmlstr= "<div id='$id'>";
	}

	function addNode($id,$level,$def)
	{
		if ($level == 1)
		{
			if ($def == 1){
				
				$this->htmlstr.= "
				<ul id='$id' style='padding:0px;margin:0px 0px 0px 20px;list-style-type:none;display:block'> ";
			
			}else{
				
				$this->htmlstr.= "
				<ul id='$id' style='padding:0px;margin:0px 0px 0px 20px;list-style-type:none;display:none'> ";
			}
		}
		else
		{
			if ($def == 1){
				
				$this->htmlstr.= "
				<div style='width: 33%; float: left'>
				<ul id='$id' style='padding:0px;margin:0px 0px 0px 0px;list-style-type:none;display:block'> ";
			
			}else if ($def == 2){
				
				$this->htmlstr.= "
				<div style='width: 50%; float: left'>
				<ul id='$id' style='padding:0px;margin:0px 0px 0px 0px;list-style-type:none;display:block'> ";
			
			}else{
			
				$this->htmlstr.= "
				<div style='float: left'>
				<ul id='$id' style='padding:0px;margin:0px 0px 0px 0px;list-style-type:none;display:block'> ";
			}
		}

	}
	function addNodeParent($nodeParent, $loop){
		if($loop == 0){
			$this->htmlstr.= "<div><strong>$nodeParent</strong></div>";
		}else{
			$this->htmlstr.= "<div style='padding-top:10px;padding-bottom:5px;'><strong>$nodeParent</strong></div>";	
		}
	}
	function addItem($menuId,$menutxt,$cbName,$txtName,$hdField, $checked='', $functionName ='countCheck')
	{
		$this->htmlstr.= "
		<li style=\"padding: 0px; margin-top:3px; background:url('../images/comboCheckbox/empty.gif');background-repeat:repeat-y\" >";
		$this->htmlstr.= "
		<input name=\"$cbName\" id=\"$cbName\" type=\"checkbox\" value=\"$menuId\" $checked onclick=\"".$functionName."('$cbName','#$txtName','#$hdField');\" >&nbsp;&nbsp;<label for='$cbName'>$menutxt</label>";
		$this->htmlstr.= "</li>";
	}
	function endtree()
	{
		$this->htmlstr.= "</ul>";
	}


	function showTree()
	{
		$this->htmlstr.= "</div>";
		return $this->htmlstr;
	}
}
?>