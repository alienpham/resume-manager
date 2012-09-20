<?php
class Company_Model_CompanyMapper {
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
            $this->setDbTable('Company_Model_DbTable_Company');
        }
        return $this->_dbTable;
    }
    
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}
	
	public function save (Company_Model_Company $company)
    {
        $data = array(
			'company_code' 		=> $company->getCompanyCode(), 
			'full_name_en' 		=> $company->getFullNameEn(), 
			'short_name_en' 	=> $company->getShortNameEn(), 
			'full_name_vn' 		=> $company->getFullNameVn(),
         	'short_name_vn'		=> $company->getShortNameVn(),
         	'busines_type_id' 	=> $company->getBusinesTypeId(),
			'industry_id' 		=> $company->getIndustryId(),
			'tel' 				=> $company->getTel(),
			'fax' 				=> $company->getFax(),
			'email' 			=> $company->getEmail(),
			'address' 			=> $company->getAddress(),
			'website' 			=> $company->getWebsite(),
			'status'			=> $company->getStatus(),
			'created_date' 		=> $company->getCreatedDate(),
			'updated_date' 		=> $company->getUpdatedDate()
		);
//print_r($data); exit;    

			
		return $this->getDbTable()->insert($data);

		
    }
	
	public function find ($id, Company_Model_Company $company)
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
				 ->setBusinesTypeId($row->busines_type_id)
				 ->setIndustryId($row->industry_id)
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
        
        foreach ($resultSet as $row) {
        	$entry = new Company_Model_Company();
            $entry   ->setCompanyId($row->company_id)
					 ->setCompanyCode($row->company_code)
					 ->setFullNameEn($row->full_name_en)
					 ->setShortNameEn($row->short_name_en)
					 ->setFullNameVn($row->full_name_vn)
					 ->setShortNameVn($row->short_name_vn)
					 ->setBusinesTypeId($row->busines_type_id)
					 ->setIndustryId($row->industry_id)
					 ->setTel($row->tel)
					 ->setFax($row->fax)
					 ->setEmail($row->email)
					 ->setAddress($row->address)
					 ->setWebsite($row->website)
					 ->setStatus($row->status)
					 ->setCreatedDate($row->created_date)
					 ->setUpdatedDate($row->updated_date);
            $entries[] = $entry;
        }
        return $entries;
    }
    
	public function fetchCompany ($where = null, $orderby = null, $limit=1, $offset=null)
    {
    	$resultSet = $this->getDbTable()->fetchAll($where, $orderby, $limit, $offset);
        $entries = array();
        
        foreach ($resultSet as $row) {
            $entry = new Default_Model_Company();
            $entry   ->setCompanyId($row->company_id)
					 ->setCompanyCode($row->company_code)
					 ->setFullNameEn($row->full_name_en)
					 ->setShortNameEn($row->short_name_en)
					 ->setFullNameVn($row->full_name_vn)
					 ->setShortNameVn($row->short_name_vn)
					 ->setBusinesTypeId($row->busines_type_id)
					 ->setIndustryId($row->industry_id)
					 ->setTel($row->tel)
					 ->setFax($row->fax)
					 ->setEmail($row->email)
					 ->setAddress($row->address)
					 ->setWebsite($row->website)
					 ->setStatus($row->status)
					 ->setCreatedDate($row->created_date)
					 ->setUpdatedDate($row->updated_date);
            $entries[] = $entry;
        }
        return $entries;
    }
    public function test()
    {
    	echo "54656546";
    }
}
