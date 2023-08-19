<?php
$week_start = isset($tpl['option_arr']['o_week_start']) && in_array((int) $tpl['option_arr']['o_week_start'], range(0,6)) ? (int) $tpl['option_arr']['o_week_start'] : 0;
$jqDateFormat = pjUtil::momentJsDateFormat($tpl['option_arr']['o_date_format']);

$time_ampm = 0;
if(strpos($tpl['option_arr']['o_time_format'], 'a') > -1)
{
    $time_ampm = 1;
}
if(strpos($tpl['option_arr']['o_time_format'], 'A') > -1)
{
    $time_ampm = 2;
}
?>

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-10">
                <h2><?php __('plugin_vouchers_infobox_add_voucher_title') ?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('plugin_vouchers_infobox_add_voucher_desc') ?></p>
    </div><!-- /.col-md-12 -->
</div>

<div class="row wrapper wrapper-content animated fadeInRight">
    <div class="col-lg-12">
        <div class="ibox float-e-margins">
            <div class="ibox-content">
                <form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjVouchers&amp;action=pjActionCreate" method="post" id="frmCreateVoucher" autocomplete="off">
                    <input type="hidden" name="voucher_create" value="1" />

                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_voucher_code') ?></label>

                                <input type="text" name="code" id="code" class="form-control required" data-msg-remote="<?php __('plugin_vouchers_voucher_code_exist', false, true); ?>" />
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_discount') ?></label>

                                <div class="input-group group-fa-change" data-currency-sign="<?php echo pjCurrency::getCurrencySign($tpl['option_arr']['o_currency'], false) ?>">
                                    <input type="text" name="discount" id="discount" class="form-control number decimal text-right required" data-msg-number="<?php __('plugin_vouchers_enter_valid_number', false, true);?>"/>

                                    <span class="input-group-addon"><strong><?php echo pjCurrency::getCurrencySign($tpl['option_arr']['o_currency'], false) ?></strong></span>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_discount_type') ?></label>

                                <?php $voucher_types = __('plugin_vouchers_types', true); ?>
                                <div class="clearfix">
                                    <div class="switch onoffswitch-data onoffswitch-fa-change pull-left">
                                        <div class="onoffswitch">
                                            <input type="checkbox" class="onoffswitch-checkbox" id="switch_type" checked>
                                            <label class="onoffswitch-label" for="switch_type">
                                                <span class="onoffswitch-inner" data-on="<?php echo $voucher_types['amount'] ?>" data-off="<?php echo $voucher_types['percent'] ?>"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div><!-- /.clearfix -->
                                <input type="hidden" name="type" id="type" value="amount">
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->
                    </div><!-- /.row -->

                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_valid') ?></label>

                                <select name="valid" id="valid" class="form-control select-voucher required">
                                    <option value="">-- <?php __('plugin_base_choose'); ?> --</option>
                                    <?php
                                    foreach (__('plugin_vouchers_valids', true, false) as $k => $v)
                                    {
                                        ?><option value="<?php echo $k; ?>"><?php echo $v; ?></option><?php
                                    }
                                    ?>
                                </select>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->
                    </div><!-- /.row -->

                    <div id="valid_fixed" class="area-fixed valid-box row" style="display:none;">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_date') ?></label>

                                <div class="input-group date"
                                         data-provide="datepicker"
                                         data-date-autoclose="true"
                                         data-date-format="<?php echo $jqDateFormat ?>"
                                         data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>"
                                    >
                                    <input type="text" name="f_date" id="f_date" value="<?php echo date($tpl['option_arr']['o_date_format'], time());?>" class="form-control required">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_time_from') ?></label>

                                <div class="row">
                                    <?php
                                    $dtHour = pjDateTime::factory()
                                        ->attr('name', 'f_hour_from')
                                        ->attr('id', 'f_hour_from')
                                        ->attr('class', 'form-control')
                                        ->prop('ampm', $time_ampm);
                                    $dtMinute = pjDateTime::factory()
                                        ->attr('name', 'f_minute_from')
                                        ->attr('id', 'f_minute_from')
                                        ->attr('class', 'form-control')
                                        ->prop('step', 5);
                                    $dtAmPm = pjDateTime::factory()
                                        ->attr('name', 'f_ampm_from')
                                        ->attr('id', 'f_ampm_from')
                                        ->attr('class', 'form-control')
                                        ->prop('ampm', $time_ampm);
                                    ?>
                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtHour->hour(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtMinute->minute(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtAmPm->ampm(); ?>
                                    </div><!-- /.col-xs-4 -->
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_time_to') ?></label>

                                <div class="row">
                                    <?php
                                    $dtHour
                                        ->attr('name', 'f_hour_to')
                                        ->attr('id', 'f_hour_to');
                                    $dtMinute
                                        ->attr('name', 'f_minute_to')
                                        ->attr('id', 'f_minute_to');
                                    $dtAmPm
                                        ->attr('name', 'f_ampm_to')
                                        ->attr('id', 'f_ampm_to');
                                    ?>
                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtHour->hour(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtMinute->minute(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtAmPm->ampm(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-xs-12">
                                        <input type="hidden" id="validate_fixedtime" name="validate_fixedtime" value="" data-msg-validateFixedTime="<?php __('plugin_vouchers_validate_time', false, true);?>"/>
                                    </div>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->
                    </div><!-- /.row -->

                    <div id="valid_period" class="area-period valid-box row" style="display: none;">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_date_from') ?></label>

                                <div class="input-group date"
                                         data-provide="datepicker"
                                         data-date-autoclose="true"
                                         data-date-format="<?php echo $jqDateFormat ?>"
                                         data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>"
                                    >
                                    <input type="text" name="p_date_from" id="p_date_from" value="<?php echo date($tpl['option_arr']['o_date_format'], time());?>" class="form-control required">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_time_from') ?></label>

                                <div class="row">
                                    <?php
                                    $dtHour
                                        ->attr('name', 'p_hour_from')
                                        ->attr('id', 'p_hour_from');
                                    $dtMinute
                                        ->attr('name', 'p_minute_from')
                                        ->attr('id', 'p_minute_from');
                                    $dtAmPm
                                        ->attr('name', 'p_ampm_from')
                                        ->attr('id', 'p_ampm_from');
                                    ?>
                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtHour->hour(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtMinute->minute(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtAmPm->ampm(); ?>
                                    </div><!-- /.col-xs-4 -->
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_date_to') ?></label>

                                <div class="input-group date"
                                         data-provide="datepicker"
                                         data-date-autoclose="true"
                                         data-date-format="<?php echo $jqDateFormat ?>"
                                         data-date-week-start="<?php echo (int) $tpl['option_arr']['o_week_start'] ?>"
                                    >
                                    <input type="text" name="p_date_to" id="p_date_to" value="<?php echo date($tpl['option_arr']['o_date_format'], time() + 86400);?>" class="form-control required">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_time_to') ?></label>

                                <div class="row">
                                    <?php
                                    $dtHour
                                        ->attr('name', 'p_hour_to')
                                        ->attr('id', 'p_hour_to');
                                    $dtMinute
                                        ->attr('name', 'p_minute_to')
                                        ->attr('id', 'p_minute_to');
                                    $dtAmPm
                                        ->attr('name', 'p_ampm_to')
                                        ->attr('id', 'p_ampm_to');
                                    ?>
                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtHour->hour(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtMinute->minute(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtAmPm->ampm(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-xs-12">
                                        <input type="hidden" id="validate_datetime" name="validate_datetime" value="1" data-msg-remote="<?php __('plugin_vouchers_validate_datetime', false, true);?>"/>
                                    </div>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->
                    </div><!-- /.row -->

                    <div id="valid_recurring" class="area-recurring valid-box row" style="display: none;">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_every') ?></label>

                                <select name="r_every" id="r_every" class="form-control">
                                    <?php
                                    $days = __('plugin_vouchers_days', true, false);
                                    foreach (pjUtil::getWeekdays() as $v)
                                    {
                                        ?><option value="<?php echo $v; ?>"><?php echo $days[$v]; ?></option><?php
                                    }
                                    ?>
                                </select>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_start_time') ?></label>

                                <div class="row">
                                    <?php
                                    $dtHour
                                        ->attr('name', 'r_hour_from')
                                        ->attr('id', 'r_hour_from');
                                    $dtMinute
                                        ->attr('name', 'r_minute_from')
                                        ->attr('id', 'r_minute_from');
                                    $dtAmPm
                                        ->attr('name', 'r_ampm_from')
                                        ->attr('id', 'r_ampm_from');
                                    ?>
                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtHour->hour(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtMinute->minute(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtAmPm->ampm(); ?>
                                    </div><!-- /.col-xs-4 -->
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="form-group">
                                <label class="control-label"><?php __('plugin_vouchers_end_time') ?></label>

                                <div class="row">
                                    <?php
                                    $dtHour
                                        ->attr('name', 'r_hour_to')
                                        ->attr('id', 'r_hour_to');
                                    $dtMinute
                                        ->attr('name', 'r_minute_to')
                                        ->attr('id', 'r_minute_to');
                                    $dtAmPm
                                        ->attr('name', 'r_ampm_to')
                                        ->attr('id', 'r_ampm_to');
                                    ?>
                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtHour->hour(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtMinute->minute(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-lg-4 col-xs-6">
                                        <?php echo $dtAmPm->ampm(); ?>
                                    </div><!-- /.col-xs-4 -->

                                    <div class="col-xs-12">
                                        <input type="hidden" id="validate_time" name="validate_time" value="" data-msg-validateTime="<?php __('plugin_vouchers_validate_time', false, true);?>"/>
                                    </div>
                                </div>
                            </div><!-- /.form-group -->
                        </div><!-- /.col-md-3 -->
                    </div><!-- /.row -->

                    <div class="hr-line-dashed"></div>

                    <div class="clearfix">
                        <button class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader pull-left" data-style="zoom-in">
                            <span class="ladda-label"><?php __('plugin_base_btn_save') ?></span>
                            <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                        </button>

                        <a class="btn btn-white btn-lg pull-right" href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjVouchers&action=pjActionIndex"><?php __('plugin_base_btn_cancel') ?></a>
                    </div><!-- /.clearfix -->
                </form>
            </div>
        </div>
    </div><!-- /.col-lg-12 -->
</div>