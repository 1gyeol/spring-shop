package com.coor.service;

import com.coor.kakaopay.ApproveResponse;
import com.coor.kakaopay.CancelResponse;
import com.coor.kakaopay.ReadyResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class KakaoPayService {
   public ReadyResponse payReady(String cid, Long partner_order_id, String partner_user_id, String item_name, int quantity, int total_amount, int tax_free_amount, String approval_url, String cancel_url, String fail_url) {
      
	  String url = "https://kapi.kakao.com/v1/payment/ready";
      MultiValueMap<String, String> parameters = new LinkedMultiValueMap();
      
      parameters.add("cid", cid);
      parameters.add("partner_order_id", String.valueOf(partner_order_id));
      parameters.add("partner_user_id", partner_user_id);
      parameters.add("item_name", item_name);
      parameters.add("quantity", String.valueOf(quantity));
      parameters.add("total_amount", String.valueOf(total_amount));
      parameters.add("tax_free_amount", "0");
      parameters.add("approval_url", approval_url);
      parameters.add("cancel_url", cancel_url);
      parameters.add("fail_url", fail_url);
      
      HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity(parameters, this.getHeaders());
      
      RestTemplate template = new RestTemplate();
      ReadyResponse readyResponse = (ReadyResponse)template.postForObject(url, requestEntity, ReadyResponse.class, new Object[0]);
      
      return readyResponse;
   }

   public ApproveResponse payApprove(String cid, String tid, Long partner_order_id, String partner_user_id, String pg_token) {
      
	  String url = "https://kapi.kakao.com/v1/payment/approve";
      MultiValueMap<String, String> parameters = new LinkedMultiValueMap();
      
      parameters.add("cid", cid);
      parameters.add("tid", tid);
      parameters.add("partner_order_id", String.valueOf(partner_order_id));
      parameters.add("partner_user_id", partner_user_id);
      parameters.add("pg_token", pg_token);
      
      HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity(parameters, this.getHeaders());
      
      RestTemplate template = new RestTemplate();
      ApproveResponse approveResponse = (ApproveResponse)template.postForObject(url, requestEntity, ApproveResponse.class, new Object[0]);
      
      return approveResponse;
   }

   public CancelResponse payCancel(String cid, String tid, int cancel_amount, int cancel_tax_free_amount) {
      
	  String url = "https://kapi.kakao.com/v1/payment/cancel";
      MultiValueMap<String, String> parameters = new LinkedMultiValueMap();
      
      parameters.add("cid", cid);
      parameters.add("tid", tid);
      parameters.add("cancel_amount", String.valueOf(cancel_amount));
      parameters.add("cancel_tax_free_amount", "0");
      parameters.add("cancel_vat_amount", "0");
      
      HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity(parameters, this.getHeaders());
     
      RestTemplate template = new RestTemplate();
      
      CancelResponse cancelResponse = (CancelResponse)template.postForObject(url, requestEntity, CancelResponse.class, new Object[0]);
      System.out.println(cancelResponse);
      
      return cancelResponse;
   }

   private HttpHeaders getHeaders() {
	   
      HttpHeaders headers = new HttpHeaders();
      
      headers.set("Authorization", "KakaoAK 0ca72e4bccbe875137424a678b72b1c5");
      headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
      
      return headers;
   }
}
