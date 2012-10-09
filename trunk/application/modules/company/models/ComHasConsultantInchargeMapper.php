<?php
class Company_Model_CompanyMapper {
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
            $this->setDbTable('Company_Model_DbTable_ComHasConsultantIncharge');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Company_Model_ComHasConsultantIncharge $comhasconsultantincharge)
    {
        $data = array(
			'company_id' 	=> $comhasconsultantincharge->getCompanyId(), 
			'consultant_id' => $comhasconsultantincharge->getConsultantId(), 
			'action_date' 	=> $comhasconsultantincharge->getActionDate(), 
			'status' 		=> $comhasconsultantincharge->getStatus()
		);
//print_r($data); exit;    

			
		return $this->getDbTable()->insert($data);

		
    }
	
	public function find ($id, Company_Model_ComHasConsultantIncharge $company)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        $company ->setCompanyId($row->company_id)
				 ->setConsultantId($row->consultant_id)
				 ->setActionDate($row->action_date)
				 ->setStatus($row->status);
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Company_Model_ComHasConsultantIncharge();
        foreach ($resultSet as $row) {
            $entry->setCompanyId($row->company_id);
			$entry->setConsultantId($row->company_code);
			$entry->setActionDate($row->full_name_en);
			$entry->setStatus($row->short_name_en);
            $entries[] = $entry;
        }
        return $entries;
    }
    
}
