class DataAnalyst():
  def __init__(self, name, age, skill, career):
      self.name = name
      self.age = age
      self.skill = skill
      self.career = career
  def introduce_yourself(self):
      print(f"My name's {self.name} and I'm {self.age} years old.")
  
  def skillset(self):
      print(f"My skills include {self.skill}.")
	
  def add_skill(self, new_skill):
      self.skill.append(new_skill)

  def goal(self):
      print(f"I am currently interested in pursuing a career as a {self.career}")
      
boss = DataAnalyst("Boss", 23,
                   ["Spreadsheets", "SQL", "R", "Python", "Looker", "PowerBI"],
                   "Data Analyst")

boss.introduce_yourself()
boss.add_skill("Machine Learning")
boss.skillset()
boss.goal()
