<?php
class Default_Model_Company
{
	protected $_company_id;
	protected $_company_code;
	protected $_full_name_en;
	protected $_short_name_en;
	protected $_full_name_vn;
	protected $_short_name_vn;
	protected $_busines_type_id;
	protected $_industry_id;
	protected $_tel;
	protected $_fax;
	protected $_email;
	protected $_address;
	protected $_website;
	protected $_status;
	protected $_created_date;
	protected $_updated_date;
    
	public function __construct(array $options = null)
    {
        if (is_array($options)) {
            $this->setOptions($options);
        }
    }
 
    public function __set($name, $value)
    {
        $method = 'set' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
           throw new Exception('Invalid page property');
        }
        $this->$method($value);
    }
 
    public function __get($name)
    {
        $method = 'get' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
            throw new Exception('Invalid page property');
        }
        return $this->$method();
    }
	
	public function setOptions(array $options)
    {
        $methods = get_class_methods($this);
        foreach ($options as $key => $value) {
            $method = 'set' . ucfirst($key);
            if (in_array($method, $methods)) {
                $this->$method($value);
            }
        }
        return $this;
    }
	
	public function getCompanyId() {
		return $this->_company_id;
	}
	public function setCompanyId($id) {
		$this->_company_id = $id;
	}
	
    public function getCompanyCode() {
		return $this->_company_code;
	}
	public function setCompanyCode($code) {
		$this->_company_code = $code;
	}
	
	public function getFullNameEn() {
		return $this->_full_name_en;
	}
	public function setFullNameEn($full_name_en) {
		$this->_full_name_en = $full_name_en;
	}
	
	public function getShortNameEn() {
		return $this->_short_name_en;
	}
	public function setShortNameEn($short_name_en) {
		$this->_short_name_en = $short_name_en;
	}
	
	public function getFullNameVn() {
		return $this->_full_name_vn;
	}
	public function setFullNameVn($full_name_vn) {
		$this->_full_name_vn = $full_name_vn;
	}
	
	public function getShortNameVn() {
		return $this->_short_name_vn;
	}
	public function setShortNameVn($short_name_vn) {
		$this->_short_name_vn = $short_name_vn;
	}
	
	public function getBusinesTypeId() {
		return $this->_busines_type_id;
	}
	public function setBusinesTypeId($busines_type_id) {
		$this->_busines_type_id = $busines_type_id;
	}
	
	public function getIndustryId() {
		return $this->_industry_id;
	}
	public function setIndustryId($industry_id) {
		$this->_industry_id = $industry_id;
	}
	
	public function getTel() {
		return $this->_tel;
	}
	public function setTel($tel) {
		$this->_tel = $tel;
	}
	
	public function getFax() {
		return $this->_fax;
	}
	public function setFax($fax) {
		$this->_fax = $fax;
	}
	
	public function getEmail() {
		return $this->_email;
	}
	public function setEmail($email) {
		$this->_email = $email;
	}
	
	public function getAddress() {
		return $this->_address;
	}
	public function setAddress($address) {
		$this->_address = $address;
	}
	
	public function getWebsite() {
		return $this->_website;
	}
	public function setWebsite($website) {
		$this->_website = $website;
	}
	
	public function getStatus() {
		return $this->_status;
	}
	public function setStatus($status) {
		$this->_status = $status;
	}
	
	public function getCreatedDate() {
		return $this->_created_date;
	}
	public function setCreatedDate($created_date) {
		$this->_created_date = $created_date;
	}
	
	public function getUpdatedDate() {
		return $this->_updated_date;
	}
	public function setUpdatedDate($updated_date) {
		$this->_updated_date = $updated_date;
	}
}
