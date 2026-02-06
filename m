Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C8EE20A6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:54:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6EA340276;
	Fri,  6 Feb 2026 15:54:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2198740156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 15:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770389670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RR5ZOqEAhMVe73Y0NrB6WXJRXTNR+xQUy35mxUUmz6c=;
 b=gnFOxgweiRlrJ8iAC8PYYXrYUNi8SF38WFdgNiupqEMX/VDcrOy7mLfNWXTlIQUiPc43D/
 eMpjbswHuUCE8a5BUO1S3QaWK0b4TrHRlgF13ekobqZ/LXvFG+KfdSlJvWCu1uB1xiNqHy
 GgKa/Sf9kXzCQSk6DkmLVW3qYq8e1K4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-oNWWKLciOze7WS-ppQKO5w-1; Fri, 06 Feb 2026 09:54:25 -0500
X-MC-Unique: oNWWKLciOze7WS-ppQKO5w-1
X-Mimecast-MFC-AGG-ID: oNWWKLciOze7WS-ppQKO5w_1770389664
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-382fcf9cb7dso5325391fa.3
 for <dev@dpdk.org>; Fri, 06 Feb 2026 06:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770389663; x=1770994463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RR5ZOqEAhMVe73Y0NrB6WXJRXTNR+xQUy35mxUUmz6c=;
 b=h3Y+mu5kxhBcnNrwG5GmDoPBcQZPxRZ70BaoYwpD9RD0eDMFYUPQSzD9up8qoo+SkA
 7yNjeQtCbaPxAR9rUN4+YPLCCd258ceqP9k63XpDP04rLInuO/U8uQYxulsF7yiEgGrW
 IdFRKwthWpq1bPsVg/mKfPZDPuQdQzJmHvdmUTxRSOitce2aB6i6CmNJpSmsoRyne240
 5SK+M+AE4zkJRNtfoALJOC0mTZV9g712GZT82KfhIgroECO/NQPD1lE3CQSQGeUJVgxg
 0gOFglnzoGHB5nFg4frHZK+izYcjl1JC38Om4lfTA6AWPZfAS4vb4I9tT6cR72t7LRNA
 36kQ==
X-Gm-Message-State: AOJu0YwmHNON8yF/9qCMYs+rHB0j2dxpsYywFFN05x5AeHvbHIkufpLK
 7vpsqBND/SNIDhO6amfw3p7o8Y4j9kF9zzb3nDUbuoG8Pdd5fGxbhezFYYdEE0qa0jRpGs60kX7
 9IUZ7iLqxtji7USWnbycuMpdCVGvYA96jjn9+LY33wV7pCjFipF1lzaPpqCbBUAL8Yn7Zf0y5Xe
 z3JphltsUmyx6se8cyWDg=
X-Gm-Gg: AZuq6aKi7SQvUdKp0CXkFaHTzyAz3NCgVpnnJ2Ftf5rGx1WyHA0kaJjIA2kIgFDTVNC
 bI+NHgPY58u6c4h5bDGSQuY4uJbjtjtC2xh6yT9y2ktmjS7ob5UOK08/Y2bAoj3030xVWeox+CN
 kjPNUaxgDO0js+ADX+Voz0rWRcudoW5SicK1wklI4r9jacEXUg4+p8IDviRpp1eE0utVy0jKfWd
 L2jtDdilGvdCtQ+W7Fju8RqNh2fPk54S2ii5Kg/76QTFzySdoPjw+DWug==
X-Received: by 2002:a05:6512:1554:20b0:59e:465d:e346 with SMTP id
 2adb3069b0e04-59e465de574mr487814e87.20.1770389663371; 
 Fri, 06 Feb 2026 06:54:23 -0800 (PST)
X-Received: by 2002:a05:6512:1554:20b0:59e:465d:e346 with SMTP id
 2adb3069b0e04-59e465de574mr487800e87.20.1770389662909; Fri, 06 Feb 2026
 06:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260202044841.90945-1-scott.k.mitch1@gmail.com>
