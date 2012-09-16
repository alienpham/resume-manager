<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
	protected function _initDoctype()
	{
		$this->bootstrap('view');
		$view = $this->getResource('view');
		$view->doctype('XHTML1_STRICT');
	}

	/**
	 *
	 * Initialize router
	 */
	protected function _initRewrite() {
		$config = new Zend_Config_Ini(APPLICATION_PATH . '/configs/routes.ini', 'production');

		$objRouter = new Zend_Controller_Router_Rewrite();
		$router = $objRouter->addConfig($config, 'routes');

		$front = Zend_Controller_Front::getInstance();
		$front->setRouter($router);
	}
}