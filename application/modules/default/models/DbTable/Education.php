<?php
require_once 'Zend/Db/Table/Abstract.php';
class Default_Model_DbTable_Education extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'res_education';
	protected $_primary  = 'res_education_id';
}
