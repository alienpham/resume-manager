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
	
	public function delete($where) {
		$this->getDbTable ()->delete($where);
	}
	
	public function save (Default_Model_Experience $experience)
    {
        $data = array(
			'resume_id' 	=> $experience->getResumeId(), 
			'start_date' 	=> $experience->getStartDate(), 
			'end_date' 		=> $experience->getEndDate(), 
			'job_title' 	=> $experience->getJobTitle(),
        	'company_name' 	=> $experience->getCompanyName(),
        	'duties' 		=> $experience->getDuties(),
        	'sort_order' 	=> $experience->getSortOrder()        	
		);
		
    	if (null == ($id = $experience->getId())) {
            return $this->getDbTable()->insert($data);
        } else {      	
            $this->getDbTable()->update($data, array('res_experience_id = ?' => $id));
            return $id;
        }
    }
	
	public function find ($id, Default_Model_Experience $experience)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        
        $experience->setId($row->res_experience_id);
		$experience->setResumeId($row->resume_id);
		$experience->setStartDate($row->start_date);
		$experience->setEndDate($row->end_date);
		$experience->setJobTitle($row->job_title);
		$experience->setCompanyName($row->company_name);
		$experience->setDuties($row->duties);
		$experience->setExperienceOther($row->experience_other);
		$experience->setSortOrder($row->sort_order);      
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        $entries = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Experience();
            $entry->setId($row->res_experience_id);
            $entry->setResumeId($row->resume_id);
			$entry->setStartDate($row->start_date);
			$entry->setEndDate($row->end_date);
			$entry->setJobTitle($row->job_title);
			$entry->setCompanyName($row->company_name);
			$entry->setDuties($row->duties);
			$entry->setExperienceOther($row->experience_other);
			$entry->setSortOrder($row->sort_order);  
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getFunction() 
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = 'SELECT * FROM function_lookup ';
        $result = $db->fetchAll($sql);
        
        return $db->fetchAll($sql);
    }
    
    public function saveExperFunction($experienceId, $functionId)
    {
        $db = $this->getDbTable()->getAdapter();
       
        $sql = "INSERT INTO res_experience_has_function(res_experience_id, function_id) VALUES ($experienceId, $functionId)";
        return $db->query($sql);
    }
    
    public function delExperFunction($experienceId)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "DELETE FROM res_experience_has_function WHERE res_experience_id = " . $experienceId;
        return $db->query($sql); 
    }
    
    public function getExperFunction($experienceId) 
    {
        $sql = "SELECT exper.function_id, f.name FROM res_experience_has_function as exper ";
        $sql .= "INNER JOIN function_lookup as f ON exper.function_id = f.function_id ";
        $sql .= "WHERE res_experience_id = " . $experienceId;

        $rows = $this->getDbTable()->getAdapter()->query($sql)->fetchAll();
        return $rows;
    }
    
    public function saveExperienceOther($resumeId, $other)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "INSERT INTO res_experience(resume_id, experience_other) VALUES($resumeId, '". addslashes($other) ."') ";
//echo $sql;exit;
        return $db->query($sql); 
    }
}
?>