<?php
class ResumeController extends Zend_Controller_Action
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
		$_SESSION['export-email'] = '';
		$view = new Zend_View();
		$view->headScript()->appendFile ( '/js/resume.js' );
		
		$view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
		$view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
		$view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );

		$resume = new Default_Model_ResumeMapper();

		$rowPerPage = $this->_getParam('rowperpage', 20);
		$currentPage = 1;
		$page = $this->_getParam('page', 1);
		if(!empty($page)) {
			$currentPage = $page;
		}

		$where = array();
		$choice = $this->_getParam('choice', '');
		$search = $this->_getParam('search', '');
		if($choice == 'full_name') $where[] = 'full_name like "%' . $search . '%"';
		if($choice == 'resume_code') $where[] = 'resume_code like "%' . $search . '%"';
		if($choice == 'job_title') $where[] = 'job_title like "%' . $search . '%"';

		$this->view->choice = $choice;
		$this->view->search = $search;

		$rows = $resume->getListResume($where, array($choice));
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage($rowPerPage);
		$paginator->setCurrentPageNumber($currentPage);

		$this->view->paginator = $paginator;
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

		$resumeRowset = new Default_Model_Resume();
		$resume = new Default_Model_ResumeMapper();
		
		$result = $resume->checkExists($post['full_name'], $post['birthday'], $post['email1']);
		if($result && !$post['resume_id']) {
			$resumeRowset->setFullName($post['full_name']);
			$resumeRowset->setBirthday($post['birthday']);
			$resumeRowset->setGender($post['gender']);
			$resumeRowset->setMaritalStatus($post['marital_status']);
			$resumeRowset->setEmail1($post['email1']);
			$resumeRowset->setEmail2($post['email2']);
			$resumeRowset->setMobile1($post['mobile1']);
			$resumeRowset->setMobile2($post['mobile2']);
			$resumeRowset->setTel($post['tel']);
			$resumeRowset->setAddress($post['address']);
			
			$this->view->resumeRowset = $resumeRowset;
			$this->view->msg = 'Resume has exists in Database';
			$this->render('personal-info');
		} else {
    		
    		if($post['resume_id']) $resumeCode = 'R' . $post['resume_id'];
    		else $resumeCode = 'R';
    		$resumeRowset->setResumeId($post['resume_id']);
    		$resumeRowset->setResumeCode($resumeCode);
    		$resumeRowset->setFullName($post['full_name']);
    		$resumeRowset->setBirthday($post['birthday']);
    		$resumeRowset->setGender($post['gender']);
    		$resumeRowset->setMaritalStatus($post['marital_status']);
    		$resumeRowset->setStatus('Active');
    		$resumeRowset->setEmail1($post['email1']);
    		$resumeRowset->setEmail2($post['email2']);
    		$resumeRowset->setMobile1($post['mobile1']);
    		$resumeRowset->setMobile2($post['mobile2']);
    		$resumeRowset->setTel($post['tel']);
    		$resumeRowset->setAddress($post['address']);
    		$resumeRowset->setCreatedDate(date('Y-m-d'));
    		$resumeRowset->setCreatedConsultantId($aNamespace->consultant_id);
    		$resumeRowset->setUpdatedConsultantId($aNamespace->consultant_id);
    
    		$resume = new Default_Model_ResumeMapper();
    		$resumeId = $resume->save($resumeRowset);
    		if(!$post['resume_id']) $resume->updateResumCode('R' . $resumeId, $resumeId);
    
    		//upload file resume
    		if ($_FILES['file_resume']['name']) {
    			$this->saveResumeFile($_FILES['file_resume'], $resumeId);
    		}
    
    		$this->_redirect('/resume/education/id/' . $resumeId);
		}
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

		$educationRowset = new Default_Model_Education();
		$educationRowset->setEducationId($post['educationid']);
		$educationRowset->setResumeId($post['resume_id']);
		$educationRowset->setStartDate($post['startdate']);
		$educationRowset->setEndDate($post['enddate']);
		$educationRowset->setSchoolName($post['school_name']);
		$educationRowset->setProgramName($post['program_name']);
		$educationRowset->setProgramInfo($post['program_info']);
		$educationRowset->setSortOrder(1);

		$educationMapper = new Default_Model_EducationMapper();
		$educationId = $educationMapper->save($educationRowset);
		if($educationId) {
		    $resumeMapper = new Default_Model_ResumeMapper();
            $resumeMapper->updateResumDate($post['resume_id']);
		}

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
		//$date = new DateTime($post['startdate']);
		//$startDate = $date->format('Y-m-d');

		//$date = new DateTime($post['enddate']);
		//$endDate = $date->format('Y-m-d');

		$experienceRowset = new Default_Model_Experience();
		$experienceRowset->setId($post['experid']);
		$experienceRowset->setResumeId($post['resume_id']);
		$experienceRowset->setStartDate($post['startdate']);
		$experienceRowset->setEndDate($post['enddate']);
		$experienceRowset->setJobTitle($post['job_title']);
		$experienceRowset->setCompanyName($post['company_name']);
		$experienceRowset->setDuties($post['duties']);
		$experienceRowset->setSortOrder(1);

		$experienceMapper = new Default_Model_ExperienceMapper();
		$experienceId = $experienceMapper->save($experienceRowset);

	    if($experienceId) {
		    $resumeMapper = new Default_Model_ResumeMapper();
            $resumeMapper->updateResumDate($post['resume_id']);
		}
		
		$experienceMapper->delExperFunction($experienceId);
		foreach($post['option'] as $functionId ) {
			$experienceMapper->saveExperFunction($experienceId, $functionId);
		}

		if($post['button'] == 'Next') $this->_redirect('resume/expectation/id/' . $post['resume_id']);
		else $this->_redirect('/resume/experience/id/' . $post['resume_id']);
	}

	public function saveExperience1Action()
	{
		$post = $this->getRequest()->getPost();

		$experienceMapper = new Default_Model_ExperienceMapper();
		$experienceMapper->saveExperienceOther($post['resume_id'], $post['experience_other']);

		if($post['button'] == 'Next') $this->_redirect('resume/expectation/id/' . $post['resume_id']);
		else $this->_redirect('/resume/experience/id/' . $post['resume_id']);
	}

	public function delExperienceAction()
	{
		$experId = $this->getRequest()->getParam('experid');
		$resumeId = $this->getRequest()->getParam('id');
		$experienceMapper = new Default_Model_ExperienceMapper();
		$experienceMapper->delete(array('res_experience_id = ?' => $experId));

		$this->_redirect('/resume/experience/id/' . $resumeId);
	}

	public function expectationAction()
	{
		$view = new Zend_View();
		$view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
		$view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
		$view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );

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
		$expectation->setEstimatedSalaryTo(floatval($post['estimated_salary_to']));
		$expectation->setEstimatedSalaryFrom(floatval($post['estimated_salary_from']));
		$expectation->setCurrentSalary(floatval($post['current_salary']));
		$expectation->setNote(($post['note']));

		$expectationMapper = new Default_Model_ExpectationMapper();
		$expectationId = $expectationMapper->save($expectation);

	    if($expectationId) {
		    $resumeMapper = new Default_Model_ResumeMapper();
            $resumeMapper->updateResumDate($post['resume_id']);
		}
		
		$expectationMapper->delExProvince($expectationId);
		foreach($post['option'] as $provinceId ) {
			$expectationMapper->saveExProvince($expectationId, $provinceId);
		}

		if($post['button'] == 'Complete') $this->_redirect('/resume');
		else $this->_redirect('/resume/experience/id/' . $post['resume_id']);
		//$this->_redirect('resume/expectation/id/' . $post['resume_id']);
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
		$html .= '<a href="#allcomment" class="allcomment" id="'.  $post['resume_id'] .'" onClick="allComment('.  $post['resume_id'] .')">view all</a>';
		echo $html;
		exit;
	}

	public function allCommentAction()
	{
		$post = $this->getRequest()->getPost();

		$resume = new Default_Model_ResumeMapper();
		$comments = $resume->getComments($post['resume_id']);
		$html = '';
		$html .= '<div style="color:#1B7CBD;background-color:#CCC;padding:5px 0px"><b>ALL COMMENT</b></div><br />';
		foreach($comments as $comment) {

			$date = new DateTime($comment['created_date']);
			$createdComment = $date->format('M-d');

			$html .= '<div>';
			$html .= substr($comment['content'], 0, 90);
			$html .= '<div align="right"><span>Comment '. $createdComment .'</span> ';
			$html .= '<span style="color: #70B4E2;">by ' . $comment['username'] . '</span></div>';
			$html .= '</div>';
			$html .= '<div style="border-top: 1px solid #BCBCBC; margin-top:10px">&nbsp;</div>';
		}

		echo $html;
		exit;
		//$this->_helper->layout->disableLayout();
		//$this->view->html = $html;
		//$this->render('comment-all');
	}
	
    public function saveHistoryAction()
	{
		$post = $this->getRequest()->getPost();

		$resume = new Default_Model_ResumeMapper();
		$resume->insertHistory($post);

		$historys = $resume->getHistory($post['resume_id'], 3);

		$html = '';
		foreach($historys as $history) {
    		$html .= '<p> - ' . substr($history['content'], 0, 90) . '</p>';
		}
		
		$html .= '<a href="#allhistory" class="allhistory" id="'.  $post['resume_id'] .'" onClick="allHistory('.  $post['resume_id'] .')">view all</a>';
		echo $html;
		exit;
	}

	public function allHistoryAction()
	{
		$post = $this->getRequest()->getPost();

		$resume = new Default_Model_ResumeMapper();
		$historys = $resume->getHistory($post['resume_id']);
		$html = '';
		$html .= '<div style="color:#1B7CBD;background-color:#CCC;padding:5px 0px"><b>ALL HISTORY</b></div><br />';
		foreach($historys as $history) {

			$date = new DateTime($history['created_date']);
			$createdHistory = $date->format('M-d');

			$html .= '<div>';
			$html .= substr($history['content'], 0, 90);
			$html .= '<div align="right"><span>Comment '. $createdHistory .'</span> ';
			$html .= '<span style="color: #70B4E2;">by ' . $history['username'] . '</span></div>';
			$html .= '</div>';
			$html .= '<div style="border-top: 1px solid #BCBCBC; margin-top:10px">&nbsp;</div>';
		}

		echo $html;
		exit;
		//$this->_helper->layout->disableLayout();
		//$this->view->html = $html;
		//$this->render('comment-all');
	}

	public function avandceSearchAction()
	{
	    $view = new Zend_View();
		$view->headScript()->appendFile ( '/js/resume.js' );
		
		$cond = array();
		$post = $this->getRequest()->getPost();
//print_r($post);exit;
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

		if(@$post['experother']) {
			$choice[] = 'experother';
			$cond[] = 'experience_other like "%'. $post['experother'] .'%"';
		}

	    if(@$post['functions']) {
			$choice[] = 'functions';
			$cond[] = 'function_id in ('. $post['functions'] .')';
		}
		
		if(@$post['provinces']) {
			$choice[] = 'provinces';
			$cond[] = 'province_id in ('. $post['provinces'] .')';
		}
		
	    if(@$post['school_name']) {
			$choice[] = 'education';
			$cond[] = 'school_name like "%'. $post['school_name'] .'%"';
		}
		
	    if(@$post['program_name']) {
			$choice[] = 'education';
			$cond[] = 'program_name like "%'. $post['program_name'] .'%"';
		}

		if(@$post['keyword']) {
			$keyword = $post['keyword'];
			$choice[] = 'keyword';
			$where  = '(job_title like  "%'. $keyword .'%"';
			$where .= ' OR company_name like  "%'. $keyword .'%"';
			$where .= ' OR duties like  "%'. $keyword .'%"';
			$where .= ' OR experience_other like  "%'. $keyword .'%")';

			$cond[] = $where;
		}
//print_r($cond);exit;
		$resume = new Default_Model_ResumeMapper();
		$rows = $resume->getListResume($cond, $choice);
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber(1);

		$this->view->paginator = $paginator;
		//$this->view->rows = $rows;
		
        $this->view->search = 1;
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
	
	public function deleteResumeAction()
	{
	    $resumeMapper = new Default_Model_ResumeMapper();
	    $listid = $this->getRequest()->getParam('listid', 0);
        $resumeMapper->deleteListResume($listid);
	    
		$rows = $resumeMapper->getListResume();
		$paginator = Zend_Paginator::factory($rows);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber(1);

		$this->view->paginator = $paginator;
        $this->_helper->layout->disableLayout();
	    $this->render('list-resume');
	}

	public function exportEmailAction()
	{
		$query = '';
		if(isset($_SESSION['export-email'])) $query = $_SESSION['export-email'];
		$resume = new Default_Model_ResumeMapper();
		$rows = $resume->getExportEmail($query);

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
		if(count($rows))
		{
			foreach ($rows AS $row) :
			$table .= '<tr>'; //new xml table row
			$table .= '<td>';
			$table .= $row['full_name'];
			$table .= '</td>';
			$table .= '<td>';
			$table .= $row['email_1'];
			$table .= '</td>';
			$table .= '</tr>';
			endforeach;
		}else{
			$table .= '<tr>'; //new xml table row
			$table .= '<td>';
			$table .= 'no data';
			$table .= '</td>';
			$table .= '<td>';
			$table .= 'no data';
			$table .= '</td>';
			$table .= '</tr>';
		}
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
				//$date = new DateTime($education->getStartDate());
				//$startDate = $date->format('M Y');

				//$date = new DateTime($education->getEndDate());
				//$endDate = $date->format('M Y');

				$table .= '<w:tr>'; //new xml table row
				$table .= '<w:tc>';
				$table .= '<w:tcPr>';
				$table .= '<w:tcW w:w="2500" w:type="dxa"/></w:tcPr>';
				$table .= '<w:p><w:r><w:t>'; //start cell
				$table .= $education->getStartDate() .'-'. $education->getEndDate(); //cell contents
				$table .= '</w:t></w:r></w:p>';
				$table .= '</w:tc>'; //close cell
				$table .= '<w:tc>';
				$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>';
				$table .= strtoupper($education->getSchoolName());
				$table .= '</w:t></w:r><w:br/><w:r><w:t>';
				$table .= $education->getProgramName();
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
			//$table .= '<w:tblPr><w:tblW w:w="4000" w:type="pct"/></w:tblPr>';
			foreach ( $experienceList as $experience ) {
				if($experience->getExperienceOther()) {
					$table .= '<w:tr>'; //new xml table row
					$table .= '<w:tc>';
					$table .= '<w:tcPr>';
					$table .= '<w:tcW w:w="2500" w:type="dxa"/></w:tcPr>';
					$table .= '<w:p><w:r><w:t>'; //start cell
					$table .= 'Experience Other: '; //cell contents
					$table .= '</w:t></w:r></w:p>';
					$table .= '</w:tc>'; //close cell
					$table .= '<w:tc>';
					$table .= '<w:p><w:r><w:t>';
					$table .= stripslashes($experience->getExperienceOther());
					$table .= '</w:t></w:r></w:p>';
					$table .= '</w:tc>';
					$table .= '</w:tr>';
				} else {

					//$date = new DateTime($experience->getStartDate());
					//$startDate = $date->format('M Y');

					//$date = new DateTime($experience->getEndDate());
					//$endDate = $date->format('M Y');

					$table .= '<w:tr>'; //new xml table row
					$table .= '<w:tc>';
					$table .= '<w:tcPr>';
					$table .= '<w:tcW w:w="2500" w:type="dxa"/></w:tcPr>';
					$table .= '<w:p><w:r><w:t>'; //start cell
					$table .= $experience->getStartDate() .'-'. $experience->getEndDate(); //cell contents
					$table .= '</w:t></w:r></w:p>';
					$table .= '</w:tc>'; //close cell
					$table .= '<w:tc>';
					$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>';
					$table .= strtoupper($experience->getCompanyName());
					$table .= '</w:t></w:r><w:br/><w:r><w:t>';
					$table .= ucwords(strtolower($experience->getJobTitle()));
					$table .= '</w:t></w:r></w:p>';
					$table .= '<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>Duties:</w:t></w:r><w:br/><w:r><w:t>';
					$table .= $experience->getDuties();
					$table .= '</w:t></w:r></w:p>';
					$table .= '</w:tc>';
					$table .= '</w:tr>';
				}
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
		@$note = $expectation['note'];
		
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
/*
		if(count($note)) {
			$table .= '<w:tr>'; //new xml table row
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= 'Note: '; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '<w:tc><w:p><w:r><w:t>'; //start cell
			$table .= $note; //cell contents
			$table .= '</w:t></w:r></w:p></w:tc>'; //close cell
			$table .= '</w:tr>';
		}
*/
		$table .= '</w:tbl>'; //close xml table
		$document->setValue('expection', $table);

		$document->setValue('note', $note);
		
		//rename and save file doc
		$resumeName = str_replace(' ', '', $resumeRowSet->getFullName()) .'.docx';
		$document->save('candidate/'. $resumeName);

		//header download file word
		header("Cache-Control: public");
		header("Content-Description: File Transfer");
		header("Content-Disposition: attachment; filename=Greyfinders_$resumeName");
		header("Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document");
		header("Content-Transfer-Encoding: binary");

		readfile('candidate/' . $resumeName);
		unlink('candidate/' . $resumeName);
		exit;
	}

	public function saveResumeFile($file_resume, $resumeId)
	{
		$data = array (
			'resume_id' => $resumeId,
			'bin_data' => '',
			'filename' => 'R' . $resumeId .'_'. $file_resume["name"],
			'filetype' => $file_resume["type"],
			'filesize' => $file_resume["size"]
		);

        //if they DID upload a file...
		if($file_resume["name"])
		{
			//if no errors...
			if(!$file_resume['error'])
			{
				//now is the time to modify the future file name and validate the file
				$new_file_name = strtolower($file_resume['tmp_name']); //rename file
				$valid_file = true;
				if($file_resume['size'] > (1024000*3)) //can't be larger than 3 MB
				{
					$valid_file = false;
					$message = 'Oops!  Your file\'s size is to large.';
				}

				//if the file has passed the test
				if($valid_file)
				{
					//move it to where we want it to be
					move_uploaded_file($file_resume['tmp_name'], APPLICATION_PATH . '/../public/uploads/' . $data["filename"]);
					$fileMapper = new Default_Model_FileMapper();
					$row = $fileMapper->getResumeFile($resumeId);
					if($row['id']) $fileMapper->updateResumeFile($data);
					else $fileMapper->insertResumeFile($data);
					return true;
				}
			}
			//if there is an error...
			else
			{
				//set that to be the returned message
				$message = 'Ooops!  Your upload triggered the following error:  '.$file_resume['error'];
			}
		}
		
		return;
	}
	
	public function downloadResumeAction()
	{
		$resumeId = $this->_getParam('id');
		$fileMapper = new Default_Model_FileMapper();
		$row = $fileMapper->getResumeFile($resumeId);

		$file = APPLICATION_PATH . '/../public/uploads/' . $row["filename"];
		if (file_exists($file))
		{
			if (FALSE!== ($handler = fopen($file, 'r')))
			{
				header('Content-Description: File Transfer');
				header('Content-Type: ' . $row["filetype"]);
				header('Content-Disposition: attachment; filename=' . basename($file));
				header('Content-Transfer-Encoding: chunked'); //changed to chunked
				header('Expires: 0');
				header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
				header('Pragma: public');
				readfile($file);
			}
		}
		exit;

	}
}

