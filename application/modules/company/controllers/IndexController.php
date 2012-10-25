<?php
class Company_IndexController extends Zend_Controller_Action
{
	public function init()
	{
		$view = new Zend_View();
        $view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
        $view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        date_default_timezone_set('Asia/Krasnoyarsk');
	}

	public function indexAction()
	{
		$post = $this->getRequest()->getPost();
		$currentPage = 1;
        $page = $this->_getParam('page',1);
        if(!empty($page)) {
            $currentPage = $page;
        }
		$condition="1";
		if (isset($post['txtSearch']) && trim($post['txtSearch'])!="")
		{
			if ($post['ccode_id']==1)
				$condition = "company_code LIKE '%".$post['txtSearch']."%'";
			else 
			if ($post['ccode_id']==2)
				$condition = "full_name_en LIKE '%".$post['txtSearch']."%' OR short_name_en LIKE '%".$post['txtSearch']."%' OR full_name_vn LIKE '%".$post['txtSearch']."%' OR short_name_vn LIKE '%".$post['txtSearch']."%'";
		}
		
		if (isset($post['industry_id']) && $post['industry_id']!="" && $post['industry_id']!="0")
		{
			$condition .= " AND industry_id = '".$post['industry_id']."'";
		}
		
		$order_by="full_name_en ASC";
		if (isset($post['sort_name_id']))
			$order_by = $post['sort_name_id']." ".$post['sort_type_id'];
		$company = new Company_Model_CompanyMapper();
		$list_industry=$company->getLookup("industry_lookup","parent_industry_id IS NULL","industry_id","abbreviation",isset($post['industry_id'])?$post['industry_id']:"");
		
		$data="";

		$list = $company->getListCompany($condition,$order_by,($currentPage-1)*20,20);
		$rows = $company->getListCompany($condition,$order_by);
		$totalRecord=$company->countCompany($condition,$order_by);
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber($currentPage);
		$totalOpen=0;
		$totalProcess=0;
		foreach($list as $rs)
		{
			$numact=$company->countAct($rs['company_id']);
			$newVa=$company->countNewVacancy($rs['company_id']);
			$openVa=$company->countOpenVacancy($rs['company_id']);
			$numRsSent=$company->countRsProcess($rs['company_id'],1);
			$numInt1=$company->countRsProcess($rs['company_id'],2);
			$numInt2=$company->countRsProcess($rs['company_id'],"3,4,5,6,7");
			$numOffMade=$company->countRsProcess($rs['company_id'],9);
			$numOffAcpt=$company->countRsProcess($rs['company_id'],10);
			$numJoin=$company->countRsProcess($rs['company_id'],11);
			$numProcess=$company->countCanProcess($rs['company_id'],"1,2,3,4,5,6,7,8,9,10");
			$industry_name = $company->getFieldValue("industry_lookup","industry_id='".$rs['industry_id']."'","abbreviation");
			$consultant_id = $company->getFieldValue("com_has_consultant_incharge","company_id='".$rs['company_id']."'","consultant_id");
			$consultant_name = $company->getFieldValue("consultant","consultant_id='$consultant_id'","abbreviated_name");
			$data.='<div class="checkbox">
                <input type="checkbox" name="company_id" id="company_id" value="'.$rs['company_id'].'"  />
            </div>
            <div class="code">
                '.$rs['company_code'].'
            </div>
            <div class="name">
                <h4><a href="#">'.$rs['full_name_en'].'</a></h4>
            </div>
            <div class="ind">
                <b>'.$industry_name.'</b>
            </div>
            <div class="act">
                '.$numact.'
            </div>
            <div class="newva">
                '.$newVa.'
            </div>
            <div class="openva">
                '.$openVa.'
            </div>
            <div class="ressent">
                '.$numRsSent.'
            </div>
            <div class="inter">
                '.($numInt1+$numInt2).'
            </div>
            <div class="offer">
                '.$numOffMade.'
            </div>
            <div class="accept">
                '.$numOffAcpt.'
            </div>
            <div class="joined">
                '.$numJoin.'
            </div>
            <div class="status">
                '.$rs['status'].'
            </div>
            <div class="cons">
                '.$consultant_name.'
            </div>
            <div class="action">
                <a href="company/company/add-company/company_id/'.$rs['company_id'].'" class="editcom">Edit</a> 
            </div><br>';
			$totalOpen+=$openVa;
			$totalProcess+=$numProcess;
		}
		$this->view->totalOpen=$totalOpen;
		$this->view->totalProcess=$totalProcess;
		$this->view->ccode_id=$this->_getParam('ccode_id',"");
		$this->view->sort_name_id=$this->_getParam('sort_name_id',"");
		$this->view->sort_type_id=$this->_getParam('sort_type_id',"");
		$this->view->txtSearch=$this->_getParam('txtSearch',"");
		$this->view->paginator = $paginator;
		$this->view->list_industry=$list_industry;
		$this->view->rows = $list;
		$this->view->baseUrl = $this->getRequest()->getBaseUrl();
		$this->view->data = $data;
	}
}

