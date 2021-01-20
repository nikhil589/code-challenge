$(document).ready(function () {
  $.validator.addMethod(
    "regx_domain_name",
    function (value, element, regexp) {
      var re = new RegExp(regexp);

      if (value == "") {
        return true;
      } else if (re.test(value)) {
        return true;
      } else {
        return false;
      }
    },
    "Please Enter the Valid Email Id."
  );

  $("#new_company").validate({
    rules: {
      "company[email]": {
        regx_domain_name: /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@getmainstreet.com$/
      }
    }
  });
});