<?php
require_once 'Zend/Db/Table/Abstract.php';
class Default_Model_DbTable_Expectation extends Zend_Db_Table_Abstract
{
    /**
     * The default table name
     */
    protected $_name = 'res_expectation';
	protected $_primary  = 'res_expectation_id';
}
