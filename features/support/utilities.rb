def transform_table(arr)
  #transforms array like:
  #[["Select database", "SAM E04"], ["Username like", "yn04"], ["Date created", "01-MAR-2012"], ["Entitlement", "appSkyGo"]]
  #to hash like:
  #
 hash = {}
 arr.each { |inner_array|

    hash[inner_array[0]] = inner_array[1]

 }
  return hash

end
