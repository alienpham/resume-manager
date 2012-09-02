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
		$this->_redirect('resume/experience');
    }
    
	public function experienceAction()
    {
		
    }
}

