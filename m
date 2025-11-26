Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C55D10384
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 07:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6228240691;
	Wed, 26 Nov 2025 08:57:39 +0100 (CET)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50]) by mails.dpdk.org (Postfix) with ESMTP id 5F49C4026F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 08:57:37 +0100 (CET)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5943b62c47dso6233051e87.1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 23:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764143857; x=1764748657; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+yXd9lKq9/4qugYUkMEem7Z6PuZr8kXohZrTxmM8TbQ=;
 b=h9W3w+/TB6QQu6YZOyCwCfoMv4yUhCnLbS7KtErn6qVhZivwLT50CI1kgErYOio2Jq
 IY3rsocGZ9AMpSURx5e3foym/wEYkCKWMZ8FHKEMdIIpbRMrYM2h4X7WLivdHWIGfrzk
 NCObpPsByqnQupACDx0OgRSrWxKUwccJwucWS8LP99tY1CWRdVBg9QT9CMLKw5VK5vUy
 b9z3rAa+g4QH4G1gyesQKlNG1UD5RjYGeY++3eoC99KR8nLG999FI/0HR4Ovhprlykrr
 qS+HPQpZ61JHrLVbgLz+R1xzRfu3sPRCVQdB9k9sCy1f5feCLZ9+7/OmFc3trlENnYLy
 9MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143857; x=1764748657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+yXd9lKq9/4qugYUkMEem7Z6PuZr8kXohZrTxmM8TbQ=;
 b=C8xFjJ6t3GUljOEVCtYgLzreYi1sEIaIlk0KqMrbMoEqXepNat7Z9v9VCsoBpc8PCZ
 kh61c5DJewMvHf+E2s5moJezXEzq+P8y8eLkmGW3B4J8rpID3penE6BBRiA9PHqhTH1W
 LdnmPL6BHG66kFZJhYP/jYbBm4N1gmLajkYAb3WxGjFaByobq3IfOMOHtyhYbtwfX/3N
 W6z1eBKRWA2K25qF7q0qEhCcjWgOPumWMzHcU9HEuaWgSreCtyibrinLwlGa4vUQ+0DI
 v97fhRiDU4rzq/knAEnYEo4Z26T5KSTvRm+tAqV/L4Y+ijF89jyhF8kx7fy5f4gf5PH1
 p8yQ==
X-Gm-Message-State: AOJu0Yw0ihe0UOiCe7ogLqb6s69YQD59H3jtGWjIlX52BbhFvafKWqPM
 OPvOujOdkaXVd3KZcRsVCTMCShKGQo3UTIIqsxa1tstxOMO2DDAm7O8u
X-Gm-Gg: ASbGncsnelHuwNzif9eggjOMwFIJa/RS78QwKLR9AWM1nAVG47BjAIMu1HR1mq9CgRe
 EfmpgucUr1uwOAjBdFSF2enNPKKgecjTxVC42oyimXElZrfqRjK/ub8cVARWsGYyuBI4+4p6DV3
 05/hNVo0hCN94bI+XUaoKtu1R/AawduJzF2RaNGPeT78cvnXxWiufXtZDlk9KtAV+Q9yc+1KcOp
 M77IxWfI/6MkazHj0W6OTlQR8QyHNs3mGusn1MFdq0gQrRTN6fXGigtZMTLvYPiW0BBTVEpJvTs
 GPvEpmCM9abcvaFsdqCvT/4XtKOkkJPJcdHKKARJAe2Z47VnFaZwdDrQaSOxXwStao8eKJqGpay
 109GPucCW2zk05+vqq57dfFzJLAQeaL/BHlwgMol15jUGkwn2d2lsJUcXtAD9Z+8+b+8Cn5+yTR
 HWzrr4EjQ00S/nN7yyk8M95MNh3jYIKzZze1pEw1lM20/zVImW3soRWXjVjc0ehMjCchdmqPuab
 0vC
X-Google-Smtp-Source: AGHT+IE//2I4sIm9QZpwHlmJWmLYh9c5l3SwlqTARQJqfzZM6uxCuyfseEZK2DaX2JU1JFBWe8lf/A==
X-Received: by 2002:a05:6512:2347:b0:595:9152:b90e with SMTP id
 2adb3069b0e04-596a3edff8emr6474540e87.44.1764143856388; 
 Tue, 25 Nov 2025 23:57:36 -0800 (PST)
Received: from [192.168.88.232] (broadband-188-32-202-29.ip.moscow.rt.ru.
 [188.32.202.29]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969db894e0sm5828430e87.37.2025.11.25.23.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 23:57:34 -0800 (PST)
Message-ID: <cb7c53de-bc26-42c1-8695-00a4a335ebef@gmail.com>
Date: Wed, 26 Nov 2025 10:57:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: =?UTF-8?B?bWFubnl3YW5nKOeOi+awuOWzsCk=?= <mannywang@tencent.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
 <7E45BE076ACCC3B2+d9eeffa0-a442-4766-b45f-406cd99700e9@tencent.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <7E45BE076ACCC3B2+d9eeffa0-a442-4766-b45f-406cd99700e9@tencent.com>
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

On 11/26/25 05:44, mannywang(王永峰) wrote:
> Thanks for sharing this suggestion.
>
> We actually evaluated the heap-based approach before implementing this 
> patch.
> It can help in some scenarios, but unfortunately it does not fully 
> solve our
> use cases. Specifically:
>
> 1. **Heap count / scalability**
>    Our application maintains at least ~200 rte_acl_ctx instances (due 
> to the
>    total rule count and multi-tenant isolation). Allowing a dedicated 
> heap per
>    context would exceed the practical limits of the current rte_malloc 
> heap
>    model. The number of heaps that can be created is not unlimited, and
>    maintaining hundreds of separate heaps would introduce considerable
>    management overhead.
This is a valid point against heaps, thanks.
> 2. **Temporary allocations in build stage**
>    During `rte_acl_build`, a significant portion of memory is 
> allocated through
>    `calloc()` for internal temporary structures. These allocations are 
> freed
>    right after the build completes. Even if runtime memory could come 
> from a
>    custom heap, these temporary allocations would still need an 
> independent
>    allocator or callback mechanism to avoid fragmentation and repeated
>    malloc/free cycles.
I don't understand the build stage issue and why it needs a custom 
allocator.
What exactly gets fragmented?
It is the entire process address space which is practically unlimited?
How does is malloc/free overhead compare to the overall ACL build time?
