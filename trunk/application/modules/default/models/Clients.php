<?php
class Default_Model_Clients
{
	protected $_id;
	protected $_name;
	protected $_birthday;
	protected $_email;
	protected $_phone;
	protected $_point;
	protected $_consultant;
    
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
	
	public function getId() {
		return $this->_id;
	}
	public function setId($id) {
		$this->_id = $id;
	}
	
	public function getConsultant() {
		return $this->_consultant;
	}
	
	public function setConsultant($consultant) {
		$this->_consultant = $consultant;
	}
	
	public function getName() {
		return $this->_name;
	}
	public function setName($name) {
		$this->_name = $name;
	}
	
	public function getEmail() {
		return $this->_email;
	}
	public function setEmail($email) {
		$this->_email = $email;
	}
		
	public function getBirthday() {
		return $this->_birthday;
	}
	public function setBirthday($birthday) {
		$this->_birthday = $birthday;
	}
		
    public function getPhone() {
            return $this->_phone;
    }
    public function setPhone($phone) {
        $this->_phone = $phone;
    }
    
    public function getPoint() {
            return $this->_point;
    }
	
	public function setPoint($point) {
        $this->_point = $point;
    }
}
