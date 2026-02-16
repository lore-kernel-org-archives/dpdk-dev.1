Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E0E81A28
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 14:04:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A9340289;
	Mon, 16 Feb 2026 15:04:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43C5240269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771250676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hLEvBXrsdC0zD4andCOozc0Xl8dGf5eRhSteAPN7V6U=;
 b=DxK2G4Bl9RccGP8MHsgQnVKqq/9Q6cnHPpTOxVRwPJNKSgpKrniHs1f2lUXhgtlcHM6t1s
 6W+d2jizJqk5bTxV1oFf4hthd/ntwHekDQFeO/m/pAdwGwF+I3EM5ICRFA/kHiSlYEfVMr
 YUfVIxBW1B4sv7IYCzXRZw2+PFckdos=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-NyOfL8lJMbaxImg7mEJgtA-1; Mon, 16 Feb 2026 09:04:35 -0500
X-MC-Unique: NyOfL8lJMbaxImg7mEJgtA-1
X-Mimecast-MFC-AGG-ID: NyOfL8lJMbaxImg7mEJgtA_1771250674
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38705f31ff9so15335531fa.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 06:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771250674; x=1771855474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLEvBXrsdC0zD4andCOozc0Xl8dGf5eRhSteAPN7V6U=;
 b=K2WFSI/VmTTIMK+i8qUbeh3gTrP04eedCMwY80FBRxQMTRHjjah5T9Tn2VHwqiwSOY
 Z5v1M7aRS5244tUb17cM2I8bViKjUQH4KhIhZb5chs32NQyR8Kr3n+YS4VaBNIz/qMxW
 /MzfM89vmGt5OQWCH9cq+NRK0ZiNTRksuLxXX4Rqlx7nbMpatYNx83zviAW6lfsz8nSr
 tFM5MUwm9UiJ5p9NVgykTIrovmUIsp04185z7b1z580ueE6v/WmlFBFrBdMHFLTArki+
 GHshKt/wmyMYbApd7zi1SOE4t5401S8jt3nlSPW4xDOHp8QGoSAA8Swx9BBf3A3YgatH
 WvaQ==
X-Gm-Message-State: AOJu0YywNnLJ0IrVo4glHKGfHlFHclPtQQCJt8UTZ1J2zqz4YJdFeKIn
 ipnQxuka0LtcGPzy/AdquNvRdI0EFoV3Oiqs9YdTfIFj2p5wTsubCOeD3VlUaEwPx8hTf0URB3K
 wf7sVnGveK3hJCcn2uwvDqpLzRuCh499+36kJKj/03H6odLa0LdZ55HJ31JKOF8jaRfJlQGfLKf
 IPUjoO1tvU9VCINntEhjYUtXZwxCI=
X-Gm-Gg: AZuq6aLWgMW6YvY/nAcrICfmPbeqeKRFe8relMAxlXaG1+9T9yrtphgBEveKOpK/AFY
 dRsstTznAk3g7Vx+4HBJg3GJ8oOpsySEPA78GwUa4RB03KwS4NgSSh9wCuAgwJZ1VJNbuDeeLDg
 oC4C1Ge4f4X6SBzncC6UJUDbuAJ4ful84Pxscj5EcvCbzk88qULDmjGLfdQwyjaipYoIDkkN+MD
 cmClk4HI2Y/r88LLUwq31I4Nmx0bcYFudeQtsAmELdifkcKtrqam/wS7htffNQi0freWw==
X-Received: by 2002:a05:6512:3f1b:b0:59e:657f:438c with SMTP id
 2adb3069b0e04-59f69c84241mr2615470e87.40.1771250673605; 
 Mon, 16 Feb 2026 06:04:33 -0800 (PST)
X-Received: by 2002:a05:6512:3f1b:b0:59e:657f:438c with SMTP id
 2adb3069b0e04-59f69c84241mr2615461e87.40.1771250673078; Mon, 16 Feb 2026
 06:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-1-scott.k.mitch1@gmail.com>
 <CAJFAV8yokz8AG5ZVLBvDSNszY05+81pRWqfWu9FmCgLOvBcZ_A@mail.gmail.com>
 <CAFn2buB6yCTZGFOfE-erpU92SRfgGqcvpFrivOLNva3g-pq5Lg@mail.gmail.com>
In-Reply-To: <CAFn2buB6yCTZGFOfE-erpU92SRfgGqcvpFrivOLNva3g-pq5Lg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 15:04:20 +0100
X-Gm-Features: AaiRm51h9garjE72_KWQM1PEdUn45Ga4hYwb0QtFCq6nyeLwQs1ABb_DLNsNWo8
Message-ID: <CAJFAV8zboa07XAewkhTzEwnFj8Co62tgJk8=cbv3YVW0hAP+Aw@mail.gmail.com>
Subject: Re: [PATCH v19 0/2] net: optimize __rte_raw_cksum
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 02GFmGDztNkbO_fnQkq2DKr2iS-epAw8rwTioiMJ26k_1771250674
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

