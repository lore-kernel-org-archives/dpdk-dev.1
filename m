Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E90EA8126
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E9F9400D7;
	Tue, 10 Feb 2026 16:06:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DC7D0400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770735961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ji4kZPXTa4Lbu/0lg086nQi3/LK1UJZG5r9PScqZkIc=;
 b=eIvBSYWmMtIaYoU8aLVSwnc1eaqzmMN1n3qQry+qkxHGt5l9fs/qFOAoE6mYGDmhsyHT4C
 mlMlY+Z7jnz/hy7s+S953PNSHaavknQRDdXxsCfgH8AdPmJhoPW7mpJu9bZPUt8Y6Ilayl
 T0Ey1BVE7ND7hQEpz88RHkJk7Y4yPwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-RCms8xrTPRuq3rHAAVXwrQ-1; Tue, 10 Feb 2026 10:05:59 -0500
X-MC-Unique: RCms8xrTPRuq3rHAAVXwrQ-1
X-Mimecast-MFC-AGG-ID: RCms8xrTPRuq3rHAAVXwrQ_1770735958
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-482eec44485so6819235e9.3
 for <dev@dpdk.org>; Tue, 10 Feb 2026 07:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770735958; x=1771340758;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji4kZPXTa4Lbu/0lg086nQi3/LK1UJZG5r9PScqZkIc=;
 b=HVPXOf5pK+r8JDu96Mr4YbkrpyqSYAO4lHosBUHRBb6IpbeRYTxp19DVSNU0wovqYq
 /+hxL74T+kJwECy+KEwi17aUV1Ds5/dfUe3VLhkoFdfaGHxGHXFXO1LeVIzt1pLuFaA6
 asYtzjdPf58Kglj1jNcM9HOk90JTRxyIzGO9LkRoEEuILtrP18AsRGgKFHvgbfOTHH55
 KCL6yYMbchcOABAbauBPpw1UTE9oMacFnuMZdPGsnNHjm7AignTB42oc/nZ6Mq9/jEWH
 zX7EbuqpoHFfLQsAKyRxflVcnDwgMW2RRt6RMVBdyJIJ8LegIPShfU3UgJ7zTyGctPff
 N7Fw==
X-Gm-Message-State: AOJu0Yy4AzTX68cGdiGY6p+eX9z+HbNuMJ0UPStNCns8PuU6rf9IgLhv
 6XJNk/oCrk7t/HuwhC5hjvlFmB5mOAPOSufm9XKXqMg4hZPeZpFwrqPPzyxhb+QObwyVVOs+zB6
 eVfawJWFfZKPBMMcHiazvnNSlhunaBqpSioQItCv2jETU
X-Gm-Gg: AZuq6aLglq84ybn68wDICv51D1kbVwgqX4dcLyNj160Onu51fqLwXjl3X3I4B23yI1o
 PbmofL17FcZrDvBCpOAiKUBw/ppwPzWN4kRF8xWrIm0shb4B5HyOeEs+maxgX80Xejyf8GXJdHc
 famPEOw3Dx1HBYyjCIulEW8tHA/c5sObB1soM8g3aCn78oHLm/qbgDm5jwJrcm/V/X0nkvYcT2g
 CzZh45UreLVsJcwkngQBBKS50xcltvN9/0bGdoLsdYe/A3vG3UrHtxynndKp8oqSNS5lClUpcfJ
 HzV8zZWWprlKAI2rH7NTpc/adLJDreZOC3k8xE+Y81SEWwCkFdAiOtU9GoChDQT/xq+XzD4Wqo3
 3ExhzTLkHGfawS5EAMMVLtciq
X-Received: by 2002:a05:600c:3b23:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-4832021eae9mr215639705e9.28.1770735958465; 
 Tue, 10 Feb 2026 07:05:58 -0800 (PST)
X-Received: by 2002:a05:600c:3b23:b0:47f:8c05:786b with SMTP id
 5b1f17b1804b1-4832021eae9mr215639125e9.28.1770735958006; 
 Tue, 10 Feb 2026 07:05:58 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.210])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48323c0296dsm338629075e9.1.2026.02.10.07.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 07:05:57 -0800 (PST)
Message-ID: <dd9faf73-b153-42b8-a42c-418bf22fe1f6@redhat.com>
Date: Tue, 10 Feb 2026 15:05:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net/mlx5: check for no data read in devx interrupt
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, stable@dpdk.org
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-2-ktraynor@redhat.com>
 <20260206220939.5a90c67c@phoenix.local>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260206220939.5a90c67c@phoenix.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qd7piBzUkuCsLqt0zaA9VEJzAzkzyza3lbssxelAxVk_1770735958
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

On 07/02/2026 06:09, Stephen Hemminger wrote:
> On Fri,  6 Feb 2026 17:20:53 +0000
> Kevin Traynor <ktraynor@redhat.com> wrote:
> 
>> A busy-loop may occur when there are EPOLLERR, EPOLLHUP or
>> EPOLLRDHUP epoll events for the devx interrupt fd.
>>
>> This may happen if the interrupt fd is deleted, if the device
>> is unbound from mlx5_core kernel driver or if the device is
>> removed by the mlx5 kernel driver as part of LAG setup.
>>
>> When that occurs, there is no data to be read and in the devx
>> interrupt handler an EAGAIN is returned on the first call to
>> devx_get_async_cmd_comp, but this is not checked.
>>
>> As the interrupt is not removed or condition reset, it causes
>> an interrupt processing busy-loop, which leads to the dpdk-intr
>> thread going to 100% CPU.
>>
>> e.g.
>> epoll_wait
>>    (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1) = 1
>> read(28, 0x7f1f5c7fc2f0, 40)
>>    = -1 EAGAIN (Resource temporarily unavailable)
>> epoll_wait
>>    (6, [{events=EPOLLIN|EPOLLRDHUP, data={u32=28, u64=28}}], 8, -1) = 1
>> read(28, 0x7f1f5c7fc2f0, 40)
>>    = -1 EAGAIN (Resource temporarily unavailable)
>>
>> Add a check for an EAGAIN return from devx_get_async_cmd_comp on the
>> first read. If that happens, unregister the callback to prevent looping.
>>
>> Bugzilla ID: 1873
>> Fixes: f15db67df09c ("net/mlx5: accelerate DV flow counter query")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> 
> AI spotted this, I didn't...
> 
> 
> Errors:
> 
>     Line 139: Unnecessary semicolon after closing brace
> 
> c
> 
>    };
> 
> Should be:
> c
> 
>    }
> 
>     Lines 142-146: Block comment uses incorrect style Block comments in C code should use /* and */ style, not /** which is reserved for documentation comments.
> 
> c
> 
>    /**
>     * no data and EAGAIN indicate there is an error or
>     * disconnect state. Unregister callback to prevent
>     * interrupt busy-looping.
>     */
> 
> Should be:
> c
> 
>    /*
>     * no data and EAGAIN indicate there is an error or
>     * disconnect state. Unregister callback to prevent
>     * interrupt busy-looping.
>     */
> 
> Warnings:
> 
>     Logic clarity: The variable data_read is set to true inside the while loop but never checked when data WAS read. Consider if data_read is the clearest way to express this condition.
> 

Ack above. Thanks.Will be fixed in v3.

