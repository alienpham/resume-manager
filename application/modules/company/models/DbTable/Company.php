<?php
require_once 'Zend/Db/Table/Abstract.php';
class Company_Model_DbTable_Company extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'company';
	protected $_primary  = 'company_id';
}
