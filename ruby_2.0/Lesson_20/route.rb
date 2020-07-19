# frozen_string_literal: true

require_relative 'instance_counter.rb'

class Route
  include InstanceCounter

  TYPE_MISMATCH_ERROR = 'Route elements must be "Station" type objects!'
  DUPLICATE_ERROR = 'There is already such a station in the route!'
  DELETE_ERROR = 'Can not delete start or last stations!'

  attr_reader :stations, :start, :finish, :mid_stations
  def initialize(start, finish)
    @mid_stations = []
    @stations = []
    @start = start
    @finish = finish
    validate!
    register_instance
  end

  def add_station(station)
    mid_stations << station
  end

  def remove_station(station)
    mid_stations.delete(station)
  end

  def stations
    [start, mid_stations, finish].flatten
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise TYPE_MISMATCH_ERROR unless stations.all? { |station| station.is_a?(Station) }
    raise DUPLICATE_ERROR if stations.first == stations.last
  end

  def delete_station_validate!(station)
    raise DELETE_ERROR if [start, finish].include?(station)
  end

  def add_station_validate!(station)
    raise TYPE_MISMATCH_ERROR unless station.is_a?(Station)
    raise DUPLICATE_ERROR if stations.include?(station)
  end
end
