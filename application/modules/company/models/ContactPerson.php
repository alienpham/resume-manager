<?php
class Company_Model_ContactPerson
{
	protected $_contact_person_id;
	protected $_company_id;
	protected $_title;
	protected $_full_name;
	
	protected $_job_title;
	protected $_tel_1;
	protected $_tel_2;
	protected $_fax;
	
	protected $_mobile_1;
	protected $_mobile_2;
	protected $_email_1;
	protected $_email_2;
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
		$this->_contact_person_id = $id;
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
	
	public function getTel1() {
		return $this->_tel_1;
	}
	public function setTel1($tel_1) {
		$this->_tel_1 = $tel_1;
	}
	
	public function getTel2() {
		return $this->_tel_2;
	}
	public function setTel2($tel_2) {
		$this->_tel_2 = $tel_2;
	}
	
	public function getFax() {
		return $this->_fax;
	}
	public function setFax($fax) {
		$this->_Fax = $fax;
	}
	
	public function getMobile1() {
		return $this->_mobile_1;
	}
	public function setMobile1($mobile_1) {
		$this->_mobile_1 = $mobile_1;
	}
	
	public function getMobile2() {
		return $this->_mobile_2;
	}
	public function setMobile2($mobile_2) {
		$this->_mobile_2 = $mobile_2;
	}
	
	public function getEmail1() {
		return $this->_email_1;
	}
	public function setEmail1($email_1) {
		$this->_email_1 = $email_1;
	}
	
	public function getEmail2() {
		return $this->_email_2;
	}
	public function setEmail2($email_2) {
		$this->_email_2 = $email_2;
	}
	
	public function getAddress() {
		return $this->_address;
	}
	public function setAddress($address) {
		$this->_address = $address;
	}
}
