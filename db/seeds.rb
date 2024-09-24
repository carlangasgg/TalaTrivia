# Fresh Start
User.destroy_all
Trivium.destroy_all
Answer.destroy_all

# Users
User.create!(name: 'ADMIN', email: 'admin@test.com', password: 'password', password_confirmation: "password", role: 'admin')
User.create!(name: 'PLAYER 1', email: 'player1@test.com', password: 'password', password_confirmation: "password", role: 'player')
User.create!(name: 'PLAYER 2', email: 'player2@test.com', password: 'password', password_confirmation: "password", role: 'player')
u1 = User.players.first

# Trivia
Trivium.find_or_create_by!(name: 'Trivia de prueba', description: 'Esta es una prueba dummy')
trivium = Trivium.first
trivium.users << u1
trivium.save

# Questions
Question.find_or_create_by!(name: 'Pregunta 1', description:'¿Qué país habla cantonés?', score: 1, trivium_id: trivium.id)
q1 = Question.first
Question.find_or_create_by!(name: 'Pregunta 2', description:'¿Qué país fue el campeón de la última FIFA World Cup?', score: 2, trivium_id: trivium.id)
q2 = Question.second
Question.find_or_create_by!(name: 'Pregunta 3', description:'Qué fue primero: ¿el huevo o la gallina?', score: 3, trivium_id: trivium.id)
q3 = Question.third

# Options
QuestionOption.find_or_create_by!(name: "Rusia", question_id: q1.id)
QuestionOption.find_or_create_by!(name: "China", correct_option: true, question_id: q1.id)
QuestionOption.find_or_create_by!(name: "Argentina", correct_option: true, question_id: q2.id)
QuestionOption.find_or_create_by!(name: "Francia", question_id: q2.id)
QuestionOption.find_or_create_by!(name: "El huevo", correct_option: true, question_id: q3.id)
QuestionOption.find_or_create_by!(name: "La gallina", question_id: q3.id)

