class Services::Find < Micro::Case
  attributes :model, :id

  def call!
    record = model.find_by(id: id)

    return Success result: { record: record } if record

    Failure :not_found, result: { error: "#{model} not found with id: #{id}" }
  end
end