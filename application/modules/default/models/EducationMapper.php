<?php
class Default_Model_EducationMapper {
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
            $this->setDbTable('Default_Model_DbTable_Education');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function delete($where) {
		$this->getDbTable ()->delete($where);
	}
	
	public function save (Default_Model_Education $education)
    {
        $data = array(
			'resume_id' 	=> $education->getResumeId(), 
			'start_date' 	=> $education->getStartDate(), 
			'end_date' 		=> $education->getEndDate(), 
			'school_name' 	=> $education->getSchoolName(),
        	'program_name' 	=> $education->getProgramName(),
        	'program_info' 	=> $education->getProgramInfo(),
        	'sort_order' 	=> $education->getSortOrder()        	
		);
		
    	if (null == ($id = $education->getEducationId())) {
            return $this->getDbTable()->insert($data);
        } else {      	
            $this->getDbTable()->update($data, array('res_education_id = ?' => $id));
            return $id;
        }
    }
	
	public function find ($id, Default_Model_Education $education)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        
        $education->setEducationId($row->res_education_id);
		$education->setResumeId($row->resume_id);
		$education->setStartDate($row->start_date);
		$education->setEndDate($row->end_date);
		$education->setSchoolName($row->school_name);
		$education->setProgramName($row->program_name);
		$education->setProgramInfo($row->program_info);
		$education->setSortOrder($row->sort_order);      
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
//print_r($resultSet);exit;
        $entries = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Education();
            $entry->setEducationId($row->res_education_id);
            $entry->setResumeId($row->resume_id);
			$entry->setStartDate($row->start_date);
			$entry->setEndDate($row->end_date);
			$entry->setSchoolName($row->school_name);
			$entry->setProgramName($row->program_name);
			$entry->setProgramInfo($row->program_info);
			$entry->setSortOrder($row->sort_order);  
            $entries[] = $entry;
        }
        return $entries;
    }
       
}
?>