Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B65CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 10:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A57C4067E;
	Mon, 29 Sep 2025 12:32:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2BFF74028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 12:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759141943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QsFMYZ2hfUJ1RU/9bvZ2PIYPeypmf9WKRGE4bp/+sKY=;
 b=Aswbk9YXHXdU/Z+1so2OBk1n1D3OO8xDbmVsSWy18snbxWajWJXxDgF6gJNgTHoXneb7Eh
 lhx+ZFmUWhfDSI7G3++ARxN8XQtEKZeVqUv/03f/ML+xD19TPM8tAQqX7M4+ZKgrzBVHPw
 Q1EiYIs/sHD8+9JAr2fYH1NJShcNwSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-J4IVRMpjPpGYXnjlWUAZFQ-1; Mon, 29 Sep 2025 06:32:22 -0400
X-MC-Unique: J4IVRMpjPpGYXnjlWUAZFQ-1
X-Mimecast-MFC-AGG-ID: J4IVRMpjPpGYXnjlWUAZFQ_1759141941
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e509374dcso5634535e9.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 03:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759141941; x=1759746741;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsFMYZ2hfUJ1RU/9bvZ2PIYPeypmf9WKRGE4bp/+sKY=;
 b=qTVblXvWj50gX/NdZEAGd8ntV+gWDYvlpcZFQPgcWoM5fOotjNdDDzW/PfJbht7AoT
 hbNs8wyJyfXzULJdYyd6hyswUy8GnsytWmUSVrAZNvv3mH6sUm8RkIrtAVguq55Vbyz/
 xNpajr8oIB2NZhnEiSIKEr4VTwXZanqmF3uRgM90JsGmLReWgoCnHz0ruxbytXNdTtFb
 jaCsrW0TPnHAL754CjtGjbSl90rmMHtk/zJkCmpcugOJCYg/Pgw6H+Ui3EoJ9F1QZqOH
 uVBZMLNMonsFM+DTxaIUFmNxMMuq2E3+9JSEAV2lXnJTXQQHNNLGVJKb3etl/kr1YFfl
 lQYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAPS2MmN0voLkz0XX8NrurP6kaxUCIVa8tH/X5s4ALNLhGvW3ScSoONd4hkMV+2npBtms=@dpdk.org
X-Gm-Message-State: AOJu0YxY3aaz1ROQcTM7ZZIGfuyhgd0b3q2fd/kfpho8kTV4ahhsZetA
 0Dem328y37VvRw1CNoOJidPXKnK37YYh5e9j//eTDnzoZbec9+qBGDy2qQ0/LU1ARQ68aX75eKG
 MAUr89TQ0lgphGkNaeRp/tdyqFRxUQ7J3wiD3/at3iRyM
X-Gm-Gg: ASbGncuLPwqRXHjIVy3cqKNg3nZGzZEM5E8LVLQw/F25uAHYuZhtymJVQ/hFUNr2OSy
 hRo3JAz2lsUmxr2/5bNVMJsIvv5kjRK9wgHwWXWlNzhGlrfcoXEkvGapyWR9qDZ+1IOI2TrlVw7
 FDomXY2FpUlvId8mrdssirp8vVvlh/XDlM/rCM+GKGVnDhBAlX009bI8nAnMc9d9Fo3G6vvkmC7
 2uNwVryDTMEE6/XLGrXo3lEKedwAGONIBmIbEXrFR1lRi3uMeFrAi7ZCGKc9txxTrKF2AM6yv69
 WUCijfh1H7EbRlyyqhOzC1bjIo+5+yGnx0tKe3oomQ==
X-Received: by 2002:a05:600c:5026:b0:46e:4389:a283 with SMTP id
 5b1f17b1804b1-46e4389a5c2mr68469645e9.22.1759141941211; 
 Mon, 29 Sep 2025 03:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg7gpNBBqKguuBFaCWjrnvvzQAz8TuTRon/FnyWQpS4V1SznKCDCk7FvpFd4KWBe98Xg2OWA==
X-Received: by 2002:a05:600c:5026:b0:46e:4389:a283 with SMTP id
 5b1f17b1804b1-46e4389a5c2mr68469345e9.22.1759141940788; 
 Mon, 29 Sep 2025 03:32:20 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.128.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a996bf1sm222799685e9.1.2025.09.29.03.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 03:32:19 -0700 (PDT)
Message-ID: <95f8dc71-98a5-4db2-8828-a2990a20e2c7@redhat.com>
Date: Mon, 29 Sep 2025 11:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DPDK/ethdev Bug 1789] vmxnet3_dev_start fails in
 vmxnet3_v4_rss_configure() for single queue in ESX8.0 causing application to
 exit
To: bugzilla@dpdk.org, dev@dpdk.org, jochen.behrens@broadcom.com
References: <bug-1789-3@https.bugs.dpdk.org/>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <bug-1789-3@https.bugs.dpdk.org/>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 68HiA0lNz7t1PkyevATCRAnwPkrZKLyF0_ExAjS8g9Q_1759141941
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

fyi - vmxnet3 maintainer Jochen

On 19/09/2025 21:15, bugzilla@dpdk.org wrote:
> https://bugs.dpdk.org/show_bug.cgi?id=1789
> 
>             Bug ID: 1789
>            Summary: vmxnet3_dev_start fails in vmxnet3_v4_rss_configure()
>                     for single queue in ESX8.0 causing application to exit
>            Product: DPDK
>            Version: 19.11
>           Hardware: All
>                 OS: All
>             Status: UNCONFIRMED
>           Severity: normal
>           Priority: Normal
>          Component: ethdev
>           Assignee: dev@dpdk.org
>           Reporter: amiyaranjan.mohakud@gmail.com
>   Target Milestone: ---
> 
> DPDK Version: 19.11
> ESX version: ESX8.0
> 
> We faced an exact similar issue as mentioned in
> https://mails.dpdk.org/archives/users/2025-April/008236.html. 
> 
> Context Details:
> -----------------
> In ESXi 8.0 setup with dpdk-19.11, when the HW compatibility version is ESX8.0
> and with single queue pair configuration, the RSS gets enabled. As a result,
> vmxnet3_v4_rss_configure() gets called and fails while writing/reading from
> BAR1 hw register. It looks to be some compatibility issue with dpdk-19.11 and
> ESX8.0.
> 
>         if (VMXNET3_VERSION_GE_4(hw) &&                                         
>             dev->data->dev_conf.rxmode.mq_mode == ETH_MQ_RX_RSS) {              
>                 /* Check for additional RSS  */                                 
>                 ret = vmxnet3_v4_rss_configure(dev);                            
>                 if (ret != VMXNET3_SUCCESS) {                                   
>                         PMD_INIT_LOG(ERR, "Failed to configure v4 RSS");        
>                         return ret;                                             
>                 }                                                               
>         }  
> 
> As a result, it causes the application to exit.
> 
> Proposed fix:
> I have a plausible fix for this. The fix is to disable RSS for such a case (
> the fix should go only in 19.11). During dev_configure(),  we can set the
> mq_mode  to ETH_MQ_RX_NONE if the num_rx_queues is 1. This would avoid calling
> of vmxnet3_v4_rss_configure().
> 
> 
>         /* Disabling RSS for single queue pair */                               
>         if (dev->data->nb_rx_queues == 1) {                                     
>                 dev->data->dev_conf.rxmode.mq_mode = ETH_MQ_RX_NONE;            
>                 PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");   
>         }
> 
> 
> Pls verify and let me know if it can be upstreamed. Once confirmed/approved, If
> required, I can generate a main stream patch for it.
> 

