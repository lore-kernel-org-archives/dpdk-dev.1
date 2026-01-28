Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92040D3569F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:05:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC26640274;
	Wed, 28 Jan 2026 12:05:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 245D8400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769598327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TrkOsUzqGEIpqm4sm3KFqhi4sgS+2keOmvc4vPS0l8I=;
 b=ELFQHf0yOjaaU5RXCbgNEYw++6JQeWczmPjXbIXFj9sKCDuCeeP/PyfnWCLU1KUZH90eWb
 KjVumCd8azc/CuyeobDOffg/YloVwE8CxkbtYwybQW1VO1FHoG5RaKVOmmN83s4jszKJ06
 PGkFIRSGEFFtPaIBfKfSG4fWU6dtCp4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-Wp7UtQC8Ny-IWhEqi9ZTng-1; Wed, 28 Jan 2026 06:05:26 -0500
X-MC-Unique: Wp7UtQC8Ny-IWhEqi9ZTng-1
X-Mimecast-MFC-AGG-ID: Wp7UtQC8Ny-IWhEqi9ZTng_1769598325
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59e0b27079cso137331e87.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 03:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769598325; x=1770203125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrkOsUzqGEIpqm4sm3KFqhi4sgS+2keOmvc4vPS0l8I=;
 b=eSdbrAxtw5xwakcEr7JFiVtrDn2P5YptTM0vhGPzpJTIqNE8OrmzCadIH6f8i3Sl9Z
 uaLRB1YoPBazzcaT1OLm7sb1kqBawMsziY+qMsFS1HmnwGMeqQnPOFikRpM37OtOtI69
 1b+VRMD209iOJ7bcYOfKRaIhrqYyNjoBWrlcICd1SeNpJ0AKvaLopsG5PH4PLRaqMkxx
 EwgIACd3juVEDTwk82ImJDstVUFJVknGQ3hoEWMbrVWiIO/9bZE9FGWrCpcqfwIdNCX6
 BLfNJf3slJuzZa8OQ0BrUcp8M7YsjsTXosJlNH41fvAJ3Y8dmNBSQZm5xE/EK3vzp+fT
 WNzA==
X-Gm-Message-State: AOJu0YxNUrL7X8f22ehUhWVNQ8W4SrWQEOKTRXExKCuzkapjbKIjBuo0
 ZAqyMpy4gEW5feKKfTM7DzLIUWtRCQpt54bMFgjZE/Hv53lokmshSE/+q0gY1Tklz4M6hiRGTKL
 gkQLMwu6NJhtUxODEP4yicc76scd3kH1XWxyq2pcRmJMixSdYsIqBaJ0qrULByvAwQdBpwrpLm+
 dbd6X91mUELA6du3oj9lw=
X-Gm-Gg: AZuq6aLfcMyEYmGfIpslVOhjBVJjvWaiXH54V9wXggCFEalRX6PRPcCD32kElQQoEEF
 CknEPKc4ZClVQySLAaq40iX8ZX5BZ98a+M7IKrUEAPx+wr7h/Kk4GMekPHiMQV9tgPvIDfd9Ob7
 2n9RLMd30qKLywfcqgQaRx1M8baRdvVnY0qBT4yqsyXk7wtInFtei+GO/1+6aOmh2kMDTMzTTuK
 EvPnnmAdIwgjYwZYgD2AYZUZ8MSHAOaueJjJISdkkz7EqGK0ccsanVs7w==
X-Received: by 2002:a05:6512:b97:b0:59b:9ff8:468e with SMTP id
 2adb3069b0e04-59e0412c83amr2540268e87.31.1769598324801; 
 Wed, 28 Jan 2026 03:05:24 -0800 (PST)
X-Received: by 2002:a05:6512:b97:b0:59b:9ff8:468e with SMTP id
 2adb3069b0e04-59e0412c83amr2540252e87.31.1769598324095; Wed, 28 Jan 2026
 03:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-3-scott.k.mitch1@gmail.com>
In-Reply-To: <20260123160244.57335-3-scott.k.mitch1@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 28 Jan 2026 12:05:12 +0100
X-Gm-Features: AZwV_QgOi2ipzn2Y9bwalgTcbEtDaYyz35ynLUmTZbqIX-XvmutqwENfMjKrEQM
Message-ID: <CAJFAV8wOwtsANF_z3EXp1ZeeMNw=jDvrBu_3xJ5kDZcB1j9E_g@mail.gmail.com>
Subject: Re: [PATCH v16 2/2] net: __rte_raw_cksum pointers enable compiler
 optimizations
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6FGsvmi-IxHAkaHE_LlEzYSpU0odieiOj6dOCcTW3lw_1769598325
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Scott,

