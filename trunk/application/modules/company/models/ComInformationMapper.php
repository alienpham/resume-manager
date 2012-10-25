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
		
		return $this->getDbTable()->insert($data);
    }
    
	public function updateComInformation($company_id,$content) {
		$db = $this->getDbTable()->getAdapter();
        $sql = "UPDATE com_information SET content = '$content' WHERE company_id = '$company_id'";
        $db->query($sql);
	}
    
	public function find ($id, Company_Model_ComInformation $cominfomation)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        $company ->setCompanyId($row->company_id)
				 ->setApplyTo($row->apply_to)
				 ->setContent($row->content);
    }
}
