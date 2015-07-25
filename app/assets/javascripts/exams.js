function puller(exam_id){
  $.getJSON('/exams/' + exam_id + '.json', function(response){
    if(response.answers.length > 0){
      window.location = '/results/' + exam_id;
    }
  });
}