In-Reply-To: <20260202044841.90945-1-scott.k.mitch1@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Feb 2026 15:54:10 +0100
X-Gm-Features: AZwV_QjCHpvIQMAQv3XasffpMwQq3F-RPkKpM3mJl8EKCx_soQUF4mhB_OjrLK8
Message-ID: <CAJFAV8yokz8AG5ZVLBvDSNszY05+81pRWqfWu9FmCgLOvBcZ_A@mail.gmail.com>
Subject: Re: [PATCH v19 0/2] net: optimize __rte_raw_cksum
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o6b618eFZ9pTZA5oSrs30weEZ-oX0ZNoXglkUr-w2Og_1770389664
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

Hi Scott,

On Mon, 2 Feb 2026 at 05:48, <scott.k.mitch1@gmail.com> wrote:
>
> From: Scott <scott.k.mitch1@gmail.com>
>
> This series optimizes __rte_raw_cksum by replacing memcpy with direct
> pointer access, enabling compiler vectorization on both GCC and Clang.
>
> Patch 1 adds __rte_may_alias and __rte_aligned(1) to unaligned typedefs
> to prevent a GCC strict-aliasing bug where struct initialization is
> incorrectly elided, and avoid UB by clarifying access can be from any
> address.
>
> Patch 2 uses the improved unaligned_uint16_t type in __rte_raw_cksum
> to enable compiler optimizations while maintaining correctness across
> all architectures (including strict-alignment platforms).
>
> Performance results show significant improvements (40% for small buffers,
> up to 8x for larger buffers) on Intel Xeon with Clang 18.1.
>
> Changes in v19:
> - Move qualifiers before typedef on all platforms
> - test_hash_functions explicit 32 bit variable use
>
> Changes in v18:
> - Fix MSVC compile error __rte_aligned(1) must come before type
> - Fix test_hash_functions incorrect usage of unaligned_uint32_t
>
> Changes in v17:
> - Use __rte_aligned(1) unconditionally on unaligned type aliases
> - test_cksum_fuzz uses unit_test_suite_runner
> - test_cksum_fuzz reference method rename to
> test_cksum_fuzz_cksum_reference
>
> Changes in v16:
> - Add Fixes tag and Cc stable/author for backporting (patch 1)
>
> Changes in v15:
> - Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST
>
> Changes in v14:
> - Split into two patches: EAL typedef fix and checksum optimization
> - Use unaligned_uint16_t directly instead of wrapper struct
> - Added __rte_may_alias to unaligned typedefs to prevent GCC bug
>
> Scott Mitchell (2):
>   eal: add __rte_may_alias and __rte_aligned to unaligned typedefs
>   net: __rte_raw_cksum pointers enable compiler optimizations
>
>  app/test/meson.build           |   1 +
>  app/test/test_cksum_fuzz.c     | 234 +++++++++++++++++++++++++++++++++
>  app/test/test_cksum_perf.c     |   2 +-
>  app/test/test_hash_functions.c |   6 +-
>  lib/eal/include/rte_common.h   |  49 ++++---
>  lib/net/rte_cksum.h            |  14 +-
>  6 files changed, 279 insertions(+), 27 deletions(-)
>  create mode 100644 app/test/test_cksum_fuzz.c

I have been trying to reproduce the numbers with one (venerable)
Skylake processor but I see no difference before/after the series.
Numbers are in the same range with gcc (11) and clang (20) on this
RHEL 9 system.

RTE>>cksum_perf_autotest
### rte_raw_cksum() performance ###
Alignment  Block size    TSC cycles/block  TSC cycles/byte
Aligned           20                13.0             0.65
Unaligned         20                13.0             0.65
Aligned           21                14.0             0.67
Unaligned         21                14.0             0.67
Aligned          100                19.1             0.19
Unaligned        100                19.4             0.19
Aligned          101                20.1             0.20
Unaligned        101                22.1             0.22
Aligned         1500               132.5             0.09
Unaligned       1500               134.9             0.09
Aligned         1501               133.1             0.09
Unaligned       1501               146.3             0.10
Aligned         9000               766.7             0.09
Unaligned       9000               802.2             0.09
Aligned         9001               767.6             0.09
Unaligned       9001               800.3             0.09
Aligned        65536              5404.8             0.08
Unaligned      65536              5596.3             0.09
Aligned        65537              5406.8             0.08
Unaligned      65537              5604.5             0.09


Is the improvement only affecting clang18?
Other things I should check?


-- 
David Marchand

