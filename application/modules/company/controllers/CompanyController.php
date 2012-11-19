<?php
class Company_CompanyController extends Zend_Controller_Action
{

	public function init()
	{
		$view = new Zend_View();
        //$view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
        $view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
        
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
        $this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
        date_default_timezone_set('Asia/Ho_Chi_Minh');
	}

	public function addCompanyAction()
	{
		$post = $this->getRequest()->getPost();
		$company_id = $this->_getParam('company_id',"");
		$company = new Company_Model_CompanyMapper();
		$industry_id="";
		$busines_type_id="";
		$consultant_id="";
		if ($company_id!="")
		{
			$cominfo=$company->getListCompany("company_id = '$company_id'", "company_id DESC", 0, 1);
			$this->view->title_page = "EDIT COMPANY";
			$this->view->full_name_en = $cominfo[0]['full_name_en'];
			$this->view->full_name_vn = $cominfo[0]['full_name_vn'];
			$this->view->short_name_en = $cominfo[0]['short_name_en'];
			$this->view->short_name_vn = $cominfo[0]['short_name_vn'];
			$this->view->tel = $cominfo[0]['tel'];
			$this->view->fax = $cominfo[0]['fax'];
			$this->view->email = $cominfo[0]['email'];
			$this->view->address = $cominfo[0]['address'];
			$this->view->website = $cominfo[0]['website'];
			$industry=$cominfo[0]['industry'];
			$busines_type=$cominfo[0]['busines_type'];
			//$consultant_id=$company->getFieldValue ("com_has_consultant_incharge", "company_id = '$company_id'", "consultant_id");
		}
		else $this->view->title_page = "ADD COMPANY";
		
		//$list_industry=$company->getLookup("industry_lookup","parent_industry_id IS NULL","industry_id","name",$industry);
		//$list_busines_type=$company->getLookup("busines_type_lookup","1","busines_type_id","name",$busines_type);
		$list_consultant=$company->getLookup("consultant","status='Active'","consultant_id","full_name",$consultant_id);
		
		if (isset($post['save']))
		{
			if (isset($post['company_id']))
			{
				$rscompany= new Company_Model_Company();
				$rscompany->setCompanyId($post['company_id']);
				$rscompany->setFullNameEn($post['full_name_en']);
				$rscompany->setShortNameEn($post['short_name_en']);
				$rscompany->setFullNameVn($post['full_name_vn']);
				$rscompany->setShortNameVn($post['short_name_vn']);
				$rscompany->setBusinesTypeId($post['busines_type']);
				$rscompany->setIndustryId($post['industry']);
				$rscompany->setTel($post['tel']);
				$rscompany->setFax($post['fax']);
				$rscompany->setEmail($post['email']);
				$rscompany->setAddress($post['address']);
				$rscompany->setWebsite($post['website']);
				$rscompany->setStatus("Active");
				$rscompany->setCreatedDate(date('Y-m-d H:i:s'));
				$rscompany->setUpdatedDate(date('Y-m-d H:i:s'));
				$ComapnyId=$company->save ($rscompany);

				$this->_redirect('/company');
			}

		}
		$this->view->company_id = $company_id;
		//$this->view->list_industry = $list_industry;
		//$this->view->list_busines_type = $list_busines_type;
		$this->view->list_consultant = $list_consultant;
	}

	public function addContactAction()
	{
		$post = $this->getRequest()->getPost();
		$company_id = $this->_getParam('company_id',"");
		$contact_person_id = $this->_getParam('contact_person_id');

		$company = new Company_Model_CompanyMapper();
		$cominfo=$company->getListCompany("company_id = '$company_id'", "company_id DESC", 0, 1);
		$contact= new Company_Model_ContactPersonMapper();
		$contactinfo =$contact->getListContact("contact_person_id = '$contact_person_id'", "contact_person_id DESC", 0, 1);
		if (isset($post['btAddmore']) || isset($post['btSave']))
		{
			$rscontact = new Company_Model_ContactPerson();
			$rscontact->setContactPersonId($contact_person_id);
			$rscontact->setCompanyId($company_id);
			$rscontact->setTitle($post['title']);
			$rscontact->setFullName($post['full_name']);
			$rscontact->setJobTitle($post['job_title']);
			$rscontact->setTel($post['tel']);
			$rscontact->setFax($post['fax']);
			$rscontact->setMobile($post['mobile']);
			$rscontact->setEmail($post['email']);
			$rscontact->setAddress($post['address']);
			$contactid=$contact->save ($rscontact);
			if (isset($post['btAddmore']))
				$this->_redirect('/company/company/add-contact/company_id/'.$company_id);
			else
				$this->_redirect('/company');
		}
		if ($contact_person_id=="")
			$this->view->title_page = "ADD CONTACT PERSON";
		else
			$this->view->title_page = "EDIT CONTACT PERSON";

		$this->view->company_id = $company_id;
		$this->view->contact_person_id = $contact_person_id;

		$this->view->company_name = $cominfo[0]['full_name_en']==""?$cominfo[0]['short_name_en']:$cominfo[0]['full_name_en'];
		$this->view->contactinfo = @$contactinfo[0];
	}

	public function viewCompanyAction()
	{
	    $this->_helper->layout->disableLayout();
	    
		$post = $this->getRequest()->getPost();
		$company_id = $this->_getParam('company_id',"");
		$company = new Company_Model_CompanyMapper();

		$cominfo = $company->getListCompany("company_id = '$company_id'", "company_id DESC", 0, 1);
		$this->view->company_id = $company_id;
		//$this->view->company_code = $cominfo[0]['company_code'];
		$this->view->company_name = $cominfo[0]['full_name_en']==""?$cominfo[0]['short_name_en']:$cominfo[0]['full_name_en'];
		$this->view->company_address = $cominfo[0]['address'];
		
		$this->render('view-company');
	}
}