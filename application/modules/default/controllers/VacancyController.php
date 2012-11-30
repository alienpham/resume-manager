<?php
class VacancyController extends Zend_Controller_Action
{

	public function init()
	{
		$view = new Zend_View();
        //$view->headScript()->appendFile ( '/js/jquery-1.7.1.js' );
        $view->headLink()->appendStylesheet( '/js/themes/base/jquery.ui.all.css' );
        $view->headScript()->appendFile ( '/js/jquery.ui.datepicker.js' );
        $view->headScript()->appendFile ( '/js/jquery.ui.core.js' );
        $view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
        $view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
        $view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' );
        date_default_timezone_set('Asia/Ho_Chi_Minh');
        
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );
        $this->view->username = $aNamespace->username;
		$this->view->fullname = $aNamespace->fullname;
		$this->view->isAdmin = $aNamespace->isAdmin;
	}
    
	public function indexAction()
	{
	    $txtSearch = $this->_getParam('txtSearch','');
		$where = '';
		if($txtSearch) $where = ' job_title like "%'. $txtSearch .'%"';
		
		$rowPerPage = $this->_getParam('rowperpage', 20);
	    $currentPage = 1;
		$page = $this->_getParam('page', 1);
		if(!empty($page)) {
			$currentPage = $page;
		}
	    $vacancy = new Default_Model_VacancyMapper();
	    $listVacancy = $vacancy->getListVacancy($where);	
		$paginator = Zend_Paginator::factory($listVacancy);
		$paginator->setItemCountPerPage($rowPerPage);
		$paginator->setCurrentPageNumber($currentPage);
	    
	    $this->view->paginator = $paginator;
	    $this->view->txtSearch =$txtSearch;
	}
	
	public function addVacancyAction()
	{
		$this->view->title = 'ADD VACANCY';
		$vacancy_id = $this->_getParam('vacancy_id','');
		
		$vacancy = new Default_Model_Vacancy();
		$vacancyMapper = new Default_Model_VacancyMapper();
		if($vacancy_id)
		{	
			$this->view->title = 'EDIT VACANCY';		
			$vacancyMapper->find($vacancy_id, $vacancy);

		}
		
		$this->view->vacancy = $vacancy;
	}
	
	public function viewVacancyAction()
	{
		$this->_helper->layout->disableLayout();
		$vacancy_id = $this->_getParam('vacancy_id','');
		$vacancyMapper = new Default_Model_VacancyMapper();
		$vacancyMapper->find($vacancy_id, $vacancy = new Default_Model_Vacancy());
		$this->view->vacancy = $vacancy;
		$this->render('view-vacancy');
	}
	
	public function saveVacancyAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		 $post = $this->getRequest()->getPost();

		 $vacancy = new Default_Model_Vacancy();

		 $vacancy->setVacancyId($post['vacancy_id']);
		 $vacancy->setCompanyName($post['company_name']);
		 $vacancy->setJobTitle($post['job_title']);
		 $vacancy->setMinSalary(intval($post['min_salary']));
		 $vacancy->setMaxSalary(intval($post['max_salary']));
		 $vacancy->setWorkLevel($post['work_level']);
		 $vacancy->setFunction($post['function']);
		 $vacancy->setLocation($post['location']);
		 $vacancy->setDescReqs($post['desc_reqs']);
		 $vacancy->setCreatedDate(date('Y-m-d'));
		 $vacancy->setUpdatedDate(date('Y-m-d'));
		 $vacancy->setCreatedConsultantId($aNamespace->consultant_id);
		 $vacancy->setUpdatedConsultantId($aNamespace->consultant_id);
		 
		 $vacancyMapper = new Default_Model_VacancyMapper();
		 $vacancyMapper->save($vacancy);
		 
		 $this->_redirect('/vacancy');
	}
	
	public function deleteVacancyAction()
	{
	    $vacancyMapper = new Default_Model_VacancyMapper();
	    $listid = $this->getRequest()->getParam('listid', 0);
        $vacancyMapper->deleteListVacancy($listid);
	    
	    $listVacancy = $vacancyMapper->getListVacancy();	
		$paginator = Zend_Paginator::factory($listVacancy);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber(1);
	    
		$this->view->paginator = $paginator;
        $this->_helper->layout->disableLayout();
	    $this->render('list-vacancy');
	}
	
	public function saveCommentAction()
	{
		$post = $this->getRequest()->getPost();

		$vacancyMapper = new Default_Model_VacancyMapper();
		$vacancyMapper->insertComment($post);

		$comment = $vacancyMapper->getComments($post['vacancy_id'], 1);
		$date = new DateTime($comment['created_date']);
		$createdComment = $date->format('M-d');

		//$html = '<p class="update-date">Comment '. $createdComment .'</p> <span>by</span> <span class="user-name">'. $comment['username'] . '</span>';
		$html = '<p>- ' . substr($comment['content'], 0, 90) . '</p>';
		//$html .= '<a href="#allcomment" class="allcomment" id="'.  $post['company_id'] .'" onClick="allComment('.  $post['company_id'] .')">view all</a>';
		echo $html;
		exit;
	}

	public function allCommentAction()
	{
	    $post = $this->getRequest()->getPost();

		$vacancyMapper = new Default_Model_VacancyMapper();
		$comments = $vacancyMapper->getComments($post['vacancy_id']);

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
	}
}