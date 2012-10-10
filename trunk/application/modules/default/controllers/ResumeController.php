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
        
        $this->_redirect('/resume/experience/id/' . $resumeId);
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
        $experienceRowset->setResumeId($post['resume_id']);
        $experienceRowset->setStartDate($startDate);
        $experienceRowset->setEndDate($endDate);
        $experienceRowset->setJobTitle($post['job_title']);
        $experienceRowset->setCompanyName($post['company_name']);
        $experienceRowset->setInfo($post['info']);  
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
            
		$html = '<strong class="text_green">Comment '. $createdComment .'</strong> ';
        $html .= '<strong>by ' . $comment['username'] . '</strong>:<br />';
        $html .= substr($comment['content'], 0, 90);
        $html .= ' <a href="#allcomment" class="allcomment" id="'.  $post['resume_id'] .'">view all</a>';
        echo $html;
		exit;
	}
	
	public function allCommentAction()
	{
	    $post = $this->getRequest()->getPost();
		
		$resume = new Default_Model_ResumeMapper();
		$comments = $resume->getComments($post['resume_id']);
        $html = ''; 
		foreach($comments as $comment) {
        
            $date = new DateTime($comment['created_date']);
            $createdComment = $date->format('M-d');
            $html .= '<div>'; 
    		$html .= '<strong class="text_green">Comment '. $createdComment .'</strong> ';
            $html .= '<strong>by ' . $comment['username'] . '</strong>:';
            $html .= substr($comment['content'], 0, 90);
            $html .= '</div>'; 
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
        $this->render('list-resume', array('paginator' => $paginator, 'rows' => $rows));

	}
	
    public function detailResumeAction()
	{
        $post = $this->getRequest()->getPost();

        $resumeRowSet = new Default_Model_Resume();
        $resumeMapper = new Default_Model_ResumeMapper();
        $rows = $resumeMapper->find($post['resume_id'], $resumeRowSet);

        $this->view->rows = $rows;
        $this->_helper->layout->disableLayout();
        $this->render('detail-resume', array('rows' => $rows));

	}
	
	function exportToWordAction()
	{
	    Zend_Loader::loadFile('PHPWord.php');
        
        // New Word Document
        $PHPWord = new PHPWord();
        
        // New portrait section
        $section = $PHPWord->createSection();
        
        // Add text elements
        $section->addText('Hello World!');
        $section->addTextBreak(2);
        
        $section->addText('I am inline styled.', array('name'=>'Verdana', 'color'=>'006699'));
        $section->addTextBreak(2);
        
        $PHPWord->addFontStyle('rStyle', array('bold'=>true, 'italic'=>true, 'size'=>16));
        $PHPWord->addParagraphStyle('pStyle', array('align'=>'center', 'spaceAfter'=>100));
        $section->addText('I am styled by two style definitions.', 'rStyle', 'pStyle');
        $section->addText('I have only a paragraph style definition.', null, 'pStyle');
        
        
        
        // Save File
        $objWriter = PHPWord_IOFactory::createWriter($PHPWord, 'Word2007');
        $objWriter->save('candidate/resume.docx');
        
        //$filename = "report".date('dmY-his').".doc";
        //header("Content-Type: application/xml; charset=UTF-8");
        //header("Expires: 0");
        //header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        //header("content-disposition: attachment;filename=$filename");
        
        //echo $html;
        //exit;
        
        header("Cache-Control: public");     
        header("Content-Description: File Transfer");     
        header("Content-Disposition: attachment; filename=resume.docx");     
        header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");     
        header("Content-Transfer-Encoding: binary");         

        readfile('candidate/resume.docx'); 
        exit;
	}
}