On Sat, 7 Feb 2026 at 02:29, Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
>
> Thanks for testing! I included my build/host config, results on the
> main branch, and then with this path applied below. What is your build
> flags/configuration (e, cpu_instruction_set, march, optimization
> level, etc.)? I wasn't able to get any Clang version (18, 19, 20) to
> vectorize on Godbolt https://godbolt.org/z/8149r7sq8, and curious if
> your config enables vectorization.
>
> #### build / host config
>   User defined options
>     b_lto              : false
>     buildtype          : release
>     c_args             : -fno-omit-frame-pointer
> -DPACKET_QDISC_BYPASS=1 -DRTE_MEMCPY_AVX512=1
>     cpu_instruction_set: cascadelake
>     default_library    : static
>     max_lcores         : 128
>     optimization       : 3
> $ clang --version
> clang version 18.1.8 (Red Hat, Inc. 18.1.8-3.el9)
> $ cat /etc/redhat-release
> Red Hat Enterprise Linux release 9.4 (Plow)
>
> #### main branch
> $ echo "cksum_perf_autotest" | /usr/local/bin/dpdk-test
> ### rte_raw_cksum() performance ###
> Alignment  Block size    TSC cycles/block  TSC cycles/byte
> Aligned           20                10.0             0.50
> Unaligned         20                10.1             0.50
> Aligned           21                11.1             0.53
> Unaligned         21                11.6             0.55
> Aligned          100                39.4             0.39
> Unaligned        100                67.3             0.67
> Aligned          101                43.3             0.43
> Unaligned        101                41.5             0.41
> Aligned         1500               728.2             0.49
> Unaligned       1500               805.8             0.54
> Aligned         1501               768.8             0.51
> Unaligned       1501               787.3             0.52
> Test OK
>
> #### with this patch
> $ echo "cksum_perf_autotest" | /usr/local/bin/dpdk-test
> ### rte_raw_cksum() performance ###
> Alignment  Block size    TSC cycles/block  TSC cycles/byte
> Aligned           20                12.6             0.63
> Unaligned         20                12.3             0.62
> Aligned           21                13.6             0.65
> Unaligned         21                13.6             0.65
> Aligned          100                22.7             0.23
> Unaligned        100                22.6             0.23
> Aligned          101                47.4             0.47
> Unaligned        101                23.9             0.24
> Aligned         1500                73.9             0.05
> Unaligned       1500                73.9             0.05
> Aligned         1501                95.7             0.06
> Unaligned       1501                73.9             0.05
> Aligned         9000               459.8             0.05
> Unaligned       9000               523.5             0.06
> Aligned         9001               536.7             0.06
> Unaligned       9001               507.5             0.06
> Aligned        65536              3158.4             0.05
> Unaligned      65536              3506.1             0.05
> Aligned        65537              3277.6             0.05
> Unaligned      65537              3697.6             0.06
> Test OK

I redid my bench from scratch and I do see an improvement for clang.
-Aligned         1500               905.3             0.60
-Unaligned       1500               924.9             0.62
-Aligned         1501               907.6             0.60
-Unaligned       1501               932.1             0.62
-Aligned         9000              5252.1             0.58
-Unaligned       9000              5433.0             0.60
-Aligned         9001              5260.9             0.58
-Unaligned       9001              5440.4             0.60
-Aligned        65536             38395.2             0.59
-Unaligned      65536             39639.5             0.60
-Aligned        65537             38030.3             0.58
-Unaligned      65537             39292.7             0.60

+Aligned         1500               104.0             0.07
+Unaligned       1500               106.5             0.07
+Aligned         1501               104.1             0.07
+Unaligned       1501               107.0             0.07
+Aligned         9000               596.7             0.07
+Unaligned       9000               655.1             0.07
+Aligned         9001               597.6             0.07
+Unaligned       9001               657.2             0.07
+Aligned        65536              4139.3             0.06
+Unaligned      65536              4583.2             0.07
+Aligned        65537              4139.9             0.06
+Unaligned      65537              4585.9             0.07

Something was most likely wrong in my test (and seeing how the gcc and
clang numbers looked so close... I may have been using the gcc
binary...).
This is noticeable with clang, and no special cpu_instruction_set or
any kind of compiler optimisation level set.

I'll finish my checks and merge this nice improvement for rc1.


-- 
David Marchand

