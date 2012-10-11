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
			$industry_name = $company->getFieldValue("industry_lookup","industry_id='".$rs['industry_id']."'","abbreviation");
			$consultant_id = $company->getFieldValue("com_has_consultant_incharge","company_id='".$rs['company_id']."'","consultant_id");
			$consultant_name = $company->getFieldValue("consultant","consultant_id='$consultant_id'","abbreviated_name");
			$data .= '<tr>
					  <td class="a-center"><input type="checkbox" name="company_id" id="company_id" value="'.$rs['company_id'].'" /></td>
					  <td class="a-left">'.$rs['company_code'].'</td>
					  <td class="a-left"><a href="#">'.$rs['full_name_en'].'</a></td>
					  <td class="a-left">'.$industry_name.'</td>
					  <td class="a-center color_bg">'.$numact.'</td>
					  <td class="a-center color_bg">'.$newVa.'</td>
					  <td class="a-center color_bg">'.$openVa.'</td>
					  <td class="a-center color_bg">'.$numRsSent.'</td>
					  <td class="a-center color_bg">'.$numInt1.'</td>
					  <td class="a-center color_bg">'.$numInt2.'</td>
					  <td class="a-center color_bg">'.$numOffMade.'</td>
					  <td class="a-center color_bg">'.$numOffAcpt.'</td>
					  <td class="a-center color_bg">'.$numJoin.'</td>
					  <td>'.$rs['status'].'</td>
					  <td>'.$consultant_name.'</td>
					  <td><a href="#"><img src="public/images/icons/user.png" title="Show profile" width="16" height="16" /></a><a href="#"><img src="public/images/icons/user_edit.png" title="Edit user" width="16" height="16" /></a></td>
					</tr>';
		}
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

