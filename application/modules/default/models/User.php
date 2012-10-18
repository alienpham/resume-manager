<?php
class Default_Model_User {
	protected $_dbTable;
    public function setDbTable ($dbTable)
    {
        if (is_string($dbTable)) {
            $dbTable = new $dbTable();
        }
        if (! $dbTable instanceof Zend_Db_Table_Abstract) {
            throw new Exception('Invalid table data gateway provided');
        }
        $this->_dbTable = $dbTable;
        return $this;
    }
    public function getDbTable ()
    {
        if (null === $this->_dbTable) {
            $this->setDbTable('Default_Model_DbTable_User');
        }
        return $this->_dbTable;
    }
    
    public function checkLogin($email, $pass)
	{
	    $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT * FROM consultant WHERE email = '" .$email. "' and password = '" . md5($pass) . "'";
        return $db->fetchRow($sql);
	}
	
    public function getConsultantName ($id)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT username FROM consultant WHERE consultant_id = " . $id;
        return $db->fetchRow($sql);
    }
}
?>