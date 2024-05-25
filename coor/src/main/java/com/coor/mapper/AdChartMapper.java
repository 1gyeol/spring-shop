package com.coor.mapper;

import java.util.List;
import java.util.Map;

import com.coor.dto.ChartDTO;

public interface AdChartMapper {
	  List<ChartDTO> firstCategoryOrderPrice();
	  
	  List<Map<String, Object>> firstCategoryChart();
	  
}
