<?php
class Vacancy_Model_ConsultantMapper {
	protected $_dbTable;

	/**
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
			$this->setDbTable('Vacancy_Model_DbTable_Consultant');
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
	 * @param Vacancy_Model_Consultant $obj
	 */
	public function save(Vacancy_Model_Consultant $obj)
	{
		$data = array(
			'consultant_id' => $obj->getConsultantId(),
			'title' => $obj->getTitle(),
			'full_name' => $obj->getFullName(),
			'username' => $obj->getUserName(),
			'job_title' => $obj->getJobTitle(),
			'email' => $obj->getEmail(),
			'phone' => $obj->getPhone(),
			'password' => $obj->getPassword(),
			'status' => $obj->getStatus(),
			'created_date' => $obj->getCreateDate(),
			'updated_date' => $obj->getUpdateDate(),
		);

		return $this->getDbTable()->insert($data);
	}

	/**
	 *
	 * Find by ID
	 * @param int $id
	 * @param Vacancy_Model_Consultant $consultant
	 */
	public function find($id, Vacancy_Model_Consultant $consultant)
	{
		$result = $this->getDbTable()->find($id);

		if (0 == count($result)) {
			return;
		}
		$row = $result->current();

		$consultant->setConsultantId($row->consultant_id);
		$consultant->setTitle($row->title);
		$consultant->setFullName($row->full_name);
		$consultant->setUserName($row->username);
		$consultant->setJobTitle($row->job_title);
		$consultant->setEmail($row->email);
		$consultant->setPhone($row->phone);
		$consultant->setPassword($row->password);
		$consultant->setStatus($row->status);
		$consultant->setCreateDate($row->created_date);
		$consultant->setUpdateDate($row->updated_date);
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
			$entry = new Vacancy_Model_Consultant();
			$entry->setConsultantId($row->consultant_id);
			$entry->setTitle($row->title);
			$entry->setFullName($row->full_name);
			$entry->setUserName($row->username);
			$entry->setJobTitle($row->job_title);
			$entry->setEmail($row->email);
			$entry->setPhone($row->phone);
			$entry->setPassword($row->password);
			$entry->setStatus($row->status);
			$entry->setCreateDate($row->created_date);
			$entry->setUpdateDate($row->updated_date);

			$entries[] = $entry;
		}
		return $entries;
	}
}