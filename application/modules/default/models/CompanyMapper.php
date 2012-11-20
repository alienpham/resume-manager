<?php
class Default_Model_CompanyMapper {
	protected $_dbTable;
    public function setDbTable ($dbTable)
    {
        if (is_string($dbTable)) {
            $dbTable = new Default_Model_DbTable_Company();
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
            $this->setDbTable('Default_Model_DbTable_Company');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Default_Model_Company $company)
    {
        $data = array(
			//'company_code' 		=> $company->getCompanyCode(), 
			'full_name_en' 		=> $company->getFullNameEn(), 
			'short_name_en' 	=> $company->getShortNameEn(), 
			'full_name_vn' 		=> $company->getFullNameVn(),
         	'short_name_vn'		=> $company->getShortNameVn(),
         	'busines_type' 	    => $company->getBusinesType(),
			'tel' 				=> $company->getTel(),
			'fax' 				=> $company->getFax(),
			'email' 			=> $company->getEmail(),
			'address' 			=> $company->getAddress(),
			'website' 			=> $company->getWebsite(),
			'status'			=> $company->getStatus(),
			'created_date' 		=> $company->getCreatedDate(),
			'updated_date' 		=> $company->getUpdatedDate()
		);
		if (null == ($id = $company->getCompanyId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	unset($data['created_date']);
        	$this->getDbTable()->update($data, array('company_id = ?' => $id));
            return $id;
        }
		
    }
	
	public function find ($id, Default_Model_Company $company)
    {
        $result = $this->getDbTable()->find($id);        
        if (0 == count($result)) {
            return;
        }
        $row = $result->current();
        $company ->setCompanyId($row->company_id)
				 ->setCompanyCode($row->company_code)
				 ->setFullNameEn($row->full_name_en)
				 ->setShortNameEn($row->short_name_en)
				 ->setFullNameVn($row->full_name_vn)
				 ->setShortNameVn($row->short_name_vn)
				 ->setBusinesType($row->busines_type)
				 ->setTel($row->tel)
				 ->setFax($row->fax)
				 ->setEmail($row->email)
				 ->setAddress($row->address)
				 ->setWebsite($row->website)
				 ->setStatus($row->status)
				 ->setCreatedDate($row->created_date)
				 ->setUpdatedDate($row->updated_date);
    }


	public function fetchAll ($where = null, $orderby = null)
    {
        $resultSet = $this->getDbTable()->fetchAll($where, $orderby);
        
        $entries = array();
        $entry = new Default_Model_Company();
        foreach ($resultSet as $row) {
            $entry->setCompanyId($row->company_id);
			$entry->setCompanyCode($row->company_code);
			$entry->setFullNameEn($row->full_name_en);
			$entry->setShortNameEn($row->short_name_en);
			$entry->setFullNameVn($row->full_name_vn);
			$entry->setShortNameVn($row->short_name_vn);
			$entry->setBusinesType($row->busines_type);
			$entry->setTel($row->tel);
			$entry->setFax($row->fax);
			$entry->setEmail($row->email);
			$entry->setAddress($row->address);
			$entry->setWebsite($row->website);
			$entry->setStatus($row->status);
			$entry->setCreatedDate($row->created_date);
			$entry->setUpdatedDate($row->updated_date);
            $entries[] = $entry;
        }
        return $entries;
    }
    
    public function getListCompany()
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT * FROM company";
    	$rows = $db->fetchAll($sql);
    	return $rows;
    }
    
    public function saveCompany($data)
    {
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "INSERT INTO company(full_name_en, short_name_en, full_name_vn, short_name_vn, busines_type, tel, fax, email, address, website, status, information, created_date, updated_date)
    	VALUES (";
    	$sql .= "'" .$data['full_name_en'] ."',";
    	$sql .= "'" .$data['short_name_en'] ."',";
    	$sql .= "'" .$data['full_name_vn'] ."',";
    	$sql .= "'" .$data['short_name_vn'] ."',";
    	$sql .= "'" .$data['busines_type'] ."',";
    	$sql .= "'" .$data['tel'] ."',";
    	$sql .= "'" .$data['fax'] ."',";
    	$sql .= "'" .$data['email'] ."',";
    	$sql .= "'" .$data['address'] ."',";
    	$sql .= "'" .$data['website'] ."',";
    	$sql .= "'" .$data['status'] ."',";
    	$sql .= "'" .$data['information'] ."',";
    	$sql .=  NOW();
    	$sql .= NOW() .")";
    	return $db->$query($sql);
    }
}
