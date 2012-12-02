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
		$consultantClass = new Default_Model_User();
		$rows = $consultantClass->fetchAll('status <> "Deleted"');
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
		$id = $this-> _getParam('id',"");
		$user = new Default_Model_User();

		if($id != ''){
		    $result = $user->editUser($data, $id);
		    $this->_redirect('/profile');
		} else {
		    if($user->checkExists($data['username'], $data['email'])) {
    			$this->view->msg = 'Username has exists';
    			$data['consultant_id'] = $data['id'];
    			$this->view->userInfo = $data;
    			$this->render('add-user');
		    } else {
		        $result = $user->saveUser($data);
		        $this->_redirect('/profile');
		    }
		}
	}
	
	public function deleteUserAction()
	{
	    $id = $this-> _getParam('id',"");
	    $userObj = new Default_Model_User();
	    $userObj->updateStatusUser('Deleted', $id);
	    
	    $this->_redirect('/profile');	
	}
	
    public function inactiveUserAction()
	{
	    $id = $this-> _getParam('id',"");
	    $userObj = new Default_Model_User();
	    $userObj->updateStatusUser('Inactive', $id);
	    
	    $this->_redirect('/profile');	
	}
	
    public function activeUserAction()
	{
	    $id = $this-> _getParam('id',"");
	    $userObj = new Default_Model_User();
	    $userObj->updateStatusUser('Active', $id);
	    
	    $this->_redirect('/profile');	
	}
}