<?php
class Default_Model_VacancyMapper {
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
            $this->setDbTable('Default_Model_DbTable_Vacancy');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Vacancy $vacancy)
    {
        $data = array(
			'vacancy_id' 		=> $vacancy->getVacancyId(), 
        	'company_name' 		=> $vacancy->getCompanyName(), 
        	'job_title' 		=> $vacancy->getJobTitle(), 
			'min_salary' 		=> $vacancy->getMinSalary(),
        	'max_salary' 		=> $vacancy->getMaxSalary(),
            'priority'			=> $vacancy->getPriority(), 
        	'work_level' 	    => $vacancy->getWorkLevel(), 
			'function' 			=> $vacancy->getFunction(),
        	'location' 			=> $vacancy->getLocation(), 
        	'desc_reqs'			=> $vacancy->getDescReqs(),
        	'created_date' 		=> $vacancy->getCreatedDate(), 
			'updated_date' 		=> $vacancy->getUpdatedDate()
		);
		
    	if (null == ($id = $vacancy->getVacancyId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('vacancy_id = ?' => $id));
            return $id;
        }
    }
    
    public function find ($id, Default_Model_Vacancy $vacancy)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
            
            $vacancy->setCompanyName($row['company_name']);
            $vacancy->setVacancyId($row['vacancy_id']);
            $vacancy->setPriority($row['priority']);
            $vacancy->setJobTitle($row['job_title']);
            $vacancy->setMinSalary($row['min_salary']);
            $vacancy->setMaxSalary($row['max_salary']);
            $vacancy->setWorkLevel($row['work_level']);
            $vacancy->setFunction($row['function']);
            $vacancy->setLocation($row['location']);
            $vacancy->setDescReqs($row['desc_reqs']);
            $vacancy->setCreatedDate($row['created_date']);
            $vacancy->setUpdatedDate($row['updated_date']);
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Vacancy();
        foreach ($resultSet as $row) {
            $entry->setVacancyId($row['vacancy_id']);
            $entry->setCompanyName($row['company_name']);
            $entry->setJobTitle($row['job_title']);
            $entry->setMinSalary($row['min_salary']);
            $entry->setMaxSalary($row['max_salary']);
            $entry->setPriority($row['priority']);
            $entry->setWorkLevel($row['work_level']);
            $entry->setLocation($row['location']);
            $entry->setFunction($row['fuction']);
            $entry->setDescReqs($row['desc_reqs']);
            $entry->setCreatedDate($row['created_date']);
            $entry->setUpdatedDate($row['updated_date']);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListVacancy($where='')
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT * FROM vacancy ";
    	if($where!='') $sql .= "WHERE " . $where;
    	$rows =  $db->fetchAll($sql);
    	return $rows;
    }

}
