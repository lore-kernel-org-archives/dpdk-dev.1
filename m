Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DA8105F781
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 09:24:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5105F40279;
	Fri, 13 Mar 2026 10:24:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CC0A54026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 10:24:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773393845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/gIGJzjAg+uTav/5wtl8r4UTClHB3FdVQdThW1XhxeQ=;
 b=dFaoZ/NbXVxIdYZyGtTQRGNJsm/jbm8Z6yjefBVBUjGh8AIdvkTydgPBcm6SqQQHMI7hft
 w60CYZ0mW4ABZEAUnKv0L9k5VQZeB9KpgV/81XfBvtjza//m4BI4kdtKqU6HH4vGRyV6f9
 Y1WREDAZcQwWAw9tCBiqufmOm3/1qmM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Xi7efT4_McCjcMfW1v-vyQ-1; Fri, 13 Mar 2026 05:24:04 -0400
X-MC-Unique: Xi7efT4_McCjcMfW1v-vyQ-1
X-Mimecast-MFC-AGG-ID: Xi7efT4_McCjcMfW1v-vyQ_1773393843
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439c112b1a4so1343490f8f.3
 for <dev@dpdk.org>; Fri, 13 Mar 2026 02:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773393843; x=1773998643;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gIGJzjAg+uTav/5wtl8r4UTClHB3FdVQdThW1XhxeQ=;
 b=Q7qg3noc1FoQHRm2mUn/u3XsZHEAGsUTA6013ojNg/tylZdzU5mxI1kHKUyVM8vQ07
 +heGMZt0X0YcoIki/Rff5Ol6k5WTei7e1YJtBRdPLoDOY32Hs0lNqKrgC8MzAboeE5rb
 CIE2pA4ybwxIP3ANjGgN1YePJsHkjUG18rPOCCSiocpPtWJX7kXys0IyfJfHbs6AINGc
 SZB3bHJ/R44/jlR6sPLAQioF5UBYwxzUGZmrWeBhWb2/4qIUBZBHizTHW7P+rhL5ux9y
 /aNJGi6giQovkfDq3KeFqqE5PR5pKaQpza586WrOYmB/PePWoP72fjM1iJ4miOLbN6bW
 KDgw==
X-Gm-Message-State: AOJu0YzRxXGAdzuSz0Hiainwu4YS9jIBS9Rfi2d6rDhv3xngQPK5k4j2
 ih5Cp7R4m1TgiA2owI51+W4u608q5z2hd1CglWWGReOcXmPwYp8Q+0PlPWMf4cljhk3X0GikCVj
 tpSTr8SH12hXxNxyGGHY5mt0+snOFpLwNwRADo/aLfZJY
X-Gm-Gg: ATEYQzweaNoShpfaLazbE0/1IZ5OaczXshrvpFewEuXGmWm/eRkH+sugEIbuZrZaTs7
 OC1bad9Ztj6/WZ0yrB19DTRDIRi6Ph+zMmLgi8naqMVTBpIDjZmAE95CgWyUZ6L8Sle/RWdn6UW
 AzRA+cIfmz90F3ftcVoDkBJrqVIaPtk1eG+Ac4n4hnwlqiyxdkfmKNtFUFUPCGQMNDVR1kZ0BYy
 jIYLQWU/5YaNFmesqap9JifSGlGTqObIF/wuLUBQRwFvi1Cnobjx49MOsAfXB/RaiTO46yNSpew
 7YVlnqA7Bsx5KCsFKQHBQm9X6d4MehBQ3j/4PylxPNVBtqeN+mCkCP3Q9foQ1IN33/BG1pTxunZ
 gIi4w6cJa4qNrfMeNpgYaHtAs
X-Received: by 2002:a05:6000:2509:b0:439:b811:11de with SMTP id
 ffacd0b85a97d-43a04d7c5a0mr5254517f8f.7.1773393842706; 
 Fri, 13 Mar 2026 02:24:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2509:b0:439:b811:11de with SMTP id
 ffacd0b85a97d-43a04d7c5a0mr5254477f8f.7.1773393842246; 
 Fri, 13 Mar 2026 02:24:02 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273d9sm18171233f8f.34.2026.03.13.02.24.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 02:24:01 -0700 (PDT)
Message-ID: <8af32367-9164-45c0-a321-51516f2e6506@redhat.com>
Date: Fri, 13 Mar 2026 09:24:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] app/testpmd: check for no arguments
To: fengchengwen <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-4-ktraynor@redhat.com>
 <51026e44-1045-47ef-add5-7a98c3ad4eac@huawei.com>
 <20260312100317.5b06a849@phoenix.local>
 <37ff0e85-3f46-4b51-bf56-5d03b4910fac@huawei.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <37ff0e85-3f46-4b51-bf56-5d03b4910fac@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kcft2e-epdxmGtjVQPuYqRuWBtX5yuf9siBRQdeDM0k_1773393843
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

On 3/12/26 11:59 PM, fengchengwen wrote:
> On 3/13/2026 1:03 AM, Stephen Hemminger wrote:
>> On Thu, 12 Mar 2026 20:37:42 +0800
>> fengchengwen <fengchengwen@huawei.com> wrote:
>>
>>> Hi Kevin,
>>>
>>> On 3/12/2026 6:36 PM, Kevin Traynor wrote:
>>>> For the case where token is NULL, there are no arguments
>>>> and split_str[0] is used uninitialized.  
>>>
>>> In which case the token is NULL, if there are no arguments, the cmdline's
>>> callback won't be invoke.
>>>
>>> Thanks
>>
>> It still maybe possible to get there with an empty string ""
>> which would evaluate to no arguments?
> 
> No, as tested below:
> 
> testpmd> port config  dcb vt on 4 pfc ""
> Bad arguments
> testpmd> port config  dcb vt on 4 pfc ''
> Bad arguments
> testpmd> port config  dcb vt on 4 pfc '
> Bad arguments
> testpmd> port config  dcb vt on 4 pfc
> Bad arguments
> 
> 

Ok, no problem to drop the patch if not needed. static analysis was just
looking at the function as an independent unit.