On Fri, 23 Jan 2026 at 17:03, <scott.k.mitch1@gmail.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> __rte_raw_cksum uses a loop with memcpy on each iteration.
> GCC 15+ is able to vectorize the loop but Clang 18.1 is not.
>
> Replace memcpy with direct pointer access using unaligned_uint16_t.
> This enables both GCC and Clang to vectorize the loop while handling
> unaligned access safely on all architectures.
>
> Performance results from cksum_perf_autotest on Intel Xeon
> (Cascade Lake, AVX-512) built with Clang 18.1 (TSC cycles/byte):
>
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

Unfortunately, clang 14 (Ubuntu 22.04) is complaining about unaligned
access in the new test.
Could you have a look?

RTE>>cksum_fuzz_autotest
../lib/net/rte_cksum.h:49:10: runtime error: load of misaligned
address 0x0001816c2e81 for type 'const unaligned_uint16_t' (aka 'const
unsigned short'), which requires 2 byte alignment
0x0001816c2e81: note: pointer points here
 00 00 00  00 70 f2 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00  00 00 00 00 00
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../lib/net/rte_cksum.h:49:10 in

The whole backtrace is as follows:

RTE>>cksum_fuzz_autotest
../lib/net/rte_cksum.h:49:10: runtime error: load of misaligned
address 0x0001816c2e81 for type 'const unaligned_uint16_t' (aka 'const
unsigned short'), which requires 2 byte alignment
0x0001816c2e81: note: pointer points here
 00 00 00  00 0e ce 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00  00 00 00 00 00
              ^
    #0 0x55a725ec25e7 in __rte_raw_cksum test_cksum_fuzz.c
    #1 0x55a725ec21ce in test_cksum_fuzz_length_aligned test_cksum_fuzz.c
    #2 0x55a725ec1f65 in test_cksum_fuzz_length test_cksum_fuzz.c
    #3 0x55a725ec1c8f in test_cksum_fuzz_edge_cases test_cksum_fuzz.c
    #4 0x55a725ec1ab2 in test_cksum_fuzz test_cksum_fuzz.c
    #5 0x55a725ceece9 in cmd_autotest_parsed commands.c
    #6 0x7fdb96d7e668 in __cmdline_parse cmdline_parse.c
    #7 0x7fdb96d7dcb1 in cmdline_parse
(/home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26+0x1bcb1)
(BuildId: bcf9387da4939ba68c89cec1938166c878fca318)
    #8 0x7fdb96d74b69 in cmdline_valid_buffer cmdline.c
    #9 0x7fdb96d8b9c3 in rdline_char_in
(/home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26+0x299c3)
(BuildId: bcf9387da4939ba68c89cec1938166c878fca318)
    #10 0x7fdb96d752d3 in cmdline_in
(/home/runner/work/dpdk/dpdk/build/app/../lib/librte_cmdline.so.26+0x132d3)
(BuildId: bcf9387da4939ba68c89cec1938166c878fca318)
    #11 0x55a725cf0f0b in main
(/home/runner/work/dpdk/dpdk/build/app/dpdk-test+0x4ddf0b) (BuildId:
5905b821f00329f9c5b95c7064ea051d7aacac48)
    #12 0x7fdb94629d8f in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #13 0x7fdb94629e3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #14 0x55a725cc5ed4 in _start
(/home/runner/work/dpdk/dpdk/build/app/dpdk-test+0x4b2ed4) (BuildId:
5905b821f00329f9c5b95c7064ea051d7aacac48)

[snip]

> diff --git a/app/test/test_cksum_fuzz.c b/app/test/test_cksum_fuzz.c
> new file mode 100644
> index 0000000000..3df11e3dc2
> --- /dev/null
> +++ b/app/test/test_cksum_fuzz.c
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Apple Inc.
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <rte_common.h>
> +#include <rte_cycles.h>
> +#include <rte_hexdump.h>
> +#include <rte_cksum.h>
> +#include <rte_malloc.h>
> +#include <rte_random.h>
> +
> +#include "test.h"
> +
> +/*
> + * Fuzz test for __rte_raw_cksum optimization.
> + * Compares the optimized implementation against the original reference
> + * implementation across random data of various lengths.
> + */
> +
> +#define DEFAULT_ITERATIONS 1000
> +#define MAX_TEST_LEN 65536  /* 64K to match GRO frame sizes */
> +
> +/*
> + * Original (reference) implementation of __rte_raw_cksum from DPDK v23.11.
> + * This is retained here for comparison testing against the optimized version.
> + */
> +static inline uint32_t
> +__rte_raw_cksum_reference(const void *buf, size_t len, uint32_t sum)
> +{

Just a nit, I prefer we don't declare test functions with the same
prefix as a public dpdk API.
It is confusing when reading the test code.


-- 
David Marchand

