<?php
class CompanyController extends Zend_Controller_Action
{

	public function init()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );

		/* Initialize action controller here */
		$view = new Zend_View();
		$view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
		$view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
		$view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
		$this->view->username = $aNamespace->username;
		$this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
		date_default_timezone_set('Asia/Ho_Chi_Minh');
	}

	public function checkLoginAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) echo 0;
		echo 1;
		exit;
	}
	public function indexAction()
	{
		
	}	
}

