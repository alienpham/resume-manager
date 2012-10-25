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
        date_default_timezone_set('Asia/Krasnoyarsk');
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
		$this->view->baseUrl = $this->getRequest()->getBaseUrl();
		$this->view->company_id = $company_id;
		$this->view->list_industry = $list_industry;
		$this->view->list_busines_type = $list_busines_type;
		$this->view->list_consultant = $list_consultant;
	}
}