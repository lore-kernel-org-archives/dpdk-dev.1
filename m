Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D42109448A
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 17:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D3F5402DB;
	Sat, 21 Mar 2026 18:19:09 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 6A265402C9
 for <dev@dpdk.org>; Sat, 21 Mar 2026 18:19:07 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2b0586d5bb8so20462495ad.3
 for <dev@dpdk.org>; Sat, 21 Mar 2026 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774113546;
 x=1774718346; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0AhdQKOq+Wgzr5Lm9sP3lmqJ2jHMsbjoPj6apj4YVA=;
 b=VMzI1zxyNugiHBwx3xOZ51BCBvj8rgmbRiUcqTO9UkVtFbZNa+xvy298tMosF3FCiv
 Xn1+NzTluQezfGHd4oEFa2dRVHNpYaUEdIukuA+fRaDN/2QVvYRkf/lhtllOYUrHlTnN
 7hfeTlwYlnFjifZDyCOJ6wG2J8blclVpHXkbfioC1due8r1JGKFJyv/sdXQBnM1km3qD
 0kvnLtaQq2si/qNEUcLVIMxmJY+BVTYuX03SbXMjY32D23QHoUgNaNBKVrINHidGKDrc
 Nvlwo9j6piEXr5A2OLW711Artv2A6X6uVYUMQhuODMzXRpBAqWZNnJXqiLecSmrxpW2X
 tZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774113546; x=1774718346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k0AhdQKOq+Wgzr5Lm9sP3lmqJ2jHMsbjoPj6apj4YVA=;
 b=KGZ0eoM/M923efy1pzdJETFpA31B7KZd1dAUCeM7MhPClskgUAjfhv5Vc+F/w0ig2j
 5hAC8NyyITcqObSGUde8kfvj9AuENyv0MfVaYweEuJ7iA+MEi7ZfD0brZuMVYTRLoZ/4
 m755/kfwwqRme/NooMW5dkCJRvRe8mValQ4/jS2a0FWtJ+rwtx5thnrNLn+O6mhhK/2y
 SR3zrjBVMZjABqmnwRQL7zYQhbvuXKl9RXobGVGrih8cW65a5uNjyV3qClTzs634Pv5Q
 CRfpqB4a6OoeEu668Dr+2eKyDLf74Z27w7LBFj7qpasHO27v1juOT60Vp/iBU+NbMKoN
 iaFQ==
X-Gm-Message-State: AOJu0YzUv8JGCo1cQE4KhEgOVGnmBQFw61DXT4DzPLAzsDEVfuA+Gjye
 na7E8L6a+aSbgR0CAwcJcRdvZqO9uADfabSijgb+kZbI1gLqqgoeMCnCjlfw+TEMv6h32bD3pC1
 SNw7Q
X-Gm-Gg: ATEYQzz46VWf2pKbFhOEdERsqflNjcU5Y4F99U6p7UOKlZfPavDDc3QzNcMtQcSA8dA
 gaq50EL27pzTx0A5scR87bOhWVhVvLy4SHP+p+vLqk2ntF0oEqOInG+wN80A8LTxfGi4a9k7zwN
 OQx5hjFkRVpVsEn6nAe1DWSvBiG6EWyRy2/6llPUTJ0wfaSUpd8DSPUevA1oeor5wJ9Cg6l0u9C
 8XendewOS0Q3rx2fnms71qzcMagewssVi2tSo4QEiHcppjNy1RtWH0GrR6w5jvpxfR+xBEsHa2J
 E7cqH5ph/AqFIEfiXGXXT7ra4pjwqkGMTiPh1nkZzjL/X+zDmmIQY7YjS6AwKylq8ouoDye46+A
 8ubO0uIL3Mqxrpu9cMFplYgtjkQyqDPTQZJl+glNTG8LVhaqe3+1qJ08ENVl2rDinJuXKJDn4ww
 zRGQEU1S9Sm2AtT/O7ylVcGAca+kmTSH9Ap9o=
X-Received: by 2002:a17:902:e811:b0:2b0:4fd1:ed69 with SMTP id
 d9443c01a7336-2b08277b140mr65282905ad.24.1774113546133; 
 Sat, 21 Mar 2026 10:19:06 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836b8b95sm57328355ad.83.2026.03.21.10.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:19:05 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:18:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v19 02/13] net/sxe: add ethdev probe and remove
Message-ID: <20260321101859.60b9eefc@phoenix.local>
In-Reply-To: <20260314085205.2419952-3-liujie5@linkdatatechnology.com>
References: <20260303091057.2952214-14-liujie5@linkdatatechnology.com>
 <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
 <20260314085205.2419952-3-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 14 Mar 2026 16:51:54 +0800
liujie5@linkdatatechnology.com wrote:

> diff --git a/drivers/net/sxe/base/sxe_common.c b/drivers/net/sxe/base/sxe_common.c
> new file mode 100644
> index 0000000000..8f3e80fae3
> --- /dev/null
> +++ b/drivers/net/sxe/base/sxe_common.c
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (C), 2022, Linkdata Technology Co., Ltd.
> + */
> +
> +#include <pthread.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <rte_common.h>
> +#include <rte_cycles.h>
> +#include <time.h>
> +#include "sxe_types.h"
> +#include "sxe_common.h"
> +
> +#define SXE_SEC_TO_MS(sec) ((sec) * 1000ULL)
> +
> +#define SXE_NSEC_PER_MS		  1000000
> +
> +RTE_ATOMIC(uint64_t) sxe_trace_id;

Could this be static.

> +
> +u64 sxe_time_get_real_ms(void)
> +{
> +	u64 ms = 0;
> +	struct timespec ts;
> +	s32 ret = clock_gettime(CLOCK_MONOTONIC, &ts);

If you are only looking at ms then you might be able to CLOCK_MONOTONIC_COARSE

> +	if (ret < 0)
> +		goto l_end;

Could be simpler as:

	if (unlikely(clockgettime(CLOCK_MONOTONIC, &ts) < 0))
		return 0;

> +
> +	ms = SXE_SEC_TO_MS(ts.tv_sec) + ts.tv_nsec / SXE_NSEC_PER_MS;
> +
> +l_end:
> +	return ms;
> +}
> +
> +void sxe_trace_id_gen(void)
> +{
> +	sxe_trace_id = 0;
> +	return;
> +}

Return statement is unnecessary here


> +u64 sxe_trace_id_get(void)
> +{
> +	return rte_atomic_fetch_add_explicit((uint64_t __rte_atomic *)&sxe_trace_id,
> +			1, rte_memory_order_relaxed);
> +}

The cast should not be necessary.
