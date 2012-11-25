<?php
class Default_Model_VacancyMapper {
	protected $_dbTable;
	var $htmlstr;
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
        	'job_title' 		=> $vacancy->getJobTitle(), 
			'min_salary' 		=> $vacancy->getMinSalary(),
        	'max_salary' 		=> $vacancy->getMaxSalary(),
            'priority'			=> $vacancy->getPriority(), 
        	'work_level' 	    => $vacancy->getWorkLevel(), 
			'function' 			=> $vacancy->getFunction(),
        	'localtion' 		=> $vacancy->getLocation(), 
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
            
            $vacancy->getPriority('priority');
            $vacancy->setJobTitle('job_title');
            $vacancy->setMinSalary('min_salary');
            $vacancy->setMaxSalary('max_salary');
            $vacancy->setWorkLevel('work_level');
            $vacancy->setFunction('function');
            $vacancy->setLocation('location');
            $vacancy->setDescReqs('desc_reqs');
            $vacancy->setCreatedDate('created_date');
            $vacancy->setUpdatedDate('updated_date');
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Vacancy();
        foreach ($resultSet as $row) {
            $entry->setVacancyId('vacancy_id');
            $entry->setJobTitle('job_title');
            $entry->setMinSalary('min_salary');
            $entry->setMaxSalary('max_salary');
            $entry->setPriority('priority');
            $entry->setWorkLevel('work_level');
            $entry->setLocation('location');
            $entry->setFunction('fuction');
            $entry->setDescReqs('desc_reqs');
            $entry->setCreatedDate('created_date');
            $entry->setUpdatedDate('updated_date');
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListVacancy()
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT * FROM vacancy";
    	$rows = $rows = $db->fetchAll($sql);
    	return $rows;
    }
}
