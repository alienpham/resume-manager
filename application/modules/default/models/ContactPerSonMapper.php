<?php
class Default_Model_ContactPersonMapper {
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
            $this->setDbTable('Default_Model_DbTable_ContactPerson');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_ContactPerson $contactperson)
    {
        $data = array(
			'company_id' 	=> $contactperson->getCompanyId(), 
			'title' 		=> $contactperson->getTitle(), 
			'full_name' 	=> $contactperson->getFullName(),
        	'job_title' 	=> $contactperson->getJobTitle(), 
			'mobile' 		=> $contactperson->getMobile(),
			'email' 		=> $contactperson->getEmail(), 
		);
		
    	if (null == ($id = $contactperson->getContactPersonId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('contact_person_id = ?' => $id));
            return $id;
        }
    }
    
	public function find ($id, Default_Model_ContactPerson $contactperson)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        
        $row = $result->current();
		$contactperson->setContactPersonId($row['contact_person_id']);
		$contactperson->setCompanyId($row['company_id']); 
		$contactperson->setTitle($row['title']); 
		$contactperson->setFullName($row['full_name']);
		$contactperson->setJobTitle($row['job_title']); 
		$contactperson->setMobile($row['mobile']);
		$contactperson->setEmail($row['email']);
	}


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Company();
        foreach ($resultSet as $row) {
			$entry->getContactPersonId($row['contact_person_id']);
            $entry->getCompanyId($row['company_id']); 
			$entry->setTitle($row['title']); 
			$entry->setFullName($row['full_name']);
			$entry->setJobTitle($row['job_title']); 
			$entry->setMobile($row['mobile']);
			$entry->setEmail($row['email']);
            $entries[] = $entry;
        }
		
        return $entries;
    }
}
