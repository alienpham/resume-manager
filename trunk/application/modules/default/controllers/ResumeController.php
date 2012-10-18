<?php
class ResumeController extends Zend_Controller_Action
{

    public function init()
    {
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );
		
        /* Initialize action controller here */
        $view = new Zend_View();
        $view->headScript()->appendFile ( '/js/jquery-1.8.0.min.js' );
        $view->headLink()->appendStylesheet ( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
		$this->view->username = $aNamespace->username;
		date_default_timezone_set('Asia/Krasnoyarsk');
    }

    public function indexAction()
    {
        $view = new Zend_View();
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
        
        $resume = new Default_Model_ResumeMapper();

        $currentPage = 1;
        $page = $this->_getParam('page',1);
        if(!empty($page)) {
            $currentPage = $page;
        }
        
        $where = array();
        $choice = $this->_getParam('choice', 'name');
        $search = $this->_getParam('search', '');
        if($choice == 'full_name') $where[] = 'full_name like "%' . $search . '%"';
        if($choice == 'resume_code') $where[] = 'resume_code like "%' . $search . '%"';
        if($choice == 'job_title') $where[] = 'job_title like "%' . $search . '%"';
        
        //http://zendgeek.blogspot.com
        $rows = $resume->getListResume($where, array($choice));
        $paginator = Zend_Paginator::factory($rows);
        $paginator->setItemCountPerPage(10);
        $paginator->setCurrentPageNumber($currentPage);
        
        $this->view->paginator = $paginator;
        $this->view->rows = $rows;
		
    }
    
	public function resumeReportAction()
	{
	    $this->_helper->layout->disableLayout();
	    
	    $resume = new Default_Model_ResumeMapper();
        $countNew = $resume->countResumeWith('new');
        $countUpdate = $resume->countResumeWith('update');
        $countTotal = $resume->countResumeWith('total');

	    $html = 'Today Entry: <strong>New '. $countNew .'</strong> | ';
        $html .= 'Updated: <strong>'. $countUpdate .'</strong$countNew> | ';
        $html .= 'Total: <strong>'. $countTotal .'</strong>';
        echo $html;
	    exit;
	}
	
	public function personalInfoAction()
    {
        $resumeId = $this->_getParam('id', 0);
        
        $resumeRowset = new Default_Model_Resume();
		$resume = new Default_Model_ResumeMapper();
        $resume->find($resumeId, $resumeRowset);
        
        $this->view->resumeRowset = $resumeRowset;
    }
    
	public function saveResumeAction()
    {
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
        $post = $this->getRequest()->getPost();

        $date = new DateTime($post['birthday']);
        $birthday = $date->format('Y-m-d');
        
        $resumeRowset = new Default_Model_Resume();
        if($post['resume_id']) $resumeCode = 'R' . $post['resume_id'];
        else $resumeCode = 'R';
        $resumeRowset->setResumeId($post['resume_id']);
        $resumeRowset->setResumeCode($resumeCode);
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
        if(!$post['resume_id']) $resumeRowset->setCreatedDate(date('Y-m-d'));
        $resumeRowset->setCreatedConsultantId($aNamespace->consultant_id);
        $resumeRowset->setUpdatedConsultantId($aNamespace->consultant_id);
        
        $resume = new Default_Model_ResumeMapper();
        $resumeId = $resume->save($resumeRowset);
        if($resumeCode == 'R') $resume->updateResumCode('R' . $resumeId, $aNamespace->consultant_id, $resumeId);
        
        $this->_redirect('/resume/education/id/' . $resumeId);
    }
    
    public function educationAction()
    {
        $resumeId = $this->getRequest()->getParam('id', 0);
        $educationId = $this->getRequest()->getParam('educationid', 0);
        
        $educationMapper = new Default_Model_EducationMapper();
        $rows = $educationMapper->fetchAll('resume_id = ' . $resumeId, 'end_date DESC');
        
        $educationRowset = new Default_Model_Education();
        $educationMapper->find($educationId, $educationRowset);
        
        $this->view->resumeId = $resumeId;
        $this->view->rows = $rows;
        $this->view->educationRowset = $educationRowset;
    }
    
