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
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
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
            'province_id' 	=> $resume->getProvinceId(),
            'created_date' 	=> $resume->getCreatedDate(),
            'updated_date' 	=> $resume->getUpdatedDate(),
            'created_consultant_id' 	=> $resume->getCreatedConsultantId(),
            'updated_consultant_id' 	=> $resume->getUpdatedConsultantId()
        );

        if (null == ($id = $resume->getResumeId())) {
            return $this->getDbTable()->insert($data);
        } else {
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
		$resume->setProvinceId($row->province_id);
		$resume->setViewCount($row->view_count);
		$resume->setCreatedDate($row->created_date);
		$resume->setUpdatedDate($row->updated_date);
		$resume->setCreatedConsultantId($row->created_consultant_id);
		$resume->setUpdatedConsultantId($row->updated_consultant_id);
    }


	public function fetchAll ($where = null, $orderby = null)
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
            $entry->setProvinceId($row->province_id);
            $entry->setViewCount($row->view_count);
            $entry->setCreatedDate($row->created_date);
            $entry->setUpdatedDate($row->updated_date);
            $entry->setCreatedConsultantId($row->created_consultant_id);
            $entry->setUpdatedConsultantId($row->updated_consultant_id);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListResume($where = null, $orderby = null) 
    {
        $db = $this->getDbTable()->getAdapter();
        if($where) $where = ' WHERE ' .$where;
        //if($orderby) $orderby = ' ORDER BY ' .$orderby;
        $sql = 'SELECT * FROM resume ' . $where;
//echo $sql;exit;
        $result = $db->fetchAll($sql);
        
        return $db->fetchAll($sql);
    }
    
	public function getProvince() 
    {
        $db = $this->getDbTable()->getAdapter();
        $sql = 'SELECT * FROM province_lookup ';
        $result = $db->fetchAll($sql);
        
        return $db->fetchAll($sql);
    }
    
}
?>