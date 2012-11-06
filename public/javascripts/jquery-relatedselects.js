/*
 * jQuery related selects plug-in 0.3
 *
 * http://www.erichynds.com/jquery/jquery-related-dependent-selects-plugin/
 * http://github.com/ferric84/jquery-related-selects
 *
 * Copyright (c) 2009 Eric Hynds
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

(function ($) {
    $.fn.extend({
        relatedSelects: function (opts) {
            opts = $.extend({}, $.RelatedSelect.defaults, opts);
            return this.each(function () {
                new $.RelatedSelect(this, opts);
            });
        }
    });
    $.RelatedSelect = function (context, opts) {
        var $context = $(context);
        var selects = [];
        if ($.isArray(opts.selects)) selectsToObj();
        for (key in opts.selects) selects.push(key);
        saveDefaultOptionText();
        $.each(opts.selects, function (elem, o) {
            var $select = $("select[name='" + elem + "']", $context);
            var $next = next(elem);
            var selectedValue = $select.find('option:selected').attr('value');
            o = $.extend({
                defaultOptionText: opts.defaultOptionText || $select.data('defaultOption')
            }, opts, o);
            $select.data('defaultOption', o.defaultOptionText);
            $select.change(function () {
                o.onChange.call($select);
                process($select, $next, elem, o);
            });
            if (selectedValue && selectedValue.length > 0 && isPopulated($next)) return;
            process($select, $next, elem, o);
        });

        function saveDefaultOptionText() {
            var $select, text;
            for (var x = 1, xx = selects.length; x < xx; x++) {
                $select = $("select[name='" + selects[x] + "']", $context);
                text = $("option[value='']", $select).text();
                $select.data('defaultOption', text);
            };
        };

        function process($select, $next, elem, o) {
            if ($next.length === 0) return;
            var value = $.trim($select.find('option:selected').attr('value'));
            if (value.length > 0 && value !== o.loadingMessage && $next) {
                resetAfter(elem);
                populate($select, $next, o);
            } else if ($next) {
                resetAfter(elem);
            };
        };

        function populate($caller, $select, o) {
            var selectors = [],
                params = [];
            for (var x = 0; x < selects.length; x++) {
                    selectors.push('select[name="' + selects[x] + '"]');
                };
            params = $(selectors.join(','), $context).serialize();
            $select.attr("disabled", "disabled").html('<option value="">' + o.loadingMessage + '</option>');
            $.ajax({
                    beforeSend: function () {
                        o.onLoadingStart.call($select);
                    },
                    complete: function () {
                        o.onLoadingEnd.call($select);
                    },
                    dataType: o.dataType,
                    data: params,
                    url: o.onChangeLoad,
                    success: function (data) {
                        var html = '',
                            defaultOptionText = $select.data('defaultOption');
                        if (defaultOptionText.length > 0) html = '<option value="" selected="selected">' + defaultOptionText + '</option>';
                        if (o.dataType === 'json' && typeof(data) === 'object' && data) {
                                $.each(data, function (i, item) {
                                    html += '<option value="' + i + '">' + item + '</option>';
                                });
                                $select.html(html).removeAttr('disabled');
                            } else if (o.dataType === 'html' && $.trim(data).length > 0) {
                                html += $.trim(data);
                                $select.html(html).removeAttr('disabled');
                            } else {
                                $select.html(html);
                                if (!o.disableIfEmpty) {
                                    $select.removeAttr('disabled');
                                };
                                o.onEmptyResult.call($caller);
                            };
                    }
                });
        };

        function isPopulated($select) {
            var options = $select.find('option');
            return (options.length === 0 || (options.length === 1 && options.filter(':first').attr('value').length === 0)) ? false : true;
        };

        function resetAfter(elem) {
            var thispos = getPosition(elem);
            for (var x = thispos + 1; x < selects.length; x++) {
                $("select[name='" + selects[x] + "']", $context).attr("disabled", "disabled").find("option:first").attr("selected", "selected");
            };
        };

        function next(elem) {
            return $("select[name='" + selects[getPosition(elem) + 1] + "']", $context);
        };

        function getPosition(elem) {
            for (var i = 0, ii = selects.length; i < ii; i++) {
                if (selects[i] === elem) {
                    return i;
                };
            };
        };

        function selectsToObj() {
            var arrSelects = opts.selects;
            opts.selects = {};
            for (var i = 0, ii = arrSelects.length; i < ii; i++) {
                opts.selects[arrSelects[i]] = {};
            };
        };
    };
    $.RelatedSelect.defaults = {
        selects: {},
        loadingMessage: 'Loading, please wait...',
        disableIfEmpty: false,
        dataType: 'json',
        onChangeLoad: '',
        onLoadingStart: function () {},
        onLoadingEnd: function () {},
        onChange: function () {},
        onEmptyResult: function () {}
    };
})(jQuery);