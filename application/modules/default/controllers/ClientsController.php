<?php
class ClientsController extends Zend_Controller_Action
{
	public function init()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		if (! isset ( $aNamespace->islogin )) $this->_redirect ( '/user' );
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
		$view = new Zend_View();
		$view->headScript()->appendFile ( '/js/jquery.mousewheel-3.0.6.pack.js' );
		$view->headScript()->appendFile ( '/js/jquery.fancybox.js?v=2.1.0' );
		$view->headLink()->appendStylesheet ( '/js/jquery.fancybox.css?v=2.1.0' ); 
		
	    $txtSearch = $this->_getParam('txtSearch','');
		$where = '';
		if($txtSearch) $where = ' name like "%'. $txtSearch .'%"';
		
		$rowPerPage = $this->_getParam('rowperpage', 20);
	    $currentPage = 1;
		$page = $this->_getParam('page', 1);
		if(!empty($page)) {
			$currentPage = $page;
		}
	    $clients = new Default_Model_ClientsMapper();
	    $listClients = $clients->getListClient($where);	
		$paginator = Zend_Paginator::factory($listClients);
		$paginator->setItemCountPerPage($rowPerPage);
		$paginator->setCurrentPageNumber($currentPage);
	    
	    $this->view->paginator = $paginator;
	    $this->view->txtSearch =$txtSearch;
	}
	
	public function addClientAction()
	{
		$this->view->title = 'ADD CLIENTS';
		$clients_id = $this->_getParam('id','');
		
		$clients = new Default_Model_Clients();
		$clientsMapper = new Default_Model_ClientsMapper();
		if($clients_id)
		{	
			$this->view->title = 'EDIT CLIENTS';		
			$clientsMapper->find($clients_id, $clients);

		}
		
		$this->view->clients = $clients;
	}
	
	public function saveClientAction()
	{
		$aNamespace = new Zend_Session_Namespace ( 'zs_User' );
		 $post = $this->getRequest()->getPost();

		 $clients = new Default_Model_Clients();
		 $clients->setId($post['id']);
		 $clients->setName($post['name']);
		 $clients->setBirthday($post['birthday']);
		 $clients->setEmail($post['email']);
		 $clients->setPhone($post['phone']);
		 $clients->setPoint($post['point']);
		 $clients->setConsultant($post['consultant']);
		 
		 $clientsMapper = new Default_Model_ClientsMapper();
		 $clientsMapper->save($clients);
		 
		 $this->_redirect('/clients');
	}
	
	public function deleteClientsAction()
	{
	    $clientsMapper = new Default_Model_ClientsMapper();
	    $listid = $this->getRequest()->getParam('listid', 0);
        $clientsMapper->deleteListClient($listid);
	    
	    $listVacancy = $clientsMapper->getListClient();	
		$paginator = Zend_Paginator::factory($listVacancy);
		$paginator->setItemCountPerPage(20);
		$paginator->setCurrentPageNumber(1);
	    
		$this->view->paginator = $paginator;
        $this->_helper->layout->disableLayout();
	    $this->render('list-clients');
	}
	
	public function saveCommentAction()
	{
		$post = $this->getRequest()->getPost();
		$clientsMapper = new Default_Model_ClientsMapper();
		$clientsMapper->insertComment($post);

		$comment = $clientsMapper->getComments($post['client_id'], 1);
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
		$baseUrl = $this->getFrontController ()->getBaseUrl ();
		
		$clientsMapper = new Default_Model_ClientsMapper();
		$comments = $clientsMapper->getComments($post['id']);

		$html = '';
		$html .= '<div style="color:#1B7CBD;background-color:#CCC;padding:5px 0px"><b>ALL COMMENT</b></div><br />';
		foreach($comments as $comment) {

			$date = new DateTime($comment['created_date']);
			$createdComment = $date->format('M-d');

			$html .= '<div>';
			$html .= substr($comment['content'], 0, 90);
			$html .= '<img class="deletecomment" id="'. $comment['id'] .'" src="'. $baseUrl .'/images/cross.png" alt="delete comment" style="float:right;cursor:pointer;">';
			$html .= '<div align="right"><span>Comment '. $createdComment .'</span> ';
			$html .= '<span style="color: #70B4E2;">by ' . $comment['username'] . '</span></div>';
			$html .= '<div style="border-top: 1px solid #BCBCBC; margin-top:10px">&nbsp;</div>';
			$html .= '</div>';
		}
		
		$html .= '<script language="javascript">
            $(document).ready(function() {
            	$(".deletecomment").click(function(){
            		$(this).parent().hide();
					var comment_id = $(this).attr("id");
                    $.ajax({
                        url: "/clients/delete-comment",
                        type: "POST",
                        data: { 
                        	comment_id: comment_id
                        },
                        success: function() {
                            
                        }
                    });
                });   
            });  
        </script>';

		echo $html;
		exit;
	}
	
    public function deleteCommentAction()
    {
	    $commentId = $this->_getParam('comment_id','');
	    $clientsMapper = new Default_Model_ClientsMapper();
		$clientsMapper->deleteComment($commentId);
		exit;
	}
}

