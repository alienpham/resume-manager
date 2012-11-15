<?php
class Vacancy_Model_VaHasConsultantMapper {
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
			$this->setDbTable('Vacancy_Model_DbTable_VaHasConsultant');
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
	public function save(Vacancy_Model_VaHasConsultant $obj)
	{
		$data = array(	'va_consultant_id' => $obj->getVaConsultantId(),
						'consultant_id' => $obj->getConsultantId(),
						'vacancy_id' => $obj->getVacancyId(),
						'inchange_type' => $obj->getInchangeType(),
						'status' => $obj->getStatus()
					);

		if (null == ($id = $obj->getVaConsultantId())) {
            return $this->getDbTable()->insert($data);
        } else {
        	$this->getDbTable()->update($data, array('va_consultant_id = ?' => $id));
            return $id;
        }
	}

	/**
	 *
	 * Find by ID
	 * @param int $id
	 * @param Vacancy_Model_WorkLevelLookup $workLevelLookup
	 */
	public function find($id, Vacancy_Model_VaHasConsultant $vahasconsultant)
	{
		$result = $this->getDbTable()->find($id);

		if (0 == count($result)) {
			return null;
		}
		$row = $result->current();

		$vahasconsultant->getVaConsultantId($row->va_consultant_id);
		$vahasconsultant->getConsultantId($row->consultant_id);
		$vahasconsultant->setVacancyId($row->vacancy_id);
		$vahasconsultant->getInchangeType($row->inchange_type);
		$vahasconsultant->getStatus($row->status);
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
			$entry = new Vacancy_Model_VaHasConsultant();
			$entry->getVaConsultantId($entry->va_consultant_id);
			$entry->getConsultantId($entry->consultant_id);
			$entry->setVacancyId($entry->vacancy_id);
			$entry->getInchangeType($entry->inchange_type);
			$entry->getStatus($entry->status);

			$entries[] = $entry;
		}
		return $entries;
	}
	
	public function delete($where) {
		$this->getDbTable()->delete($where);
	}
}