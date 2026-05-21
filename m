Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22697CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D799402A2;
	Thu, 21 May 2026 17:26:12 +0200 (CEST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49]) by mails.dpdk.org (Postfix) with ESMTP id 4A4E1400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 17:26:11 +0200 (CEST)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a884815606so7306717e87.0
 for <dev@dpdk.org>; Thu, 21 May 2026 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779377171; x=1779981971; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pF2OhlFU86xPb/0Ibbh9BLfVlu11FV6K2hVt5QkkbAQ=;
 b=X0ZA+DpD7eRIDARmgwiHzxmj+8r7XOUWTqO1BxgGAA/cjOKvk6A6wgrPXMQ54d2gW2
 a7E81KXLa9gP4mXW8BACH7zuclxUi76m/S3PN6320b6q7IYxclHYwqzVo63AqomJEnKx
 DdfbWugJTCzMUK28ntCwo7SEh3o42gj8Ddzyavsg2HoJnJZqXvKnx2qot2GzmCHv7ssJ
 rB2e8NHOmsSzfJ38tuVQjMpQSa+sh1lcLkfuAG1aAAhb3EMn/BZZ6EIGXDcLgpNqg4NY
 JYNBxOa0qeORoly/FWVIUZ3tDYbCLUaZctPxMQPCDDpacixV/3yJzGEZNujf9ZF/PURa
 EbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779377171; x=1779981971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pF2OhlFU86xPb/0Ibbh9BLfVlu11FV6K2hVt5QkkbAQ=;
 b=IV0LNqprA5lNbtXqszf2w+Sn1FC5VgKSR6Y2AYVnC919n2kIi1xtfBuUA1UBAua9fm
 9/JrJU+ho1yn4t0veMeKejlXo4GglB8hn9rU8jGhDqiICs0AhS5a4ppvN8iILs6OuYv+
 J7WEoEdiw2GLVHrtI7rSmN08qNcSdd/0J/rcoPDZiiZ0LeNfhTiuXf7kI3fSViE7ohKJ
 +LvEQY2rOxDi7OV4l/qsxwSkqU5eaSGrZOJM1JnsEqIbCmJfKqy8qFil80cZyT1NtwT5
 Zk3f4VdrZmY5L7l6OkZ07XVG0hP/pHh9MWVXQvomiSQdA83kSfa7So+No3fTZzTrLjpq
 ANVg==
X-Gm-Message-State: AOJu0YzUaFn+6VxFaTDDFdELFoDQDeoAJ479D9bcoXk3m78ollhk0MfD
 QBmm5VPZ9FX/xbn0/4zBF7xOAOQv63yufly4/hHHTkjc1M+0xnvWesK8
X-Gm-Gg: Acq92OFdW4QdI1b9XG7+L5goahVaFGrthBsGOxSywo4UVUL6SSHUYM63trPnxwRTZHA
 G9KyGLY70z21fsZLQlxbiWItA2W4/Vrp5K/9khXm1rz2kNhiaDtFLR/Kws9vOD611CRgIGEniFo
 EjSxWbdOrDmaOPvelBLlMAu6MeFWMpYErrYo5popzD3sd4S9i1H3PiWxRUmAIuZbGAAzFQHtVZd
 BPAPk++TTK/viZrTIdcYKUtNMTgRcYRAidu6w3SKhaw8kVgsFH6hb5GpuZeluSeJoWIa1f/gvqe
 8LzPPCNtzkjPil1Bub3O2Dxym4bOc7MOWF2yTOmiQLVtXUYu0v5F4eWkD8zBh6DWA9BGHlikie3
 +qkUy8gzHVHTb+8MseqUmAdqSmN28ss0HqyI4H7pVG23pBWYq/a4jgsC//jq4zIYI98P4Wqajun
 4BrGFvH5mXEn0VHrLn/KhiN44rItNQ7FoVIKlwAEXv3ZG0srqsKdTMPoi/CzMWoBi1Hsh7OZdPm
 LGm/zmuLK7Bi+DjBGrFQqlqUc1cMtlVGXi7K/m1NBeQojqetV5NHYpK00AfvQU=
X-Received: by 2002:a05:6512:38c5:b0:5a8:6b89:5e5b with SMTP id
 2adb3069b0e04-5aa2ba9060amr981153e87.36.1779377170318; 
 Thu, 21 May 2026 08:26:10 -0700 (PDT)
Received: from [192.168.88.232] (broadband-178-140-149-144.ip.moscow.rt.ru.
 [178.140.149.144]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa2f11a390sm353771e87.9.2026.05.21.08.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 08:26:09 -0700 (PDT)
Message-ID: <5dc0fe20-2b58-40a1-8118-7b653c8f452f@gmail.com>
Date: Thu, 21 May 2026 18:26:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Windows: fix core count on NUMA with more than 64 cores
 per node
To: David Marchand <david.marchand@redhat.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Gena Tertychnyi <genter@microsoft.com>
References: <20260513235518.408895-1-andremue@linux.microsoft.com>
 <CAJFAV8yhmQ8hEpMmUWW77kAyuJXb-Ru6z1kBnHLSBhcZ_LfEhg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <CAJFAV8yhmQ8hEpMmUWW77kAyuJXb-Ru6z1kBnHLSBhcZ_LfEhg@mail.gmail.com>
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

Fixes: b70a9b788625 ("eal: get/set thread affinity per thread identifier")
Cc: stable@dpdk.org
Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

I believe it really fixes my commit b8a36b086625 ("eal/windows: improve 
CPU and
NUMA node detection"), but the patch will only apply to Tyler's commit
and it's far enough for any LTS.

Nit: EAL_NUMA_GROUP_COUNT is not needed because GroupCount handling
is source-compatible between MinGW and Windows SDK,
and there is logic to handle GroupCount == 0 for older Windows anyway.

