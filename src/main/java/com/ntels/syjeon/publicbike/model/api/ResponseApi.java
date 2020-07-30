package com.ntels.syjeon.publicbike.model.api;

/**
 * @author syjeon@ntels.com
 */
public class ResponseApi {
    private RentBikeStatus rentBikeStatus;

    public void setRentBikeStatus(RentBikeStatus rentBikeStatus){
        this.rentBikeStatus = rentBikeStatus;
    }
    public RentBikeStatus getRentBikeStatus(){
        return this.rentBikeStatus;
    }

    @Override
    public String toString() {
        return "ResponseApi{" +
                "rentBikeStatus=" + rentBikeStatus +
                '}';
    }
}
