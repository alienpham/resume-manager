<?php
class Vacancy_VacancyController extends Zend_Controller_Action
{

	public function init()
	{
		$view = new Zend_View();
        $view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
        $view->headLink()->appendStylesheet( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
        date_default_timezone_set('Asia/Krasnoyarsk');
	}
	
/**
	 *
	 * To add new a vacancy
	 */
	public function addVacancyAction() {
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		$post = $this->getRequest()->getPost();
		$currentPage = 1;
        $vacancy_id = $this->_getParam('vacancy_id',"");
		$company = new Company_Model_CompanyMapper();
		$listFunctionId = $company->getFieldValue("va_has_function","vacancy_id = '$vacancy_id'","function_id");
		$company_id = $company->getFieldValue("vacancy","vacancy_id='$vacancy_id'","company_id");
		$list_company=$company->getLookup("company","status='Active' AND company_id IN (SELECT company_id FROM com_has_consultant_incharge WHERE consultant_id='".$aNamespace->consultant_id."')","company_id","short_name_en",$company_id);
		$list_consultant=$company->getLookup("consultant","status='Active'","consultant_id","full_name",$aNamespace->consultant_id);
		$this->view->list_company = $list_company;
		$this->view->list_consultant = $list_consultant;
		$this->view->vacancy_id= $vacancy_id;
		if($listFunctionId!=""){
			$this->view->numfunction= count(explode("|",$listFunctionId))." items selected";
		}
		else{
			$this->view->numfunction= "Please select ...";
		}
		
		if($listFunctionId == '')$listFunctionId = "''";
		$listFunctionId=explode("|",$listFunctionId);
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
		$listfunction = $vacancy->getListMultiFunctionLookup("sectionFunction","function_id", "targetFunction", "hdFunction",  implode(',', $listFunctionId));
		$this->view->listfunction=$listfunction;
		$this->view->listFunctionId =  implode(',', $listFunctionId);
		$listFunctionId=$company->getFieldValue("va_has_function","vacancy_id='".$vacancy_id."'","function_id");
		if ($listFunctionId=="")
			$listFunctionId="''";
		$functionName = $company->getFieldValue("function_lookup","function_id IN (".str_replace("|", ",", $listFunctionId).")","name");
		$this->view->funtion = 'Selected: '.$functionName;
		
		$listProvinceId = $company->getFieldValue("va_has_location","vacancy_id ='$vacancy_id'","province_id");
		
		$this->view->listProvinceId = $listProvinceId;
		if($listProvinceId!=""){
			$this->view->numprovince = count(explode("|",$listProvinceId))." items selected";
		}
		else{
			$this->view->numprovince = "Please select ...";
		}
		if($listProvinceId == '') $listProvinceId = "''";
		
		$listProvince=$vacancy->getListMultiProvinceLookup("sectionProvince","province_id", "targetProvince", "hdProvince", implode(',', explode("|",$listProvinceId)));
		
		$this->view->assign('listProvince', 'Selected: '.$listProvince);
		
		$listProvinceId=$company->getFieldValue("va_has_location","vacancy_id='".$vacancy_id."'","province_id");
		if ($listProvinceId=="")
			$listProvinceId="''";
		$provinceName = $company->getFieldValue("province_lookup","province_id in(".str_replace("|", ",", $listProvinceId).")","name");
		$this->view->location= $provinceName;
		
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
			// VaDetails
			$vlcheck= $company->getFieldValue("va_details", "vacancy_id='$vacancy_id'", "va_va_details_id");
			$vadetails = new Vacancy_Model_VaDetailsMapper();
			$rsvadetails = new Vacancy_Model_VaDetails();
			$rsvadetails->setVaVaDetailsId($vlcheck);
			$rsvadetails->setVacancyId($vacancy_id);
			$rsvadetails->setDescReqs($post['desc_reqs']);
			$vadetails->save($rsvadetails);
			//VaHasConsultant
			$vlcheck= $company->getFieldValue("va_has_consultant", "vacancy_id='$vacancy_id'", "va_consultant_id");
			$vahasconsultant = new Vacancy_Model_VaHasConsultantMapper();
			$rsvahasfunction = new Vacancy_Model_VaHasConsultant();
			$rsvahasfunction->setVaConsultantId($vlcheck);
			$rsvahasfunction->setConsultantId($post['consultant_id']);
			$rsvahasfunction->setVacancyId($vacancy_id);
			$rsvahasfunction->setStatus($post['status']=="Open"?"Active":"Inactive");
			$rsvahasfunction->setInchangeType("Main");
			$vahasconsultant->save($rsvahasfunction);
			
			$strFunctionId = $post['hdFunction'];
			if ($strFunctionId!="")
			{
				$tmp= explode(",",$strFunctionId);
				$vahasfunction = new Vacancy_Model_VaHasFunctionMapper();
				for($i=0; $i<count($tmp);$i++)
				{
					$vlcheck= $company->getFieldValue("va_has_function", "vacancy_id='$vacancy_id' AND function_id='".$tmp[$i]."'", "va_function_id");
					$rsvahasfunction = new Vacancy_Model_VaHasFunction();
					$rsvahasfunction->setVaFunctionId($vlcheck);
					$rsvahasfunction->setVacancyId($vacancy_id);
					$rsvahasfunction->setFunctionId($tmp[$i]);
					$vahasfunction->save($rsvahasfunction);
				}
				$vahasfunction->delete("vacancy_id='$vacancy_id' AND function_id NOT IN($strFunctionId)");
			}
			
			$strLocationId = $post['hdProvince'];
			if ($strLocationId!="")
			{
				$tmp= explode(",",$strLocationId);
				$vahaslocation = new Vacancy_Model_VaHasLocationMapper();
				for($i=0; $i<count($tmp);$i++)
				{
					$vlcheck= $company->getFieldValue("va_has_location", "vacancy_id='$vacancy_id' AND province_id='".$tmp[$i]."'", "va_function_id");
					$rsvahaslocation = new Vacancy_Model_VaHasLocation();
					$rsvahaslocation->setVaLocationId($vlcheck);
					$rsvahaslocation->setVacancyId($vacancy_id);
					$rsvahaslocation->setProvinceId($tmp[$i]);
					$vahaslocation->save($rsvahaslocation);
				}
				$vahaslocation->delete("vacancy_id='$vacancy_id' AND province_id NOT IN($strLocationId)");
			}
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
		$listFunctionId = $company->getFieldValue("va_has_function","vacancy_id = '$vacancy_id'","function_id");
		if ($listFunctionId=="")
			$listFunctionId="''";
		else 
			$listFunctionId=str_replace("|", ",", $listFunctionId);
		$functionName = $company->getFieldValue("function_lookup","function_id IN($listFunctionId)","name");
		$listProvinceId=$company->getFieldValue("va_has_location","vacancy_id='".$vacancy_id."'","province_id");
		if ($listProvinceId=="")
			$listProvinceId="''";
		else 
			$listProvinceId=str_replace("|", ",", $listProvinceId);
		$provinceName = $company->getFieldValue("province_lookup","province_id in($listProvinceId)","name");
		$vacancyinfo= $vacancy->getListRecord("vacancy","vacancy_id='$vacancy_id'","vacancy_id",0,1);
		$vacancydes= $vacancy->getListRecord("va_details","vacancy_id='$vacancy_id'","vacancy_id",0,1);
		$companyinfo= $vacancy->getListRecord("com_information","company_id ='".$vacancyinfo[0]['company_id']."'","company_id",0,1);
		$this->view->vacancy_code=$vacancyinfo[0]['vacancy_code'];
		$this->view->job_title=$vacancyinfo[0]['job_title'];
		$this->view->status=$vacancyinfo[0]['status'];
		$this->view->created_date=$vacancyinfo[0]['created_date'];
		$this->view->salary=$vacancy->getSalaryValue($vacancyinfo[0]['min_salary'],$vacancyinfo[0]['max_salary']);
		$this->view->cominfomation=isset($companyinfo[0]['content'])?$companyinfo[0]['content']:"";
		$this->view->job_desc=$vacancydes[0]['desc_reqs'];
		$this->view->province=$provinceName;
		$this->view->function=$functionName;
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