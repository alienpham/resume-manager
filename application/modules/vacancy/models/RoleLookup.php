<?php
class Vacancy_Model_RoleLookup {
	const ROLE_TYPE_CONSULTANT	= 'Consultant';
	const ROLE_TYPE_OPERATION	= 'Operation';

	protected $_role_id;
	protected $_department_id;
	protected $_role_type;
	protected $_level;
	protected $_name;
	protected $_created_date;
	protected $_updated_date;
	protected $_sort_order;

	/**
	 *
	 * Setter - setConsultantId
	 * @param int $consultantId
	 */
	public function setRoleId($roleId) {
		$this->_role_id = $roleId;
	}

	/**
	 * Getter - getConsultantId
	 * @return int
	 */
	public function getRoleId() {
		return $this->_role_id;
	}

	/**
	 *
	 * Setter - setDepartmentId
	 * @param int $deptId
	 */
	public function setDepartmentId($deptId) {
		$this->_department_id = $deptId;
	}

	/**
	 * Getter - getDepartmentId
	 * @return int
	 */
	public function getDepartmentId() {
		return $this->_department_id;
	}

	/**
	 *
	 * Setter - setRoleType
	 * @param int $roleType
	 */
	public function setRoleType($roleType) {
		$this->_role_type = $roleType;
	}

	/**
	 * Getter - getRoleType
	 * @return int
	 */
	public function getRoleType() {
		return $this->_role_type;
	}

	public function setCreateDate($createDate) {
		$this->_created_date = $createDate;
	}

	public function getCreateDate() {
		return $this->_created_date;
	}

	public function setUpdateDate($updateDate) {
		$this->_updated_date = $updateDate;
	}

	public function getUpdateDate() {
		return $this->_updated_date;
	}

	/**
	 *
	 * Default constructor of class model
	 * @param $options
	 */
	public function __construct(array $options = null)
	{
		if (is_array($options)) {
			$this->setOptions($options);
		}
	}

	/**
	 *
	 * Setter - Magic method
	 * @param string $property
	 * @param mixed $value
	 */
	public function __set($name, $value)
	{
		$method = 'set' . $name;
		if (('mapper' == $name) || !method_exists($this, $method)) {
			throw new Exception('Invalid page property');
		}
		$this->$method($value);
	}

	/**
	 *
	 * Getter - Magic method
	 * @param string $property
	 */
	public function __get($name)
	{
		$method = 'get' . $name;
		if (('mapper' == $name) || !method_exists($this, $method)) {
			throw new Exception('Invalid page property');
		}
		return $this->$method();
	}

	/**
	 *
	 * Set options
	 * @param $options
	 */
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
}