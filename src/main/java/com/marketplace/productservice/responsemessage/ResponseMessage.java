package com.marketplace.productservice.responsemessage;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
@AllArgsConstructor
public class ResponseMessage {

    private String message;
    private HttpStatus error;
    private int status;
    private String url;

}
