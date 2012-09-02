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
    }
	
	public function testAction()
    {
		echo 2223343;exit;
    }
}

