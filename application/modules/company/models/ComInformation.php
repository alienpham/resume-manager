<?php
class Company_Model_ComInformation
{
	protected $_com_information_id;
	protected $_company_id;
	protected $_apply_to;
	protected $_content;
    
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
	
	public function getComInformationId() {
		return $this->_com_information_id;
	}
	public function setComInformationId($id) {
		$this->_com_information_id = $id;
	}
	
    public function getCompanyId() {
		return $this->_company_id;
	}
	public function setCompanyId($id) {
		$this->_company_id = $id;
	}
	
	public function getApplyTo() {
		return $this->_apply_to;
	}
	public function setApplyTo($apply_to) {
		$this->_apply_to = $apply_to;
	}
	
	public function getContent() {
		return $this->_content;
	}
	public function setContent($content) {
		$this->_content = $content;
	}
}
