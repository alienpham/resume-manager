<?php

class Vacancy_IndexController extends Zend_Controller_Action
{

	public function init()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );

		/* Initialize action controller here */
		$view = new Zend_View();
		$view->headScript()->appendFile ( '/js/jquery-1.8.0.min.js' );
		$view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
		$view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
		$view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
		$this->view->username = $aNamespace->username;
		$this->view->full_name = $aNamespace->full_name;
		$this->view->isAdmin = $aNamespace->isAdmin;
		date_default_timezone_set('Asia/Ho_Chi_Minh');
	}

	/**
	 *
	 * Default controller action
	 * Show vacancy listing
	 */
	public function indexAction()
	{
		// To do
	}

	/**
	 *
	 * To add new a vacancy
	 */
	public function addVacancyAction() {
		$consultantMapper = New Vacancy_Model_ConsultantMapper();
		$colsultants = $consultantMapper->getColsultants();
		$this->view->consultants = $colsultants;

		$companyMapper = New Vacancy_Model_CompanyMapper();
		$companies = $companyMapper->getCompanies();
		$this->view->companies = $companies;

		$displaySalaryConfig = $companyMapper->getDisplaySalaries();
		$this->view->displaySalaryConfig = $displaySalaryConfig;
	}
}

