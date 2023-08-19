<select name="value-<?php echo $option['type']; ?>-<?php echo $option['key']; ?>" class="form-control">
    <?php
    $default = explode("::", $option['value']);
    $enum = explode("|", $default[0]);
    
    $enumLabels = array();
    if (!empty($option['label']) && strpos($option['label'], "|") !== false)
    {
        $enumLabels = explode("|", $option['label']);
    }
    
    foreach ($enum as $k => $el)
    {
    	if ($default[1] == $el)
    	{
    		?><option value="<?php echo $default[0].'::'.$el; ?>" selected="selected"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
    	} else {
    		?><option value="<?php echo $default[0].'::'.$el; ?>"><?php echo array_key_exists($k, $enumLabels) ? stripslashes($enumLabels[$k]) : stripslashes($el); ?></option><?php
    	}
    }
    ?>
</select>