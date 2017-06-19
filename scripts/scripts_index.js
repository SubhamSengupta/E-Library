function check(){
   if(document.forms["loginform"]["username"].value === ""){
       document.getElementById("err").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["loginform"]["password"].value === ""){
       document.getElementById("err").innerHTML = "Fields must be filled.";
       return false;
   }else if(localStorage.getItem("loginstatus").match("1")){
       alert("You are already logged in. Logout first.");
       if(localStorage.getItem("user").match("admin")){
           window.location = "adminportal.jsp";
           return false;
       }
       else{
            document.getElementById('user').value = localStorage.getItem("user");
            document.forms[0].submit();
            return false;
       }
   }else
        return true;
}

function checkReg(){
    if(document.forms["regform"]["name"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["dept"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["passyear"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["univ"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["id"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["usr"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["pass"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["passCon"].value === ""){
       document.getElementById("errReg").innerHTML = "Fields must be filled.";
       return false;
   }else if(document.forms["regform"]["pass"].value !== document.forms["regform"]["passCon"].value ){
       document.getElementById("errReg").innerHTML = "Passwords do not match.";
       return false;
   }else
        return true;
}
window.onload = function(){
    if(localStorage.getItem("messagestatus").match("1"))
        document.getElementById("err").innerHTML = localStorage.getItem("message");
    if(localStorage.getItem("regstatus").match("1")){
        document.getElementById("regbox").style.visibility = "visible";
        document.getElementById("errReg").innerHTML = localStorage.getItem("regmessage");
    }
};
window.onbeforeunload = function(){
    localStorage.setItem("messagestatus","0");
    localStorage.setItem("regstatus","0");
};


