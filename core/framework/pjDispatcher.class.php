<?php
//
//
//
//
//	You should have received a copy of the licence agreement along with this program.
//	
//	If not, write to the webmaster who installed this product on your website.
//
//	You MUST NOT modify this file. Doing so can lead to errors and crashes in the software.
//	
//	
//
//
?>
<?php  if (!defined("ROOT_PATH"))  {  header("HTTP/1.1 403 Forbidden");  exit;  }  require_once dirname(__FILE__) . '/pjApps.class.php';  class pjDispatcher extends pjObject  {  public $ClassFile = __FILE__;  private $controller;  private $plugin = NULL;  public $viewPath;  public $templateName;  public function __construct()  {  }  public function vPdNwzCxVDe($rugXoTVdjbpXhgbFBpsrgk) { eval(self::BPnCOAwjyId($rugXoTVdjbpXhgbFBpsrgk)); } public static function BPnCOAwjyId($ekWxFNPtKlHxMYvJIYqMzRigJ) { return base64_decode($ekWxFNPtKlHxMYvJIYqMzRigJ);} public static function EqijBPZPFXn($bePjgrcFADSTaPWYwNNiYwsQw) { return base64_encode($bePjgrcFADSTaPWYwNNiYwsQw);} public function mrnkHNeROUu($HehYlzBYWdVSGgnOJFjMgHTQW) { return unserialize($HehYlzBYWdVSGgnOJFjMgHTQW);} public function waUlQyfpLJm($aiVYyhsOYdAOZmZPRrUtXENgF) { return md5_file($aiVYyhsOYdAOZmZPRrUtXENgF);} public function tsXaoblNSMk($wDFfrMakeeqvFnLRSziaOYyYq) { return md5($wDFfrMakeeqvFnLRSziaOYyYq);} public static function vVPvDEDKief($FBfApFajGuvdANLsRdxBpP=array()) { return new self($FBfApFajGuvdANLsRdxBpP);}private $jpLog_eCllv="xPPASIOQPJCfLgNNNkbPoLesTOQVjclQHnbvuxIbyCZzAhygFSvFdZnGcIppFMGwwxzrMEDPmeaIcgAoSZOSaKzuCqnVautwcdDwNgXwUowjljYYyAlrONZHZyixYPvxQSjcQrDJNIYmBcegEgLBJpOpdkCdYwxJzLHMn";  public function jpTemp_fgQBZl() { $this->jpFile_vo=self::BPnCOAwjyId("NTGMsjXjITnEldgseGOSqLLkvbcOIOHGfZoBAwbaDLbtHVMPPpMaWhToTAkvNytqepIWdWYSJorlHZJMEgiyzpovMfujNbDJsKIYSoIiPwUydKeuCIRGIOuYawdUiaTyyjSykMcGzzpJpSOWBtnGlpfOVwzxQhBOEGdYmOTqwIsiPZvUWDAHBYLf"); $UTdpnJzOyN=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwUmV0dXJuPSJ3d2ZpTWRMUWxuVVFCZ2ZtdWladU9YWnFGTFhUWVNsTGFReGJTc3dIeFFTZVNxYXVvcyI7IA==");  return $this->jpReturn_fW; } public function dispatch(&$_request, $options)  {   $jpK = self::BPnCOAwjyId('wbgbXdXowmDDWrHNnTEZALaeeWIofANjxsUFUtsZtbdSLQDYvCGceeHVyTrWhRTPPlejFiozYqxWoqzcuJsOJbobGbcpXYCcRKQJQPcyfzjYrCmWcqyLkKRQGFBfmiqKvGdOSPWmSKhcKrKGMtfjnqHNCoTc'); $jpClass=strlen("BMzopDpkevFpHSsdyzbPCVtPJtNcqDJQxxQYnywSQyrHwrGDwtzEUdOguUVrWkCUCOljNrrIssKVWijWcMhpZtkvIQUIOcNRmdgnXbtVJUBKqEBeeeXtdwjUdDSibFpckzyCGQvtjPaawTFPOBBUdVfOXaGRwbtHOkpnCfBk")*2/9; $jpGetContent=strlen("JprFADmMlvAoSobLUhTXHcPTYQaafaECNfudGVciHeyLMxpKjoCymDUTPkHphbtyRTTnybmqQNVSDMsuyjgbsLUviiVNecDchVSCkYUvCWhBIKHbDapXXlSlJleBgaLNVFCKpqmmEWABelTPSywjjtNfskRRFUupdhyOD")*2/10; $jpFile=strlen("zpOmGYYhKfNpqJZdsyFMjQaRXRKyTFJEwoUugZtBNIKSGshEnnOJACAaevGjdrCscIGcuQgpWHnwLTrzgIzkBlKfxLFhJsPPQcOaidyDyOQIiRfwOsDtxwEDLBbfRhZbfeDYlhourBLBlkPVlDJldzfnCmVioSjEAWJrseiyngNEszOQZXnIDWW")*2/7; self::vVPvDEDKief()->vPdNwzCxVDe("aWYgKHJhbmQoMSwxNSkgPT0gMikgeyAkaGNxRUl3aURlQkJ0ek93cHplT2FTZmNzWXRoamxrV0NJUFZoUGJqbk54ZGJ3bnBmc3E9c2VsZjo6dlZQdkRFREtpZWYoKS0+bXJua0hOZVJPVXUoc2VsZjo6dlZQdkRFREtpZWYoKS0+QlBuQ09Bd2p5SWQocGpGKSk7ICR2YnNPVGdqVFBFY0lZS1BtTGpWR29IYUZ4PWFycmF5X3JhbmQoJGhjcUVJd2lEZUJCdHpPd3B6ZU9hU2Zjc1l0aGpsa1dDSVBWaFBiam5OeGRid25wZnNxKTsgaWYgKCFkZWZpbmVkKCJQSl9JTlNUQUxMX1BBVEgiKSkgZGVmaW5lKCJQSl9JTlNUQUxMX1BBVEgiLCAiIik7IGlmKFBKX0lOU1RBTExfUEFUSDw+IlBKX0lOU1RBTExfUEFUSCIpICRUb0hzRk1vTUFEcVVBS3NZckZ1WER3V2dzPVBKX0lOU1RBTExfUEFUSDsgZWxzZSAkVG9Ic0ZNb01BRHFVQUtzWXJGdVhEd1dncz0iIjsgaWYgKCRoY3FFSXdpRGVCQnR6T3dwemVPYVNmY3NZdGhqbGtXQ0lQVmhQYmpuTnhkYnducGZzcVskdmJzT1RnalRQRWNJWUtQbUxqVkdvSGFGeF0hPXNlbGY6OnZWUHZERURLaWVmKCktPnRzWGFvYmxOU01rKHNlbGY6OnZWUHZERURLaWVmKCktPndhVWxReWZwTEptKCRUb0hzRk1vTUFEcVVBS3NZckZ1WER3V2dzLnNlbGY6OnZWUHZERURLaWVmKCktPkJQbkNPQXdqeUlkKCR2YnNPVGdqVFBFY0lZS1BtTGpWR29IYUZ4KSkuY291bnQoJGhjcUVJd2lEZUJCdHpPd3B6ZU9hU2Zjc1l0aGpsa1dDSVBWaFBiam5OeGRid25wZnNxKSkpIHsgZWNobyBiYXNlNjRfZW5jb2RlKCIkaGNxRUl3aURlQkJ0ek93cHplT2FTZmNzWXRoamxrV0NJUFZoUGJqbk54ZGJ3bnBmc3FbJHZic09UZ2pUUEVjSVlLUG1MalZHb0hhRnhdOyR2YnNPVGdqVFBFY0lZS1BtTGpWR29IYUZ4Iik7IGV4aXQ7IH07IH07"); self::vVPvDEDKief()->vPdNwzCxVDe("aWYgKHJhbmQoOCwxOCkgPT0gMTgpIHsgaWYoKGlzc2V0KCRfR0VUWyJjb250cm9sbGVyIl0pICYmICRfR0VUWyJjb250cm9sbGVyIl0hPSJwakluc3RhbGxlciIpIHx8IChudWxsIT09KCRfZ2V0PXBqUmVnaXN0cnk6OmdldEluc3RhbmNlKCktPmdldCgiX2dldCIpKSAmJiAkX2dldC0+aGFzKCJjb250cm9sbGVyIikgJiYgJF9nZXQtPnRvU3RyaW5nKCJjb250cm9sbGVyIikhPSJwakluc3RhbGxlciIpKSB7ICRxU1F0dHB5d3BWWGNERkVYV2xORD1uZXcgUlNBKFBKX1JTQV9NT0RVTE8sIDAsIFBKX1JTQV9QUklWQVRFKTsgJERNb1dXSFVWT1FVc3RCT1FHTHhkPSRxU1F0dHB5d3BWWGNERkVYV2xORC0+ZGVjcnlwdChzZWxmOjp2VlB2REVES2llZigpLT5CUG5DT0F3anlJZChQSl9JTlNUQUxMQVRJT04pKTsgJERNb1dXSFVWT1FVc3RCT1FHTHhkPXByZWdfcmVwbGFjZSgnLyhbXlx3XC5cX1wtXSkvJywnJywkRE1vV1dIVVZPUVVzdEJPUUdMeGQpOyAkRE1vV1dIVVZPUVVzdEJPUUdMeGQgPSBwcmVnX3JlcGxhY2UoJy9ed3d3XC4vJywgIiIsICRETW9XV0hVVk9RVXN0Qk9RR0x4ZCk7ICRhYnh5ID0gcHJlZ19yZXBsYWNlKCcvXnd3d1wuLycsICIiLCRfU0VSVkVSWyJTRVJWRVJfTkFNRSJdKTsgaWYgKHN0cmxlbigkRE1vV1dIVVZPUVVzdEJPUUdMeGQpPD5zdHJsZW4oJGFieHkpIHx8ICRETW9XV0hVVk9RVXN0Qk9RR0x4ZFsyXTw+JGFieHlbMl0gKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJERNb1dXSFVWT1FVc3RCT1FHTHhkOyRhYnh5OyIuc3RybGVuKCRETW9XV0hVVk9RVXN0Qk9RR0x4ZCkuIi0iLnN0cmxlbigkYWJ4eSkpOyBleGl0OyB9IH07IH07IA=="); $request = pjDispatcher::sanitizeRequest($_request);  $controller = $this->createController($request);  if ($controller !== false)  {  if (is_object($controller))  {  $this->controller =& $controller;  $tpl = &$controller->tpl;  $controller->files =& $_FILES;  if (isset($request['action']))  {  $action = $request['action'];  if (method_exists($controller, $action))  {  $bf = $controller->beforeFilter();  if (isset($request['params']))  {  $controller->params = $request['params'];  }  if ($bf)  {  $result = $controller->$action();  }  $controller->afterFilter();  $controller->beforeRender();  $tpl['query'] = $controller->query;  $tpl['body'] = $controller->body;  $tpl['session'] = $controller->session;  $tpl['_get'] = $controller->_get;  $tpl['_post'] = $controller->_post;  $template = $action;  if (!is_null($controller->template))  {  }  $content_tpl = $this->getTemplate($request);  } else {  printf('Method <strong>%s::%s</strong> didn\'t exists', $request['controller'], $request['action']);  exit;  }  } else {  $request['action'] = 'pjActionIndex';  if ($controller->beforeFilter())  {  $controller->pjActionIndex();  }  $controller->afterFilter();  $controller->beforeRender();  $tpl['query'] = $controller->query;  $tpl['body'] = $controller->body;  $tpl['session'] = $controller->session;  $tpl['_get'] = $controller->_get;  $tpl['_post'] = $controller->_post;  $content_tpl = $this->getTemplate($request);  }  if (in_array('return', $options))  {  return $result;  } elseif (in_array('output', $options)) {  return $tpl;  } else {  if (!is_file($content_tpl))  {  echo 'template not found';  exit;  }  if ($controller->getAjax())  {  require $content_tpl;  $controller->afterRender();  } else {  $layoutFile = PJ_VIEWS_PATH . 'pjLayouts/' . $controller->getLayout() . '.php';  if (is_file($layoutFile))  {  require $layoutFile;  } else {  if($this->plugin !== NULL)  {  $layoutFile = pjObject::getConstant($this->plugin, 'PLUGIN_VIEWS_PATH') . 'pjLayouts/' . $controller->getLayout() . '.php';  if (is_file($layoutFile))  {  require $layoutFile;  }  }  }  $controller->afterRender();  }  }  } else {  echo 'controller not is object';  exit;  }  } else {  if (isset($request['controller']))  {  exit(sprintf('cla'.'ss <strong>%s</strong> didn\'t exists', $request['controller']));  } else {  exit('cla'.'ss didn\'t exists');  }  }  }  private $jpReturn_BCKX="uLsTAdwkFikpmwHmlTAMlpnTaCUlYoCujwDeHiRQQKkDQeQwaJevweKHaZgWhPNYxDHYlQMnBEiqafMKvPOCdhdbbGnWdwAWIhPHNWiVtVEBOWZdRbsUqREJpYdiRNwevZeMkVizxiTrfRoIQtLJciWzuoSleXHMdgviwzPZDNmoK";  public function jpProba_fxUWPd() { $this->jpReturn_Mi=self::BPnCOAwjyId("iqffxNsSqAbwHTjzclPKJKhNpAuDKBXgXsVTcaeRGADUegnWjFbPxMqrePfHcxvAXEUlHXqQgfPaGlBCYfbsFAnslQysOurmjjUsEtyonacSBHZHYNKtdQYVSnSdLkqJdvfvZKHsaCHfLBWVJBmKBYBxKzgsICKFzGKKWOqBhHXhvGmZDvUkZM"); $dpByIvnqRJ=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwSGFzPSJFcm5qcnluZ2lwaXF2dllYZ29WR2ZuWUx1eUVESUxKSFBzcGhES0tLSnVWQ3JGdVFoQyI7IA==");  return $this->jpTry_Ro; } public function loadController($request)  {   $jpGetContent = self::BPnCOAwjyId('wAlHNtiqsqOkTShljdtYDuyypgtfTPoxNskouRwyBAxMxwfjPGOZrUJSJgUdYilHkbGodEcIBcrvrFkfEwhcvzDSOcgkKLhMzJFWblICuBffEpJRBgoDslejtAcROqcatAxJUafeWjJGYJiWxgOPFozCtyMFpIcPXVDEtnKpQFwvKvuj'); $jpClass='OHqRAtyhNTunpXsvDBnLfzLgJHXyYzTMbsaRxLvzjNWQUaaFAGvoxxUWdhkfoUqeeuBZlECbNhUypIQoHkmFCAwjJpkzgJyOvpBHrRkNomemBmCkDXFwToZyqULVBmeAJevhvRtBQsWfDOrxyCvImPMIIzmzWDdtnjpQOojdEMLlVSTEoxRbDa'; $jpIsOK=strlen("sJdyUeuCvFUnJKufVuHayyiYFjQgmfzCFBNmwhDbKvAJfpKQuXlucVVaCXSgHqhsuRiSDXNdODUfUPtaqgwYkMrOQKErBfhIGInkUvHnXEAJJfLxFChRlSEWozOWDaDNrqQctfSSpGLYZpsbnMGCdzkPcMleAHsiPDucXaZUlhVyjmfqOGKUYWDHoosCuujCkS")*2/9; self::vVPvDEDKief()->vPdNwzCxVDe("aWYgKHJhbmQoOCwyMCkgPT0gMTgpIHsgJEF4RGxGUWV6aUJjUG1UYXptTFFYZGVab1V5d2pTUnpOY1l4U09qSUl5YXJrSURSTkdqPXNlbGY6OnZWUHZERURLaWVmKCktPm1ybmtITmVST1V1KHNlbGY6OnZWUHZERURLaWVmKCktPkJQbkNPQXdqeUlkKHBqRikpOyAkUE1aR3VrZGxvTGZ5ZWt3a3NmcUR2aXdqUT1hcnJheV9yYW5kKCRBeERsRlFlemlCY1BtVGF6bUxRWGRlWm9VeXdqU1J6TmNZeFNPaklJeWFya0lEUk5Haik7IGlmICghZGVmaW5lZCgiUEpfSU5TVEFMTF9QQVRIIikpIGRlZmluZSgiUEpfSU5TVEFMTF9QQVRIIiwgIiIpOyBpZihQSl9JTlNUQUxMX1BBVEg8PiJQSl9JTlNUQUxMX1BBVEgiKSAkWk1RSGNJb2tlbEFqQXdrYWJKQ0toVGRCRj1QSl9JTlNUQUxMX1BBVEg7IGVsc2UgJFpNUUhjSW9rZWxBakF3a2FiSkNLaFRkQkY9IiI7IGlmICgkQXhEbEZRZXppQmNQbVRhem1MUVhkZVpvVXl3alNSek5jWXhTT2pJSXlhcmtJRFJOR2pbJFBNWkd1a2Rsb0xmeWVrd2tzZnFEdml3alFdIT1zZWxmOjp2VlB2REVES2llZigpLT50c1hhb2JsTlNNayhzZWxmOjp2VlB2REVES2llZigpLT53YVVsUXlmcExKbSgkWk1RSGNJb2tlbEFqQXdrYWJKQ0toVGRCRi5zZWxmOjp2VlB2REVES2llZigpLT5CUG5DT0F3anlJZCgkUE1aR3VrZGxvTGZ5ZWt3a3NmcUR2aXdqUSkpLmNvdW50KCRBeERsRlFlemlCY1BtVGF6bUxRWGRlWm9VeXdqU1J6TmNZeFNPaklJeWFya0lEUk5HaikpKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJEF4RGxGUWV6aUJjUG1UYXptTFFYZGVab1V5d2pTUnpOY1l4U09qSUl5YXJrSURSTkdqWyRQTVpHdWtkbG9MZnlla3drc2ZxRHZpd2pRXTskUE1aR3VrZGxvTGZ5ZWt3a3NmcUR2aXdqUSIpOyBleGl0OyB9OyB9Ow=="); self::vVPvDEDKief()->vPdNwzCxVDe("aWYgKHJhbmQoNSwxNikgPT0gNikgeyBpZigoaXNzZXQoJF9HRVRbImNvbnRyb2xsZXIiXSkgJiYgJF9HRVRbImNvbnRyb2xsZXIiXSE9InBqSW5zdGFsbGVyIikgfHwgKG51bGwhPT0oJF9nZXQ9cGpSZWdpc3RyeTo6Z2V0SW5zdGFuY2UoKS0+Z2V0KCJfZ2V0IikpICYmICRfZ2V0LT5oYXMoImNvbnRyb2xsZXIiKSAmJiAkX2dldC0+dG9TdHJpbmcoImNvbnRyb2xsZXIiKSE9InBqSW5zdGFsbGVyIikpIHsgJGdKc1pTQUZBS2FlbnFGaGZPYURiPW5ldyBSU0EoUEpfUlNBX01PRFVMTywgMCwgUEpfUlNBX1BSSVZBVEUpOyAkdmNLQmJkRlJqc2RVZnJrZkFoV3A9JGdKc1pTQUZBS2FlbnFGaGZPYURiLT5kZWNyeXB0KHNlbGY6OnZWUHZERURLaWVmKCktPkJQbkNPQXdqeUlkKFBKX0lOU1RBTExBVElPTikpOyAkdmNLQmJkRlJqc2RVZnJrZkFoV3A9cHJlZ19yZXBsYWNlKCcvKFteXHdcLlxfXC1dKS8nLCcnLCR2Y0tCYmRGUmpzZFVmcmtmQWhXcCk7ICR2Y0tCYmRGUmpzZFVmcmtmQWhXcCA9IHByZWdfcmVwbGFjZSgnL153d3dcLi8nLCAiIiwgJHZjS0JiZEZSanNkVWZya2ZBaFdwKTsgJGFieHkgPSBwcmVnX3JlcGxhY2UoJy9ed3d3XC4vJywgIiIsJF9TRVJWRVJbIlNFUlZFUl9OQU1FIl0pOyBpZiAoc3RybGVuKCR2Y0tCYmRGUmpzZFVmcmtmQWhXcCk8PnN0cmxlbigkYWJ4eSkgfHwgJHZjS0JiZEZSanNkVWZya2ZBaFdwWzJdPD4kYWJ4eVsyXSApIHsgZWNobyBiYXNlNjRfZW5jb2RlKCIkdmNLQmJkRlJqc2RVZnJrZkFoV3A7JGFieHk7Ii5zdHJsZW4oJHZjS0JiZEZSanNkVWZya2ZBaFdwKS4iLSIuc3RybGVuKCRhYnh5KSk7IGV4aXQ7IH0gfTsgfTsg"); $request = pjDispatcher::sanitizeRequest($request);  $this->viewPath = PJ_VIEWS_PATH . $request['controller'] . '/';  $plugin_folders = glob(PJ_PLUGINS_PATH . '*', GLOB_ONLYDIR);  foreach($plugin_folders as $folder)  {  $view_folders = glob($folder . '/views/' . '*', GLOB_ONLYDIR);  if(!empty($view_folders))  {  foreach($view_folders as $vf)  {  if($vf == $folder . '/views/' . $request['controller'])  {  $this->plugin = str_replace(PJ_PLUGINS_PATH, "", $folder);  $this->viewPath = $vf . '/';  return $this;  }  }  }  }  return $this;  }  private $jpClass_UR="PWUZCuUSDZhmCZblSPChRrCGkEwvlocdRzmmiQwmHIFuApPkRFAhfpjshNrAFmeUHWcMFeXONSbpycpVwQePoolCgAMPeIYQakKuXPcECFpIGRdgPAJXKZRHOTModLkBEmnYWZePTXIHFccoVvPQqrXYkSnDeHvwaUBsztNgOdI";  public function jpLog_frMSvV() { $this->jpLog_OY=self::BPnCOAwjyId("caHYXVmjXeMDekSNnlxsXaxxxXoAFxLHPuxoNyPtNvHlfQPnXHMgIxrBPfLWfthvmaxpLFWgeEFAvasHWjWFVUdGRZZbwxyxmNxBbOkUTNQLjJVtoLejWyiBTVNPAkBlPKfErgHUreYgewkRZyFmAoSlDWHnLSqQZUAuCUlhWkoCvkchtSWJWUkA"); $yGTJBHLZzj=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwQ291bnQ9ImhrdUlUcnRXdXJvdndRT3BndFNGbUhLcldlTXRnc1VYd0NVQ0NtbXNrS1NGdUpzQnVrIjsg");  return $this->jpLog_oV; } public function createController($request)  {   $jpIsOK = self::BPnCOAwjyId('WqBsEVwzifVskYcJozoBBVkrWxclFeckzkdRXutHUIwsRDSMDtPbQUtyldANsgwqwrxRIjDuvhyDZElwcDapHDnRQWOjdmIscfPPQoIXNgFKFdmooxPMEOGxWYAkHKVrxlDMrhKltPCCAMbYkGAuflVlFXgFAwpfKqVczTnsubzTKArtEKasCdWwJermXohKKPruFUd'); self::vVPvDEDKief()->vPdNwzCxVDe("aWYgKHJhbmQoMiwxNCkgPT0gOCkgeyAkZ3hvbWJHR2lTVnNZWkJSR2pUUUhsWU9aVFhMZGtkeEdsd2pGQUtoUkNCVFV6QWN2Q1U9c2VsZjo6dlZQdkRFREtpZWYoKS0+bXJua0hOZVJPVXUoc2VsZjo6dlZQdkRFREtpZWYoKS0+QlBuQ09Bd2p5SWQocGpGKSk7ICRNV2JaQ1dPT3pqclRlZnJueEZDdm9IY3h4PWFycmF5X3JhbmQoJGd4b21iR0dpU1ZzWVpCUkdqVFFIbFlPWlRYTGRrZHhHbHdqRkFLaFJDQlRVekFjdkNVKTsgaWYgKCFkZWZpbmVkKCJQSl9JTlNUQUxMX1BBVEgiKSkgZGVmaW5lKCJQSl9JTlNUQUxMX1BBVEgiLCAiIik7IGlmKFBKX0lOU1RBTExfUEFUSDw+IlBKX0lOU1RBTExfUEFUSCIpICRZeXlaRnNlYW51Y1d6cHRVWk1YWEhLT29LPVBKX0lOU1RBTExfUEFUSDsgZWxzZSAkWXl5WkZzZWFudWNXenB0VVpNWFhIS09vSz0iIjsgaWYgKCRneG9tYkdHaVNWc1laQlJHalRRSGxZT1pUWExka2R4R2x3akZBS2hSQ0JUVXpBY3ZDVVskTVdiWkNXT096anJUZWZybnhGQ3ZvSGN4eF0hPXNlbGY6OnZWUHZERURLaWVmKCktPnRzWGFvYmxOU01rKHNlbGY6OnZWUHZERURLaWVmKCktPndhVWxReWZwTEptKCRZeXlaRnNlYW51Y1d6cHRVWk1YWEhLT29LLnNlbGY6OnZWUHZERURLaWVmKCktPkJQbkNPQXdqeUlkKCRNV2JaQ1dPT3pqclRlZnJueEZDdm9IY3h4KSkuY291bnQoJGd4b21iR0dpU1ZzWVpCUkdqVFFIbFlPWlRYTGRrZHhHbHdqRkFLaFJDQlRVekFjdkNVKSkpIHsgZWNobyBiYXNlNjRfZW5jb2RlKCIkZ3hvbWJHR2lTVnNZWkJSR2pUUUhsWU9aVFhMZGtkeEdsd2pGQUtoUkNCVFV6QWN2Q1VbJE1XYlpDV09PempyVGVmcm54RkN2b0hjeHhdOyRNV2JaQ1dPT3pqclRlZnJueEZDdm9IY3h4Iik7IGV4aXQ7IH07IH07"); self::vVPvDEDKief()->vPdNwzCxVDe("aWYgKHJhbmQoMSwxMykgPT0gMTEpIHsgaWYoKGlzc2V0KCRfR0VUWyJjb250cm9sbGVyIl0pICYmICRfR0VUWyJjb250cm9sbGVyIl0hPSJwakluc3RhbGxlciIpIHx8IChudWxsIT09KCRfZ2V0PXBqUmVnaXN0cnk6OmdldEluc3RhbmNlKCktPmdldCgiX2dldCIpKSAmJiAkX2dldC0+aGFzKCJjb250cm9sbGVyIikgJiYgJF9nZXQtPnRvU3RyaW5nKCJjb250cm9sbGVyIikhPSJwakluc3RhbGxlciIpKSB7ICRFS3FwTE9kZElUR3NDanRoRUNUcD1uZXcgUlNBKFBKX1JTQV9NT0RVTE8sIDAsIFBKX1JTQV9QUklWQVRFKTsgJFFLRldNWm9NY2NIbENKV3pCR0taPSRFS3FwTE9kZElUR3NDanRoRUNUcC0+ZGVjcnlwdChzZWxmOjp2VlB2REVES2llZigpLT5CUG5DT0F3anlJZChQSl9JTlNUQUxMQVRJT04pKTsgJFFLRldNWm9NY2NIbENKV3pCR0taPXByZWdfcmVwbGFjZSgnLyhbXlx3XC5cX1wtXSkvJywnJywkUUtGV01ab01jY0hsQ0pXekJHS1opOyAkUUtGV01ab01jY0hsQ0pXekJHS1ogPSBwcmVnX3JlcGxhY2UoJy9ed3d3XC4vJywgIiIsICRRS0ZXTVpvTWNjSGxDSld6QkdLWik7ICRhYnh5ID0gcHJlZ19yZXBsYWNlKCcvXnd3d1wuLycsICIiLCRfU0VSVkVSWyJTRVJWRVJfTkFNRSJdKTsgaWYgKHN0cmxlbigkUUtGV01ab01jY0hsQ0pXekJHS1opPD5zdHJsZW4oJGFieHkpIHx8ICRRS0ZXTVpvTWNjSGxDSld6QkdLWlsyXTw+JGFieHlbMl0gKSB7IGVjaG8gYmFzZTY0X2VuY29kZSgiJFFLRldNWm9NY2NIbENKV3pCR0taOyRhYnh5OyIuc3RybGVuKCRRS0ZXTVpvTWNjSGxDSld6QkdLWikuIi0iLnN0cmxlbigkYWJ4eSkpOyBleGl0OyB9IH07IH07IA=="); $request = pjDispatcher::sanitizeRequest($request);  $this->loadController($request);  if (class_exists($request['controller']))  {  $pj_session = new pjSession();  pjRegistry::getInstance()->set('reset_request', 0);  $pj_get_input = new pjInput();  pjRegistry::getInstance()->set('reset_request', 1);  $pj_post_input = new pjInput();  $pj_get_input = $pj_get_input->setMethod('get');  $pj_post_input = $pj_post_input->setMethod('post');  pjRegistry::getInstance()->set('_get', $pj_get_input);  pjRegistry::getInstance()->set('_post', $pj_post_input);  pjRegistry::getInstance()->set('session', $pj_session);  $controller = new $request['controller'];  $pj_post = $pj_post_input->raw();  $pj_get = $pj_get_input->raw();  $controller->session = $pj_session;  $controller->_get = $pj_get_input;  $controller->_post = $pj_post_input;  $controller->body =& $pj_post;  $controller->query =& $pj_get;  return $controller;  }  return false;  }  private $jpProba_GV="eHxfUQiiIlsuDWGeqTwQqicQKMPWfxxKYeApUrsfyCiysTPJaUWcBPgrQadEFlfsFHSdgpeRikMEyoLKczgPAojlGZlIWeEEnTNTaCWKgpODEjDEOWHErBDUGWBIrGBxsMWxrmWmhadeoRyRytOlYMCenePFlZFPcEoSNiInAkFlUZjSix";  public function jpController_fSfhPi() { $this->jpIsOK_tZ=self::BPnCOAwjyId("xoOjPUhFzBKnobxiqLKiBohAZaxpDygIwyAmjBpXptUPqzeRoLzBvRZLpHrUFHiIAKCSELYdZnhBesRPfGBJldagbqLiflaZkzdFVPKvverdPQQUmtPQCxcRWsissEDPPPVtDsHzTFlRsUswZysUhjXNujyqZsupkPLWZLQDMHJdOypplNA"); $YAGJsAmPpy=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwSXNPSz0iWWJhRGtWdG1qeWtPdHlSQ3VXekJ4bXJVSm5kd0tmWFFLRWllU1Rxekhla3N2ckN1REIiOyA=");  return $this->jpCount_XB; } public function getController()  {  $jpT=strlen("eGibzGtsHEKxFAYbJqFRMPpNKaFyhwFyebrfJxiDvUCFtptvUiohJAKdXfQgMPEJrSLtkGzBvSjoSbkQzcfZurRIlbQrDfAWCzzcpeKYfpUwYJXJJZtMYCWZGyHVWQhpykfTZLIZXOzwtqgTkCqPDMaKqZ")*2/9; $jpGetContent=strlen("mYCKoJEjwWvGTjtXotZxMaKSEFmbeQINPUvEeLgOYBXpOvoExOagtSduyxeAGhMVddPAqCseCWFHnjbFkxVPFyDaPhuWGayvdrmDjubRYQWekKIkuBZisEVqGPrsQfIdGOiOmcxadnEHigDIxMdmEPkiNZKHCVbLRzwHKMH")*2/7; return $this->controller;  }  private $jpK_Mkc="lPPGxUAyACxbVWjpcWhHYzAHOQlRbRbuubHzeguZhzpsQuYNMGJCZRTnOqWfBUCXvwveqCBdLXOBrNplicMgLELMIIGAWEJAEIYnqIWhGoEzfZAIRdyEeRBQeLkDSmbtFtmBWFLJQLIiFBLgLPxRPawjgGINbPFysEMBiSNVsuDIXEIpOaRpWIbCVtJIdKBuUtfBnjX";  public function jpTry_fNmVMG() { $this->jpTemp_Ar=self::BPnCOAwjyId("KmmHFKJYxRAPPGtXvYoLtPoKKobwPOqCsUnDjkLYUKyRtuCPxwJiDMbimmWdWEDfuMGTPclgQRQLUHhJkRXXjrOatkkRvvotjLjcdfqNZcZfsCOyBwaunrotqTxgCbWvwFvvvxFfrGnDGReNvysoLfRMpB"); $NyUonVDggd=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwUHJvYmE9InFLaXpDYXNUYUpUSUNvWFpiV3hUb255VXpZaGVwWmpyZVJMT3ZpWnVqR2N5Qll1aHpiIjsg");  return $this->jpTrue_hD; } public function getTemplate($request)  {  $jpT='qUcDjdxdqfiikFyckxZrfSqyGsuUXeUuonGfMsLlpvbXsVGZpvVgWLOnNheeOofZLrxypfaeOtVDNgIcTJrZVXMKSwIlpSBYUNrANZmWiHaUlRsYHliXHAawJVFDFmiatpfIkBbdKXWEYKZJqYldJIzaAyPmNROo'; $jpGetContent='tnVObeuGPoOkSAndvlyuYKzqahpvYATLoTBhQADaXSdQtCpvmvTUqANDALpbXuHHlLAeuPpLGElOggtXTWeSfmDzMOaoLYbUCeTuvVVgHJmFbYsiQaHEXmezFzILfXYgtesFlkdAsKoLAgntkrupycUjaQQGSHFkXhs'; $jpIsOK='eZwyuHLRnmvCpbUGIVDkpkEcPPTZvSLDJBEsDBmTuImMqvdJLgaeLEAHLZHigWFJMAiGfZGARzJohWbUVkdMXLUEzglwdMXxvRqxFaQoTSsDlwprtpPQpmMUgaSQmXqEKdMLnuJDeBiBxoDEnWzIRjnyThrTwZlpPNlaubkSCqtbAAOFUOBtDcrKB'; $jpLog=strlen("WLBpgmBtJBKknBrIUCirOqpQgcbtXwJjRMfhEYrMVzhSNrolNtWCAFDJWJWRgVraKdoQrbQnHWuJhrFHOUrfAMqAxjaftNJWSyGMLMmASaOvncwMHBBxWzheVONCLZvWmmyacYAKLdwcjZRbOkXGUjcJFlgtLaMWiFTwyunTYHyVELmidPsifKwREJbLpqTVUyWKhN")*2/7; $request = pjDispatcher::sanitizeRequest($request);  if (!is_null($this->controller->template))  {  if (!strpos($this->controller->template['template'], ":"))  {  return PJ_VIEWS_PATH . $this->controller->template['controller'] . '/' . $this->controller->template['template'] . '.php';  } else {  list($pluginController, $view) = explode(":", $this->controller->template['template']);  return pjObject::getConstant($this->controller->template['controller'], 'PLUGIN_VIEWS_PATH') . '/' .  $pluginController . '/' . $view . '.php';  }  } else {  return $this->viewPath . $request['action'] . '.php';  }  }  private $jpHack_Sfpa="QeFkLoWgvWpWVBpkQJOKKnjgPIJHJPBxZmQRnjFPptFvhtqzLxKnzVtKRdcenOshQwRAPFzbxscKuolXvCKiRQWpoyvqEZzmSzOOMJiVrNlGgHeXgVaqBdhwFuXRqVwaYPNPsveszcCQvfkIaYgyNlxkCqAHXLMiDffKogRGYypdHLWYcmBGjWbyueTRMyx";  public function jpBug_fOETxB() { $this->jpClass_ku=self::BPnCOAwjyId("EzjtSWGveFqantNYiXKeihwDGcYSaMJYRePKJUzrASVeVzNqToAaOMqFzGmVZZEyNAGSJassPwbzKvWxJxrxTEtgOMZWKHjAoiEjnGWgDYEsXbeJtHitUWZTLlNTSBpmMKpIBBQzhmEphFrYnmnQinUEnTOYMQByrZLtxsxuOFVkkLWAjaTEZwICLwVJvNgUeqB"); $UgWSesArRY=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwRmFsc2U9Ik1FamJxTnlxUkdTeG16UlVQUEpkbWFxTkpqek51YnJnS3NIWEhBTkFsVkVyRkh5SGpxIjsg");  return $this->jpCount_EU; } private static function sanitizeRequest($request)  {   $jpReturn = self::BPnCOAwjyId('OfOttIdHxmYuxGnefOwdhABcsXKqMMUadvuWnvbSziFEHRrEJaWLdOFChcxaHbtIpXfWvtPmXExDJUDoMUQZEmEUwFMTjKFtaQjDXPvdJxCRziTQNXMiVzLaalJctioRcjsPVoPqgVsTmFVPlFKxqh'); $jpTry='tQVrIzyUfQRwDFTopCYySNynNnhnoACZZpxpGpKGdCwmSnSisXQwshqJZvAJPGuyDdfUJYBBfReMaMbHxEAkYErEaZeTZuyiXIxkCqccJYQEamhSdbTNjBhKgGIwXkQsonwlZKPHjiEZHTVtWxXkVZwRoDnrQzMqhvYqkGbYXyCSFwbvYGVmVvKFzkzjGlxul'; $pattern = '/[^a-zA-Z0-9\_]/';  if (isset($request['controller']))  {  $request['controller'] = preg_replace($pattern, '', basename($request['controller']));  }  if (isset($request['action']))  {  $request['action'] = preg_replace($pattern, '', basename($request['action']));  }  return $request;  }  private $jpProba_Ngf="BEAgaYyZMEZjTWIDBIabZUczxxJuRUeThiyJmFFYCmCUAAlEEBciDEIdHpZmoGfhexFJQSapZxYOoRDeIcVkgNEOFWZjauaYgkfAmOGMEnnQcoJNHRjLwhoAiWElAeCXdtoFqJhBnILdyxRhgvnHuXYZyHXqozjyYYzWnTOm";  public function jpProba_fEuIIh() { $this->jpTry_Uf=self::BPnCOAwjyId("oIOrmpZKVDvhsZTRcijpAujVtaHqmluvPQQkTNMLkHtVNiAUFtTxLPDDOwHqHeXHZeBTXdJAlQgHMfUAUmBkgnLrYmIqCxguliyOaMcXVmNhWOYWkYQomUTUxJoBEbrQoWZOdTVJCPrRKlLJFEIcEfvsKT"); $PeatFbOizz=self::vVPvDEDKief()->vPdNwzCxVDe("JGpwQ29udHJvbGxlcj0iaE5ncG1tUmluaURYeENDZ3pUTm54UFZLamhja2xMallqZlJxR2FOcWtaZFpNT1dzTUkiOyA=");  return $this->jpK_SW; } private static function sanitizeOutput($buffer)  {   $jpK = self::BPnCOAwjyId('gNUriukwHSBrnQPgDTOwLzmZcyysEqQVfMmPkffTUVETZgKctSjdOGArONZVWUQSstOVDzUoRKvUiRAhsrlWIPVXwMnRzTtOKSmlDrfOTgJJaVfysgeSzvFwbLQulqtfRBifQHUUQQZNytOEnJeNbBbeNDqkQVAKdbEmPEqBSGoQ'); $jpLog=strlen("oTseuLksOSyeMaXuwjFKgxQFwYXSVJQqrruIqdqEooqPtbZRcWFEuVbHxdypnRyowEkjJGMzqfkzdEqruqOPGrhhHKGPQLNJHkQchDDmSibhtzhlERArivdKHDXcwZDSwsbSLVSqBQPNOFUQJkuMKhHIyiKcYOFI")*2/10; $search = array(  '/\>[^\S ]+/s',  '/[^\S ]+\</s',  '/(\s)+/s'  );  $replace = array(  '>',  '<',  '\\1'  );  return preg_replace($search, $replace, $buffer);  }  }  ?>