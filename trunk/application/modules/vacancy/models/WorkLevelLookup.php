<?php
class Vacancy_Model_WorkLevelLookup {
	protected $_work_level_id;
	protected $_name;
	protected $_sort_order;

	/**
	 *
	 * Setter - setWorkLevelId
	 * @param int $consultantId
	 */
	public function setWorkLevelId($workLevelId) {
		$this->_work_level_id = $workLevelId;
	}

	/**
	 * Getter - getWorkLevelId
	 * @return int
	 */
	public function getWorkLevelId() {
		return $this->_work_level_id;
	}

	/**
	 *
	 * Setter - setName
	 * @param string $name
	 */
	public function setName($name) {
		$this->_name = $name;
	}

	/**
	 * Getter - getName
	 * @return string
	 */
	public function getName() {
		return $this->_name;
	}

	/**
	 *
	 * Setter - setName
	 * @param int $sortOrder
	 */
	public function setSortOrder($sortOrder) {
		$this->_sort_order = $sortOrder;
	}

	/**
	 * Getter - getSortOrder
	 * @return int
	 */
	public function getSortOrder() {
		return $this->_sort_order;
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