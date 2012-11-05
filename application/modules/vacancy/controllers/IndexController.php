<?php

class Vacancy_IndexController extends Zend_Controller_Action
{

	public function init()
	{
		/* Initialize action controller here */
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

