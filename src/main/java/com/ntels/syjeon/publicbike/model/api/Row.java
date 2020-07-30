package com.ntels.syjeon.publicbike.model.api;

/**
 * @author syjeon@ntels.com
 */
public class Row {
    private String rackTotCnt;

    private String stationName;

    private String parkingBikeTotCnt;

    private String shared;

    private String stationLatitude;

    private String stationLongitude;

    private String stationId;

    public String getRackTotCnt() {
        return rackTotCnt;
    }

    public void setRackTotCnt(String rackTotCnt) {
        this.rackTotCnt = rackTotCnt;
    }

    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public String getParkingBikeTotCnt() {
        return parkingBikeTotCnt;
    }

    public void setParkingBikeTotCnt(String parkingBikeTotCnt) {
        this.parkingBikeTotCnt = parkingBikeTotCnt;
    }

    public String getShared() {
        return shared;
    }

    public void setShared(String shared) {
        this.shared = shared;
    }

    public String getStationLatitude() {
        return stationLatitude;
    }

    public void setStationLatitude(String stationLatitude) {
        this.stationLatitude = stationLatitude;
    }

    public String getStationLongitude() {
        return stationLongitude;
    }

    public void setStationLongitude(String stationLongitude) {
        this.stationLongitude = stationLongitude;
    }

    public String getStationId() {
        return stationId;
    }

    public void setStationId(String stationId) {
        this.stationId = stationId;
    }

    @Override
    public String toString() {
        return "Row{" +
                "rackTotCnt='" + rackTotCnt + '\'' +
                ", stationName='" + stationName + '\'' +
                ", parkingBikeTotCnt='" + parkingBikeTotCnt + '\'' +
                ", shared='" + shared + '\'' +
                ", stationLatitude='" + stationLatitude + '\'' +
                ", stationLongitude='" + stationLongitude + '\'' +
                ", stationId='" + stationId + '\'' +
                '}';
    }
}
