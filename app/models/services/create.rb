class Services::Create < Micro::Case
  attributes :model, :params

  def call!
    begin
      record = model.new(params)
      if record.save
        Success result: {record: record}
      else
        Failure result: {error: record.errors}
      end
    rescue StandardError => e
      Failure result: {error: e.to_s}
    end
  end
end