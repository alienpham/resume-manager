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
			'company_id' 		=> $vacancy->getCompanyId(), 
			'vacancy_code' 		=> $vacancy->getVacancyCode(), 
        	'job_title' 		=> $vacancy->getJobTitle(), 
			'min_salary' 		=> $vacancy->getMinSalary(),
        	'max_salary' 		=> $vacancy->getMaxSalary(), 
        	'work_level' 	    => $vacancy->getWorkLevel(), 
			'public' 			=> $vacancy->getPublic(), 
			'status' 			=> $vacancy->getStatus(),
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
            $vacancy ->setCompanyId($row->company_id);
            $vacancy->SetCompanyId(company_id);
            $vacancy->setJobTitle('job_title');
            $vacancy->setMinSalary('min_salary');
            $vacancy->setMaxSalary('max_salary');
            $vacancy->setWorkLevel('work_level');
            $vacancy->setPublic('public');
            $vacancy->setStatus('status');
            $vacancy->setCreatedDate('created_date');
            $vacancy->setUpdatedDate('updated_date');
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Vacancy();
        foreach ($resultSet as $row) {
            $entry ->setCompanyId($row->company_id);
            $entry->SetCompanyId(company_id);
            $entry->setJobTitle('job_title');
            $entry->setMinSalary('min_salary');
            $entry->setMaxSalary('max_salary');
            $entry->setWorkLevel('work_level');
            $entry->setPublic('public');
            $entry->setStatus('status');
            $entry->setCreatedDate('created_date');
            $entry->setUpdatedDate('updated_date');
            $entries[] = $entry;
        }
        return $entries;
    }
}
