<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_Consultant extends Zend_Db_Table_Abstract
{
	/**
	 * The default table name
	 */
	protected $_name = 'consultant';
	protected $_primary  = 'consultant_id';
}
