<?php
class CompanyController extends Zend_Controller_Action
{

	public function init()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );

		/* Initialize action controller here */
		$view = new Zend_View();
		$view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
		$view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
		$view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
		$this->view->username = $aNamespace->username;
		$this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
		date_default_timezone_set('Asia/Ho_Chi_Minh');
	}

	public function checkLoginAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) echo 0;
		echo 1;
		exit;
	}
	public function indexAction()
	{
		$view = new Zend_View();
		$view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
		$view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
		$view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' ); 
		
		$company = new Default_Model_CompanyMapper();
		$rowPerPage = $this->_getParam('rowperpage', 20);
		$currentPage = 1;
		$rows = $company->getListCompany();	
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage($rowPerPage);
		$paginator->setCurrentPageNumber($currentPage);

		$this->view->paginator = $paginator;
	}	
	
	public function addCompanyAction()
	{
	    $this->view->title = 'ADD COMPANY';
		$company_id = $this->_getParam('company_id','');
		$company = new Default_Model_Company();
		
		if($company_id) {
		    $this->view->title = 'EDIT COMPANY';
		    $companyMapper = new Default_Model_CompanyMapper();
		    $companyMapper->find($company_id, $company);		    
		}
		
		$this->view->company = $company;
		
	}
	
	public function saveCompanyAction()
	{
	    $post = $this->getRequest()->getPost();
//print_r($post);exit;
	    $company = new Default_Model_Company();
	    $company->setCompanyId($post['company_id']);
		$company->setFullNameEn($post['full_name_en']);
		$company->setShortNameEn($post['short_name_en']);
		$company->setFullNameVn($post['full_name_vn']);
		$company->setShortNameVn($post['short_name_vn']);
		$company->setBusinesType($post['busines_type']);
		$company->setTel($post['tel']);
		$company->setFax($post['fax']);
		$company->setEmail($post['email']);
		$company->setAddress($post['address']);
		$company->setWebsite($post['website']);
		$company->setInformation($post['information']);
		$company->setCreatedDate(date('Y-m-d'));
		$company->setUpdatedDate(date('Y-m-d'));
		
		$companyMapper = new Default_Model_CompanyMapper();
	    $row = $companyMapper->save($company);
	    
	    $this->_redirect('/company');
	}
	
	public function viewCompanyAction()
	{
		$this->_helper->layout->disableLayout();
		$company = new Default_Model_CompanyMapper();
		$company_id = $this->_getParam('company_id','');
		$row = $company->getCompany($company_id);
		$this->view->cominfo = $row[0];
		
	
	}
	
	public function addContactAction()
	{	
		$this->view->title = 'ADD CONTACT';
		$company = new Default_Model_CompanyMapper();
		$company_id = $this->_getParam('company_id','');
		$contact_id = $this->_getParam('contact_person_id','');
		 
		if($contact_id)
		{
			$this->view->title = 'EDIT CONTACT';
			$contact = new Default_Model_ContactPersonMapper();
			$row = $contact->getContact($contact_id);
			$this->view->contactinfo = $row[0];
		}
		 
		$cominfo = $company->getCompany($company_id);
		 
		$this->view->cominfo = $cominfo[0];
		 
	}
	
	public function saveContactAction()
	{
		 $post = $this->getRequest()->getPost();
		 $contact = new Default_Model_ContactPerson();
		 
		 $contact->setContactPersonId($_POST['contact_person_id']);
		 $contact->setCompanyId($_POST['company_id']);
		 $contact->setTitle($_POST['title']);
		 $contact->setFullName($_POST['full_name']);
		 $contact->setJobTitle($_POST['job_title']);
		 $contact->setTel($_POST['tel']);
		 $contact->setMobile($_POST['mobile']);
		 $contact->setEmail($_POST['email']);
		 $contact->setAddress($_POST['address']);
		 
		 $addContact = new Default_Model_ContactPersonMapper();
		 $row = $addContact->save($contact);

		 $this->_redirect('/company/index');
	}
}
