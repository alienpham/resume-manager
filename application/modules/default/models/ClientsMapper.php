<?php
class Default_Model_ClientsMapper {
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
            $this->setDbTable('Default_Model_DbTable_Clients');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Clients $clients)
    {
        $data = array(
        	'name' 			=> $clients->getName(), 
        	'birthday' 		=> $clients->getBirthday(), 
			'email' 		=> $clients->getEmail(),
        	'phone' 		=> $clients->getPhone(),
        	'point' 	    => $clients->getPoint(), 
			'consultant' 	=> $clients->getConsultant()
		);
//print_r($clients);exit;
    	if (null == ($id = $clients->getId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('id = ?' => $id));
            return $id;
        }
    }
    
    public function find ($id, Default_Model_Clients $clients)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
		$clients->setId($row['id']);
		$clients->setName($row['name']);
		$clients->setBirthday($row['birthday']);
		$clients->setEmail($row['email']);
		$clients->setPhone($row['phone']);
		$clients->setPoint($row['point']);
		$clients->setConsultant($row['consultant']);
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Clients();
        foreach ($resultSet as $row) {
			$entry->getId($row['id']);
			$entry->getName($row['name']);
			$entry->setBirthday($row['birthday']);
			$entry->setEmail($row['email']);
			$entry->setPhone($row['phone']);
			$entry->setPoint($row['point']);
			$entry->setConsultant($row['consultant']);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListClient($where='')
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT * FROM clients ";
    	if($where!='') $sql .= "WHERE " . $where;

    	$rows =  $db->fetchAll($sql);
    	return $rows;
    }
	
	public function deleteListClient($listId)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = 'DELETE FROM clients WHERE id in ('. $listId .')';
        $db->query($sql);
    }
	
	public function getComments($clientId, $limit=null)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT cc.*, c.full_name, c.username FROM clients_comment AS cc ";
        $sql .= "INNER JOIN consultant AS c ON c.consultant_id = cc.consultant_id";
        $sql .= " WHERE cc.client_id = " . $clientId;
        $sql .= " ORDER BY cc.id DESC ";

		if($limit) {
		    $sql .= "LIMIT 1";
		    return $db->fetchRow($sql);
		} 
		
        return $db->fetchAll($sql);
    }
    
    public function insertComment($data)
    {
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
        $db = $this->getDbTable()->getAdapter();
        $sql = "INSERT INTO clients_comment(client_id, consultant_id, content) VALUES (";
		$sql .= $data['client_id'] . ",";
		$sql .= $aNamespace->consultant_id . ",";
		$sql .= "'" . @$data['content'] . "');";
	
        $db->query($sql);
    }
}
