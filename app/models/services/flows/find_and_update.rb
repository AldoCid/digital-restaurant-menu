class Services::Flows::FindAndUpdate < Micro::Case
  flow Services::Find,
       Services::Update
end