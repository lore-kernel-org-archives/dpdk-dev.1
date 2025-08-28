Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38120C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 14:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C1894025A;
	Thu, 28 Aug 2025 16:55:15 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id B526F400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 16:55:13 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so522861f8f.1
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1756392913; x=1756997713; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fMtMN8zMMi3jaVIONpn6Kr95DCWc8wPqwihVZ01JuIo=;
 b=EDwD4VLM7GFnTy9l+aiHD8B+gDpL0FNVJGMz94biyBjvxUzLzNEBGKdVgoiWN6676w
 XhVPryWOzO50cLp94bqJVfq2CuQGirC5lfd/l9XS81/WzVm+LJomEXopdAL9VdAo776S
 /LmKA49iRbTKGH/ZmMLAjzqrrx5HdohfmiN3buVC4A0hIZV4rl9qcsNj23RwpvT2P0jO
 IXtiZvUdYakdMwP/f3goFUqGUSkBunlbHZLtBhw9mhQl5ZE7kn8/jU8ADU3G3vbZaxED
 7GE55R0ZJHSzVC3ZOGXWMLgXqLMnmLcmJRWUu0z5rb71T87lpSUpWA8pzXF+jorZv+Gh
 OhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392913; x=1756997713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMtMN8zMMi3jaVIONpn6Kr95DCWc8wPqwihVZ01JuIo=;
 b=Jje6KuD3QgywHYZuwMKGqHQERqDHQ35lBOrrbbCfPq57bKbJ9S8LKsZe0aJU0ErvQ0
 Dk3qUZXoI45jzLR4q16J1yC1qNyLiSLJnTXIFUQbXmIa/uare5mo9TzHtBScC6BVOn1O
 fqifeh4SqGuXmjQqskCVwCO/ctEVReqJwOLGptKD7gZLyvU0Fur6UhCNcpHwIsdYiKDc
 2NtnpTNdsCUOmHGpOsFC5NttHML4ctuOcUx4bpN03vXdnmMyUtsNtw1i/toQa//eDv2L
 boYsAdVVa+e36F4coPYaNrkmQ8e2foBB4rWWlJdnEyqYi49B94Y/gJ+Zzoyc4ceQ2SYN
 oLqQ==
X-Gm-Message-State: AOJu0YyY/LEqsXB1DxnJWYrBPD2GZ6i5X4FioJNfmj+Ej7IMcKsXB/Xp
 djS/GM9gUmtVku0570zdGDx4OPFWv8y+SEhvsCfZTnwlWNxQcvLaC8ODisIiePqe+g==
X-Gm-Gg: ASbGnctIPppRF5ufJpu+D4kn7JNv4b6cM26pu6UqJzG1hPIBeulr8rC+tJ0WisKQoC8
 tKjl49Wf/n5wEDAb4jyTipmZC+QRkutu6/nKJvhItDuM+eEjEuCMhXu4IagBP8UpW1bo3maQhi/
 GVg4giuuhX7pH8mUHoV2ISaz6BOiJXjrsXasBHHahx/K2Gdwn3CLiFVYAv0IpaWgVTSckAYePoo
 t0gV61pNlBaS1mgdiPllpTvqXoGe9BYMzS1PS3fYVtadKIlAL0+W1zrL27U3kZR2PwMad0jQa9P
 lAQ1QmXHolVa2XxzVHPJH1kxZZ9U49EpGu/lmbOkQGY4qT7ilxcewaN1ZHnUgvhc+H+kBhs4PK7
 90AalkEGslZtwdMLzQyT5e4su9mssgQKgQk9z08Wz2hzGVkggvP3Fe/uSoUE=
X-Google-Smtp-Source: AGHT+IG6N9AbaByy5CZpdkwxw+wp7C6RGOihU1Hz+3l+6rYVxjhRRq1QYdihmBmU4l4MjEfMzoSXoQ==
X-Received: by 2002:a05:6000:2f83:b0:3b5:dd38:3523 with SMTP id
 ffacd0b85a97d-3c5db8aa9b9mr15694098f8f.8.1756392913179; 
 Thu, 28 Aug 2025 07:55:13 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cbc6a5da6dsm10678094f8f.63.2025.08.28.07.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 07:55:12 -0700 (PDT)
Message-ID: <c2e83bd1-4a5f-447c-8ee5-261a0f886349@6wind.com>
Date: Thu, 28 Aug 2025 16:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] net/qede: workaround for operation in Ubuntu-24.04
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Olivier Matz <olivier.matz@6wind.com>,
 dsinghrawat@marvell.com, palok@marvell.com, jerinj@marvell.com,
 Laurent Hardy <laurent.hardy@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>
References: <3bbf5e67-8acd-47f1-90ea-405f62cbbc4c@6wind.com>
 <20250828075135.77381013@hermes.local>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <20250828075135.77381013@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/28/25 16:51, Stephen Hemminger wrote:
> On Thu, 28 Aug 2025 10:09:35 +0200
> Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> 
>> Hello,
>>
>> [resend because the original diff was for the 24.11 branch]
>>
>> qede stopped working with recent distributions, as explained in this bug
>> report:
>> https://bugs.dpdk.org/show_bug.cgi?id=1379
>>
>> For reference, one workaround is to disable all optimizations when
>> compiling the qede PMD with gcc-13, as seen in main branch:
> 
> 
> Using O0 is pretty drastic and can have bad performance and doing it for
> every distro will cause performance drop.

Hello Stephen

I absolutely agree: -O0 brings a big performance drop.
I am investigating if the qede PMD compiled with -O1 or -O2 optimization 
levels and gcc-13 is still working.

	Regards

	Thierry

> 
> All patches must have Signed-off-by, so this patch will be dropped.

-- 
Thierry Herbelot
