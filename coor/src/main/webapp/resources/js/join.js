
let idCheck = false;

//아이디 중복 확인
function checkId(){
	
	let reg_id = /^[a-zA-Z0-9]{6,12}$/; 
	let id = $('#mb_id').val();

	if(id == "") {
	  alert("아이디를 입력하세요.");
	  $("#mb_id").focus();
	  return false;
	}
	
	if(reg_id.test(id) == false){
		alert("아이디는 영문,숫자 포함 6~12자 입니다.");
	  $("#mb_id").focus(); 
	  return false;
	}

	//get 방식으로 id중복 체크
	$.ajax({
	  url: '/member/idCheck',
	  type: 'get',
	  dataType: 'text',
	  data: {mb_id : id},
	  success:function(result){
	      if(result == "yes"){ 
	          alert("사용가능한 아이디입니다");
	          idCheck = true;
	          $("#mb_pw").focus();
	      }else{
	          alert("아이디가 존재합니다. 다른 아이디를 입력해 주세요");
	          $("#mb_id").focus();
	          idCheck = false;
	     
	      }
	  }
	});
};


//회원가입 유효성검사
function goJoin(e){
	
    //정규식 구문
    let reg_pw = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,20}$/;
    let reg_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    let reg_phone = /^\d{3}\d{8}$/;
    let reg_birth = /^\d{8}$/
    let mb_pw = document.getElementById("mb_pw");
    let mb_pwChk = document.getElementById("mb_pwChk");
    let mb_name = document.getElementById("mb_name");
    let mb_email = document.getElementById("mb_email");
    let mb_phone = document.getElementById("mb_phone");
    let mb_birth = document.getElementById("mb_birth");
    let phoneCheck = false;
    
    if(idCheck == false){
        alert("아이디 중복확인을 하세요.");
        $("#mb_id").focus();
        return false;
    }
    
    if(mb_pwChk.value !== mb_pw.value){ 
    	alert("입력하신 비밀번호가 같지 않습니다."); 
    	mb_pw.focus(); 
    	return false;
    }  
    
    if(check_validate(mb_pw, "비밀번호를 입력하세요.") == false) {mb_pw.focus();}
    if(check_validate(mb_name, "이름을 입력하세요.") == false){mb_name.focus();}
    if(check_validate(reg_email, "이메일을 입력하세요.") == false){mb_email.focus();}
    if(check_validate(mb_phone, "전화번호를 입력하세요.") == false){mb_phone.focus();}
    if(check_validate(mb_birth, "생년월일을 입력하세요.") == false){mb_birth.focus();}
    if(reg_validate(reg_pw, mb_pw, "비밀번호는 영문,숫자,특수문자 포함 6~20자 입니다.")){ mb_pw.focus();}
    if(reg_validate(reg_email, mb_email, "이메일 형식이 틀립니다.")){mb_email.focus();}
    if(reg_validate(reg_phone, mb_phone, "전화번호 형식이 틀립니다.")){mb_phone.focus();}
    if(reg_validate(reg_birth, mb_birth, "생년월일 형식이 틀립니다.")){mb_birth.focus();}
    

    $("#joinForm").attr("action", "/member/join");
    $("#joinForm").submit();
    
}

// 일반 공백유무 체크
function check_validate(target, msg){
    if(target.value == ""){
        alert(msg);
        target.focus();
        return false;
        
    }

}

//정규식 체크
function reg_validate(regex, target, msg){
    if(regex.test(target.value) == false){
        alert(msg);
        e.preventDefault();
        target.focus();
    }
}



