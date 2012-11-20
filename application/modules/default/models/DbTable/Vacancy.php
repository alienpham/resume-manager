<?php
require_once 'Zend/Db/Table/Abstract.php';
class Default_Model_DbTable_Vacancy extends Zend_Db_Table_Abstract {
	/**
	 * The default table name
	 */
	protected $_name = 'vacancy';
	protected $_primary  = 'vacancy_id';
}