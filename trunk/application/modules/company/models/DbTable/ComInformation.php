<?php
require_once 'Zend/Db/Table/Abstract.php';
class Company_Model_DbTable_ComInformation extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'com_information';
	protected $_primary  = 'com_information_id';
}
