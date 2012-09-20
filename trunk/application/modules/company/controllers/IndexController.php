<?php

class Company_IndexController extends Zend_Controller_Action
{

	public function init()
	{
		/* Initialize action controller here */
	}

	public function indexAction()
	{
		// To do
		$rsComapny = new Company_Model_CompanyMapper();
		
		//$l=$rsComapny->find(1);
		try{
			print_r($rsComapny->fetchAll());
		}catch(Exception $e){echo $e;}
	}


}

