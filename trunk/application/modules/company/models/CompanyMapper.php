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
        $entry = new Company_Model_Company();
        foreach ($resultSet as $row) {
            $entry->setCompanyId($row->company_id);
			$entry->setCompanyCode($row->company_code);
			$entry->setFullNameEn($row->full_name_en);
			$entry->setShortNameEn($row->short_name_en);
			$entry->setFullNameVn($row->full_name_vn);
			$entry->setShortNameVn($row->short_name_vn);
			$entry->setBusinesTypeId($row->busines_type_id);
			$entry->setIndustryId($row->industry_id);
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
    
	public function getListCompany ($where = null, $orderby = null, $offset="", $limit="")
    {
    	$db = $this->getDbTable()->getAdapter();
    	if ($limit=="")
       		$sql = "SELECT * FROM company WHERE $where ORDER BY $orderby";
       	else 
       		$sql = "SELECT * FROM company WHERE $where ORDER BY $orderby LIMIT $offset,$limit";
        $result = $db->fetchAll($sql);
        
        return $result;
    }
    
	public function countCompany ($where = null, $orderby = null)
    {
    	$db = $this->getDbTable()->getAdapter();
       	$sql = "SELECT * FROM company WHERE $where ORDER BY $orderby";
        $result = $db->fetchAll($sql);
        
        return count($result);
    }
    
    public function countAct($company_id)
    {
    	$str_date=date('Y-m');
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT count(*) as numact FROM com_activity WHERE action_date like '%".$str_date."%' AND company_id='$company_id'";
    	$result = $db->fetchAll($sql);
    	return $result[0]['numact'];
    }
    
	public function countNewVacancy($company_id)
    {
    	$str_date=date('Y-m');
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT v.vacancy_id as vacancy_id, v2.va_process_history_id as va_proccess_history_id FROM vacancy v, va_process_history v2 WHERE v.vacancy_id = v2.vacancy_id AND v2.status = 'Open' AND v.company_id='$company_id' AND date_format(v2.action_date,'%Y-%m-%d') >= '%".$str_date."-01%'";
    	$result = $db->fetchAll($sql);
    	return count($result);
    }
    
	public function countOpenVacancy($company_id)
    {
    	$str_date=date('Y-m');
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT count(*) as numnewvacancy FROM vacancy WHERE created_date like '%".$str_date."%' AND updated_date like '%".$str_date."%' AND date_format(created_date,'%Y-%m-%d') = date_format(updated_date,'%Y-%m-%d') AND company_id='$company_id'";
    	$result = $db->fetchAll($sql);
    	return $result[0]['numnewvacancy'];
    }
    
	public function countRsProcess($company_id,$process_id)
    {
    	$str_date=date('Y-m');
    	$db = $this->getDbTable()->getAdapter();
    	$sql = "SELECT count(*) as numrsproc FROM candidate_has_process WHERE 
    			action_date like '%".$str_date."%' AND candidate_id IN (SELECT candidate_id FROM candidate WHERE vacancy_id IN (SELECT vacancy_id FROM vacancy WHERE company_id = '$company_id')) AND resume_process_id IN($process_id)";
    	$result = $db->fetchAll($sql);
    	return $result[0]['numrsproc'];
    }
    
	public function getFieldValue ($table, $where, $field)
    {
    	$db = $this->getDbTable()->getAdapter();
        $sql = "SELECT * FROM $table WHERE $where";
        $result = $db->fetchAll($sql);
        $num=0;
        $str="";
        
        foreach ($result as $rs)
        {
        	if ($num==0)
        		$str=$rs[$field];
        	else 
        		$str=" | ".$rs[$field];
        	$num++;
        }
        return $str;
    }
    
    public function getLookup($table,$where,$field_id,$field_name)
    {
    	$db = $this->getDbTable()->getAdapter();
        $sql = "SELECT * FROM $table WHERE $where";
        $result = $db->fetchAll($sql);
        $data="";
        foreach($result as $rs)
        {
        	$data.="<option value='".$rs[$field_id]."'>".$rs[$field_name]."</option>";
        }
        return $data;
    }
    
	public function pagingProcess($TotalRows,$RowsInPage,$maxpage,$page,$jsname){
		if ($maxpage) $numfrom = 1;
		else $numfrom = 0;

		$numto = $RowsInPage;
		if ($TotalRows < $numto) $numto = $TotalRows;

		if($page >1){
			$numfrom = ($RowsInPage)*($page-1)+1;
			$numto = ($RowsInPage)*$page;

			if ($TotalRows < $numto) $numto = $TotalRows;
		}

		$arrnumpage=explode('.',$TotalRows/$RowsInPage);
		if ($TotalRows%$RowsInPage!=0)
			$numpage=$arrnumpage[0]+1;
		else
			$numpage=$arrnumpage[0];

		$vl=explode('.',$page/$maxpage);
		//if ($page%$maxpage==0)
		$step=$vl[0];

		if ($step==0)
		{
			$start=1;
			$step=1;
		}
		else
		if ($page%$maxpage==0)
		{
			$start=($step-1)*$maxpage+1;
		}
		else
		{
			$start=$step*$maxpage+1;
		}
		$end=$start+$maxpage-1;

		if ($page>1)
		$str="<a href='#' onClick=\"".$jsname."(".($page-1).");\">Back</a> &nbsp;";
		else
		$str="<font color='#999999'>Back &nbsp;</font>";
		//Middle
		if ($end<$numpage){
			$k=0;
			for($i=$start;$i<=$end;$i++){
				if ($k==0)
				{
					if ($i==$page)

					$str.="<b>".$i.'</b>';

					else
					$str.="<a href='#' onClick=\"".$jsname."(".$i.");\">".$i.'</a>';
				}
				else{
					if ($i==$page)

					$str.=" | <b>".$i.'</b>';

					else
					$str.=" | <a href=\"#\" onClick=\"".$jsname."(".$i.");\">".$i.'</a>';
				}
				$k++;
			}

		}
		else{
			if ($start==1)
			{
				$end=$numpage;
			}
			else
			if ($end-$numpage>0)
			{
				$start=$start-($end-$numpage);
				$end=$numpage;
			}
			else
			if ($end-$start<$maxpage)
			$start=$start-($end-$start);
			$k=0;
			for($i=$start;$i<=$end;$i++){
				if ($k==0)
				{
					if ($i==$page)

					$str.="<b>".$i.'</b>';
					else
					$str.="<a href='#' onClick=\"".$jsname."(".$i.");\">".$i.'</a>';
				}
				else{
					if ($i==$page)

					$str.=" | <b>".$i.'</b>';

					else
					$str.=" | <a href=\"#\" onClick=\"".$jsname."(".$i.");\">".$i.'</a>';
				}
					
				$k++;
			}
		}
		//Next
		if ($page<$numpage)
		{
			$str.=" &nbsp;<a href='#' onClick=\"".$jsname."(".($page+1).");\">Next</a>";
		}
		else
		$str.=' <font color="#999999">&nbsp;Next</font>';
		return $str.'<br/>( '.$numfrom.'-'.$numto.' of '.$TotalRows.' records - Page '.$page.' of '.$numpage.' pages)';
	}
}
