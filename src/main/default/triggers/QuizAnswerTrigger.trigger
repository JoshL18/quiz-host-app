trigger QuizAnswerTrigger on Quiz_Answer__c (before insert) {
    AnswerService answerService = new AnswerService();
    Set<Id> playerIds = answerService.getUniquePlayerIds(Trigger.new);
    Map<ID, ID> mapPlayerQuestion = answerService.getPlayerQuestionMapping(playerIds);
    for (Quiz_Answer__c answer : Trigger.new) {
        String key = answer.Player__c;
        if (mapPlayerQuestion.containsKey(key) && mapPlayerQuestion.get(key) == answer.Question__c) {
            answer.addError('Duplicate answer');
        } else {
            // # of milliseconds since January 1, 1970, 00:00:00 GMT, ie. 1569261277045
            answer.Timestamp__c = Datetime.now().getTime();
        }
    }
}