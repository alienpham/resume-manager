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
            //'priority'			=> $vacancy->getPriority(), 
        	'work_level' 	    => $vacancy->getWorkLevel(), 
			'function' 			=> $vacancy->getFunction(),
        	'location' 			=> $vacancy->getLocation(), 
        	'desc_reqs'			=> $vacancy->getDescReqs(),
        	'created_date' 		=> $vacancy->getCreatedDate(), 
			'updated_date' 		=> $vacancy->getUpdatedDate(),
			'created_consultant_id' => $vacancy->getCreatedConsultantId(),
			'updated_consultant_id' => $vacancy->getUpdatedConsultantId()
		);
		
    	if (null == ($id = $vacancy->getVacancyId())) {
            return $this->getDbTable()->insert($data);
        } else {
			unset($data['created_date']);
			unset($data['created_consultant_id']);
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
            //$vacancy->setPriority($row['priority']);
            $vacancy->setJobTitle($row['job_title']);
            $vacancy->setMinSalary($row['min_salary']);
            $vacancy->setMaxSalary($row['max_salary']);
            $vacancy->setWorkLevel($row['work_level']);
            $vacancy->setFunction($row['function']);
            $vacancy->setLocation($row['location']);
            $vacancy->setDescReqs($row['desc_reqs']);
            $vacancy->setCreatedDate($row['created_date']);
            $vacancy->setUpdatedDate($row['updated_date']);
			$vacancy->setCreatedConsultantId($row['created_consultant_id']);
			$vacancy->setUpdatedConsultantId($row['updated_consultant_id']);
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
            //$entry->setPriority($row['priority']);
            $entry->setWorkLevel($row['work_level']);
            $entry->setLocation($row['location']);
            $entry->setFunction($row['fuction']);
            $entry->setDescReqs($row['desc_reqs']);
            $entry->setCreatedDate($row['created_date']);
            $entry->setUpdatedDate($row['updated_date']);
			$entry->setCreatedConsultantId($row['created_consultant_id']);
			$entry->setUpdatedConsultantId($row['updated_consultant_id']);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListVacancy($where='', $choose=0)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT * FROM vacancy as v ";
		if($choose == 2) {
			$sql .= "INNER JOIN consultant AS c ON c.consultant_id = v.created_consultant_id ";
		}
    	if($where!='') $sql .= " WHERE " . $where;
//echo $sql;exit;

		$sql .= " ORDER BY vacancy_id DESC";
    	$rows =  $db->fetchAll($sql);
    	return $rows;
    }
	
	public function deleteListVacancy($listId)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = 'DELETE FROM vacancy WHERE vacancy_id in ('. $listId .')';
        $db->query($sql);
    }
	
	public function getComments($vacancyId, $limit=null)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT cc.*, c.full_name, c.username FROM vacancy_comment AS cc ";
        $sql .= "INNER JOIN consultant AS c ON c.consultant_id = cc.consultant_id";
        $sql .= " WHERE cc.vacancy_id = " . $vacancyId;
        $sql .= " ORDER BY cc.id DESC ";
		if($limit) {
		    $sql .= "LIMIT 1";
		    return $db->fetchRow($sql);
		} 
		
        return $db->fetchAll($sql);
    }
    
    public function insertComment($data)
    {
        $aNamespace = new Zend_Session_Namespace ( 'zs_User' );
        $db = $this->getDbTable()->getAdapter();
        $sql = "INSERT INTO vacancy_comment(vacancy_id, consultant_id, content) VALUES (";
		$sql .= $data['vacancy_id'] . ",";
		$sql .= $aNamespace->consultant_id . ",";
		$sql .= "'" . @$data['content'] . "');";
		
        $db->query($sql);
    }
}
