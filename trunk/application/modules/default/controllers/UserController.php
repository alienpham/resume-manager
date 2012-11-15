<?php

class UserController extends Zend_Controller_Action
{

	public function init()
	{
		/* Initialize action controller here */
	}

	public function indexAction()
	{
		$view = new Zend_View();
		$view->headLink()->appendStylesheet ( '/css/stylesheet.css' );

		$this->_helper->layout->disableLayout ();
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if ( isset ( $aNamespace->islogin )) $this->_redirect ('/resume');

		$request = $this->getRequest();
		$msg = addslashes ( $request->getParam ( 'msg' ) );
		$message = '';
		if($msg) $message = 'Username or Password incorrect!';

		$this->view->message = $message;
	}

	public function loginAction()
	{
		$request = $this->getRequest();
		$user = addslashes ( $request->getParam ( 'username' ) );
		$pass = $request->getParam ( 'password' );

		$userObj = new Default_Model_User();
		$row = $userObj->checkLogin($user, $pass);

		if(!$row) $this->_redirect('/user?msg=Username or Password incorrect!');

		$sess = new Zend_Session_Namespace ( 'zs_User' );
		$sess->consultant_id = $row['consultant_id'];
		$sess->username = $row['username'];
		$sess->email = $row['email'];
		$sess->phone = $row['phone'];
		$sess->isAdmin = $row['is_admin'];
		$sess->islogin = 1;
		$full_name = $row['title'] . ' ' . $row['full_name'];
		$sess->fullname = $full_name ? $full_name : $row['username'];


		$this->_redirect('/resume');
	}

	public function logoutAction()
	{
		Zend_Session::namespaceUnset ( 'zs_User' );

		$this->_redirect('/user');
	}
	
 	public function viewProfileAction()
    {
		$id = $this-> _getParam('id',"");
    	$user = new Default_Model_User();
    	    	
    	if($id != '')
    	{
    		$userInfo = $user->getUser($id);
    		$this->view->page_title = "USER INFO";
			$this->view->userInfo = $userInfo;	
    	}
    	
    }
    
    public function checkPasswordAction()
    {
    	//$data = $this->getRequest()->getPost();
    	$user = new Default_Model_User();
    	$pass = $this-> _getParam('password',"");
    	$id = $this-> _getParam('id',"");
    	$check = $user->getUser($id);
    	
    	if($check['password'] == md5($pass))
    	{
    		echo 1;
    	} else{
    		echo 0;
    	}
    	exit;
    }
    
    
    public function addPasswordAction()
    {
    	$data = $this->getRequest()->getPost();
    	$user = new Default_Model_User();
    	$id = $this-> _getParam('id',"");
    	$check = $user->getUser($id);
    	
    	if($check['password'] == md5($data['password']))
    	{
    	$user->changePassword($data['password1'], $id);
    	}
    	$this->_redirect('/resume');
    }
}

