<?php
require_once 'Zend/Db/Table/Abstract.php';
class Vacancy_Model_DbTable_ConsultantHasRole extends Zend_Db_Table_Abstract {
	/**
	 * The default table name
	 */
	protected $_name = 'consultant_has_role';
	protected $_primary  = 'consultant_role_id';
}