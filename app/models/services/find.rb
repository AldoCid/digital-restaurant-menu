class Services::Find < Micro::Case
  attributes :model, :id

  def call!
    record = model.find_by(id: id)
    if record
      Success result: { record: record }
    else
      Failure :not_found, result: { error: "#{model} not found with id: #{id}" }
    end
  end
end