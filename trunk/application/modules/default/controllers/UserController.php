<?php

class UserController extends Zend_Controller_Action
{

	public function init()
	{
		/* Initialize action controller here */
	}

	public function indexAction()
	{
	    $this->_helper->layout->disableLayout ();
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if ( isset ( $aNamespace->islogin )) $this->_redirect ('/resume');
	}
	
	public function loginAction()
	{
	    $request = $this->getRequest();
	    $user = addslashes ( $request->getParam ( 'username' ) );
		$pass = md5 ( $request->getParam ( 'password' ) );
	    $sess = new Zend_Session_Namespace ( 'zs_User' );
	    
	    $sess->username = $user;
        $sess->islogin = 1;
        
	    $this->_redirect('/resume');
	}
	
	public function logoutAction()
	{
	    Zend_Session::namespaceUnset ( 'zs_User' );
	    
	    $this->_redirect('/user');
	}
}

