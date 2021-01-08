class Services::Create < Micro::Case
  attributes :model, :params

  def call!
    begin
      record = model.new(params)

      return Success result: {record: record} if record.save

      Failure result: {error: record.errors}
    rescue StandardError => e
      Failure result: {error: e.to_s}
    end
  end
end