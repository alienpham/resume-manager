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
	protected $_nationality_id;
	protected $_view_count;
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
}