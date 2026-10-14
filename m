Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B0CC6B24
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A18B640279;
	Wed, 14 Oct 2026 08:45:29 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id BC3BB40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 08:45:28 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so2139137f8f.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960328; x=1792565128; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+/9HcqhijrTF5I2DenkRM2n2wQ+EHIrHo2zs8PxV30c=;
 b=VhLeHapdEwEjET80ve2BWkOkGUfhq+wgJ6FVdG202QSxQw5ZVFInepqzkrJyWsGlvu
 KyGhQilWGtE//albZsspVAQMd90Z5xn+wTAflpxRGb5muVgqmhD7Hmw9aNyBVmRHZHdh
 40tCIa0qIpqY2YSW2zaZfdbaJm+eBL54qaMSjGR4CWSgNYSAyRavH7MmbrMnTGZwMoCa
 HKAhoWifvB9aWrAs2+dmrZax/QZUVgFh3Tn9lpUkDCgUnzqung2FnF4TnbDgjpE5fevN
 Q3PjF5KBWkzOTJXtFFA1qTEUYd3GKQw93hEG+DuD/Ug/AmWHdmz+NaUr7g3y23/V7GSQ
 wunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960328; x=1792565128;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+/9HcqhijrTF5I2DenkRM2n2wQ+EHIrHo2zs8PxV30c=;
 b=gucVfmRea5db+y/gO42IqRaSdrrqhP5KGawIM4gTAZxytuEX14moh3DEMoDong+9wI
 SEuGANeCIi35/8rFah7rqlJOn0l3JxJkunCZLUrqussto1uU2shD+7Pq8XpXmfToqwX7
 hXlsrEAY9LlGCi+sJVK14yFTGFGVnQwo3PwWEKfiv5/HJ1nPii981Q8Z22Qf7dEPAXOd
 DWlmq2R4eF7/7FlucCuQvZXNbIuyghh9as/J70J/PEs6DL+89IdAdsTprsA7U4dytHID
 lhGavM4Jhb08d6k8BZBVztxnTs75qxZ9o8fFSA6uzNmWNEfWiwEphp7mqkYsejR+GP94
 1hpQ==
X-Gm-Message-State: AFq9FYLdvUXiGichnL6BbtaMIyTm/4U0s5ZiGsGLIqwDeq38RJvGIRSr
 9tnmegVYxzCjBTOVRKv3bIf6NSQIr8bgF3vE4bkkwot+1BUI21a6HwVtIHXzROQSlSw=
X-Gm-Gg: AYBFou3d67gCRjpF0C2p/jP15TO4C0iSQAHc0ZXbgRyaGNXF9wBeWxcJO3tfRwU/y3J
 gHeN5r+44nWhQONTu9lpcvXJxVLuvtWONk2nRvnFC1tjiFs1l7WHi4vE0AbIgmwri1QFebytmEd
 AhKRBNkfDUi4czhqhalV5ERbK+Ks68w2LP6xTMYIWF6yqxdAa9OMrCJ3g1j/3RyQfOTtbNi2Jqe
 yGPcW2UhE6a5u9kFf2dnxDyjC1a/0MDVX7d+NEyyBTfyAHNxLEhabj1rV7nxBidfQfkElxYzBva
 JFR3Me8gqVcg+h1T8BtpzCrox5OiD6O+eEzdMvo3HN46ybzZmGKcsr9cFRuEieCX2xLEIIJsM9T
 WjVzNmJzeuycnUSCb/GLdlZWdGlHhhHrcAFTZoTocXur0pUByMzEioRfqLxuPSdyGS+GVNByYLh
 9ST3WwW4FDuBMTwrXmH/fMSlwEfaDyHFEFAwR3ijSs0mMTZCObnazrntWW6yM3h54VoJ1zzG+HP
 VkKeQ==
X-Received: by 2002:a05:6000:470f:b0:48b:74b:4ce1 with SMTP id
 ffacd0b85a97d-48dbad00328mr26307055f8f.32.1791960327997; 
 Tue, 13 Oct 2026 23:45:27 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.42.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de72d2b13sm4659496f8f.55.2026.10.13.23.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:45:26 -0700 (PDT)
Message-ID: <dd243c4c-bb36-4340-96d5-28b2b35b186b@gmail.com>
Date: Wed, 14 Oct 2026 07:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
From: Marat Khalili <qm2k21@gmail.com>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
Content-Language: en-US
In-Reply-To: <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
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

On 12/10/2026 19:52, Marat Khalili wrote:

> On 09/10/2026 07:05, Wathsala Vithanage wrote:
>>>   /*
>>>    * Marks given callback as used by datapath.
>>>    */
>>>   static __rte_always_inline void
>>>   bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>>>   {
>>> -    cbi->use++;
>>> -    /* make sure no store/load reordering could happen */
>>> -    rte_smp_mb();
>>> +    rte_atomic_store_explicit(&cbi->use,
>>> +        rte_atomic_load_explicit(&cbi->use, 
>>> rte_memory_order_relaxed) + 1,
>>> +        rte_memory_order_relaxed);
>>> +
>>> +    /* full barrier: count must be visible before cb is read */
>>> +    rte_atomic_thread_fence(rte_memory_order_seq_cst);
>
> NAK: optimizing this increment makes little sense when more careful 
> analysis shows that it can be simply removed.
>
> I highly recommend keeping this patchset dedicated to removing 
> rte_smp_XX barriers and moving other bpf_pkt.c improvements elsewhere.

Withdrawing my NAK. It was mostly for stylistic and commit history 
considerations, we have run out of time and this is the only version 
that has a reviewed-by.

