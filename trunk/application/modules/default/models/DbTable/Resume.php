<?php
require_once 'Zend/Db/Table/Abstract.php';
class Default_Model_DbTable_Resume extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'resume1';
	protected $_primary  = 'resume_id';
}
