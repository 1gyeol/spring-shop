package com.coor.service;

import com.coor.dto.ChartDTO;
import java.util.List;
import org.json.simple.JSONObject;

public interface AdChartService {
   List<ChartDTO> firstCategoryOrderPrice();

   JSONObject firstCategoryChart();
}
