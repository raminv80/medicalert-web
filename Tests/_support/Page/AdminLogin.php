<?php
namespace Page;

class AdminLogin
{
    // include url of current page
    public static $URL = '/admin/login';

    public static $usernameField = '#email';
    public static $passwordField = '#password';
    public static $loginButton = '#login-form button[type=submit]';

    /**
     * Declare UI map for this page here. CSS or XPath allowed.
     * public static $usernameField = '#username';
     * public static $formSubmitButton = "#mainForm input[type=submit]";
     */

    /**
     * Basic route example for your current URL
     * You can append any additional parameter to URL
     * and use it in tests like: Page\Edit::route('/123-post');
     */
    public static function route($param)
    {
        return static::$URL.$param;
    }

    public function __construct(\AcceptanceTester $I){
        $this->tester = $I;
    }

}