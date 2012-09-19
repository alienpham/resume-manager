<?php
class Default_Model_Resume
{
	protected $_resume_id;
	protected $_resume_code;
	protected $_full_name;
	protected $_birthday;
	protected $_gender;
	protected $_marital_status;
	protected $_status;
	protected $_email_1;
	protected $_email_2;
	protected $_mobile_1;
	protected $_mobile_2;
	protected $_tel;
	protected $_address;
	protected $_province_id;
	protected $_view_count;
	protected $_created_date;
	protected $_updated_date;
	protected $_created_consultant_id;
	protected $_updated_consultant_id;
    
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
	
	public function getResumeId() {
		return $this->_resume_id;
	}
	public function setResumeId($id) {
		$this->_resume_id = $id;
	}
	
    public function getResumeCode() {
		return $this->_resume_code;
	}
	public function setResumeCode($code) {
		$this->_resume_code = $code;
	}
	
	public function getFullName() {
		return $this->_full_name;
	}
	public function setFullName($fullname) {
		$this->_full_name = $fullname;
	}
	
	public function getBirthday() {
		return $this->_birthday;
	}
	public function setBirthday($birthday) {
		$this->_birthday = $birthday;
	}
	
	public function getGender() {
		return $this->_gender;
	}
	public function setGender($gender) {
		$this->_gender = $gender;
	}
	
	public function getMaritaStatus() {
		return $this->_marital_status;
	}
	public function setMaritaStatus($marital_status) {
		$this->_marital_status = $marital_status;
	}
	
	public function getStatus() {
		return $this->_marital_status;
	}
	public function setStatus($status) {
		$this->_status = $status;
	}
	
	public function getEmail1() {
		return $this->_email_1;
	}
	public function setEmail1($email1) {
		$this->_email_1 = $email1;
	}
	
	public function getEmail2() {
		return $this->_email_2;
	}
	public function setEmail2($email2) {
		$this->_email_2 = $email2;
	}
	
	public function getMobile1() {
		return $this->_mobile_1;
	}
	public function setMobile1($mobile1) {
		$this->_mobile_1 = $mobile1;
	}
	
	public function getMobile2() {
		return $this->_mobile_2;
	}
	public function setMobile2($mobile2) {
		$this->_mobile_2 = $mobile2;
	}
	
	public function getTel() {
		return $this->_tel;
	}
	public function setTel($tel) {
		$this->_tel = $tel;
	}
	
	public function getAddress() {
		return $this->_address;
	}
	public function setAddress($address) {
		$this->_address = $address;
	}
	
	public function getProvinceId() {
		return $this->_province_id;
	}
	public function setProvinceId($provinceId) {
		$this->_province_id = $provinceId;
	}
	
	public function getViewCount() {
		return $this->_view_count;
	}
	public function setViewCount($viewCount) {
		$this->_view_count = $viewCount;
	}
	
	public function getCreatedDate() {
		return $this->_created_date;
	}
	public function setCreatedDate($createdDate) {
		$this->_created_date = $createdDate;
	}
	
	public function getUpdatedDate() {
		return $this->_updated_date;
	}
	public function setUpdatedDate($updatedDate) {
		$this->_updated_date = $updatedDate;
	}
	
	public function getCreatedConsultantId() {
		return $this->_created_consultant_id;
	}
	public function setCreatedConsultantId($createdConsultantId) {
		$this->_created_consultant_id = $createdConsultantId;
	}
	
	public function getUpdatedConsultantId() {
		return $this->_updated_consultant_id;
	}
	public function setUpdatedConsultantId($updatedConsultantId) {
		$this->_updated_consultant_id = $updatedConsultantId;
	}
}