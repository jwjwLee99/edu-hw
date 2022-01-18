function sendit() {
  const userpw = document.getElementById('userpw');
  const userpw_re = document.getElementById('userpw_re');
  const name = document.getElementById('name');
  const hp = document.getElementById('hp');
  const email = document.getElementById('email');
  const hobby = document.getElementsByName('hobby');

  //정규식
  const expHpText = /^\d{3}-\d{3,4}-\d{4}$/;
  const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;

  

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

  return true;
}
