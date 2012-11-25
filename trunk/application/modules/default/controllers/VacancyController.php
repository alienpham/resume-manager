<?php
class VacancyController extends Zend_Controller_Action
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
        
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );
        $this->view->username = $aNamespace->username;
		$this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
	}
    
	public function indexAction()
	{
	    
	}
	
	public function addVacancyAction()
	{
		$this->view->title = 'ADD VACANCY';
		$vacancy = new Default_Model_VacancyMapper();
		$vacancy_id = $this->_getParam('vacancy_id','');
		
		if($vacancy_id)
		{
			$this->view->title = 'EDIT VACANCY';
		}
		
		$this->view->vacancy = $vacancy;
	}
	
	public function saveVacancyAction()
	{
		 $data = $this->getRequest()->getPost();
		 $vacancy = new Default_Model_Vacancy();
		 $vacancy_id = $this->_getParam('vacancy_id','');
		 
		 $vacancy->setVacancyId($_POST['vacancy_id']);
		 $vacancy->setJobTitle($_POST['job_title']);
		 $vacancy->setMinSalary($_POST['min_salary']);
		 $vacancy->setMaxSalary($_POST['max_salary']);
		 $vacancy->setPriority($_POST['priority']);
		 $vacancy->setWorkLevel($_POST['work_level']);
		 $vacancy->setFunction($_POST['function']);
		 $vacancy->setLocation($_POST['location']);
		 $vacancy->setDescReqs($_POST['desc_reqs']);
		 $vacancy->setCreatedDate(date('Y-m-d'));
		 $vacancy->setUpdatedDate(date('Y-m-d'));
		 
		 $vacancy_md = new Default_Model_VacancyMapper();
		 
		 $vacancy_md->save($vacancy);
		 
		 $this->_redirect('/vacancy');
	}
}