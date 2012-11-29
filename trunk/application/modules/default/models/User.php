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

    public function fetchAll($where)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT * FROM consultant WHERE ";
        $sql .= "$where";
		return $db->fetchAll($sql);
    	
    }
    
    public function checkLogin($username, $pass)
	{
	    $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT * FROM consultant WHERE ";
        $sql .= "(username = '" .$username. "' or email = '" .$username. "') ";
        $sql .= "and password = '" . md5($pass) . "'";
        $sql .= "and status = 'Active'";
		return $db->fetchRow($sql);
	}

    public function getConsultantName ($id)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT username, full_name FROM consultant WHERE consultant_id = " . $id;
        return $db->fetchRow($sql);
    }
    
 	public function saveUser ($data)
    {
        $db = $this->getDbTable()->getAdapter();
        //print_r($data);
          
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
       
        return $db->query($sql);
    }
    
    public function editUser($data, $id)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "UPDATE consultant SET ";
        $sql .= "full_name = '" .$data['full_name'] ."',";
        $sql .= "username = '" .$data['username'] ."',";
        $sql .= "job_title = '" .$data['job_title'] ."',";
        $sql .= "phone = '" .$data['tel'] ."',";
        $sql .= "email = '" .$data['email'] ."' ";
        $sql .= "WHERE consultant_id = " .$id;
    	return $db->query($sql);
    }
    
    public function getUser($id)
    {	
	    $db = $this->getDbTable()->getAdapter();
	    $sql = "SELECT * FROM consultant WHERE consultant_id = " . $id;
	    $result = $db->fetchRow($sql);
	    return $result;	
    }
    
    public function changePassword($password, $id)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "UPDATE consultant SET password = " ."'" .md5($password)."' WHERE consultant_id = " . $id;
    	return $db->query($sql);
    }
   
    public function updateStatusUser($status, $id) {
		$db = $this->getDbTable()->getAdapter();
        $sql = 'UPDATE consultant SET status = "'. $status .'" WHERE consultant_id = '. $id;
       // echo $sql;exit;
        $db->query($sql);
	}
}
?>