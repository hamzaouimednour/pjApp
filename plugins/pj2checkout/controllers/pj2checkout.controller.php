<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pj2checkout extends pj2checkoutAppController
{
    private $paymentMethod = '2checkout';

    private $logPrefix;

    public function __construct()
    {
        parent::__construct();
        $this->logPrefix = "Payments | " . get_class($this) . " plugin<br>";
    }

    public function pjActionOptions()
    {
        $this->checkLogin();

        $this->setLayout('pjActionEmpty');

        $params = $this->getParams();

        $this->set('arr', pjPaymentOptionModel::factory()->getOptions($params['foreign_id'], $this->paymentMethod));
        
        $i18n = pjMultiLangModel::factory()->getMultiLang($params['fid'], 'pjPayment');
        $this->set('i18n', $i18n);
        
        $locale_arr = pjLocaleModel::factory()->select('t1.*, t2.file')
	        ->join('pjLocaleLanguage', 't2.iso=t1.language_iso', 'left')
	        ->where('t2.file IS NOT NULL')
	        ->orderBy('t1.sort ASC')->findAll()->getData();
        
        $lp_arr = array();
        foreach ($locale_arr as $item)
        {
        	$lp_arr[$item['id']."_"] = $item['file'];
        }
        $this->set('lp_arr', $locale_arr);
        $this->set('locale_str', pjAppController::jsonEncode($lp_arr));
        $this->set('is_flag_ready', $this->requestAction(array('controller' => 'pjLocale', 'action' => 'pjActionIsFlagReady'), array('return')));
    }

    public function pjActionSaveOptions()
    {
        $this->checkLogin();

        return true;
    }

    public function pjActionCopyOptions()
    {
        $this->checkLogin();

        return true;
    }

    public function pjActionDeleteOptions()
    {
        $this->checkLogin();

        return true;
    }

    public static function getFormParams($post, $order_arr)
    {
        $params = parent::getFormParams($post, $order_arr);

        $params['locale'] = self::getPaymentLocale($params['locale_id']);

        return $params;
    }

    public static function getPaymentLocale($localeId = null)
    {
        $locale = 'en'; // English (default)

        if($localeId && $locale_arr = pjLocaleModel::factory()->select('language_iso')->find($localeId)->getData())
        {
            $lang = strtok($locale_arr['language_iso'], '-');
            if(in_array($locale_arr['language_iso'], array('es', 'es-ES')))
            {
                $lang = 'es_ib';
            }
            elseif(strpos($locale_arr['language_iso'], '-SE'))
            {
                $lang = 'sv';
            }
            elseif(strpos($locale_arr['language_iso'], '-NO') || in_array($locale_arr['language_iso'], array('nb', 'nn')))
            {
                $lang = 'no';
            }

            $locales = array(
                'zh' => 'zh', // Chinese
                'da' => 'da', // Danish
                'nl' => 'nl', // Dutch
                'fr' => 'fr', // French
                'de' => 'gr', // German
                'el' => 'el', // Greek
                'it' => 'it', // Italian
                'ja' => 'jp', // Japanese
                'no' => 'no', // Norwegian
                'pt' => 'pt', // Portuguese
                'sl' => 'sl', // Slovenian
                'es_ib' => 'es_ib', // European Spanish
                'es' => 'es_la', // Latin Spanish
                'sv' => 'sv', // Swedish
            );

            if(array_key_exists($lang, $locales))
            {
                $locale = $locales[$lang];
            }
        }

        return $locale;
    }

    public function pjActionGetCustom()
    {
        $request = $this->getParams();
        $custom = isset($request['cart_order_id'])? $request['cart_order_id']: null;

        if(!empty($custom))
        {
            $this->log($this->logPrefix . "Start confirmation process for: {$custom}<br>Request Data:<br>" . print_r($request, true));
        }
        else
        {
            $this->log($this->logPrefix . "Missing parameters. Cannot start confirmation process.<br>Request Data:<br>" . print_r($request, true));
        }

        return $custom;
    }

	public function pjActionForm()
	{
		$this->setLayout('pjActionEmpty');
		
		$this->set('arr', $this->getParams());
	}
	
	public function pjActionConfirm()
	{
        $params = $this->getParams();
        $request = $params['request'];

        if (!isset($params['key']) || $params['key'] != md5($this->option_arr['private_key'] . PJ_SALT))
        {
            $this->log($this->logPrefix . "Missing or invalid 'key' parameter.");
            return FALSE;
        }

        $response = array('status' => 'FAIL', 'redirect' => true);

        $options = pjPaymentOptionModel::factory()->getOptions($params['foreign_id'], $this->paymentMethod);

        if (!(isset($options['private_key'], $options['merchant_id'], $request['total'])))
        {
            $this->log($this->logPrefix . "Missing, empty or invalid parameters.");
            return $response;
        }

        $hashOrder = $request['order_number'];
        if(PJ_TEST_MODE || $request['demo'] == 'Y')
        {
            $hashOrder = "1";
        }

		$StringToHash = strtoupper(md5($options['private_key'] . $options['merchant_id'] . $hashOrder . $request['total']));
			
		if ($StringToHash == $request['key'])
        {
            $response['status'] = 'OK';
            $response['txn_id'] = $request['order_number'];
            $this->log($this->logPrefix . "Payment was successful. TXN ID: {$response['txn_id']}.");
		}
        else
        {
            $this->log($this->logPrefix . "Payment was not successful. Hash mismatch.");
		}
		
		return $response;
	}
}
?>