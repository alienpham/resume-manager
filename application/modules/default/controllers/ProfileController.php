<?php
/**
 *
 * Class User Profile
 * @author LONG
 *
 */
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
		$view->headScript()->appendFile ( '/js/jquery-1.8.0.min.js' );
		$view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
		$view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
		$view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
		$this->view->username = $aNamespace->username;
		date_default_timezone_set('Asia/Saigon');
	}

	public function indexAction() {
		$consultantClass = new Vacancy_Model_ConsultantMapper();
		$db = $consultantClass->getDbTable();
	}
}