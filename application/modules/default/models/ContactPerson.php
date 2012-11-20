<?php
class Default_Model_ContactPerson
{
	protected $_contact_person_id;
	protected $_company_id;
	protected $_title;
	protected $_full_name;
	
	protected $_job_title;
	protected $_tel;
	protected $_fax;
	protected $_mobile;
	protected $_email;
	protected $_address;
    
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
	
	public function getContactPersonId() {
		return $this->_contact_person_id;
	}
	public function setContactPersonId($contact_person_id) {
		$this->_contact_person_id = $contact_person_id;
	}
	
    public function getCompanyId() {
		return $this->_company_id;
	}
	public function setCompanyId($id) {
		$this->_company_id = $id;
	}
	
	public function getTitle() {
		return $this->_title;
	}
	public function setTitle($title) {
		$this->_title = $title;
	}
	
	public function getFullName() {
		return $this->_full_name;
	}
	public function setFullName($full_name) {
		$this->_full_name = $full_name;
	}
	
	public function getJobTitle() {
		return $this->_job_title;
	}
	public function setJobTitle($job_title) {
		$this->_job_title = $job_title;
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
	
	public function getMobile() {
		return $this->_mobile;
	}
	public function setMobile($mobile) {
		$this->_mobile = $mobile;
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
}
