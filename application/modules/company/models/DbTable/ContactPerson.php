<?php
require_once 'Zend/Db/Table/Abstract.php';
class Company_Model_DbTable_ContactPerson extends Zend_Db_Table_Abstract
{
    /**
     * The default table name 
     */
    protected $_name = 'contact_person';
	protected $_primary  = 'contact_person_id';
}