     public function saveEducationAction()
    {
        $post = $this->getRequest()->getPost();	
        $date = new DateTime($post['startdate']);
        $startDate = $date->format('Y-m-d');
        
        $date = new DateTime($post['enddate']);
        $endDate = $date->format('Y-m-d');

        $educationRowset = new Default_Model_Education();
        $educationRowset->setEducationId($post['educationid']);
        $educationRowset->setResumeId($post['resume_id']);
        $educationRowset->setStartDate($startDate);
        $educationRowset->setEndDate($endDate);
        $educationRowset->setSchoolName($post['school_name']);
        $educationRowset->setProgramName($post['program_name']);
        $educationRowset->setProgramInfo($post['program_info']);  
        $educationRowset->setSortOrder(1);   
        
        $educationMapper = new Default_Model_EducationMapper();
        $educationId = $educationMapper->save($educationRowset);
        
        if($post['button'] == 'Next') $this->_redirect('resume/experience/id/' . $post['resume_id']);
        else $this->_redirect('/resume/education/id/' . $post['resume_id']);
    }
    
    public function delEducationAction()
    {
    	$resumeId = $this->getRequest()->getParam('id');
        $educationId = $this->getRequest()->getParam('educationid', 0);
        
    	$educationMapper = new Default_Model_EducationMapper();
    	$educationMapper->delete(array('res_education_id = ?' => $educationId));
    	
    	$this->_redirect('/resume/education/id/' . $resumeId);
    }
    
    public function experienceAction()
    {
    	$experid = $this->getRequest()->getParam('experid', 0);
        $resumeId = $this->getRequest()->getParam('id');
        $experienceMapper = new Default_Model_ExperienceMapper();
        $rows = $experienceMapper->fetchAll('resume_id = ' . $resumeId, 'end_date DESC');
        
        $experienceRowSet = new Default_Model_Experience();
        $experienceMapper->find($experid, $experienceRowSet);
        
        $resume = new Default_Model_ExperienceMapper();
        $listFunction = $resume->getFunction();
        
        $functionArr = array();
        if($experienceRowSet->getId()) {
            $experFunction = $experienceMapper->getExperFunction($experienceRowSet->getId());
            foreach($experFunction as $function){
                $functionArr[] = $function['function_id'];
            }
	    }
        $this->view->resumeId = $resumeId;
        $this->view->rows = $rows;
        $this->view->experienceRowSet = $experienceRowSet;
        $this->view->listFunction = $listFunction;
        $this->view->experFunction = $functionArr;
    }    
    
   	public function saveExperienceAction()
    {
        $post = $this->getRequest()->getPost();	
        $date = new DateTime($post['startdate']);
        $startDate = $date->format('Y-m-d');
        
        $date = new DateTime($post['enddate']);
        $endDate = $date->format('Y-m-d');
        
        $experienceRowset = new Default_Model_Experience();
        $experienceRowset->setId($post['experid']);
        $experienceRowset->setResumeId($post['resume_id']);
        $experienceRowset->setStartDate($startDate);
        $experienceRowset->setEndDate($endDate);
        $experienceRowset->setJobTitle($post['job_title']);
        $experienceRowset->setCompanyName($post['company_name']);
        $experienceRowset->setDuties($post['duties']);  
        $experienceRowset->setSortOrder(1);   
        
        $experienceMapper = new Default_Model_ExperienceMapper();
        $experienceId = $experienceMapper->save($experienceRowset);
        
        $experienceMapper->delExperFunction($experienceId);
        foreach($post['option'] as $functionId ) {
            $experienceMapper->saveExperFunction($experienceId, $functionId);
        }
        
        if($post['button'] == 'Next') $this->_redirect('resume/expectation/id/' . $post['resume_id']);
        else $this->_redirect('/resume/experience/id/' . $post['resume_id']);
    }
    
    public function delExperienceAction()
    {
    	$experId = $this->getRequest()->getParam('experid');
    	$resumeId = $this->getRequest()->getParam('id');
    	$experienceMapper = new Default_Model_ExperienceMapper();
    	$experienceMapper->delete(array('id = ?' => $experId));
    	
    	$this->_redirect('/resume/experience/id/' . $resumeId);
    }
	
	public function expectationAction()
	{
        $resumeId = $this->getRequest()->getParam('id');
        
        $resume = new Default_Model_ResumeMapper();
        $listProvince = $resume->getProvince();
        
        $expectationRowSet = new Default_Model_Expectation();
        $expectationMapper = new Default_Model_ExpectationMapper();
        $expectationMapper->find($resumeId, $expectationRowSet);

        $provinceArr = array();
        if($expectationRowSet->getResExpectationId()) {
            $resumeProvince = $expectationMapper->getExpectationProvince($expectationRowSet->getResExpectationId());
            foreach($resumeProvince as $province){
                $provinceArr[] = $province['province_id'];
            }
	    }
	    
        $this->view->listProvince = $listProvince;
        $this->view->resumeId = $resumeId;
        $this->view->expectationRowSet = $expectationRowSet;
        $this->view->resumeProvince = $provinceArr;
	
	}
	
