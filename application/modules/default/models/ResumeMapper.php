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
         	'marital_status'=> $resume->getMaritaStatus(),
         	'status' 		=> $resume->getStatus(),
			'email_1' 		=> $resume->getEmail1(),
			'email_2' 		=> $resume->getEmail2(),
			'mobile_1' 		=> $resume->getMobile1(),
			'mobile_2' 		=> $resume->getMobile2(),
			'tel' 			=> $resume->getTel(),
			'address' 		=> $resume->getAddress(),
			'province_id' 	=> $resume->getProvinceId(),
			'view_count' 	=> $resume->getViewCount(),
			'created_date' 	=> $resume->getCreatedDate(),
			'updated_date' 	=> $resume->getUpdatedDate(),
        	'created_consultant_id' 	=> $resume->getCreatedConsultantId(),
			'updated_consultant_id' 	=> $resume->getUpdatedConsultantId()
		);
//print_r($data); exit;    

			
		return $this->getDbTable()->insert($data);

		
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
				->setGender($row->gender)
				->setMaritalStatus($row->marital_status)
				->setStatus($row->status)
				->setEmail1($row->email_1)
				->setEmail2($row->email_2)
				->setMobile1($row->mobile_1)
				->setMobile2($row->mobile_2)
				->setTel($row->tel)
				->setAddress($row->address)
				->setPrivinceId($row->province_id)
				->setViewCount($row->view_count)
				->setCreatedDate($row->created_date)
				->setUpdatedDate($row->updated_date)
				->setCreatedConsultantId($row->created_consultant_id)
				->setUpdatedConsultantId($row->updated_consultant_id);
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
					->setGender($row->gender)
					->setMaritalStatus($row->marital_status)
					->setStatus($row->status)
					->setEmail1($row->email_1)
					->setEmail2($row->email_2)
					->setMobile1($row->mobile_1)
					->setMobile2($row->mobile_2)
					->setTel($row->tel)
					->setAddress($row->address)
					->setPrivinceId($row->province_id)
					->setViewCount($row->view_count)
					->setCreatedDate($row->created_date)
					->setUpdatedDate($row->updated_date)
					->setCreatedConsultantId($row->created_consultant_id)
					->setUpdatedConsultantId($row->updated_consultant_id);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListResume() 
    {
        $sql  = "SELECT * FROM resume as r ";
        $sql .= "INNER JOIN res_experience as ex ON r.resume_id = ex.resume_id ";
        
        $db = $this->getDbTable()->getAdapter();
        return $db->query($sql)->fetchAll(); 
    }
}
?>