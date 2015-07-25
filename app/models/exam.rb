class Exam < ActiveRecord::Base
  CODES = %w{B LVA LCM A1 AM C D EC EB BTP}
  LANGUAGES = {'Castellano' => 1, 'Catalán' => 2, 'Valenciano' => 3,
               'Gallego' => 4, 'Euskera' => 5, 'Alemán' => 6, 'Inglés' => 7,
               'Francés' => 8}

  serialize :metadata, Hash
end