    public function saveExpectationAction()
	{
        $post = $this->getRequest()->getPost();
        $expectation = new Default_Model_Expectation();
        $expectation->setResExpectationId($post['expecid']);
        $expectation->setResumeId($post['resume_id']);
        $expectation->setEstimatedSalaryTo($post['estimated_salary_to']);
        $expectation->setEstimatedSalaryFrom($post['estimated_salary_from']);
        $expectation->setCurrentSalary($post['current_salary']);
        	
        $expectationMapper = new Default_Model_ExpectationMapper();
        $expectationId = $expectationMapper->save($expectation);
        
        $expectationMapper->delExProvince($expectationId);
        foreach($post['option'] as $provinceId ) {
            $expectationMapper->saveExProvince($expectationId, $provinceId);
        }
        
        if($post['button'] == 'Complete') $this->_redirect('/resume');
        else $this->_redirect('/resume/experience/id/' . $post['resume_id']);
        //$this->_redirect('resume/expectation/id/' . $post['resume_id']);
	}
	
	public function commentAction()
	{
		$this->_helper->layout->disableLayout();
        $post = $this->getRequest()->getPost();
	}
	
	public function saveCommentAction()
	{
        $post = $this->getRequest()->getPost();
		
		$resume = new Default_Model_ResumeMapper();
		$resume->insertComment($post);

		$comment = $resume->getComments($post['resume_id'], 1);
        $date = new DateTime($comment['created_date']);
        $createdComment = $date->format('M-d');
            
		$html = '<p class="update-date">Comment '. $createdComment .'</p> <span>by</span> <span class="user-name">'. $comment['username'] . '</span>';
        $html .= '<p>' . substr($comment['content'], 0, 90) . '</p>';
        $html .= '<a href="#allcomment" class="allcomment" id="'.  $post['resume_id'] .'">view all</a>';
        echo $html;
		exit;
	}
	
	public function allCommentAction()
	{
	    $post = $this->getRequest()->getPost();
		
		$resume = new Default_Model_ResumeMapper();
		$comments = $resume->getComments($post['resume_id']);
        $html = ''; 
		$html .= '<div style="color:#70b4e2;"><b>ALL COMMENT</b></div><br />';
		foreach($comments as $comment) {
        
            $date = new DateTime($comment['created_date']);
            $createdComment = $date->format('M-d');
			
            $html .= '<div>'; 
			$html .= substr($comment['content'], 0, 90);
    		$html .= '<div align="right"><strong class="text_green">Comment '. $createdComment .'</strong> ';
            $html .= '<strong>by ' . $comment['username'] . '</strong></div>';
            $html .= '</div>'; 
			$html .= '<div style="border-top: 1px solid #BCBCBC; margin-top:10px">&nbsp;</div>'; 
        }
        
        echo $html;
		exit;
	}
	
	public function avandceSearchAction()
	{
	    $cond = array();
        $post = $this->getRequest()->getPost();
//print_r($post);
        if(@$post['full_name']) $cond[] = 'full_name like "%' . $post['full_name'] . '%" ';
        if(@$post['email']) $cond[] = '(email_1 like "%' . $post['email'] . '%" OR email_2 like "%' . $post['email'] . '%")';
        if(@$post['phone']) $cond[] = '(mobile_1 like "%' . $post['phone'] . '%" OR mobile_2 like "%' . $post['phone'] . '%") ';
        if(@$post['gender']) $cond[] = 'gender = "'. $post['gender'] .'"';
        if(@$post['marital_status']) $cond[] = 'marital_status = "'. $post['marital_status'] .'"';
        $choice = array();
        if(@$post['job_title']) {
            $choice[] = 'job_title';
            $cond[] = 'job_title like  "%'. $post['job_title'] .'%"';   
        }
	    if(@$post['company_name']) {
            $choice[] = 'company_name';
            $cond[] = 'company_name like  "%'. $post['company_name'] .'%"';   
        }
	    if(@$post['salary']) {
            $choice[] = 'salary';
            $symbol = $post['symbol'];
            if($symbol == 1) $symbol = '=';
            else if($symbol == 2) $symbol = '>';
            else $symbol = '<';
            $cond[] = 'current_salary '. $symbol .'  "'. $post['salary'] .'"';   
        }
    	if(@$post['functions']) {
            $choice[] = 'functions';
            $cond[] = 'function_id in ('. $post['functions'] .')';   
        }
        
        $resume = new Default_Model_ResumeMapper();
        $rows = $resume->getListResume($cond, $choice);
        $paginator = Zend_Paginator::factory($rows);
        $paginator->setItemCountPerPage(10);
        $paginator->setCurrentPageNumber(1);
    
        $this->view->paginator = $paginator;
        $this->view->rows = $rows;
        
        $this->_helper->layout->disableLayout();
        $this->render('list-resume');

	}
	
