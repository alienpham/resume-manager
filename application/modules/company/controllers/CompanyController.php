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
		$list_industry=$company->getLookup("industry_lookup","parent_industry_id IS NULL","industry_id","abbreviation");
		$list_busines_type=$company->getLookup("busines_type_lookup","1","busines_type_id","name");
		$list_consultant=$company->getLookup("consultant","status='Active'","consultant_id","full_name");
		/*if (isset($post['save']))
		{
			if (isset($post['company_id']) && $post['company_id']=="")
			{
				
				$rs=$company->getListCompany("1", "company_id DESC", 0, 1);
				$rscompany= new Company_Model_Company();
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
				$company->save ($rscompany);
				echo $company->getCompanyId();
			}
		}*/
		$this->view->baseUrl = $this->getRequest()->getBaseUrl();
		$this->view->company_id = $company_id;
		$this->view->list_industry = $list_industry;
		$this->view->list_busines_type = $list_busines_type;
		$this->view->list_consultant = $list_consultant;
	}
}