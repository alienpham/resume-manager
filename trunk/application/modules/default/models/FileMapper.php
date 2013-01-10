<?php
class Default_Model_FileMapper {
	protected $_dbTable;
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
    public function getDbTable ()
    {
        if (null === $this->_dbTable) {
            $this->setDbTable('Default_Model_DbTable_File');
        }
        return $this->_dbTable;
    }

	public function insertResumeFile($data) 
	{
		$db = $this->getDbTable()->getAdapter();
		$this->getDbTable()->insert($data);
		return true;
	}
	
	public function updateResumeFile($data) 
	{
		$db = $this->getDbTable()->getAdapter();
		$resumeId = $data['resume_id'];
		unset($data['resume_id']);
		$this->getDbTable()->update($data, 'resume_id = ' . $resumeId);
		return true;
	}
	
	public function getResumeFile($resumeId) 
	{
		$db = $this->getDbTable()->getAdapter();
        $sql = 'SELECT * FROM res_file WHERE resume_id = ' . $resumeId;
		
        return $db->fetchRow($sql);
	}
}
?>