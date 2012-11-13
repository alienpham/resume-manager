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

    public function checkLogin($username, $pass)
	{
	    $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT * FROM consultant WHERE (username = '" .$username. "' or email = '" .$username. "') and password = '" . md5($pass) . "'";
		return $db->fetchRow($sql);
	}

    public function getConsultantName ($id)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT username FROM consultant WHERE consultant_id = " . $id;
        return $db->fetchRow($sql);
    }
    
 	public function saveUser ($data)
    {
        $db = $this->getDbTable()->getAdapter();
        //print_r($data);
        $sql = "SELECT * FROM consultant WHERE consultant_id = " .$data['consultant_id'];
        $result = $db->query($sql)->rowCount();
   
        if($result == 0)
        {
	        $sql = "INSERT INTO consultant (`title`, `full_name`, `job_title`, `phone`, `username`, `email`, `password`, `created_date`, `updated_date`) VALUES (";
			$sql .= "'" .$data['title'] . "',";
			$sql .= "'" .$data['full_name'] . "',";
			$sql .= "'" .$data['job_title'] . "',";
			$sql .= "'" .$data['tel'] . "',";
			$sql .= "'" .$data['username'] . "',";
			$sql .= "'" .$data['email'] . "',";
			$sql .= "'" .md5($data['password']) . "',";
			$sql .= "now(),";
			$sql .= "now()";	
	        $sql .= ")";
        }
        else
        {
        	$sql = "UPDATE consultant SET  
        			full_name = " ."'" .$data['full_name'] ."',
        	 		job_title = " ."'" .$data['job_title'] ."',
        	 		phone = " .$data['tel'] .",
        	 		username = " ."'" .$data['username'] ."',
        	 		email = " ."'" .$data['email'] ."'  
        			WHERE consultant_id = " .$data['consultant_id'];
        }
        return $db->query($sql);
    }
    
    public function getUser($id)
    {	
	    $db = $this->getDbTable()->getAdapter();
	    $sql = "SELECT * FROM consultant WHERE consultant_id = " . $id;
	    $result = $db->fetchRow($sql);
	    return $result;	
    }
    
    public function viewProfileAction()
    {
    	$data = $this->getRequest()->getPost();
		$id = $this-> _getParam('id',"");
    	$user = new Default_Model_User();
    	$db = $this->getDbTable()->getAdapter();
    	
    }
}
?>