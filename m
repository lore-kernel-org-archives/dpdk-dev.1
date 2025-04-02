Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70F4C36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 21:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 967024021E;
	Wed,  2 Apr 2025 23:16:20 +0200 (CEST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43]) by mails.dpdk.org (Postfix) with ESMTP id 53F0E4014F
 for <dev@dpdk.org>; Wed,  2 Apr 2025 23:16:19 +0200 (CEST)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-54298ec925bso401056e87.3
 for <dev@dpdk.org>; Wed, 02 Apr 2025 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743628578; x=1744233378; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qvp7q/tyygvzjdRu+KDrWc7Tk2P6xiplVLx1ZTk5DOI=;
 b=K5kxkYfALQWYxOXh+mm4oWNxxefRANg456con2pobwKtXW5G/vU6hzpZyF5cIiUmZH
 pwdjuBeITftyOHziDuGukzL7qf2gk/LoVK1AqnIISLAmIlic0dzhNxKmwJbAZzb+FopA
 4dMQXaRFKOZay3osbYIJvKv+GuOUvDgSYePyuyG90F/ld2UAafYdo5ggeJv8qrx6bIfS
 dpd6ii9n3dHISPtOTEpahQbQDSZt0Igw2nTe9BJhNHUoAOLGKhtv/30jNAEC+Tm/AAwV
 GgVpNSCr4d5tOm/+Gx3PxoJwk6mU4dwrILCsyCXooApaPp2wR3sDQUjk1xnIdxxlCEsN
 47Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628578; x=1744233378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvp7q/tyygvzjdRu+KDrWc7Tk2P6xiplVLx1ZTk5DOI=;
 b=cJEe3id05g0vDenO5CIGqnxC6SMvoomMneFTLDWw73chXkNAhahsOspdgwbshwVWrZ
 WgupSrAquebu96K9VHYrqodx8q7JAI/fph8HLhhLc07uztYLXFjaeGLtMiHuh0mFpbuN
 RKTnTQO6JkWf2fYrkEu2j8Zis7GqxWRJ+P3W3d6epZK9GA5ewkTVjjiosOl97dWbxKwP
 NuZUTNAovVST/ekWKQ079R45ziQ3DspRJsUtNvPvO2hGzxsqP30B4NUXOnZLQCU9Hy1j
 W5jayo5apyNIm3JmvNQarFUhfcagbhuzjY30al8hNYrPKbfEYp5B4Mu0Uqj541Z6WrdH
 08RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViDJzxqXHkpd3e8vA6ETvMz8HSFL5yLpcyGEOqYV5tD/sYsV+bklBxxoC9ALSd2mFHHFA=@dpdk.org
X-Gm-Message-State: AOJu0YwRu3KDymEWpPseNW41urd9Fql6wTDUk/8GUgXOGFK5dn9hp3zR
 qToPlLspghXs19p7GPhoayxWEPfHejyxzMCTm0Rrmkv8NUPXqsCq
X-Gm-Gg: ASbGncuGGFdmgBqhJJ2Me/c9LxuAleZrguYMA8DwxNu1Ga3N+jfKmnTjxkMa2NygwLX
 /O+7WiKGEwmxQ8OgC+G79nHtaRzWet487m7/iZw3dwfrGwAkR3GkqXiQVUw3YX6NSKwjtqm3FCN
 8wZHLUYyWNYOdMO8B0+C8zL/8GgcKeioBeqzfoa85sgmKLwryB2ZVB9sZvS0T0G/wzTD/aFS3gH
 GV6Itv6hZXQZ+/Wx2ulUUsNzS/C8cpOMUEWrFoWHIBC2Fp2xlSsi7Zzapahyr3XPKT4cs0T5ys0
 5YQtXlrKwSf58hNWkFWxfS8spcbELCpyCZVA8O78maPQCfWa0GtOhtMavBlek/Ug7TKddZjWh8h
 iHJmDhPUTS445dZ6q5H8/1ZYCWixv/+2zEtm1
X-Google-Smtp-Source: AGHT+IEPa25/kUpHaYgC6KmltenSNt5IYXwqwnP8S1ddFVYXn0PGt+MFREuUGZSJiPiOQMhyJ08nnw==
X-Received: by 2002:a05:6512:124f:b0:545:2a96:34f7 with SMTP id
 2adb3069b0e04-54b10eccbc4mr5422151e87.31.1743628578256; 
 Wed, 02 Apr 2025 14:16:18 -0700 (PDT)
Received: from [192.168.88.232] (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54b094c191esm1723118e87.82.2025.04.02.14.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 14:16:16 -0700 (PDT)
Message-ID: <a063308e-448d-4881-a661-17adb52888a4@gmail.com>
Date: Thu, 3 Apr 2025 00:16:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem: fix infinite loop
To: Dengdui Huang <huangdengdui@huawei.com>, dev@dpdk.org
Cc: fengchengwen@huawei.com, lihuisong@huawei.com, haijie1@huawei.com,
 liuyonglong@huawei.com, roretzla@linux.microsoft.com,
 anatoly.burakov@intel.com, stephen@networkplumber.org,
 mb@smartsharesystems.com
References: <20250402124258.2299435-1-huangdengdui@huawei.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <20250402124258.2299435-1-huangdengdui@huawei.com>
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

On 02.04.2025 15:42, Dengdui Huang wrote:
> When the process address space is insufficient,
> mmap will fail, which will cause an infinite loop.
> This pathc fix it.
>
> Fixes: c4b89ecb64ea ("eal: introduce memory management wrappers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

Typo: "pathc fix" -> "patch fixes", or, better:
"This patch stops attempting mmap if it fails and the requested size 
cannot be reduced."

The bug is actually older, but it doesn't matter since both c4b89ecb64ea 
and b7cc54187ea4 belong to all LTS:

Fixes: b7cc54187ea4 ("mem: move virtual area function in common directory")

