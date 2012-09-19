<?php
class Default_Model_ExperienceMapper {
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
            $this->setDbTable('Default_Model_DbTable_Experience');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Experience $experience)
    {
        $data = array(
			'resume_id' 	=> $experience->getResumeId(), 
			'start_date' 	=> $experience->getStartDate(), 
			'end_date' 		=> $experience->getEndDate(), 
			'job_title' 	=> $experience->getJobTitle(),
        	'company_name' 	=> $experience->getCompanyName(),
        	'info' 			=> $experience->getInfo(),
        	'sort_order' 	=> $experience->getSortOrder()        	
		);

		return $this->getDbTable()->insert($data);
    }
	
	public function find ($id, Default_Model_Experience $experience)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        
        $experience->setExperienceId($row->id)
        		->setResumeId($row->resume_id)
				->setResumeId($row->start_date)
				->setStartDate($row->end_date)
				->setEndDate($row->job_title)
				->setJobTitle($row->company_name)
				->setCompanyName($row->info)
				->setInfo($row->sort_order);      
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Resume();
            $entry->setExperienceId($row->id)
	        		->setResumeId($row->resume_id)
					->setResumeId($row->start_date)
					->setStartDate($row->end_date)
					->setEndDate($row->job_title)
					->setJobTitle($row->company_name)
					->setCompanyName($row->info)
					->setInfo($row->sort_order);
            $entries[] = $entry;
        }
        return $entries;
    }
}
?>