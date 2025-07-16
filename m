Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD62AC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D4A4013F;
	Wed, 16 Jul 2025 22:35:34 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 81C08400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:35:32 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e34399cdb2so22728785a.3
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752698132;
 x=1753302932; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yr5qU3xloacAwIIVsKbo/vIxLnE+uStf0xnN3n8v7Jk=;
 b=IjVu+wzjeuHrAfWO+EM3HY/HL8kc5zMhdOD0bv0Da8FsXmo8Lo48p7kgPEeWfFrPjI
 f1zyXLE55DEqOTJUQohLZdVZY4c5FJh0cQE2gchn2k4nHwSQ+Fsq4gS9bR7ya7w8ZpuR
 uUkwCMDuE7pHnoXbsB1UiuQN4z+5KtOclpKd+rj4Gt0eP/kWc08fCKgXhOmxqm/Kx1XY
 1VBGME8nYTj41g3GQnvf09p6DjM61gX53iAD0zh4DFBQ3pK6A1S0RvSIK5y8n1NpdeCy
 zUCwhUyJKQhW7ZJtVG5gy+/dxxMAwv++Ton9FKk1F90gyNPT0e4hK3MpdOqFLSL1x1KP
 /qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752698132; x=1753302932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yr5qU3xloacAwIIVsKbo/vIxLnE+uStf0xnN3n8v7Jk=;
 b=dpdzyuUzZtqutwGHPEdG4JXu+lZ3N19nL4K7vG6EonCyQ+bOEbR8h/tNl1fsVYGTOK
 4ZMNvkrlybzMGhPKX30HtmeIwyLoVt/QB6Adyqgwnmvs5D+tmxN6+RrMzP1GCvOM3iHU
 oxVVW8fLbTnD0BMdS1I6YYOF7u9g+n+zi55IassuhkwftcXLEPM/lkq8YYbJ2VVLpZ/B
 1qiv35ftsh9Ed2lveMYikbo4AZMh3Bpw5ZZ/LsvyZJYmrv0Qm32gphtWje2kUTWFzOf7
 wpGCAAfJHiW9IsdphImPCxWF79R/3mLPZb/rV5owr9d0KrlCFcLTXUuzcS7tgtzSEOI9
 LFgw==
X-Gm-Message-State: AOJu0YyDbcEmEoaRsR1XG1WCnax37teVAZrSfdJ+qDuyvMihi5I0CQEn
 o69ZDVL+OKCI9EWWyZyMnlVar28fcwHeyCDncmiNZIhIw8cgI+f9h2MYQKIZBHurO3EpLz5tpGS
 ttsqJ
X-Gm-Gg: ASbGncss2hgJewg5GPlepZHKGxvUfGBBVkL2lrqk7sGxCOX/4slTkFyibXKomt7873I
 Fr4mvibPAk+ZxkjRkJmHSsdEAItldqzatZx0W55ZnKXmFMC7WjZ94sn/0FfMvjGa3rtFrd+s9gL
 zA/Za6GwWh/g/cEgIFj7AThU5SgT9qTYIOXl7cALVVOsupd4NZI9zeFmThAMsMcGxkfXn0GkJ+H
 XLOK6zucLiiEdsp/qrVgXXUfWm1VKecmCITUPCvLcAbCirkgriB7qahRcxAVdIQZWPyE6QJejUQ
 /+X8WWEPM4JSgTG3mmPrIDwuP6AlzgRw4fsOkSn584sVoZletnAanG1yAJSwBXcjA4ODDJJR1FB
 duRpvY2Jh0MyEoIJaL/H5v22amZ8iuuFiSNukMq5L+9vl8glyNXqEj4TM/SEanjOMP/ReYbOcSo
 OoFdck/PUKbQ==
X-Google-Smtp-Source: AGHT+IEUIDuh5t+5WoRTFQRnCwOZg1ud9PW56fDvBTl7YpSPxK1ierCBrZwImhOVKmJsDXFKhlBn6g==
X-Received: by 2002:a05:620a:4620:b0:7e3:2c6a:9bdd with SMTP id
 af79cd13be357-7e342b69bbemr630489885a.41.1752698131337; 
 Wed, 16 Jul 2025 13:35:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e01602a6d6sm609534085a.74.2025.07.16.13.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:35:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:35:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250716133527.35bf3053@hermes.local>
In-Reply-To: <20250716082930.83026-2-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-2-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:18 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> --- /dev/null
> +++ b/drivers/net/sxe/base/sxe_common.c
> @@ -0,0 +1,66 @@
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
> +#define SXE_TRACE_ID_COUNT_MASK  0x00000000000000FFLLU
> +#define SXE_TRACE_ID_TID_MASK	0x0000000000FFFF00LLU
> +#define SXE_TRACE_ID_TIME_MASK   0x00FFFFFFFF000000LLU
> +#define SXE_TRACE_ID_FLAG		0xFF00000000000000LLU
> +
> +#define SXE_TRACE_ID_COUNT_SHIFT 0
> +#define SXE_TRACE_ID_TID_SHIFT   8
> +#define SXE_TRACE_ID_TIME_SHIFT  24
> +
> +#define SXE_SEC_TO_MS(sec) ((sec) * 1000ULL)
> +#define SXE_SEC_TO_NS(sec) ((sec) * 1000000000ULL)
> +
> +#define SXE_USEC_PER_MS		  1000000
> +
> +u64 sxe_trace_id;
> +
> +u64 sxe_time_get_real_ms(void)
> +{
> +	u64 ms = 0;
> +	struct timespec ts;
> +	s32 ret = clock_gettime(CLOCK_MONOTONIC, &ts);
> +	if (ret < 0)
> +		goto l_end;
> +
> +	ms = SXE_SEC_TO_MS(ts.tv_sec) + ts.tv_nsec / SXE_USEC_PER_MS;
> +
> +l_end:
> +	return ms;
> +}
> +
> +u64 sxe_trace_id_gen(void)
> +{
> +	u64 tid	   = getpid() + (pthread_self() << 20);
> +	u64 index	 = 0;
> +	u64 timestamp = sxe_time_get_real_ms();
> +
> +	sxe_trace_id = (SXE_TRACE_ID_FLAG)
> +		| ((timestamp << SXE_TRACE_ID_TIME_SHIFT) & SXE_TRACE_ID_TIME_MASK)
> +		| ((tid << SXE_TRACE_ID_TID_SHIFT) & SXE_TRACE_ID_TID_MASK)
> +		| ((index << SXE_TRACE_ID_COUNT_SHIFT) & SXE_TRACE_ID_COUNT_MASK);
> +	return sxe_trace_id;
> +}
> +
> +void sxe_trace_id_clean(void)
> +{
> +	sxe_trace_id = 0;
> +}
> +
> +u64 sxe_trace_id_get(void)
> +{
> +	return sxe_trace_id++;
> +}

Inventing your own tracing mechanism is not a good idea.
In general, we want all DPDK drivers to behave the same and be debuggable in the same way.
There already is rte_trace and rte_log functions, what does all this add?

