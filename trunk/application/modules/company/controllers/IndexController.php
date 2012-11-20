<?php
class Company_IndexController extends Zend_Controller_Action
{
	public function init()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );

        /* Initialize action controller here */
        $view = new Zend_View();
        //$view->headScript()->appendFile ( '/js/jquery-1.8.0.min.js' );
        $view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
		$this->view->username = $aNamespace->username;
		$this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
		date_default_timezone_set('Asia/Ho_Chi_Minh');
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
//		if (isset($post['txtSearch']) && trim($post['txtSearch'])!="")
//		{
//			if ($post['ccode_id']==1)
//				$condition = "company_code LIKE '%".$post['txtSearch']."%'";
//			else
//			if ($post['ccode_id']==2)
//				$condition = "full_name_en LIKE '%".$post['txtSearch']."%' OR short_name_en LIKE '%".$post['txtSearch']."%' OR full_name_vn LIKE '%".$post['txtSearch']."%' OR short_name_vn LIKE '%".$post['txtSearch']."%'";
//		}

		if (isset($post['industry_id']) && $post['industry_id']!="" && $post['industry_id']!="0")
		{
			$condition .= " AND industry_id = '".$post['industry_id']."'";
		}

		$order_by="full_name_en ASC";
		if (isset($post['sort_name_id']))
			$order_by = $post['sort_name_id']." ".$post['sort_type_id'];
		$company = new Company_Model_CompanyMapper();
		
		$rows = $company->getListCompany($condition,$order_by);
		$totalRecord=$company->countCompany($condition,$order_by);
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber($currentPage);
		
		$this->view->ccode_id=$this->_getParam('ccode_id',"");
		$this->view->short_name_id=$this->_getParam('short_name_id',"");
		$this->view->short_type_id=$this->_getParam('short_type_id',"");
		$this->view->txtSearch=$this->_getParam('txtSearch',"");
		$this->view->paginator = $paginator;
	}
}

