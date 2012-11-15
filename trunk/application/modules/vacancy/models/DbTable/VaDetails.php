<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_VaDetails extends Zend_Db_Table_Abstract
{
	/**
	 * The default table name
	 */
	protected $_name = 'va_details';
	protected $_primary  = 'va_va_details_id';
}