    public function detailResumeAction()
	{
        $post = $this->getRequest()->getPost();

        $resumeRowSet = new Default_Model_Resume();
        $resumeMapper = new Default_Model_ResumeMapper();
        $resumeMapper->find($post['resume_id'], $resumeRowSet);

        $this->view->resume = $resumeRowSet;
        $this->_helper->layout->disableLayout();
        $this->render('detail-resume');
	}
	
	public function exportEmailAction()
	{
	    $resume = new Default_Model_ResumeMapper();
        $rows = $resume->fetchAll();
        
	    header("Pragma: public");
        header("Cache-Control: no-store, no-cache, must-revalidate");
        header("Cache-Control: pre-check=0, post-check=0, max-age=0");
        header("Pragma: no-cache");
        header("Expires: 0");
        header("Content-Transfer-Encoding: none");
        header("Content-Type: application/vnd.ms-excel;");
        header("Content-type: application/x-msexcel");
        header("Content-Disposition: attachment; filename=ListEmailResume".date('Ymd').".xls");

        $table = '<html><body>';
        $table .= '<meta content="text/html; charset=utf-8" http-equiv="Content-Type">';
        $table .= '<table border="1">';
        $table .= '<tr>'; //new xml table row
        $table .= '<td>Candidate</td>';
        $table .= '<td>Email</td>';
        $table .= '</tr>';
        foreach ($rows AS $row) :
            $table .= '<tr>'; //new xml table row
		        $table .= '<td>';
                $table .= $row->getFullName();
                $table .= '</td>';
                 $table .= '<td>';
                $table .= $row->getEmail1();
                $table .= '</td>';
            $table .= '</tr>';
        endforeach;
        $table .= '</table></body></html>';
        echo $table;
        exit;
    }


