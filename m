Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07BF3D330
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A63FE4029D;
	Thu,  5 Mar 2026 17:40:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AA90B40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2n5Vo7LF4Ou+6lXv0M7f93TiBvoeQZOwY+70vQJ9OY=;
 b=JDkvO74Q+sCgNGmgy5s53tux4BBH+kWQhbB6n5zueq2DVOW213whiSS0sLzyuOh71+E7sy
 2DnFnNcTGQS6qTRHLj01wedfEzy2KRlqfXRby+WkszFYHHMJeiWq//9EneUdWItxmZQpSF
 TjEq9H/i1bN0FRp1PbCTsRvnLdwiZ3o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-9QADjC7yMcGDSdcgWHvuTw-1; Thu, 05 Mar 2026 11:39:51 -0500
X-MC-Unique: 9QADjC7yMcGDSdcgWHvuTw-1
X-Mimecast-MFC-AGG-ID: 9QADjC7yMcGDSdcgWHvuTw_1772728790
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3870b9ec9a0so68107761fa.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 08:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772728790; x=1773333590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2n5Vo7LF4Ou+6lXv0M7f93TiBvoeQZOwY+70vQJ9OY=;
 b=Pnpyb06sdJeONkOjMGAGpp1cFWJtSt/ndHdnc7Bxw8hHY1PNMYGmPDMTIQTSNci/ps
 tkpBzjQBfpFOWZhgjS6VMYQdP84Y5Vwq2kUag+AQYhR8IcuXbriw46skKdd5+TKewY2v
 gzP99gff9d8CcBQgo8RtIbHQBMCl/F6UFtJ6/eZFjEJ4GrKvWZ2kip/CQ4AGfWxusCkF
 lzzWwcSKsJZePrmLVazt8YNIQhe4DbXZdSiXnLuTnu8cr14zmcLjMNanW/W4H8Z7WDZP
 1jYMTSZyXVimbt2VSTxg0Tm5GtA4Cz73M57kwF5MTx6uk5rmxIgb5kvzEfSrvKUf1UIf
 FWAA==
X-Gm-Message-State: AOJu0Ywdq8XE8qvT0WRCX3LkguSt0e44k3k6LQ4sT1WNi2xGNnlrBqv0
 mPnlT69v4cujRLFk/YQ2QkmUtv8QPqq9IlcoUo5YrmneL9pZic+oObUw8KB9mDNMPVpG66v3BeK
 V3Yyy/VbETiQjgIkNZuV98loyX/8QeS72LBOpWMGzxdb3jb2rRytvZkCnLGivEaryUxxscd9/nc
 Y+9PvZrfy/wXZB2FaJzPEoy045iMI=
X-Gm-Gg: ATEYQzzOz0/YjAdCqpdHUSxphV9HRxTcpx49czb3pqGDq1IOK8EWbNFDLcHzPJVrwpB
 FM81081+GXp1ZwJ+3gW01ZGd0XTLOZHwt3omzkRxuIBtLKqZsfyeL/wGASf4lBZUB+q8JIvGr70
 nsuwk0qfvn0wt/pfHbXOZokxl6CWCQGfgeycBCWztcdz2WuP4bSBuV0hjiAz2MRpGpTKNP1E14k
 4kxMYep4JE/STX5XYJrNRXEEma81CTy+oLGxRFQ23yVYOC4/Jqu4chm6ay1ouMo48QkSg==
X-Received: by 2002:a05:651c:4103:b0:38a:2c06:a270 with SMTP id
 38308e7fff4ca-38a2c7af6b9mr26256181fa.30.1772728790227; 
 Thu, 05 Mar 2026 08:39:50 -0800 (PST)
X-Received: by 2002:a05:651c:4103:b0:38a:2c06:a270 with SMTP id
 38308e7fff4ca-38a2c7af6b9mr26256121fa.30.1772728789692; Thu, 05 Mar 2026
 08:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 17:39:38 +0100
