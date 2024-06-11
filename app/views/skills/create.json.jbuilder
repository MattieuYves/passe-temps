if @skill.persisted?
  json.form render(partial: "skills/form", formats: :html, locals: {skill: Skill.new})
  json.inserted_item render(partial: "shared/bookings_teacher", formats: :html, locals: {skill: @skill})
else
  json.form render(partial: "skills/form", formats: :html, locals: {skill: @skill})
end
