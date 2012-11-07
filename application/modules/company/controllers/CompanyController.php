<?php
class Company_CompanyController extends Zend_Controller_Action
{

	public function init()
	{
		$view = new Zend_View();
        $view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
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
			$industry_id=$cominfo[0]['industry_id'];
			$busines_type_id=$cominfo[0]['busines_type_id'];
			$consultant_id=$company->getFieldValue ("com_has_consultant_incharge", "company_id = '$company_id'", "consultant_id");
		}
		else
			$this->view->title_page = "ADD COMPANY";
		$list_industry=$company->getLookup("industry_lookup","parent_industry_id IS NULL","industry_id","name",$industry_id);
		$list_busines_type=$company->getLookup("busines_type_lookup","1","busines_type_id","name",$busines_type_id);
		$list_consultant=$company->getLookup("consultant","status='Active'","consultant_id","full_name",$consultant_id);
		if (isset($post['save']))
		{
			if (isset($post['company_id']))
			{
				$rs=$company->getListCompany("1", "company_id DESC", 0, 1);
				$rscompany= new Company_Model_Company();
				$rscompany->setCompanyId($post['company_id']);
				$rscompany->setCompanyCode("C".($rs[0]['company_id']+1));
				$rscompany->setFullNameEn($post['full_name_en']);
				$rscompany->setShortNameEn($post['short_name_en']);
				$rscompany->setFullNameVn($post['full_name_vn']);
				$rscompany->setShortNameVn($post['short_name_vn']);
				$rscompany->setBusinesTypeId($post['busines_type_id']);
				$rscompany->setIndustryId($post['industry_id']);
				$rscompany->setTel($post['tel']);
				$rscompany->setFax($post['fax']);
				$rscompany->setEmail($post['email']);
				$rscompany->setAddress($post['address']);
				$rscompany->setWebsite($post['website']);
				$rscompany->setStatus("Active");
				$rscompany->setCreatedDate(date('Y-m-d H:i:s'));
				$rscompany->setUpdatedDate(date('Y-m-d H:i:s'));
				$ComapnyId=$company->save ($rscompany);

				$consultantincharge= new Company_Model_ComHasConsultantIncharge();
				$consultantincharge->setConsultantId($post['consultant_id']);
				$consultantincharge->setCompanyId($ComapnyId);
				$consultantincharge->setStatus("Active");
				$consultantincharge->setActionDate(date('Y-m-d H:i:s'));
				$conincharge = new Company_Model_ComHasConsultantInchargeMapper();

				if ($post['company_id']=="")
				{
					$conincharge->save($consultantincharge);
				}
				else
				{
					$consultant_id=$company->getFieldValue ("com_has_consultant_incharge", "company_id = '$ComapnyId'", "com_consultant_incharge_id");
					if ($consultant_id=="" && $post['consultant_id']!="")
						$conincharge->save($consultantincharge);
					else
						$conincharge->updateComIncharge($post['consultant_id'], $ComapnyId);
				}
				$rscominfomation= new Company_Model_ComInformation();
				$rscominfomation->setCompanyId($ComapnyId);
				$rscominfomation->setApplyTo("Internal");
				$rscominfomation->setCompanyId($ComapnyId);
				$rscominfomation->setContent($post['contents']);
				$cominfomation = new Company_Model_ComInformationMapper();
				if ($post['company_id']=="")
				{
					$cominfomation->save($rscominfomation);
				}
				else
				{
					$com_information_id=$company->getFieldValue ("com_information", "company_id = '$ComapnyId'", "com_information_id");
					if ($com_information_id=="" && $post['contents']!="")
						$cominfomation->save($rscominfomation);
					else
						$cominfomation->updateComInformation($ComapnyId,$post['contents']);
				}

				$this->_redirect('/company');
			}

		}
		$this->view->company_id = $company_id;
		$this->view->list_industry = $list_industry;
		$this->view->list_busines_type = $list_busines_type;
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
			$rscontact->setTel1($post['tel_1']);
			$rscontact->setTel2($post['tel_2']);
			$rscontact->setFax($post['fax']);
			$rscontact->setMobile1($post['mobile_1']);
			$rscontact->setMobile2($post['mobile_2']);
			$rscontact->setEmail1($post['email_1']);
			$rscontact->setEmail2($post['email_2']);
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
		$this->view->title = isset($contactinfo[0]['title'])?$contactinfo[0]['title']:"";
		$this->view->full_name = isset($contactinfo[0]['full_name'])?$contactinfo[0]['full_name']:"";
		$this->view->job_title = isset($contactinfo[0]['job_title'])?$contactinfo[0]['job_title']:"";
		$this->view->tel_1 = isset($contactinfo[0]['tel_1'])?$contactinfo[0]['tel_1']:"";
		$this->view->tel_2 = isset($contactinfo[0]['tel_2'])?$contactinfo[0]['tel_2']:"";
		$this->view->fax = isset($contactinfo[0]['fax'])?$contactinfo[0]['fax']:"";
		$this->view->mobile_1 = isset($contactinfo[0]['mobile_1'])?$contactinfo[0]['mobile_1']:"";
		$this->view->mobile_2 = isset($contactinfo[0]['mobile_2'])?$contactinfo[0]['mobile_2']:"";
		$this->view->email_1 = isset($contactinfo[0]['email_1'])?$contactinfo[0]['email_1']:"";
		$this->view->email_2 = isset($contactinfo[0]['email_2'])?$contactinfo[0]['email_2']:"";
	}

	public function viewCompanyAction()
	{
		$post = $this->getRequest()->getPost();
		$company_id = $this->_getParam('company_id',"");
		$company = new Company_Model_CompanyMapper();

		$cominfo=$company->getListCompany("company_id = '$company_id'", "company_id DESC", 0, 1);
		$this->view->company_id = $company_id;
		$this->view->company_code = $cominfo[0]['company_code'];
		$this->view->company_name = $cominfo[0]['full_name_en']==""?$cominfo[0]['short_name_en']:$cominfo[0]['full_name_en'];
	}
}