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
            $this->setDbTable('Default_Model_DbTable_Resume');
        }
        return $this->_dbTable;
    }
    
	public function updateResumCode($code, $resumeId) {
		$db = $this->getDbTable()->getAdapter();
        $sql = 'UPDATE resume SET resume_code = "'. $code .'" WHERE resume_id = '. $resumeId;
        $db->query($sql);
	}
	
	public function save (Default_Model_Resume $resume)
    {
        $data = array(
            'resume_code' 	=> $resume->getResumeCode(), 
            'full_name' 	=> $resume->getFullName(), 
            'birthday' 		=> $resume->getBirthday(), 
            'gender' 		=> $resume->getGender(),
            'marital_status'=> $resume->getMaritalStatus(),
            'status' 		=> $resume->getStatus(),
            'email_1' 		=> $resume->getEmail1(),
            'email_2' 		=> $resume->getEmail2(),
            'mobile_1' 		=> $resume->getMobile1(),
            'mobile_2' 		=> $resume->getMobile2(),
            'tel' 			=> $resume->getTel(),
            'address' 		=> $resume->getAddress(),
            'created_date' 	=> $resume->getCreatedDate(),
            'updated_date' 	=> $resume->getUpdatedDate(),
            'created_consultant_id' 	=> $resume->getCreatedConsultantId(),
            'updated_consultant_id' 	=> $resume->getUpdatedConsultantId()
        );
//print_r($data);exit;
        if (null == ($id = $resume->getResumeId())) {
            return $this->getDbTable()->insert($data);
        } else {
            unset($data['created_date']);
            unset($data['created_consultant_id']);
            unset($data['resume_code']);
            $this->getDbTable()->update($data, array('resume_id = ?' => $id));
            return $id;
        }
    }
	
	public function find ($id, Default_Model_Resume $resume)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        
        $resume->setResumeId($row->resume_id);
		$resume->setResumeCode($row->resume_code);
		$resume->setFullName($row->full_name);
		$resume->setBirthday($row->birthday);
		$resume->setGender($row->gender);
		$resume->setMaritalStatus($row->marital_status);
		$resume->setStatus($row->status);
		$resume->setEmail1($row->email_1);
		$resume->setEmail2($row->email_2);
		$resume->setMobile1($row->mobile_1);
		$resume->setMobile2($row->mobile_2);
		$resume->setTel($row->tel);
		$resume->setAddress($row->address);
		$resume->setViewCount($row->view_count);
		$resume->setCreatedDate($row->created_date);
		$resume->setUpdatedDate($row->updated_date);
		$resume->setCreatedConsultantId($row->created_consultant_id);
		$resume->setUpdatedConsultantId($row->updated_consultant_id);
    }


	public function fetchAll ($where = null, $orderby = 'updated_date DESC')
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);

        $entries = array();
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Resume();
            $entry->setResumeId($row->resume_id);
            $entry->setResumeCode($row->resume_code);
            $entry->setFullName($row->full_name);
            $entry->setBirthday($row->birthday);
            $entry->setGender($row->gender);
            $entry->setMaritalStatus($row->marital_status);
            $entry->setStatus($row->status);
            $entry->setEmail1($row->email_1);
            $entry->setEmail2($row->email_2);
            $entry->setMobile1($row->mobile_1);
            $entry->setMobile2($row->mobile_2);
            $entry->setTel($row->tel);
            $entry->setAddress($row->address);
            $entry->setViewCount($row->view_count);
            $entry->setCreatedDate($row->created_date);
            $entry->setUpdatedDate($row->updated_date);
            $entry->setCreatedConsultantId($row->created_consultant_id);
            $entry->setUpdatedConsultantId($row->updated_consultant_id);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListResume($cond = null, $choice = array(), $orderby =' updated_date DESC') 
    {
        $db = $this->getDbTable()->getAdapter();
        $where = '';
        if($cond) {
            $cond = implode(' AND ', $cond);
            $where = ' WHERE ' .$cond;
        }
        
        $join='';
        if(in_array('job_title', $choice) || in_array('company_name', $choice) || in_array('experother', $choice) || in_array('functions', $choice) || in_array('keyword', $choice)) {
            $join .= ' INNER JOIN res_experience as exper ON r.resume_id = exper.resume_id ';
            if(in_array('functions', $choice))
				$join .= ' INNER JOIN res_experience_has_function as exper_fun ON exper.id = exper_fun.res_experience_id ';
        }
        if(in_array('salary', $choice)) {
            $join .= ' INNER JOIN res_expectation as expec ON r.resume_id = expec.resume_id ';
        }
        
        if(in_array('education', $choice)) {
            $join .= ' INNER JOIN res_education as edu ON r.resume_id = edu.resume_id ';
        }
        
        if($orderby) $orderby = ' ORDER BY ' .$orderby;
        $sql = 'SELECT r.*, f.id as file_resume FROM resume as r ';
		$sql .= 'LEFT JOIN res_file as f ON r.resume_id = f.resume_id ';
		$sql .= $join . $where . $orderby;

        echo $sql;//exit;
        $_SESSION['export-email'] = $sql;
        
        return $db->fetchAll($sql);
    }
    
    public function getExportEmail($sql=null)
    {
        $db = $this->getDbTable()->getAdapter();
        if($sql) return $db->fetchAll($sql);
        return false;
    }
	public function getProvince() 
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = 'SELECT * FROM province_lookup ';
        $result = $db->fetchAll($sql);
        
        return $db->fetchAll($sql);
    }
    
    public function countResumeWith($cond)
    {
        $db = $this->getDbTable()->getAdapter();
        if($cond == 'new') $sql = 'SELECT * FROM resume WHERE created_date = CURDATE()';
        if($cond == 'update') $sql = 'SELECT * FROM resume WHERE SUBSTR(updated_date, 1, 10) = CURDATE()';
        if($cond == 'total') $sql = 'SELECT * FROM resume ';
        return $db->query($sql)->rowCount();
    }
	
	public function insertComment($data)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "INSERT INTO res_comment(resume_id, consultant_id, content) VALUES (";
		$sql .= $data['resume_id'] . ",";
		$sql .= "1,";
		$sql .= "'" . @$data['content'] . "');";
		
        $db->query($sql);
    }
    
    public function getComments($resumeId, $limit=null)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT rc.*, c.full_name, c.username FROM res_comment AS rc ";
        $sql .= "INNER JOIN consultant AS c ON c.consultant_id = rc.consultant_id";
        $sql .= " WHERE resume_id = " . $resumeId;
        $sql .= " ORDER BY rc.res_comment_id DESC ";
		if($limit) {
		    $sql .= "LIMIT 1";
		    return $db->fetchRow($sql);
		} 
		
		
        return $db->fetchAll($sql);
    }
    
    public function insertHistory($data)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "INSERT INTO res_history(resume_id, consultant_id, content) VALUES (";
		$sql .= $data['resume_id'] . ",";
		$sql .= "1,";
		$sql .= "'" . @$data['content'] . "');";
		
        $db->query($sql);
    }
    
    public function getHistory($resumeId, $limit=null)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT rc.*, c.full_name, c.username FROM res_history AS rc ";
        $sql .= "INNER JOIN consultant AS c ON c.consultant_id = rc.consultant_id";
        $sql .= " WHERE resume_id = " . $resumeId;
        $sql .= " ORDER BY rc.res_history_id DESC ";
		if($limit) {
		    $sql .= "LIMIT $limit";
		} 
			
        return $db->fetchAll($sql);
    }
    
    public function checkExists($fullname, $birthday, $email)
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = "SELECT * FROM resume WHERE (full_name = '". $fullname ."' AND birthday = '". $birthday ."') OR email_1 = '". $email ."'";
//echo $sql;exit;
        return $db->query($sql)->rowCount();
    }
}
?>