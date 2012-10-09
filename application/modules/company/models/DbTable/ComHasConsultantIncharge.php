<?php
require_once 'Zend/Db/Table/Abstract.php';
class Company_Model_DbTable_ComHasConsultantIncharge extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'com_has_consultant_incharge';
	protected $_primary  = 'com_consultant_incharge_id';
}