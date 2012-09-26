<?php
class Default_Model_ExpectationMapper {
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
            $this->setDbTable('Default_Model_DbTable_Expectation');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Expectation $expectation)
    {
        $data = array(
			'resume_id' 			=> $expectation->getResumeId(), 
			'estimated_salary_to' 	=> $expectation->getEstimatedSalaryTo(), 
			'estimated_salary_from' => $expectation->getEstimatedSalaryFrom(), 
			'current_salary' 		=> $expectation->getCurrentSalary()
		);
		
        if (null == ($id = $expectation->getResExpectationId())) {
            return $this->getDbTable()->insert($data);
        } else {
            $this->getDbTable()->update($data, array('res_expectation_id = ?' => $id));
            return $id;
        }
    }
	
	public function find ($resumeid, Default_Model_Expectation $expectation)
    {
        $row = $this->getDbTable()->fetchRow(array('resume_id = ?' => $resumeid));        
        if (0 == count($row)) {
            return;
        }
        //$row = $result->current();

        $expectation->setResExpectationId($row['res_expectation_id']);
		$expectation->setResumeId($row['resume_id']);
		$expectation->setEstimatedSalaryTo($row['estimated_salary_to']);
		$expectation->setEstimatedSalaryFrom($row['estimated_salary_from']);
		$expectation->setCurrentSalary($row['current_salary']);   
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        $entries = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Expectation();
            $entry->setResExpectationId($row->res_expectation_id);
            $entry->setResumeId($row->resume_id);
			$entry->setEstimatedSalaryTo($row->estimated_salary_to);
			$entry->setEstimatedSalaryFrom($row->estimated_salary_from);
			$entry->setCurrentSalary($row->current_salary);
            $entries[] = $entry;
        }
        
        return $entries;
    }
    
    public function saveExProvince($expectationId, $provinceId)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "INSERT INTO res_expectation_has_location(res_expectation_id, province_id) VALUES ($expectationId, $provinceId)";
        return $db->query($sql);
    }
    
    public function getExpectation($resumeid) 
    {
        $row = $this->getDbTable()->fetchRow(array('resume_id = ?' => $resumeid)); 
        return $row;
    }
}
?>