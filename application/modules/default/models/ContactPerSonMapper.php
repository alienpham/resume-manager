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
			'tel' 			=> $contactperson->getTel(),
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
    
	public function getContact($id)
	{
		$db = $this->getDbTable()->getAdapter();
		$sql = "SELECT * FROM contact_person WHERE contact_person_id = " .$id;
		$rows = $db->fetchAll($sql);
    	return $rows;
		
	}
	
	public function getListContact($id)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT contact_person_id,contact_person.company_id,full_name,title,job_title,contact_person.tel,mobile,contact_person.email,contact_person.address FROM contact_person  INNER JOIN company ON company.company_id = contact_person.company_id WHERE contact_person.company_id = " .$id; 
    	$rows = $db->fetchAll($sql);
    	return $rows;
    }
}
