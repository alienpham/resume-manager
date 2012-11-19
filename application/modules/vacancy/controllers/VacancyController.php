<?php
class Vacancy_VacancyController extends Zend_Controller_Action
{

	public function init()
	{
		$view = new Zend_View();
        //$view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
        $view->headLink()->appendStylesheet( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
        date_default_timezone_set('Asia/Ho_Chi_Minh');
	}
	
/**
	 *
	 * To add new a vacancy
	 */
	public function addVacancyAction() 
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		$post = $this->getRequest()->getPost();
		$currentPage = 1;
        $vacancy_id = $this->_getParam('vacancy_id',"");
		$company = new Company_Model_CompanyMapper();
		


		$this->view->vacancy_id= $vacancy_id;
		
		
		$vacancy = new Vacancy_Model_VacancyMapper();
		if ($vacancy_id!="")
		{
			$vacancyinfo= $vacancy->getListRecord("vacancy","vacancy_id='$vacancy_id'","vacancy_id",0,1);
			$vacancydes= $vacancy->getListRecord("va_details","vacancy_id='$vacancy_id'","vacancy_id",0,1);
			$this->view->job_title=$vacancyinfo[0]['job_title'];
			$this->view->no_of_vacancies=$vacancyinfo[0]['no_of_vacancies'];
			$this->view->min_salary=$vacancyinfo[0]['min_salary'];
			$this->view->max_salary=$vacancyinfo[0]['max_salary'];
			$this->view->estimated_salary=$vacancyinfo[0]['estimated_salary'];
			$this->view->p=$vacancyinfo[0]['public'];
			$this->view->status=$vacancyinfo[0]['status'];
			$this->view->desc_reqs=isset($vacancydes[0]['desc_reqs'])?$vacancydes[0]['desc_reqs']:"";
		}
		
		
		$listWorkLevel = $company->getLookup("work_level_lookup","1","work_level_id","name",isset($vacancyinfo[0]['work_level_id'])?$vacancyinfo[0]['work_level_id']:"");
		$this->view->listWorkLevel= $listWorkLevel;
		if (isset($post['btSave']) || isset($post['btAdd']))
		{
			$rs=$vacancy->getListRecord("vacancy","1","vacancy_id DESC",0,1);
			$rsVacancy = new Vacancy_Model_Vacancy();
			$rsVacancy->setCompanyId($post['company_id']);
			$rsVacancy->setVacancyId($vacancy_id);
			$rsVacancy->setVacancyCode("V".(isset($rs[0]['vacancy_id'])?($rs[0]['vacancy_id']+1):"1"));
			$rsVacancy->setJobTitle($post['job_title']);
			$rsVacancy->setNoOfVacancies($post['no_of_vacancies']);
			$rsVacancy->setMinSalary($post['min_salary']);
			$rsVacancy->setMaxSalary($post['max_salary']);
			$rsVacancy->setEstimatedSalary($post['estimated_salary']);
			$rsVacancy->setWorkLevelId($post['work_level_id']);
			$rsVacancy->setPublic($post['p']);
			$rsVacancy->setStatus($post['status']);
			$rsVacancy->setCreatedDate(date('Y-m-d H:i:s'));
			$rsVacancy->setUpdatedDate(date('Y-m-d H:i:s'));
			$vacancy_id=$vacancy->save ($rsVacancy);
			


			if (isset($post['btSave']))
				$this->_redirect('/vacancy');
			else 
			if (isset($post['btAdd']))
				$this->_redirect('/vacancy/vacancy/add-vacancy');
		}
	}
	
	public function viewVacancyAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		$post = $this->getRequest()->getPost();
		$vacancy_id= $this->_getParam('vacancy_id',"");
		$company = new Company_Model_CompanyMapper();
		$vacancy = new Vacancy_Model_VacancyMapper();
		
		$vacancyinfo= $vacancy->getListRecord("vacancy","vacancy_id='$vacancy_id'","vacancy_id",0,1);
		//$vacancydes= $vacancy->getListRecord("va_details","vacancy_id='$vacancy_id'","vacancy_id",0,1);
		//$companyinfo= $vacancy->getListRecord("com_information","company_id ='".$vacancyinfo[0]['company_id']."'","company_id",0,1);
		//$this->view->vacancy_code=$vacancyinfo[0]['vacancy_code'];
		$this->view->job_title=$vacancyinfo[0]['job_title'];
		$this->view->status=$vacancyinfo[0]['status'];
		$this->view->created_date=$vacancyinfo[0]['created_date'];
		$this->view->salary=$vacancy->getSalaryValue($vacancyinfo[0]['min_salary'],$vacancyinfo[0]['max_salary']);
		//$this->view->cominfomation=isset($companyinfo[0]['content'])?$companyinfo[0]['content']:"";
		//$this->view->job_desc=$vacancydes[0]['desc_reqs'];

	}
	
	public function closeVacancyAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		$post = $this->getRequest()->getPost();
		$listVacancy = $post['listvacancyid'];
		$vacancy = new Vacancy_Model_VacancyMapper();
		$vacancy->updateStatus($listVacancy,"Close");
	}
}