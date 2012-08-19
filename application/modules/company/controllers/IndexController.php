<?php

class Company_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
		$test = new Company_Model_Test();
		$test->demo();
		echo "this is module company";
    }


}

