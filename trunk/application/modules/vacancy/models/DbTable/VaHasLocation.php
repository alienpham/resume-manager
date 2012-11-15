<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_VaHasLocation extends Zend_Db_Table_Abstract
{
	/**
	 * The default table name
	 */
	protected $_name = 'va_has_location';
	protected $_primary  = 'va_location_id';
}
