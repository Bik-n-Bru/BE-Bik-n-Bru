class StateLatLong
  def self.convert(state)
    self.dictionary[state.downcase]
  end

  def self.dictionary 
    {
      'alabama' => ['32.806671',	'-86.791130'],
      'alaska' => ['61.370716',	'-152.404419'],
      'arizona' => ['33.729759', '-111.431221'],
      'arkansas' => ['34.969704', '-92.373123'],
      'california' => ['36.116203',	'-119.681564'],
      'colorado' => ['39.059811',	'-105.311104'],
      'connecticut' => ['41.597782',	'-72.755371'],
      'delaware' => ['39.318523',	'-75.507141'],
      'district of columbia' => ['38.897438',	'-77.026817'],
      'washington d.c.' => ['38.897438',	'-77.026817'],
      'washington dc' => ['38.897438',	'-77.026817'],
      'florida' => ['27.766279',	'-81.686783'],
      'georgia' => ['33.040619',	'-83.643074'],
      'hawaii' => ['21.094318',	'-157.498337'],
      'idaho' => ['44.240459',	'-114.478828'],
      'illinois' => ['40.349457',	'-88.986137'],
      'indiana' => ['39.849426',	'-86.258278'],
      'iowa' => ['42.011539',	'-93.210526'],
      'kansas' => ['38.526600',	'-96.726486'],
      'kentucky' => ['37.668140',	'-84.670067'],
      'louisiana' => ['31.169546',	'-91.867805'],
      'maine' => ['44.693947',	'-69.381927'],
      'maryland' => ['39.063946',	'-76.802101'],
      'massachusetts' => ['42.230171',	'-71.530106'],
      'michigan' => ['43.326618',	'-84.536095'],
      'minnesota' => ['45.694454',	'-93.900192'],
      'mississippi' => ['32.741646',	'-89.678696'],
      'missouri' => ['38.456085',	'-92.288368'],
      'montana' => ['46.921925',	'-110.454353'],
      'nebraska' => ['41.125370',	'-98.268082'],
      'nevada' => ['38.313515',	'-117.055374'],
      'new hampshire' => ['43.452492',	'-71.563896'],
      'new jersey' => ['40.298904',	'-74.521011'],
      'new mexico' => ['34.840515',	'-106.248482'],
      'new york' => ['42.165726',	'-74.948051'],
      'north carolina' => ['35.630066',	'-79.806419'],
      'north dakota' => ['47.528912',	'-99.784012'],
      'ohio' => ['40.388783',	'-82.764915'],
      'oklahoma' => ['35.565342',	'-96.928917'],
      'oregon' => ['44.572021',	'-122.070938'],
      'pennsylvania' => ['40.590752',	'-77.209755'],
      'rhode island' => ['41.680893',	'-71.511780'],
      'south carolina' => ['33.856892',	'-80.945007'],
      'south dakota' => ['44.299782',	'-99.438828'],
      'tennessee' => ['35.747845',	'-86.692345'],
      'texas' => ['31.054487',	'-97.563461'],
      'utah' => ['40.150032',	'-111.862434'],
      'vermont' => ['44.045876', '-72.710686'],
      'virginia' => ['37.769337', '-78.169968'],
      'washington' => ['47.400902', '-121.490494'],
      'west virginia' => ['38.491226', '-80.954453'],
      'wisconsin' => ['44.268543', '-89.616508'],
      'wyoming' => ['42.755966', '-107.302490']
    }
  end
end