<div class="form-group">
    <label class="control-label col-lg-4"><?php __('plugin_world_pay_allow'); ?></label>

    <div class="col-lg-8">
        <div class="switch m-t-xs">
            <div class="onoffswitch onoffswitch-yn">
                <input id="payment_is_active" name="plugin_payment_options[world_pay][is_active]" value="<?php echo @$tpl['arr']['is_active'];?>"  type="hidden" />
                <input class="onoffswitch-checkbox" id="enablePayment" name="enablePayment" type="checkbox"<?php echo @$tpl['arr']['is_active'] == '1' ? ' checked="checked"' : NULL; ?>>
                <label class="onoffswitch-label" for="enablePayment">
                    <span class="onoffswitch-inner"></span>
                    <span class="onoffswitch-switch"></span>
                </label>
            </div>
        </div>
    </div><!-- /.col-lg-4 -->
</div><!-- /.form-group -->
<div class="hidden-area" style="display: <?php echo $tpl['arr']['is_active'] == '1' ? 'block' : 'none'; ?>">
    <?php
    foreach ($tpl['lp_arr'] as $v)
    {
        ?>
        <div class="form-group pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 1 ? NULL : 'none'; ?>">
            <label class="control-label col-lg-4"><?php __('plugin_world_pay_payment_label'); ?></label>
            <div class="col-lg-8">
                <div class="input-group">
                    <input type="text" class="form-control" name="i18n[<?php echo $v['id']; ?>][world_pay]" value="<?php echo pjSanitize::html(@$tpl['i18n'][$v['id']]['world_pay']); ?>">
                    <?php if ($tpl['is_flag_ready']) : ?>
                    <span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
                    <?php endif; ?>
                </div>
            </div>
        </div>
        <?php
    }
    ?>
</div>

<div class="form-group hidden-area" style="display: <?php echo $tpl['arr']['is_active'] == '1' ? 'block' : 'none'; ?>">
    <label class="control-label col-lg-4"><?php __('plugin_world_pay_merchant_id'); ?></label>

    <div class="col-lg-8">
        <input type="text" name="plugin_payment_options[world_pay][merchant_id]" value="<?php echo pjSanitize::html(@$tpl['arr']['merchant_id']); ?>" class="form-control<?php echo @$tpl['arr']['is_active'] == 1 ? ' required' : '';?>" />
        <p class="small"><?php __('plugin_world_pay_merchant_id_text'); ?></p>
    </div><!-- /.col-lg-8 -->
</div><!-- /.form-group -->
<div class="form-group hidden-area" style="display: <?php echo $tpl['arr']['is_active'] == '1' ? 'block' : 'none'; ?>">
    <label class="control-label col-lg-4"><?php __('plugin_world_pay_private_key'); ?></label>

    <div class="col-lg-8">
        <input type="text" name="plugin_payment_options[world_pay][private_key]" value="<?php echo pjSanitize::html(@$tpl['arr']['private_key']); ?>" class="form-control<?php echo @$tpl['arr']['is_active'] == 1 ? ' required' : '';?>" />
        <p class="small"><?php __('plugin_world_pay_private_key_text'); ?></p>
    </div><!-- /.col-lg-8 -->
</div><!-- /.form-group -->