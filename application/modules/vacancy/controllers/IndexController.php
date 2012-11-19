<?php

class Vacancy_IndexController extends Zend_Controller_Action
{

	public function init()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );
		
        /* Initialize action controller here */
        $view = new Zend_View();
        #$view->headScript()->appendFile ( '/js/jquery-1.8.0.min.js' );
        $view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
		$this->view->username = $aNamespace->username;
		date_default_timezone_set('Asia/Krasnoyarsk');
	}

	/**
	 *
	 * Default controller action
	 * Show vacancy listing
	 */
	public function indexAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		$post = $this->getRequest()->getPost();
		$currentPage = 1;
        $page = $this->_getParam('page',1);
        if(!empty($page)) {
            $currentPage = $page;
        }
		//$condition="company_id IN (SELECT company_id FROM com_has_consultant_incharge WHERE consultant_id='".$aNamespace->consultant_id."')";
		$condition="";
		if (isset($post['txtSearch']) && trim($post['txtSearch'])!="")
		{
			if ($post['ccode_id']==1)
				$condition = "vacancy_code LIKE '%".$post['txtSearch']."%'";
			else 
			if ($post['ccode_id']==2)
				$condition = "job_title LIKE '%".$post['txtSearch']."%'";
		}
		
		if (isset($post['status']) && $post['status']!="" && $post['status']!="0")
		{
			$condition .= " status = '".$post['status']."'";
		}
		$order_by=" company_id ASC, updated_date DESC";
		$vacancy = new Vacancy_Model_VacancyMapper();
		$rows = $vacancy->getListVacancy ($condition, $order_by);
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber($currentPage);
		
		$this->view->order_by = $order_by;
		$this->view->condition = $condition;
		$this->view->currentPage = $currentPage;
		$this->view->paginator = $paginator;
	}

	
	
}

