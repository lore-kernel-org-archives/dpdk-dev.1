Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68617CF9C7C
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 17:59:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 763094026F;
	Thu, 20 Nov 2025 18:59:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B9FCF40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 18:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763661569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UrDF+Ikfa3fJqasKAp/waHCPDH2yOyc+WtKI8l7StZA=;
 b=LksOW2kNaWO2WM5T5UBcqTENC2rHJNDjXkxy3nU1GikFYotA09WCnHkwqfw/7VoEeAjNfL
 f0/PEuKpUmIhR1FlpIFtXF+FJ8vPqTowMtbqxfQuMMU/sAXQZxFdMunqG84wVbiCn47wrH
 3ZJ0TUCxKR9HS0oyoBysJSTkPG7GcIg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-R-Z1hXruNCyvcIPQVtTtgA-1; Thu, 20 Nov 2025 12:59:25 -0500
X-MC-Unique: R-Z1hXruNCyvcIPQVtTtgA-1
X-Mimecast-MFC-AGG-ID: R-Z1hXruNCyvcIPQVtTtgA_1763661564
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477939321e6so7341225e9.0
 for <dev@dpdk.org>; Thu, 20 Nov 2025 09:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661564; x=1764266364;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrDF+Ikfa3fJqasKAp/waHCPDH2yOyc+WtKI8l7StZA=;
 b=ey7wlS/NCzOqgc+4RZzXFrNIDiO4O/DugdVu1co+USbYEPbVZV/oe5bEcP7eo60Xyd
 YoqhLCauivgtTiXTxDOYiYl6ye+csLEjQw4m31n3Ck162NqiNGdYzvpD5aLdGcHfy2eB
 yz6HSj1k7o9uonr32FMGQCY41JcrL/iiPc3F+gF98uHt0gq6oG2WR3LjCjGzfXbTPcRP
 BXVrXg09LAbJUbmHkaxoSxKdfr4gclwshp/TcOdHveusRKm+a9aC02I3j3kHmVRaH/fk
 TKRHCwRUVGijdOK9qyC78LZKqxkGzrEd1kyV2I6x5ad2crHaapCM4YHbwhGQ0mcmDmLA
 +Ebw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNfyFo/ek183gUlxgSZg1vCeu4Gd1AYqaa5JbbOtOz4wTmLKf5feGMxl0xVfxW22UdXm8=@dpdk.org
X-Gm-Message-State: AOJu0YzfqYp4wQdc+HN9knZoGnZL0hO4hIRrOLsgG4vaa3Fx8nELd8Z6
 iy5W1HfcjKHvCa57VoMeVWD/Qqhzumtfmn8ewtJFec5nQlbA6zr7CJl8kYOEYFnoo1jLprxL33U
 d4h9lt7touWa9gHOOm4UxUW1KqjW0qHjrWa+QTugOHpJS
X-Gm-Gg: ASbGncvN95BYPMXqk95mQnarEmr36LoNRYQHmE96XHWhuTq/jTtiGUnKBg6esJmvOs4
 ZzkGmTnXDZQIQ8M+JyowWcQu/vVTEmdh0upg3UaSkJ41+ikXM5pUcnsYdi5VHH50u7oiMkfmjWt
 Pe9tBCUZsazlMrJ8wOChJgTXYBEbiktQwtV1c2DNt0VLEX5BtTNXte2rM/Ux5uKtJfG9JJlIzQY
 fYA7Csd/fkpM1hoh2Q26bOtipTkj50TxAFpxA1n7mhSDS3lY8Y+Gp9YP3BvWOWx5mrYJtzuwPI3
 y7SmANQnoPIUxNVYnfgy93S/DHfjGK2JyXU4x25XKIXKwzqqGcGb9RYtjVbqgTlArrzwzEKfQn4
 rei7NVasbGWaD
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-477b9ea4d28mr27484865e9.5.1763661564496; 
 Thu, 20 Nov 2025 09:59:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpQrKHqpLo/RxT/mqdDvefwslJJ0hc8af5eRo/ZV+HgjDnao+F5C19gLIy8pEee22BFP7axQ==
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-477b9ea4d28mr27484685e9.5.1763661564066; 
 Thu, 20 Nov 2025 09:59:24 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e598sm6611640f8f.4.2025.11.20.09.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 09:59:23 -0800 (PST)
Message-ID: <68c6d836-5daa-4d1a-a5d8-4c746d3826ee@redhat.com>
Date: Thu, 20 Nov 2025 17:59:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net/mlx5: release representor interrupt handler
To: Thomas Monjalon <thomas@monjalon.net>, rasland@nvidia.com
Cc: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org,
 orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, Roi Dayan <roid@nvidia.com>, xuemingl@nvidia.com,
 Shani Peretz <shperetz@nvidia.com>
References: <20251112074015.8901-1-bingz@nvidia.com>
 <2da88441-307a-4287-8387-d1906edf3755@redhat.com> <5256033.1IzOArtZ34@thomas>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <5256033.1IzOArtZ34@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ajk3_LF4bXh-MhzorW3LnmN4hTyyTzCph-qgLCoP9oA_1763661564
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

On 20/11/2025 17:39, Thomas Monjalon wrote:
> 20/11/2025 18:08, Kevin Traynor:
>> On 12/11/2025 07:40, Bing Zhao wrote:
>>> From: Roi Dayan <roid@nvidia.com>
>>>
>>> Looks like commit the cited commit removed the representor
>>> interrupt handler cleanup by mistake. Fix it.
>>>
>>> Fixes: 5cf0707fc7e9 ("net/mlx5: remove Rx queue data list from device")
>>> Cc: xuemingl@nvidia.com
>>>
>>
>> Hi,
>>
>> Some of this series (see below) is fixing issues in older releases, but
>> does not include stable tag to indicate the fixes should be backported.
>>
>> Just checking if this is deliberate, or an oversight and they should be
>> backported ?
>>
>> thanks,
>> Kevin.
>>
>> 25.11 dbaed15366 - F net/mlx5: release representor interrupt handler
>> (Fixes issue in 21.11)
>>
>> 25.11 aef94343d3 - F common/mlx5: release unused mempool entries (Fixes
>> issue in  21.11 (partially fixed in 8947eebc999e @ 21.11))
>>
>> 25.11 8d1fe10768 - F net/mlx5/hws: fix buddy memory allocation (Fixes
>> issue in 22.11)
> 
> I think it is an oversight.
> Usually I fix it myself, but this time I missed some.
> 

No problem, they all apply cleanly (24.11). Just checking builds now.

> Raslan, please run devtools/check-git-log.sh for each patch,
> it is raising such issue.
> 
> 

