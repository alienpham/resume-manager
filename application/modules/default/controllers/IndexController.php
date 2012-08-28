<?php

class IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
		$test = new Default_Model_Test();
		$test->demo();
		echo 2223343;
    }

	public function testAction()
    {
		echo 2223343;exit;
    }

}

