<?php
class Default_Model_CompanyMapper {
	protected $_dbTable;
    public function setDbTable ($dbTable)
    {
        if (is_string($dbTable)) {
            $dbTable = new Default_Model_DbTable_Company();
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
            $this->setDbTable('Default_Model_DbTable_Company');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Company $company)
    {
        $data = array(
            'company_name' 		=> $company->getCompanyName(), 
            'busines_type' 	    => $company->getBusinesType(),
            'tel' 				=> $company->getTel(),
            'email' 			=> $company->getEmail(),
            'address' 			=> $company->getAddress(),
            'website' 			=> $company->getWebsite(),
            'information'	    => $company->getInformation(),
            'created_date' 		=> $company->getCreatedDate(),
            'updated_date' 		=> $company->getUpdatedDate()
		);
		if (null == ($id = $company->getCompanyId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	unset($data['created_date']);
        	$this->getDbTable()->update($data, array('company_id = ?' => $id));
            return $id;
        }		
    }
	
	public function find ($id, Default_Model_Company $company)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        
        $row = $result->current();
        $company->setCompanyId($row->company_id);
        $company->setCompanyName($row->company_name);
        $company->setBusinesType($row->busines_type);
        $company->setTel($row->tel);
        $company->setEmail($row->email);
        $company->setAddress($row->address);
        $company->setWebsite($row->website);
        $company->setInformation($row->information);
        $company->setCreatedDate($row->created_date);
        $company->setUpdatedDate($row->updated_date);
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Company();
        foreach ($resultSet as $row) {
            $entry->setCompanyId($row->company_id);
			$entry->setCompanyName($row->company_name);
			$entry->setBusinesType($row->busines_type);
			$entry->setTel($row->tel);
			$entry->setEmail($row->email);
			$entry->setAddress($row->address);
			$entry->setWebsite($row->website);
			$entry->setInformation($row->information);
			$entry->setCreatedDate($row->created_date);
			$entry->setUpdatedDate($row->updated_date);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListCompany($where='', $order='')
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT c.*, cp.contact_person_id, cp.title, cp.job_title, cp.full_name, cp.mobile, cp.email as ct_email FROM company as c ";
		$sql .= "LEFT JOIN contact_person as cp ON cp.company_id = c.company_id ";
    	if($where!='') $sql .= 'WHERE ' . $where;
    	$sql .= ' ' . $order;
//echo $sql;exit;
    	$rows = $db->fetchAll($sql);
    	return $rows;
    }
    
    public function getCompany($id)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT c.*, cp.contact_person_id, cp.title, cp.job_title, cp.full_name, cp.mobile, cp.email as ct_email FROM company as c ";
		$sql .= "LEFT JOIN contact_person as cp ON cp.company_id = c.company_id ";
		$sql .= "WHERE c.company_id =" . $id;
    	$rows = $db->fetchRow($sql);
    	return $rows;
    }
    
	public function deleteListCompany($listId)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = 'DELETE FROM company WHERE company_id in ('. $listId .')';
        $db->query($sql);
    }
	
    public function getComments($companyId, $limit=null)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT cc.*, c.full_name, c.username FROM company_comment AS cc ";
        $sql .= "INNER JOIN consultant AS c ON c.consultant_id = cc.consultant_id";
        $sql .= " WHERE cc.company_id = " . $companyId;
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
        $sql = "INSERT INTO company_comment(company_id, consultant_id, content) VALUES (";
		$sql .= $data['company_id'] . ",";
		$sql .= $aNamespace->consultant_id . ",";
		$sql .= "'" . @$data['content'] . "');";
		
        $db->query($sql);
    }
}

