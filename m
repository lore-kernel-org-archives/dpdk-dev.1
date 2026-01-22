Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA6C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0FC940269;
	Thu, 22 Jan 2026 01:54:03 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id C99B04021E
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:02 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so225713f8f.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043242;
 x=1769648042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JSdivYecBNcsYlz+b8yPomxGiNs3cEEk2u5NY+SoZI=;
 b=CEf7X+SonYvge98cZ2LM15UMQVKoYrXuveFeq+n43Wt2BfdaksYhFm/07q7GuDKm/a
 xkNjC7LD+Xa0FDHa0HA8a9GOZBlIbhsuYd8PUyGFVwcUtqY6n0X8yIdJyjjXtoPh68VU
 66P5ZjVsgRHk0/E9c0B862uAO/pTgT3NjEZJkuJG0bYYGpcsE7S9G9TYGuKMAmkedz6P
 fq8qLKjqkFdCD97lwlf3FTewz4BMKgPtGXpYundLeyGBgDqQ0bMOuZVr3n0c7nIRqvIC
 bU/YVvoFrAFBQ8DfwJiMTK/V0myM3XSQSTr6LTmdpI6+SOII1Te4TAeKfD7nUuaspluT
 SahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043242; x=1769648042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/JSdivYecBNcsYlz+b8yPomxGiNs3cEEk2u5NY+SoZI=;
 b=tHf1NXdCQkWXG0l83Lc137mpIQpZ4rx59PLzQtn4aoCZRA8f1Wa7nK+zvauvZ+BqTS
 RiuWUIzEktxIw2eBoHCY0ZBFiI2NVRWZLPZFInWcOrSqLjiAan5E3BttW9EV4JHhmex4
 3iqg3PGyVlKEDATgyiS3trgQswpwKvX41uYKBMZrIUjr+9aw+sOENKytbLPWXuP3+kwq
 x5cr+KrEy9JmgSPofN+wwQgJUyMjfipLDxjPxu+soQJXoZKVZ2MyJD9d/5rAfGZ1tb9x
 IKh4NuVHLyNeckvNZCs0u5xsJSoCHhL2f3b5afBrwcE80xKUZuNtj9w4EM1e2zbeK/A7
 XNJg==
X-Gm-Message-State: AOJu0YxbTHsvlMPbv9fs4waF38JAiT/NFMziwMEh8Bu+oyZXp2TT6eeF
 vfbJCZQDxDVfr4kwuyQk0gGDT3e31p6BzGPOoFwm8OOu6+LXQvGzKBkmGTJQMk0dZz11i20/V1U
 Cq7IA
X-Gm-Gg: AZuq6aKuYTLe3J0+n6eCJTFoSXpXHD9b2U2huTWm3ZlavyuB92n7gG9Etk1L3ORPCjr
 wjrxqCnMwrPokirM/7EEvYneDjMKrv9F31wfEtF1W/rkTR6GQiv93cw56UzAnNglWNgNmpL48QQ
 zeBI0BePEzjj+qL4ySTF8DXjB7T0qs8ZGQNcZeNY6gZGudmgdgHjPZhTPRA+c4rucZk0bzVlroI
 Ne0cDLNYkU/+h5w08eumZSTHfXgnNmhv+aGMZYxIMci6qfsJkLTLhW+a5Wbydt2XQg1gn/glPYT
 OxxaRyEh91PWEUczch86UVbndtmLedJLFroW0EYFXOO9PifhGT2WNoCjOgRl0JFynv7BkKs7Z2+
 +1Ri0QHU1I0SqopFchcZoQqVRlTdcZ8/3VFGqMcIzJYcCeu2/RJO6w9U/ZVf307Zc28kYi3z/I5
 +gWN+HLrCH5Dpd20ye8ozIpy0yXg9rP8OP2H1RNsn4rvi1IASquw==
X-Received: by 2002:a05:6000:420f:b0:432:5c34:fb22 with SMTP id
 ffacd0b85a97d-4358ff44602mr11297310f8f.22.1769043241822; 
 Wed, 21 Jan 2026 16:54:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/14] test: fix test failures on high cores
Date: Wed, 21 Jan 2026 16:50:16 -0800
Message-ID: <20260122005356.1168221-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118201223.323024-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
MIME-Version: 1.0
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

This series addresses several categories of test infrastructure issues:

1. Spinloop synchronization fixes (patch 1)
   
   Tests using tight spinloops for thread synchronization cause sporadic
   failures on high core count AMD Zen systems. The loops starve SMT
   sibling threads and create race conditions. Adding rte_pause() to
   all synchronization spinloops fixes these issues.

2. Test scaling for high core count systems (patches 2-5)
   
   Several tests use fixed iteration counts that cause timeouts on
   systems with many cores due to increased lock contention. A new
   helper function test_scale_iterations() scales iterations inversely
   with core count to maintain roughly constant test duration.

   Affected tests:
   - atomic_autotest (Bugzilla #952)
   - mcslock_autotest  
   - stack_autotest
   - timer_secondary_autotest

3. BPF test fixes (patches 6-8, 14)
   
   - Fix missing error handling in ELF load tests
   - Fix clang 20+ compatibility by restricting to BPF v2 instruction
     set (Bugzilla #1844)
   - Skip ELF test gracefully if null PMD is disabled
   - Fix incorrect size parameter in Rx/Tx load tests

4. Parallel test execution fixes (patches 9-10)
   
   Multiple tests colliding on the default "rte" file-prefix causes EAL
   initialization failures when running tests in parallel. Restore unique
   file-prefix for all fast-tests on Linux, including a separate prefix
   for trace_autotest_with_traces.

5. Test skip conditions (patches 11-13)
   
   Tests that depend on optional drivers (null PMD, eventdev) should skip
   gracefully when those drivers are disabled via -Ddisable_drivers=
   rather than failing.

v4 - add additional scaling for failures reported on 96 core system
   - gracefully handle case where null PMD disabled in build

Stephen Hemminger (14):
  test: add pause to synchronization spinloops
  test: scale atomic test based on core count
  test/mcslock: scale test based on number of cores
  test/stack: scale test based on number of cores
  test/timer: scale test based on number of cores
  test/bpf: fix error handling in ELF load tests
  test/bpf: fix unsupported BPF instructions in ELF load test
  test/bpf: skip ELF test if null PMD disabled
  test: add file-prefix for all fast-tests on Linux
  test: fix trace_autotest_with_traces parallel execution
  test/eventdev: skip test if eventdev driver disabled
  test/pcapng: skip test if null driver missing
  test/vdev: skip test if no null PMD
  test/bpf: pass correct size for Rx/Tx load tests

 app/test/bpf/meson.build             |  3 +-
 app/test/meson.build                 |  4 +-
 app/test/suites/meson.build          | 19 +++++---
 app/test/test.h                      | 19 ++++++++
 app/test/test_atomic.c               | 66 ++++++++++++++++------------
 app/test/test_bpf.c                  | 13 ++++--
 app/test/test_event_eth_tx_adapter.c | 11 +++--
 app/test/test_mcslock.c              | 10 +++--
 app/test/test_stack.c                |  8 ++--
 app/test/test_threads.c              | 17 +++----
 app/test/test_timer_secondary.c      | 14 +++---
 11 files changed, 121 insertions(+), 63 deletions(-)

-- 
2.51.0

