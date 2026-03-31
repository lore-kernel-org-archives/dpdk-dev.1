Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C810F92E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 17:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CB4A40A6D;
	Tue, 31 Mar 2026 19:50:15 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 18CDF406FF
 for <dev@dpdk.org>; Tue, 31 Mar 2026 19:50:13 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1271257ae53so6048907c88.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774979413;
 x=1775584213; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6+zNjL96aHUhWu2FHhPx/q8/Ote2FYvxUwA4TWAWk4=;
 b=nKbMkhvArnefZ29QkF5h+8x3v/4IIQwCiEnSRTuCH1VUmGol30YHTTRFQsvKZdr1YB
 mLL875Y2tWlqsPrGkkJkXTN/SNBvyM6uKLRiTll1z5kxxrJu/WpSykNJyDCkHVTpItsk
 kPr5JCKdzH9pouZWUPN3xKKAD+EYm3TYq2vf4n7ke6kpvdS/0t7zmbyVqu19FAfpnrVi
 yoepKQgjQ7B2itpTt3w6CWoshncpahIQfrsHegAcnIC1WaY1HvMuv8aEkIzGDF7uYwXH
 /VijKpSacL/HbHQvYraYPddfHCvi0OSW1aosxuuZrNFehQlHLgj9vujmbYwdbIxyP7N6
 PGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774979413; x=1775584213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6+zNjL96aHUhWu2FHhPx/q8/Ote2FYvxUwA4TWAWk4=;
 b=TZm60j7Ha/Hw67X1B49HgQ1PIP34ztLRayi/BQrPH+D+Fi2XuMPSyVkjar5UJ/bi2n
 mT/rEa8hBoPgARtGpnqB3JTkeMCRigWD+wGhxcbguqVNv0CF9viOomp+/z873i12JtF4
 oEBoLirQXXQq9Yp3Bdx+KAQzxTKIPKd/PRD5fQ09e+daEoLY70+G8bEmd0xyGXNY2GP5
 fr1hnhtsNZ5BTkrL5Z3wVtve7RB5EUrbg7wwGeVFowELhaDEXLPnwA1rAMEil4S9Jy6W
 H0YZ8ffYoTIpCKW3FeAR90HCwMoRb0Q/yY054SpdrUNC3l0kcaGouSYLglY1HcO2ayAm
 hFUg==
X-Gm-Message-State: AOJu0YxiqKNWsT9XhhV42Fi1zYBFyuelFsG7ni+5oD9h2wSBzOJhO1KR
 pUvN1jvHEsAUwPE1FqqRzKV8NJh+xdD3PDUp1sx8ef1mzz4gIytFrtR5cbL7Zy2me5Y=
X-Gm-Gg: ATEYQzwKFMuZ+ov/X8gRSz1DaPW5aZVW56ZGhLBoVFFgDAIrFv8JsWtu0ry7XDnsMST
 Dm8eAmRkxd0iow8/4kKsR5OGkWPbi0iLUQLP4bt8nqASA12SmfoXUkFF00yV+2ovk8PkZMqFdZw
 aKWkMAlJHWluT2J9rKZpe3aSQEoBfeIJjFGXvCJiZSOIzOfugkhqJD/t3kyavdp+vjhTcxD8Y2h
 L8hbwcTgA+0Y7ulBGcyXsBzROblCZZol+0Y/RUuBFpdlCLBZrQ8Q5f90RIF2EAC7MR2Yey9mYt7
 0it2ZInMjHaQFkleWrF9/1jiMTRNsnWz3SKQNyvTawk11cSqrqKUflnYl33hdJj8HVSiqGVF8q5
 wfGAHb57PkkV7yDChCkMTVYDHGo80OKxzdKKnDq0PkbmvnrEFXuwvQfxNVsZdjdHRHXzV3s0cau
 NCfJkO6ujmxRpdl8r/x+53xfGXMojXDC3Z6ms=
X-Received: by 2002:a05:7022:2508:b0:12a:7181:2eff with SMTP id
 a92af1059eb24-12be645defbmr246608c88.4.1774979412407; 
 Tue, 31 Mar 2026 10:50:12 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12abbe21787sm10724676c88.11.2026.03.31.10.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:50:12 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:50:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [RFC 1/1] build: support ThreadSanitizer
Message-ID: <20260331105009.221272db@phoenix.local>
In-Reply-To: <20250408130556.1054041-2-huangdengdui@huawei.com>
References: <20250408130556.1054041-1-huangdengdui@huawei.com>
 <20250408130556.1054041-2-huangdengdui@huawei.com>
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

On Tue, 8 Apr 2025 21:05:56 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> ThreadSanitizer is a tool that detects data races. It consists of a
> compiler instrumentation module and a run-time library.
> Typical slowdown introduced by ThreadSanitizer is about 5x-15x.
> Typical memory overhead introduced by ThreadSanitizer is about 5x-10x.
> 
> UBSan is integrated with gcc and clang and can be enabled via a meson
> option: -Db_sanitize=thread.
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---

This didn't look right to me, so asked AI for review.
Please address these comments.

Review: [RFC 1/1] build: support ThreadSanitizer

Patch 1/1 - build: support ThreadSanitizer

Commit message:

Warning: The commit message says "UBSan is integrated with gcc and clang
and can be enabled via a meson option: -Db_sanitize=thread." This is
confusing -- UBSan is the Undefined Behavior Sanitizer, not the Thread
Sanitizer. This sentence appears to be copy-pasted from the UBSan block
and should say "TSan is integrated with gcc and clang..."

Error: The patch uses `get_option('b_sanitize') == 'thread'` (exact
string match) but upstream ASan and UBSan blocks use `.contains()`.
The meson `b_sanitize` option accepts comma-separated values like
`'address,undefined'`. Using `== 'thread'` means the TSan block will
NOT trigger if someone passes `-Db_sanitize=thread,undefined` or any
compound value. Must use `.contains('thread')` to match the existing
pattern:

    if get_option('b_sanitize').contains('thread')

Warning: The ASan and UBSan blocks for GCC both add the library to
link arguments and to `dpdk_extra_ldflags` so that downstream consumers
(pkg-config, static linking) also get the flag. The TSan block is
missing both:

    add_project_link_arguments('-ltsan', language: 'c')
    dpdk_extra_ldflags += '-ltsan'

Without these, the DPDK build itself may link (meson's `b_sanitize`
adds `-fsanitize=thread` to the compiler), but applications linking
against DPDK's static libraries via pkg-config will fail to resolve
TSan symbols.

Info: TSan and ASan are mutually exclusive -- they cannot be used
together. Consider adding a check at the top of the TSan block:

    if get_option('b_sanitize').contains('address')
        error('TSan and ASan cannot be used together')
    endif

This would give a clear error message instead of cryptic linker
failures.

Info: It may be worth adding a `dpdk_conf.set10('RTE_THREAD_SANITIZER', true)`
define (analogous to `RTE_MALLOC_ASAN`) so that DPDK code can use
`#if defined(RTE_THREAD_SANITIZER)` to annotate custom synchronization
primitives with TSan annotations (`__tsan_acquire`, `__tsan_release`,
etc.). Without these annotations, TSan will produce many false positives
on DPDK's custom locking (rte_spinlock, rte_rwlock, rte_ring) since
these use inline atomics that TSan cannot automatically recognize as
synchronization. This would be the main value of build-level TSan
support beyond what the user gets from just passing `-Db_sanitize=thread`.
