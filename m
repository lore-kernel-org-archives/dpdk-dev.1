Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45260D0EE00
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 18:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25B5B406BC;
	Tue, 25 Nov 2025 19:01:54 +0100 (CET)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53]) by mails.dpdk.org (Postfix) with ESMTP id CDD4D40615
 for <dev@dpdk.org>; Tue, 25 Nov 2025 19:01:52 +0100 (CET)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5957f617ff0so6204921e87.2
 for <dev@dpdk.org>; Tue, 25 Nov 2025 10:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764093712; x=1764698512; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5JQ44jP8XRZY3veMm99FS46MT29IrKGKOf+Jh40dLUo=;
 b=NPSR6Ve4JR2ZKFUqW4WZTEW+TE5hvXNlt+3zO7mgAHv41W0B64bg0UjjbGgOTSETXx
 pCbfHpWPsLK/4/AsWHTRVqVgVdo2+Y/wfl8c+azk0lqfC1r0PqAbcuGaQrczhkrYnPLe
 Ve11x/yrsBvEuF9+cD1y1Fc58ALTW9QpOu0fRufo5F2eAM1CwOEcTh2wXTKikWRee5TE
 7zokdSHzxxDxlT69ETKmj/R/YvNbxzdgHcCjwWIRSngDO+ZRSvuFA2O1lRe0oHw4zcCI
 fAsecALmXBLBQ2r2yckYzIjrXU6xLyEQ1G3WV8DQ8NDTRPG9HPRRIXf9zkWjtzx2vvOI
 14sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764093712; x=1764698512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5JQ44jP8XRZY3veMm99FS46MT29IrKGKOf+Jh40dLUo=;
 b=dsoO0v6mjxE6VgG7MMo0lOEv2LKngc9I2i1E0pqtxV4ZzvsOo0CgmNZjJw4mN0QWN7
 /abYOV2ra2q55W8vNF12xVRpLariMZa/ZmlQSBTbdaZHgAQvrASOgVP3laWjKltsTNEY
 ArprU8Ig9r5WSbeI0+s5xY22lP9IVq5r6VxavX4QGU2J2bOB6saJPDG4uoqtJfx4RzkE
 D/eDp+cL65GgijNP0NYNhq6f/mOXBRoU1dsm0kmMiZCNHFIfBOqj+PfUJxJmKyPMsMiY
 b7RU2VdBgyMiSzVL4djK2tkNt35UY/+xm/jqSnKiTqNdO1g3qtZssIsgh1/OyE6RBMCV
 XftA==
X-Gm-Message-State: AOJu0YwN7npbGouXIbC5/hks8OvQGpBX7dvYRcP+qNn9khi2kPNpld56
 E43Nv6VOBJsBS/LZq8lfWvkd7qy1tcEhYKe2MHSSduZRompGpsfe+OnN
X-Gm-Gg: ASbGncvPbuQBp5GzhzCZ7l+PTvLH3BhQCBoq4fJhRNxjb782Y7ALFuRAfWtsywE1l5l
 1VJ3Tp5IZEnWIggSxnhK5vcvnlgHre15sBWjfKK4c/OLcNaDai7Nhi8ZmchEFwF/uTAy3CuQK9p
 OPy7IVN82ZsE6tO+jXZcI1F6j9LdpVwLsMhubwCd9dhtZ79KVg65zkXm02fyNO8tSMswV1x6jgF
 k1rNgPR/dhKgYPAXjY2qZ9HZZE0ulZmn3MW/54Rm6ug10XICBeZyW/9hYoH1Kz9YczxNhj7fZ35
 VbAAZNLJ9cYnFgRqzcH483G4ylzCHjFWzLIkeOrPgjVSYuUwyONiJUQzsDKgSoJmOcaxbcnisBH
 XiyaZSX/qqH/Kbtxv6v6TXVduqfH5JORTv4dEuQwQFGXAfzbMjiXDOJ/Ml1Pio0JWi5kA2KL9hU
 ggOYBH+bALvzgGGpZzv5FbsZdaVwpLvHFl8tsgkJA78iZApb2x178FRenI/5CK4IdZfXE5Mao+N
 WD+PRn/cxI/iFw=
X-Google-Smtp-Source: AGHT+IGUB6Ev8VGOQCnmQPo43W7B/zxxKtTPIbr6N41o9MEfaHkiVp4jVN1tcQ1LZ6W192SufxMmjQ==
X-Received: by 2002:a05:6512:3188:b0:594:2835:e73e with SMTP id
 2adb3069b0e04-596a3edddf5mr6582236e87.37.1764093711745; 
 Tue, 25 Nov 2025 10:01:51 -0800 (PST)
Received: from [192.168.88.232] (broadband-188-32-202-29.ip.moscow.rt.ru.
 [188.32.202.29]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969dbbed8fsm5218632e87.47.2025.11.25.10.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 10:01:51 -0800 (PST)
Message-ID: <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
Date: Tue, 25 Nov 2025 21:01:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acl: support custom memory allocator
To: =?UTF-8?B?bWFubnl3YW5nKOeOi+awuOWzsCk=?= <mannywang@tencent.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
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

On 11/25/25 15:14, mannywang(王永峰) wrote:
> Reduce memory fragmentation caused by dynamic memory allocations
> by allowing users to provide custom memory allocator.
>
> Add new members to struct rte_acl_config to allow passing custom
> allocator callbacks to rte_acl_build:
>
> - running_alloc: allocator callback for run-time internal memory
> - running_free: free callback for run-time internal memory
> - running_ctx: user-defined context passed to running_alloc/free
>
> - temp_alloc: allocator callback for temporary memory during ACL build
> - temp_reset: reset callback for temporary allocator
> - temp_ctx: user-defined context passed to temp_alloc/reset
>
> These callbacks allow users to provide their own memory pools or
> allocators for both persistent runtime structures and temporary
> build-time data.
>
> A typical approach is to pre-allocate a static memory region
> for rte_acl_ctx, and to provide a global temporary memory manager
> that supports multipleallocations and a single reset during ACL build.
>
> Since tb_mem_pool handles allocation failures using siglongjmp,
> temp_alloc follows the same approach for failure handling.

If a static memory region would suffice for runtime memory,
could you have solved the issue using existing API as follows?
1. Allocate memory in any way, may even use `rte_malloc_*()`.
2. Create a new heap using `rte_malloc_heap_create()`.
3. Attach the memory to the heap using `rte_malloc_heap_memory_add()`.
4. Get the heap "socket ID" using `rte_malloc_heap_get_socket()`.
5. Pass the heap "socket ID" to `rte_acl_create()`.

In https://inbox.dpdk.org/dev/tencent_4125B1322F9238892BFA5F38@qq.com/
you said that the issue is runtime memory fragmentation,
but also did "propose extending the ACL API to support
external memory buffers for the build process".
What is the issue with build-time allocations?

