<?php
class ResumeController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
        $view = new Zend_View();
        $view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
        $view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
    }

    public function indexAction()
    {
        $resume = new Default_Model_ResumeMapper();

        $currentPage = 1;
        $page = $this->_getParam('page',1);
        if(!empty($i)) {
            $currentPage = $page;
        }
        
        $where = '';
        $choice = $this->_getParam('choice', 'name');
        $search = $this->_getParam('search', '');
        if($choice == 'name') $where = 'full_name like "%' . $search . '%"';
        
        //http://zendgeek.blogspot.com
        $rows = $resume->getListResume($where);
        $paginator = Zend_Paginator::factory($rows);
        $paginator->setItemCountPerPage(10);
        $paginator->setCurrentPageNumber($currentPage);
    
        $this->view->paginator = $paginator;
        $this->view->rows = $rows;
    }
    
	
	public function personalInfoAction()
    {
		//$this->_redirect('resume/experience');
    }
	
	public function saveResumeAction()
    {
    	$post = $this->getRequest()->getPost();
    	$date = new DateTime($post['birthday']);
        $birthday = $date->format('Y-m-d');
        
		$resumeRowset = new Default_Model_Resume();
			
		$resumeRowset->setResumeCode('R-01');
		$resumeRowset->setFullName($post['full_name']);
		$resumeRowset->setBirthday($birthday);
		$resumeRowset->setGender($post['gender']);
		$resumeRowset->setMaritalStatus($post['marital_status']);
		$resumeRowset->setStatus('Active');
		$resumeRowset->setEmail1($post['email1']);
		$resumeRowset->setEmail2($post['email2']);
		$resumeRowset->setMobile1($post['mobile1']);
		$resumeRowset->setMobile2($post['mobile2']);
		$resumeRowset->setTel($post['tel']);
		$resumeRowset->setAddress($post['address']);
		$resumeRowset->setProvinceId(1);
		$resumeRowset->setCreatedDate(date('Y-m-d'));
		$resumeRowset->setCreatedConsultantId(1);
		$resumeRowset->setUpdatedConsultantId(1);
		
		$resume = new Default_Model_ResumeMapper();
		$resumeId = $resume->save($resumeRowset);

		$this->_redirect('resume/experience/id/' . $resumeId);
    }
    
    public function experienceAction()
    {
		$resumeId = $this->getRequest()->getParam('id');
		$experienceMapper = new Default_Model_ExperienceMapper();
        $rows = $experienceMapper->fetchAll('resume_id = ' . $resumeId, 'end_date DESC');

		$this->view->resumeId = $resumeId;
		$this->view->rows = $rows;
    }    
    
	public function saveExperienceAction()
    {
		$post = $this->getRequest()->getPost();
///print_r($post);exit;	
		$date = new DateTime($post['startdate']);
        $startDate = $date->format('Y-m-d');

	    $date = new DateTime($post['enddate']);
        $endDate = $date->format('Y-m-d');
        
		$experienceRowset = new Default_Model_Experience();
        $experienceRowset->setResumeId($post['resume_id']);
		$experienceRowset->setStartDate($startDate);
		$experienceRowset->setEndDate($endDate);
		$experienceRowset->setJobTitle($post['job_title']);
		$experienceRowset->setCompanyName($post['company_name']);
		$experienceRowset->setInfo($post['info']);  
		$experienceRowset->setSortOrder(1);   

		$experienceMapper = new Default_Model_ExperienceMapper();
		$experienceMapper->save($experienceRowset);
		
		$this->_redirect('resume/experience/id/' . $post['resume_id']);
    }
	
	public function expectationAction()
	{
		//echo 111;exit;
	
	}
	
    public function saveExpectationAction()
	{
		//echo 111;exit;
	
	}
	
	function exportToWordAction()
	{
		$filename = "report".date('dmY-his').".doc";
		header("Content-Type: application/xml; charset=UTF-8");
		header("Expires: 0");
		header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
		header("content-disposition: attachment;filename=$filename");
		$html = "<h1>this is test<h1>";
		$html .="<div> this is testing111";
		$html .="<div> this is testing2222";
		
		echo $html;
		exit;
	}
}