	function exportToWordAction()
	{
        $resume_id = $this->_getParam('id');
        $resumeRowSet = new Default_Model_Resume();
        $resumeMapper = new Default_Model_ResumeMapper();
        $resumeMapper->find($resume_id, $resumeRowSet);
	    
	    Zend_Loader::loadFile('PHPWord.php');
        $PHPWord = new PHPWord();

        $document = $PHPWord->loadTemplate('candidate/template_resume.docx');
        $document->setValue('fullname', ucwords(strtolower($resumeRowSet->getFullName())));
        $document->setValue('birthday', $resumeRowSet->getBirthday());
        $document->setValue('gender', $resumeRowSet->getGender());
        $document->setValue('maritalstatus', $resumeRowSet->getMaritalStatus());
        $document->setValue('address', $resumeRowSet->getAddress());
        $document->setValue('email', $resumeRowSet->getEmail1());
        $document->setValue('phone', $resumeRowSet->getMobile1());
        
        //element education in file doc
        $educationMapper = new Default_Model_EducationMapper();
        $educationList = $educationMapper->fetchAll('resume_id = ' . $resume_id, 'end_date DESC');
        $table = ''; //empty table
    	if(count($educationList)){ //if there was data returned from queryDB()
    		$table .= '<w:tbl>';
    		//$table .= '<w:tblPr><w:tblW w:w = "4000" w:type="pct"/></w:tblPr>';
    		foreach ( $educationList as $education ) {
    		    $date = new DateTime($education->getStartDate());
                $startDate = $date->format('M Y');
        
                $date = new DateTime($education->getEndDate());
                $endDate = $date->format('M Y');
           
    			$table .= '<w:tr>'; //new xml table row
        			$table .= '<w:tc>';
            			$table .= '<w:tcPr>';
            			$table .= '<w:tcW w:w="2500" w:type="dxa"/></w:tcPr>';
            			$table .= '<w:p><w:r><w:t>'; //start cell
            			$table .= $startDate .'-'. $endDate; //cell contents
            			$table .= '</w:t></w:r></w:p>';
        			$table .= '</w:tc>'; //close cell
        			$table .= '<w:tc>';
            			$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>';
        			    $table .= strtoupper($education->getSchoolName()) .'</w:t></w:r><w:br/><w:r><w:t>'. ucwords(strtolower($education->getProgramName()));
            			$table .= '</w:t></w:r></w:p>';
            			$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>Program Info:</w:t></w:r><w:br/><w:r><w:t>';
        			    $table .= $education->getProgramInfo();
            			$table .= '</w:t></w:r></w:p>';
        			$table .= '</w:tc>';
    			$table .= '</w:tr>';
    		} //done with dynamic data
            $table .= '</w:tbl>'; //close xml table
    	}
        $document->setValue('education', $table);
        
        //element experience in file doc
        $experienceMapper = new Default_Model_ExperienceMapper();
        $experienceList = $experienceMapper->fetchAll('resume_id = ' . $resume_id, 'end_date DESC');
        $table = ''; //empty table
    	if(count($experienceList)){ //if there was data returned from queryDB()
    		$table .= '<w:tbl>';
    		//$table .= '<w:tblPr><w:tblW w:w = "4000" w:type="pct"/></w:tblPr>';
    		foreach ( $experienceList as $experience ) {
    		    $date = new DateTime($experience->getStartDate());
                $startDate = $date->format('M Y');
        
                $date = new DateTime($experience->getEndDate());
                $endDate = $date->format('M Y');
           
    			$table .= '<w:tr>'; //new xml table row
        			$table .= '<w:tc>';
            			$table .= '<w:tcPr>';
            			$table .= '<w:tcW w:w="2500" w:type="dxa"/></w:tcPr>';
            			$table .= '<w:p><w:r><w:t>'; //start cell
            			$table .= $startDate .'-'. $endDate; //cell contents
            			$table .= '</w:t></w:r></w:p>';
        			$table .= '</w:tc>'; //close cell
        			$table .= '<w:tc>';
            			$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>';
        			    $table .= strtoupper($experience->getCompanyName()) .'</w:t></w:r><w:br/><w:r><w:t>'. ucwords(strtolower($experience->getJobTitle()));
            			$table .= '</w:t></w:r></w:p>';
            			$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>Duties:</w:t></w:r><w:br/><w:r><w:t>';
        			    $table .= $experience->getDuties();
            			$table .= '</w:t></w:r></w:p>';
        			$table .= '</w:tc>';
    			$table .= '</w:tr>';
    		} //done with dynamic data
            $table .= '</w:tbl>'; //close xml table
    	}
        $document->setValue('experience', $table);
        
        //element expection in file doc
        $expectationMapper = new Default_Model_ExpectationMapper();
        $expectation = $expectationMapper->getExpectation($resume_id);
        
        $provinceArr = array();
        if($expectation['res_expectation_id']) {
            $resumeProvince = $expectationMapper->getExpectationProvince($expectation['res_expectation_id']);
            foreach($resumeProvince as $province){
                $provinceArr[] = $province['name'];
            }
        }

        $currentSalary = number_format($expectation['current_salary']);
        @$salaryFrom = number_format($expectation['estimated_salary_from']);
        @$salaryTo = number_format($expectation['estimated_salary_to']);

        $table = ''; //empty table
		$table .= '<w:tbl>';
		$table .= '<w:tblPr><w:tblW w:w = "4000" w:type="pct"/></w:tblPr>';
		if($currentSalary) {
			$table .= '<w:tr>'; //new xml table row
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= 'Salary:'; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= '$' . $currentSalary; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '</w:tr>';
		}
		
        if($salaryFrom) {
			$table .= '<w:tr>'; //new xml table row
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= 'Estimated:'; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= '$' . $salaryFrom .' - ' . '$' . $salaryTo; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '</w:tr>';
		}
		
        if(count($provinceArr)) {
			$table .= '<w:tr>'; //new xml table row
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= 'Location: '; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= implode(', ', $provinceArr); //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '</w:tr>';
		}
        $table .= '</w:tbl>'; //close xml table
        $document->setValue('expection', $table);
                    
        //rename and save file doc
        $resumeName = str_replace(' ', '', $resumeRowSet->getFullName()) .'.docx';
        $document->save('candidate/'. $resumeName);
        
        //header download file word
        header("Cache-Control: public");     
        header("Content-Description: File Transfer");     
        header("Content-Disposition: attachment; filename=$resumeName");     
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        header("Content-Transfer-Encoding: binary");         

        readfile('candidate/' . $resumeName); 
        unlink('candidate/' . $resumeName);
        exit;
	}
}

