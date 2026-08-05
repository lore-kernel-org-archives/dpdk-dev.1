Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B4C55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 11:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4D0E40272;
	Wed,  5 Aug 2026 13:07:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 41D5F40144
 for <dev@dpdk.org>; Wed,  5 Aug 2026 13:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785928053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQngiP4/sn9sfjiDE/cc8Wp7cV7m4NcC13uNJQWKlBg=;
 b=bvK7R7V8Cp6BH+2IEDy6h14PvYA+BO9pdlCeV0eusqetIwg/cHbGIbkDE2zssUV74UOvCv
 xEUiE8Vop8Lqn+zpvYPFTljPbIpdVVJAS3y9k+VKq9Boiciz1ut0mfJVZddmWWxiN3Nki/
 WoyueFQvUUzK/2VwN39m7SodX3d6b+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-C3wAIZ8INmaC6X1DsvP0ag-1; Wed, 05 Aug 2026 07:07:32 -0400
X-MC-Unique: C3wAIZ8INmaC6X1DsvP0ag-1
X-Mimecast-MFC-AGG-ID: C3wAIZ8INmaC6X1DsvP0ag_1785928051
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49544a639e9so4296875e9.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 04:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785928051; x=1786532851;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQngiP4/sn9sfjiDE/cc8Wp7cV7m4NcC13uNJQWKlBg=;
 b=kPHNKg0UUlCsXeSNFSR/g5nkMjeTNy6Ig/uAGsTo4n0ppBVVflQTDXQpev8gCds5Q5
 47B34BM3ppnOVPUlZJpQjNHgKodEv2I1RJaRR2VKFW2G3r3h03e67jlvreNd0vlxR10w
 j8WAgCDkQ5fKKdwZhcJ9iQpMe1e0r4ukQQAb5UrEMI3g6exyu0m+QwkzIg6nmaBVdZ4z
 u0aUHPWEaX2Wsy7ETpnRKNXS/mcBu/XQoGOE9iINbC3DEhfu8W3Qo57FT4GViBz/OWne
 SVMr1ImjDA3aDvYoIRxgz9ckXLPtAscLsO3fDdv343/ib9Hn4ypoUWnUI2QIS06RLPd+
 T/7w==
X-Gm-Message-State: AOJu0YwlHXaU6U3x3f3WJgBQWZF9z77TWWYcEukCWPaOzktFrfFuQSJ4
 0jeFxjd86GwTMh6BqkL7D+wPvXYKkiNWvYQSGwhywHDFCORsN3V/lSlUyF4aNlq/sk4HlrUqT7Z
 y0X3Tm8Ozp1mbbhzpgd0tVroPaCvk0MJWtmPbZjKU4nyQ
X-Gm-Gg: AR+sD1379iEGI8Dzf1MGvY+6NY9RkFrc+pQD4v/w5C3B7x5R4WqEkNDHGxQ3LzE1WVk
 cBZFIrrey2rhrjzfF7LSwP/rGaonRKhoeqaXydMr5hj60mVCM3BYad6faPi8HfiTt7jSXK1DfSN
 wSw/WvUg5mGyM2kKI1PyzFPj9MlyyOBWRuoxw8/CnxArK6gIdhxV3/GkbLq5vvC+hh2bfzerX2f
 Tnjev34jcmT6GauXdLzJZSqZ9GdGz+8oCyj/2jBIMMIJvXSCbcqBFV87q+bwXsktn+6ADLFWi6U
 cm0gVNq2AxXOoTC/oYMcCXD9yisFRTE04hEbsu39VLEoqGkJbLrgaZQm5vv/MtCzOmde2o99imf
 8
X-Received: by 2002:a05:600c:5694:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-4994e7bab0emr47180695e9.9.1785928051066; 
 Wed, 05 Aug 2026 04:07:31 -0700 (PDT)
X-Received: by 2002:a05:600c:5694:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-4994e7bab0emr47180055e9.9.1785928050617; 
 Wed, 05 Aug 2026 04:07:30 -0700 (PDT)
Received: from [192.168.0.66] ([78.16.71.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a100e14sm160949845e9.14.2026.08.05.04.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 04:07:29 -0700 (PDT)
Message-ID: <a2e71ae1-daf2-4f7f-aa08-47cd450ca1a3@redhat.com>
Date: Wed, 5 Aug 2026 12:07:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.7 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>, luca.boccassi@gmail.com,
 stable@dpdk.org, dsosnowski@nvidia.com, maxime.peim@gmail.com
Cc: dev@dpdk.org, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, sbadawi@nvidia.com, waela@nvidia.com
References: <20260727094306.41797-1-luca.boccassi@gmail.com>
 <c49e8480-5d4d-459d-bf8d-c73321c42abb@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
In-Reply-To: <c49e8480-5d4d-459d-bf8d-c73321c42abb@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 686M6Jumy-DGhZ_mtqfmSpYPVX22NYQO2EAoJOTHxlw_1785928051
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/4/26 14:46, Ali Alnubani wrote:
> On 7/27/26 12:43 PM, luca.boccassi@gmail.com wrote:
> 
>> Hi all,
>>
>> Here is a list of patches targeted for stable release 24.11.7.The 
>> planned date for the final release is 2026/08/10.
>>
>> Please help with testing and validation of your use cases and report
>> any issues/results with reply-all to this mail. For the final release
>> the fixes and reported validations will be added to the release notes.
>>
>> A release candidate tarball can be found at:
>>
>>      https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.7-rc1
>>
>> These patches are located at branch 24.11 of dpdk-stable repo:
>>      https://dpdk.org/browse/dpdk-stable/
>>
>> Thanks.
>>
>> Luca Boccassi
>>
>> ---
> [..]
>> Maxime Peim (1):
>>        net/mlx5: prepend implicit items in sync flow creation
> [..]
> 
> Hello Maxime, Luca,
> 
> Commit 471350f6cd ("net/mlx5: prepend implicit items in sync flow 
> creation") on 24.11 regresses eSwitch HWS when representor matching is 
> disabled (repr_matching_en=0): traffic that should hit PF NIC Rx rules 
> after FDB transfer is no longer received.
> 
> The backport dropped the priv->sh->config.repr_matching checks that 
> previously gated implicit REPRESENTED_PORT / REG_C_0 prepending. That is 
> correct on upstream main after repr_matching_en was removed 
> (c41f621786), but on 24.11 the option still exists and, when off, TX 
> representor tagging is not set up. Unconditionally prepending those 
> matches then scopes NIC rules incorrectly.
> 

I think we should be ok for 23.11 as the commit that was being fixed was 
introduced in 24.07 so the backport is not relevant.

e909fd3a90 S F net/mlx5: prepend implicit items in sync flow creation 
(24.07)

and ok for 25.11 as c41f621786 is present.

$ git tag --contains c41f621786 | grep v25.11
v25.11


> Dariusz volunteered to send a fix.
> 
> We will send our full report soon.
> 
> Regards,
> Ali
> 

