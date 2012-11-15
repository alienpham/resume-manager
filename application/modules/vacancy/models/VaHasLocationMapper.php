<?php
class Vacancy_Model_VaHasLocationMapper {
	protected $_dbTable;

	/**
	 *
	 * Set table object
	 * @param object $dbTable
	 * @throws Exception
	 */
	public function setDbTable ($dbTable)
	{
		if (is_string($dbTable)) {
			$dbTable = new $dbTable();
		}

		if (! $dbTable instanceof Zend_Db_Table_Abstract) {
			throw new Exception('Invalid table data gateway provided');
		}

		$this->_dbTable = $dbTable;
		return $this;
	}

	/**
	 *
	 * To get table object
	 *
	 * @return object
	 */
	public function getDbTable ()
	{
		if (null === $this->_dbTable) {
			$this->setDbTable('Vacancy_Model_DbTable_VaHasLocation');
		}
		return $this->_dbTable;
	}

	/**
	 *
	 * To update data
	 * @param array $data
	 * @param mixed $where
	 */
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}

	/**
	 *
	 * On Save Action
	 * @param Vacancy_Model_WorkLevelLookup $obj
	 */
	public function save(Vacancy_Model_VaHasLocation $obj)
	{
		$data = array(
			'va_location_id' => $obj->getValocationId(),
			'province_id' => $obj->getProvinceId(),
			'vacancy_id' => $obj->getVacancyId()
		);

		if (null == ($id = $obj->getValocationId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('va_location_id = ?' => $id));
            return $id;
        }
	}

	/**
	 *
	 * Find by ID
	 * @param int $id
	 * @param Vacancy_Model_WorkLevelLookup $workLevelLookup
	 */
	public function find($id, Vacancy_Model_VaHasLocation $vahaslocation)
	{
		$result = $this->getDbTable()->find($id);

		if (0 == count($result)) {
			return null;
		}
		$row = $result->current();

		$vahaslocation->setVaLocationId($row->va_location_id)
						->setProvinceId($row->province_id)
						->setVacancyId($row->vacancy_id);
	}

	/**
	 *
	 * Fetch all rows
	 * @param mixed $where
	 * @param mixed $orderby
	 */
	public function fetchAll ($where = null, $orderby = null)
	{
		$resultSet = $this->getDbTable()->fetchAll($where, $orderby);

		$entries = array();

		foreach ($resultSet as $row) {
			$entry = new Vacancy_Model_VaHasLocation();
			$entry->setVaLocationId($entry->va_location_id)
				  ->setProvinceId($entry->province_id)
				  ->setVacancyId($entry->vacancy_id);

			$entries[] = $entry;
		}
		return $entries;
	}
	
	public function delete($where) {
		$this->getDbTable()->delete($where);
	}
}