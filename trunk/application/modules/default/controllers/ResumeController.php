<?php

class ResumeController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
		$test = new Default_Model_Test();
		$test->demo();
		
		$this->view->number = 123456;
		$this->view->name = 'phan duy canh';		
    }
    
	
	public function personalInfoAction()
    {
		//$this->_redirect('resume/experience');
    }
	
	public function saveResumeAction()
    {

		$resumeRowset = new Default_Model_Resume();
			
		$resumeRowset->setResumeCode('R-01');
		$resumeRowset->setFullName('Phan Duy Canh');
		$resumeRowset->setBirthday('1985-07-25');
		$resumeRowset->setGender('Male');
	
		$resume = new Default_Model_ResumeMapper();
		$resume->save($resumeRowset);
echo 1773319991;exit;
		//$this->_redirect('resume/experience');
		echo 111;
		exit;
    }
    
	public function experienceAction()
    {
		
    }
}

