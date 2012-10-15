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
	    if($msg) $message = 'Email or Password incorrect';
	    
	    $this->view->message = $message;
	}
	
	public function loginAction()
	{
	    $request = $this->getRequest();
	    $user = addslashes ( $request->getParam ( 'email' ) );
		$pass = $request->getParam ( 'password' );
	    
	    $userObj = new Default_Model_User();
	    $row = $userObj->checkLogin($user,$pass);
	    
	    if(!$row) $this->_redirect('/user?msg=error');
//print_r($row);exit;
	    $sess = new Zend_Session_Namespace ( 'zs_User' );
	    $sess->consultant_id = $row['consultant_id'];
	    $sess->username = $row['username'];
	    $sess->email = $row['email'];
	    $sess->phone = $row['phone'];
        $sess->islogin = 1;

	    $this->_redirect('/resume');
	}
	
	public function logoutAction()
	{
	    Zend_Session::namespaceUnset ( 'zs_User' );
	    
	    $this->_redirect('/user');
	}
}

