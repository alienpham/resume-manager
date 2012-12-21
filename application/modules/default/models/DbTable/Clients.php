<?php
require_once 'Zend/Db/Table/Abstract.php';
class Default_Model_DbTable_Clients extends Zend_Db_Table_Abstract {
	/**
	 * The default table name
	 */
	protected $_name = 'clients';
	protected $_primary  = 'id';
}