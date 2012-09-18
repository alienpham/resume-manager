<?php
require_once 'Zend/Db/Table/Abstract.php';
class Default_Model_DbTable_Experience extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'res_experience1';
	protected $_primary  = 'experience_id';
}
