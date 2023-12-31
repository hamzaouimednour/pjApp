<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminOptions extends pjAdmin
{
    public function pjActionOrders()
    {
        $this->checkLogin();
        if (!pjAuth::factory()->hasAccess())
        {
            $this->sendForbidden();
            return;
        }
        $arr = pjOptionModel::factory()
        ->where('t1.foreign_id', $this->getForeignId())
        ->orderBy('t1.order ASC')
        ->findAll()
        ->getData();
        
        $this->set('arr', $arr);
        
        $this->appendJs('pjAdminOptions.js');
    }
    
    public function pjActionBooking()
	{
        $arr = pjOptionModel::factory()
            ->where('t1.foreign_id', $this->getForeignId())
            ->where('t1.tab_id', 2)
            ->orderBy('t1.order ASC')
            ->findAll()
            ->getData();

        $this->set('arr', $arr);
        $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionOrderForm()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory('pjAdminOptions', 'pjActionOrderForm')->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
        $arr = pjOptionModel::factory()
            ->where('t1.foreign_id', $this->getForeignId())
            ->where('t1.tab_id', 4)
            ->orderBy('t1.order ASC')
            ->findAll()
            ->getData();

        $this->set('arr', $arr);
        $this->appendJs('pjAdminOptions.js');
	}
	public function pjActionDeliveryForm()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory('pjAdminOptions', 'pjActionOrderForm')->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    $arr = pjOptionModel::factory()
	    ->where('t1.foreign_id', $this->getForeignId())
	    ->where('t1.tab_id', 6)
	    ->orderBy('t1.order ASC')
	    ->findAll()
	    ->getData();
	    
	    $this->set('arr', $arr);
	    $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionUpdate()
	{
        if (self::isPost() && $this->_post->check('options_update'))
        {
            if (pjAuth::factory('pjAdminOptions', $this->_post->toString('next_action'))->hasAccess())
            {
                $pjOptionModel = new pjOptionModel();

                foreach ($this->_post->raw() as $key => $value)
                {
                    if (preg_match('/value-(string|text|int|float|enum|bool|color)-(.*)/', $key) === 1)
                    {
                        list(, $type, $k) = explode("-", $key);
                        if (!empty($k))
                        {
                            $_value = ':NULL';
                            if ($value)
                            {
                                switch ($type)
                                {
                                    case 'string':
                                    case 'text':
                                    case 'enum':
                                    case 'color':
                                        $_value = $this->_post->toString($key);
                                        break;
                                    case 'int':
                                    case 'bool':
                                        $_value = $this->_post->toInt($key);
                                        break;
                                    case 'float':
                                        $_value = $this->_post->toFloat($key);
                                        break;
                                }
                            }

                            $pjOptionModel
                                ->reset()
                                ->where('foreign_id', $this->getForeignId())
                                ->where('`key`', $k)
                                ->limit(1)
                                ->modifyAll(array('value' => $_value));
                        }
                    }
                }

                $i18n_arr = $this->_post->toI18n('i18n');
                if (!empty($i18n_arr))
                {
                    pjMultiLangModel::factory()->updateMultiLang($i18n_arr, 1, 'pjOption', 'data');
                }

                switch ($this->_post->toString('next_action'))
                {
                    case 'pjActionIndex':
                        $err = 'AO01';
                        break;
                    case 'pjActionOrders':
                        $err = 'AO02';
                        break;
                    case 'pjActionOrderForm':
                    case 'pjActionDeliveryForm':
                        $err = 'AO03';
                        break;
                    case 'pjActionNotifications':
                        $err = 'AO04&tab_id=' . $this->_post->toString('tab_id');
                        break;
                    case 'pjActionTerm':
                        $err = 'AO05';
                        break;
                    case 'pjActionPrintOrder':
                        $err = 'AO07';
                        break;
                }

                pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOptions&action=" . $this->_post->toString('next_action') . "&err=$err");
            }
            else
            {
                $this->sendForbidden();
                return;
            }
        }
	}

	public function pjActionUpdateTheme()
	{
		$this->setAjax(true);
		
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if(!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		
		if (!$this->_post->has('theme'))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid parameters.'));
		}
		
		pjOptionModel::factory()
			->where('foreign_id', $this->getForeignId())
			->where('`key`', 'o_theme')
			->limit(1)
			->modifyAll(array('value' => 'theme1|theme2|theme3|theme4|theme5|theme6|theme7|theme8|theme9|theme10::' . $this->_post->toString('theme')));
		
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Theme has been changed.'));
	}
	
	public function pjActionNotifications()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    
        $arr = pjOptionModel::factory()
            ->where('t1.foreign_id', $this->getForeignId())
            ->where('t1.tab_id', 3)
            ->orderBy('t1.order ASC')
            ->findAll()
            ->getData();

        $arr['i18n'] = pjMultiLangModel::factory()->getMultiLang(1, 'pjOption');

        $this->set('arr', $arr);

        $this->setLocalesData();

        $this->appendCss('awesome-bootstrap-checkbox.css', PJ_THIRD_PARTY_PATH . 'awesome_bootstrap_checkbox/');
        $this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
        $this->appendJs('tinymce.min.js', PJ_THIRD_PARTY_PATH . 'tinymce/');
        $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionTerm()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    
        $arr = pjOptionModel::factory()
            ->where('t1.foreign_id', $this->getForeignId())
            ->where('t1.tab_id', 5)
            ->orderBy('t1.order ASC')
            ->findAll()
            ->getData();

        $arr['i18n'] = pjMultiLangModel::factory()->getMultiLang(1, 'pjOption');

        $this->set('arr', $arr);

        $this->setLocalesData();

        $this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
        $this->appendJs('tinymce.min.js', PJ_THIRD_PARTY_PATH . 'tinymce/');
        $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionPrintOrder()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    
        $arr = pjOptionModel::factory()
            ->where('t1.foreign_id', $this->getForeignId())
            ->where('t1.tab_id', 7)
            ->orderBy('t1.order ASC')
            ->findAll()
            ->getData();

        $arr['i18n'] = pjMultiLangModel::factory()->getMultiLang(1, 'pjOption');

        $this->set('arr', $arr);

        $this->setLocalesData();

        $this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
        $this->appendJs('tinymce.min.js', PJ_THIRD_PARTY_PATH . 'tinymce/');
        $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionPreview()
	{
        $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionInstall()
	{
        $this->appendJs('pjAdminOptions.js');
	}

	public function pjActionPayments()
	{
		$pjOptionModel = pjOptionModel::factory();
		$arr = $pjOptionModel
			->where('t1.foreign_id', $this->getForeignId())
			->where('tab_id', 3)
			->orderBy('t1.order ASC')
			->findAll()
			->getData();
		$key_arr = 	$pjOptionModel->getDataPair('key');

		$this->set('arr', $arr);
		$this->set('key_arr', $key_arr);
		$this->set('o_arr', $pjOptionModel->reset()->getPairs($this->getForeignId()));

		$this->setLocalesData();

		$this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
		$this->appendJs('pjAdminOptions.js');
	}

	public function pjActionPaymentOptions()
	{
		$this->checkLogin();

		$this->setAjax(true);
		if($this->_post->check('options_update'))
		{
			if (pjObject::getPlugin('pjPayments') !== NULL && $this->_post->check('plugin_payment_options'))
			{
				$this->requestAction(array(
						'controller' => 'pjPayments',
						'action' => 'pjActionSaveOptions',
						'params' => array(
								'foreign_id' => NULL,
								'data' => $this->_post->toArray('plugin_payment_options'),
						)
				), array('return'));
			}
			if(in_array($this->_post->toString('payment_method'), array('cash', 'bank')))
			{
				$pjOptionModel = new pjOptionModel();
				if($this->_post->toString('payment_method') == 'cash')
				{
					$k = 'o_allow_cash';
				}else{
					$k = 'o_allow_bank';
				}
				$value = $this->_post->toString($k) == '1' ? 'Yes|No::Yes' : 'Yes|No::No';
				$pjOptionModel
					->reset()
					->where('foreign_id', $this->getForeignId())
					->where('`key`', $k)
					->limit(1)
					->modifyAll(array('value' => $value));
			}
			if ($this->_post->check('i18n'))
			{
				pjMultiLangModel::factory()->updateMultiLang($this->_post->toI18n('i18n'), $this->getForeignId(), 'pjPayment', 'data');
			}
			if ($this->_post->check('i18n_options'))
            {
                pjMultiLangModel::factory()->updateMultiLang($this->_post->toI18n('i18n_options'), $this->getForeignId(), 'pjOption', 'data');
            }
		}else{
			$this->set('i18n', pjMultiLangModel::factory()->getMultiLang($this->getForeignId(), 'pjPayment'));
			$this->set('i18n_options', pjMultiLangModel::factory()->getMultiLang($this->getForeignId(), 'pjOption'));

			$this->setLocalesData();
		}
	}
	
	public function pjActionNotificationsGetMetaData()
	{
		$this->setAjax(true);
		
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isGet())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
		}
		
		if (!(isset($this->query['recipient']) && pjValidation::pjActionNotEmpty($this->query['recipient'])))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid parameters.'));
		}
		$this->set('arr', pjNotificationModel::factory()
		    ->where('t1.recipient', $this->query['recipient'])
		    ->findAll()
		    ->getData());
	}
	
	public function pjActionNotificationsGetContent()
	{
	    $this->setAjax(true);
	    
	    if (!$this->isXHR())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
	    }
	    
	    if (!self::isGet())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
	    }
	    
	    if (!(isset($this->query['recipient'], $this->query['variant'], $this->query['transport'])
	        && pjValidation::pjActionNotEmpty($this->query['recipient'])
	        && pjValidation::pjActionNotEmpty($this->query['variant'])
	        && pjValidation::pjActionNotEmpty($this->query['transport'])
	        && in_array($this->query['transport'], array('email', 'sms'))
	        ))
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid parameters.'));
	    }
	    
	    $arr = pjNotificationModel::factory()
	    ->where('t1.recipient', $this->query['recipient'])
	    ->where('t1.variant', $this->query['variant'])
	    ->where('t1.transport', $this->query['transport'])
	    ->limit(1)
	    ->findAll()
	    ->getDataIndex(0);
	    
	    if (!$arr)
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Message not found.'));
	    }
	    
	    $arr['i18n'] = pjBaseMultiLangModel::factory()->getMultiLang($arr['id'], 'pjNotification');
	    $this->set('arr', $arr);
	    
	    # Check SMS
	    $this->set('is_sms_ready', (isset($this->option_arr['plugin_sms_api_key']) && !empty($this->option_arr['plugin_sms_api_key']) ? 1 : 0));
	    
	    $this->setLocalesData();
	}
	
	public function pjActionNotificationsSetContent()
	{
	    $this->setAjax(true);
	    
	    if (!$this->isXHR())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
	    }
	    
	    if (!self::isPost())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request.'));
	    }
	    
	    if (!(isset($this->body['id']) && pjValidation::pjActionNumeric($this->body['id'])))
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid parameters.'));
	    }
	    
	    $isToggle = isset($this->body['is_active']) && in_array($this->body['is_active'], array(1,0));
	    $isFormSubmit = isset($this->body['i18n']) && is_array($this->body['i18n']) && !empty($this->body['i18n']);
	    
	    if (!($isToggle xor $isFormSubmit))
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Data mismatch.'));
	    }
	    
	    if ($isToggle)
	    {
	        pjNotificationModel::factory()
	        ->set('id', $this->body['id'])
	        ->modify(array('is_active' => $this->body['is_active']));
	    } elseif ($isFormSubmit) {
	        pjBaseMultiLangModel::factory()->updateMultiLang($this->body['i18n'], $this->body['id'], 'pjNotification');
	    }
	    
	    self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Notification has been updated.'));
	}
}
?>