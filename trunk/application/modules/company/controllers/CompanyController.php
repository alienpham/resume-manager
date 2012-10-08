<?php
class Company_CompanyController extends Zend_Controller_Action
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

	public function addCompanyAction()
	{
		$post = $this->getRequest()->getPost();
		if (isset($post['save']))
		{
			
		}
	}
}