require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "バリデーション" do
    it "La validation de la tâche est désactivée si le titre n'est pas saisi" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "La validation de la tâche est invalide si le statut n'est pas renseigné" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "La validation de la tâche est invalide si le délai de réalisation n'est pas renseigné" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
      
     
     
    end

    it "La validation d'une tâche est invalide si la date d'échéance est dans le passé" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Date.yesterday)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline must start from today."]
    
      
    end

    it "La validation de la tâche est valide si la date d'échéance est la date du jour" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Date.today)
      expect(task).to be_valid
      expect(task.errors.full_messages).to eq [ ]
    end
  end
end
