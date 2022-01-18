function sendit() {
  const userid = document.getElementById('userid');
  const userpw = document.getElementById('userpw');
  const userpw_re = document.getElementById('userpw_re');
  const name = document.getElementById('name');
  const hp = document.getElementById('hp');
  const email = document.getElementById('email');
  const hobby = document.getElementsByName('hobby');
  const isssn = document.getElementById('isssn');
  const isidcheck = documetn.getElementById('isidcheck');

  //정규식
  const expNameText = /[가-힣]+$/;
  const expHpText = /^\d{3}-\d{3,4}-\d{4}$/;
  const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;

  // id
  if(userid.value == ''){
    alert('아이디를 입력하세요');
    userid.focus();
    return false;
  }
  if(userid.value.length < 4 || userid.value.length > 20){
    alert('아이디는 4자 이상 20자 이하 작성하세요');
    userid.focus();
    return false;
  }
  if(isidcheck.value == 'n'){
	  alert('아이디 중복확인을 해주세요');
	  isidChechk.focus();
	  return false;
  }

  // pw
  if(userpw.value == ''){
    alert('비밀번호를 입력하세요');
    userpw.focus();
    return false;
  }
  if(userpw.value.length < 4 || userpw.value.length > 20){
    alert('비밀번호는 4자 이상 20자 이하 작성하세요');
    userpw.focus();
    return false;
  }

  // pw check
  if(userpw_re.value != userpw.value){
    alert('비밀번호와 비밀번호 확인의 값이 다릅니다');
    userpw.focus();
    return false;
  }

  // name
  if(!expNameText.test(name.value)){
    alert('이름 형식을 확인하세요 \n 한글만 입력가능');
    name.focus();
    return false;
  }

  // hp
  if(!expHpText.test(hp.value)){
    alert('휴대폰 형식을 확인하세요 \n 하이픈(-)을 포함해야함');
    hp.focus();
    return false;
  }

  // email
  if(!expEmailText.test(email.value)){
    alert('이메일 형식을 확인하세요');
    email.focus();
    return false;
  }

  // hobby
  let count = 0;
  for(let i in hobby){
    if(hobby[i].checked){
      count++;
    }
  }
  if(count == 0){
    alert('취미는 적어도 하나이상 선택하세요.');
    return false;
  }

  // isssn
  if(isssm.value == 'n'){
    alert('주민등록번호를 검증해 주세요');
    return false;
  }

  return true;
}

function moveFocus() {
  const ssn1 = document.getElementById('ssn1');
  if(ssn1.value.length >= 6){
    document.getElementById('ssn2').focus();
  }
}

function checkSsn() {
  const ssn1 = document.getElementById('ssn1');
  const ssn2 = document.getElementById('ssn2');
  const isssn = document.getElementById('isssn');


  if(ssn1.value == '' || ssn2.value == ''){
    alert('주민등록번호를 입력하세요');
    ssn1.focus();
    return false;
  }

  const ssn = ssn1.value + ssn2.value;
  const s1 = Number(ssn.substr(0,1)) * 2;
  const s2 = Number(ssn.substr(1,1)) * 3;
  const s3 = Number(ssn.substr(2,1)) * 4;
  const s4 = Number(ssn.substr(3,1)) * 5;
  const s5 = Number(ssn.substr(4,1)) * 6;
  const s6 = Number(ssn.substr(5,1)) * 7;
  const s7 = Number(ssn.substr(6,1)) * 8;
  const s8 = Number(ssn.substr(7,1)) * 9;
  const s9 = Number(ssn.substr(8,1)) * 2;
  const s10 = Number(ssn.substr(9,1)) * 3;
  const s11 = Number(ssn.substr(10,1)) * 4;
  const s12 = Number(ssn.substr(11,1)) * 5;
  const s13 = Number(ssn.substr(12,1));

  let result = s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11+s12;

  result = result % 11;
  result = 11 - result;

  if (result >= 10){
    result %= 10;
  }

  if(result == s13){
    alert('유효한 주민등록번호입니다');
    isssn.value = 'y'
  }else{
    alert('유효하지 않은 주민등록번호입니다');
  }

}

function ssnChange() {
  const isssn = document.getElementById('isssn');

  isssn.value = 'n'
}

$(function() {
	$("#btnIdCheck").on('click', function() {
		if($("#userid").val() == ''){
			alert('아이디를 입력하세요.');
			$("#userid").focus();
			return false;
		}
		
		const xhr = new XMLHttpRequest();
		const userid = $("#userid").val()
		xhr.open('GET', 'idCheck.jsp?userid='+userid, true);
		xhr.send();
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				const result = xhr.responseText;
				if(result.trim() == "ok"){
					$("#idCheckMsg").html("<b style='color:blue'>사용할 수 있는 아이디</b>");
					$("#isidcheck").val('y');
				}else{
					$("#idCheckMsg").html("<b style='color:red'>사용할 수 없는 아이디</b>");
				}
			}
		}
	});
	$("#userid").on("keyup", function(){
		$("#isidcheckt").val('n');
		$("#idCheckMsg").html("");
	})
});