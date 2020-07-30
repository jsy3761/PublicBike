package com.ntels.syjeon.publicbike.model.api;

import java.util.ArrayList;
import java.util.List;

/**
 * @author syjeon@ntels.com
 */
public class RentBikeStatus {
    private List<Row> row;

    public RentBikeStatus(List<Row> row){
        this.row = new ArrayList<>(row);
    }

    public List<Row> getRow(){
        return row;
    }

    @Override
    public String toString() {
        return "RentBikeStatus{" +
                "row=" + row +
                '}';
    }
}
