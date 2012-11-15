<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_VaHasFunction extends Zend_Db_Table_Abstract
{
	/**
	 * The default table name
	 */
	protected $_name = 'va_has_function';
	protected $_primary  = 'va_function_id';
}
