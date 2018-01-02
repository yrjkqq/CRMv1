package com.cdsxt.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("crm")
public class LoginController {

    @RequestMapping(value = {"", "index"}, method = RequestMethod.GET)
    public String login() {
        return "login";
    }
}
