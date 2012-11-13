<?php
class ProfileController extends Zend_Controller_Action {
	/**
	 * (non-PHPdoc)
	 * @see library/Zend/Controller/Zend_Controller_Action::init()
	 */
	public function init() {
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );

		/* Initialize action controller here */
		$view = new Zend_View();
		//$view->headLink()->appendStylesheet ( '/css/stylesheet.css' );
		//$view->headScript()->appendFile ( '/js/jquery-1.8.0.min.js' );
		$view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
		$view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
		$view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
		$this->view->username = $aNamespace->username;
		$this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
		date_default_timezone_set('Asia/Ho_Chi_Minh');
	}

	public function indexAction() 
	{
		$consultantClass = new Vacancy_Model_ConsultantMapper();
		$db = $consultantClass->getDbTable();

		$select = $db->select()->from('consultant');
		$rows = $db->fetchAll($select);

		$this->view->rows = $rows;
	}
	
	public function addUserAction()
	{
		$data = $this->getRequest()->getPost();
		$id = $this-> _getParam('id',"");
		$user = new Default_Model_User();
	
		if($id !="")
		{
			$userInfo = $user->getUser($id);
			$this->view->page_title = "EDIT USER";
			$this->view->userInfo = $userInfo;
		}
		else
		{
			$this->view->page_title = "ADD USER";
		}
	}
	
	public function saveUserAction() 
	{
		$data = $this->getRequest()->getPost();

		
		$user = new Default_Model_User();
		$user->saveUser($data);
		
		$this->_redirect('/profile');		
	}
}