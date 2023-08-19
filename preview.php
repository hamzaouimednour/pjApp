<!DOCTYPE html>
<html>
	<head>
		<title>Food Delivery - Preview</title>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link href="core/framework/libs/pj/css/pj.bootstrap.min.css" type="text/css" rel="stylesheet" />
	    <link href="index.php?controller=pjFrontEnd&action=pjActionLoadCss<?php echo isset($_GET['theme']) ? '&layout=' . $_GET['theme'] : null;?>" type="text/css" rel="stylesheet" />
	</head>
	<body>
		<div style="max-width: 1024px;">
			<script type="text/javascript" src="index.php?controller=pjFrontEnd&action=pjActionLoad<?php echo isset($_GET['locale']) ? '&locale=' . $_GET['locale'] : null;?><?php echo isset($_GET['hide']) ? '&hide=' . $_GET['hide'] : null;?><?php echo isset($_GET['theme']) ? '&layout=' . $_GET['theme'] : null;?>"></script>		
		</div>
	<script async src="//demo.phpjabbers.com/popup/js/load.js"></script></body>
</html>