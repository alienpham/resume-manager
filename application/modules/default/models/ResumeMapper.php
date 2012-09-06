<?php
class Default_Model_ResumeMapper {
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
            $this->setDbTable('Application_Model_DbTable_Pages');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Resume $resume)
    {
        $data = array(
			'resume_id' => $resume->getResumeId(), 
			'resume_code' => $resume->getResumeCode(), 
			'full_name' => $resume->getFullName(), 
			'birthday' => $resume->getBirthday(), 
			'gender' => $resume->getGender()
		);
        
        $this->getDbTable()->insert($data);
    }
	
	public function find ($id, Default_Model_Resume $resume)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        
        $resume->setResumeId($row->resume_id)
				->setResumeCode($row->resume_code)
				->setFullName($row->full_name)
				->setBirthday($row->birthday)
				->setGender($row->gender);
    }
	
	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Resume();
            $entry->setResumeId($row->resume_id)
					->setResumeCode($row->resume_code)
					->setFullName($row->full_name)
					->setBirthday($row->birthday)
					->setGender($row->gender);
            $entries[] = $entry;
        }
        return $entries;
    }
}
?>