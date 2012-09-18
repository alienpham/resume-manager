<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_WorkLevelLookup extends Zend_Db_Table_Abstract
{
	/**
	 * The default table name
	 */
	protected $_name = 'work_level_lookup';
	protected $_primary  = 'work_level_id';
}
