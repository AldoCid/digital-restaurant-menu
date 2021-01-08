class Services::Update < Micro::Case
  attributes :record, :params

  def call!
    begin
      return Success result: {record: record.reload} if record.update(params)

      Failure :update_failure, result: {error: record.errors.messages}
    rescue StandardError => e
      Failure :update_failure, result: {error: e.to_s}
    end
  end
end