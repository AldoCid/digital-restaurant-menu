class Services::Update < Micro::Case
  attributes :record, :params

  def call!
    begin
      if record.update(params)
        Success result: {record: record.reload}
      else
        Failure :update_failure, result: {error: record.errors.messages}
      end
    rescue StandardError => e
      Failure :update_failure, result: {error: e.to_s}
    end
  end
end