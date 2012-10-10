<?php
class Company_Model_ComInformationMapper {
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
            $this->setDbTable('Company_Model_DbTable_ComInformation');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Company_Model_ComInformation $cominformation)
    {
        $data = array(
			'company_id' 	=> $cominformation->getCompanyId(), 
			'apply_to' 		=> $cominformation->getApplyTo(), 
			'content' 		=> $cominformation->getContent()
		);
//print_r($data); exit;    

			
		return $this->getDbTable()->insert($data);
    }
	
	public function find ($id, Company_Model_ComInformation $company)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        $company ->setCompanyId($row->company_id);
		$company ->setApplyTo($row->apply_to);
		$company ->setContent($row->content);
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Company_Model_ComInformation();
        foreach ($resultSet as $row) {
            $entry->setCompanyId($row->company_id);
			$entry->setApplyTo($row->apply_to);
			$entry->setContent($row->content);
            $entries[] = $entry;
        }
        return $entries;
    }
    
}
