<?php
class Default_Model_Company
{
    protected $_company_id;  
    protected $_company_name;
    protected $_busines_type;
    protected $_tel;
    protected $_fax;
    protected $_email;
    protected $_address;
    protected $_website;
    protected $_status;
    protected $_information;
	protected $_assign_cons;
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
	
    public function getCompanyName() {
		return $this->_company_name;
	}
	public function setCompanyName($company_name) {
		$this->_company_name = $company_name;
	}
	
	public function getBusinesType() {
		return $this->_busines_type;
	}
	public function setBusinesType($busines_type) {
		$this->_busines_type = $busines_type;
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
	
    public function getInformation() {
		return $this->_information;
	}
	public function setInformation($information) {
		$this->_information = $information;
	}
	
	public function getAssignCons() {
		return $this->_assign_cons;
	}
	public function setAssignCons($cons) {
		$this->_assign_cons = $cons;
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
