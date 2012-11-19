<?php
class Company_Model_ContactPersonMapper {
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
            $this->setDbTable('Company_Model_DbTable_ContactPerson');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Company_Model_ContactPerson $contactperson)
    {
        $data = array(
			'company_id' 	=> $contactperson->getCompanyId(), 
			'title' 		=> $contactperson->getTitle(), 
			'full_name' 	=> $contactperson->getFullName(),
        	'job_title' 	=> $contactperson->getJobTitle(), 
			'tel' 			=> $contactperson->getTel(),
        	'fax' 			=> $contactperson->getFax(), 
			'mobile' 		=> $contactperson->getMobile(),
			'email' 		=> $contactperson->getEmail(), 
			'address' 		=> $contactperson->getAddress(),
		);
		
    	if (null == ($id = $contactperson->getContactPersonId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('contact_person_id = ?' => $id));
            return $id;
        }
    }
    
	public function getListContact ($where = null, $orderby = null, $offset="", $limit="")
    {
    	$db = $this->getDbTable()->getAdapter();
    	if ($limit=="")
       		$sql = "SELECT * FROM contact_person WHERE $where ORDER BY $orderby";
       	else 
       		$sql = "SELECT * FROM contact_person WHERE $where ORDER BY $orderby LIMIT $offset,$limit";
       		
        $result = $db->fetchAll($sql);
        
        return $result;
    }
}
