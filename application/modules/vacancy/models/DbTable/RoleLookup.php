<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_RoleLookup extends Zend_Db_Table_Abstract
{
	/**
	 * The default table name
	 */
	protected $_name = 'role_lookup';
	protected $_primary  = 'role_id';
}