X-Gm-Features: AaiRm50yiZr0h_uhanLPkjYR-4jBNfCcanL4WLUr1IlDiAo7Ji5doOQy34tpciY
Message-ID: <CAJFAV8w9nWFccrTKCLOEgBwHbE0eKAt-Tkwkn0ZcsxnOMkdM4Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] test: fix test failures on high cores
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n0B4qVrGOVOw7zy5DSx2f014_4t2dPZBrAh8gWBqvjY_1772728790
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

On Thu, 22 Jan 2026 at 01:54, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This series addresses several categories of test infrastructure issues:
>
> 1. Spinloop synchronization fixes (patch 1)
>
>    Tests using tight spinloops for thread synchronization cause sporadic
>    failures on high core count AMD Zen systems. The loops starve SMT
>    sibling threads and create race conditions. Adding rte_pause() to
>    all synchronization spinloops fixes these issues.
>
> 2. Test scaling for high core count systems (patches 2-5)
>
>    Several tests use fixed iteration counts that cause timeouts on
>    systems with many cores due to increased lock contention. A new
>    helper function test_scale_iterations() scales iterations inversely
>    with core count to maintain roughly constant test duration.
>
>    Affected tests:
>    - atomic_autotest (Bugzilla #952)
>    - mcslock_autotest
>    - stack_autotest
>    - timer_secondary_autotest
>
> 3. BPF test fixes (patches 6-8, 14)
>
>    - Fix missing error handling in ELF load tests
>    - Fix clang 20+ compatibility by restricting to BPF v2 instruction
>      set (Bugzilla #1844)
>    - Skip ELF test gracefully if null PMD is disabled
>    - Fix incorrect size parameter in Rx/Tx load tests
>
> 4. Parallel test execution fixes (patches 9-10)
>
>    Multiple tests colliding on the default "rte" file-prefix causes EAL
>    initialization failures when running tests in parallel. Restore unique
>    file-prefix for all fast-tests on Linux, including a separate prefix
>    for trace_autotest_with_traces.
>
> 5. Test skip conditions (patches 11-13)
>
>    Tests that depend on optional drivers (null PMD, eventdev) should skip
>    gracefully when those drivers are disabled via -Ddisable_drivers=
>    rather than failing.
>
> v4 - add additional scaling for failures reported on 96 core system
>    - gracefully handle case where null PMD disabled in build
>
> Stephen Hemminger (14):
>   test: add pause to synchronization spinloops
>   test: scale atomic test based on core count
>   test/mcslock: scale test based on number of cores
>   test/stack: scale test based on number of cores
>   test/timer: scale test based on number of cores
>   test/bpf: fix error handling in ELF load tests
>   test/bpf: fix unsupported BPF instructions in ELF load test
>   test/bpf: skip ELF test if null PMD disabled
>   test: add file-prefix for all fast-tests on Linux
>   test: fix trace_autotest_with_traces parallel execution
>   test/eventdev: skip test if eventdev driver disabled
>   test/pcapng: skip test if null driver missing
>   test/vdev: skip test if no null PMD
>   test/bpf: pass correct size for Rx/Tx load tests
>
>  app/test/bpf/meson.build             |  3 +-
>  app/test/meson.build                 |  4 +-
>  app/test/suites/meson.build          | 19 +++++---
>  app/test/test.h                      | 19 ++++++++
>  app/test/test_atomic.c               | 66 ++++++++++++++++------------
>  app/test/test_bpf.c                  | 13 ++++--
>  app/test/test_event_eth_tx_adapter.c | 11 +++--
>  app/test/test_mcslock.c              | 10 +++--
>  app/test/test_stack.c                |  8 ++--
>  app/test/test_threads.c              | 17 +++----
>  app/test/test_timer_secondary.c      | 14 +++---
>  11 files changed, 121 insertions(+), 63 deletions(-)

I think there is some overlap with some other merged patches (like a
conflict on the meson side).
Please check and rebase this series.

Thanks.


-- 
David Marchand

