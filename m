Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA401C61DB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 02:01:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CB90400D7;
	Wed, 26 Aug 2026 04:01:45 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 5D794400D5
 for <dev@dpdk.org>; Wed, 26 Aug 2026 04:01:43 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so515965a91.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 19:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787709702;
 x=1788314502; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2/bi1xUqEzJGwQhJxJ/uW+sFJ/Z7XjtbtxHaF/IR6eM=;
 b=LyTDjvpPXwou+UFcFb4MK8smOlTbFd6GBNwbIYxJSW9NUi7c0orioz0yxNNP+MYLzP
 VlkoVBfYNzy4oXYH5garfAO9jA2XEiTmoFKJqdEcn5LoM7ABNwjf5Jv3GKZTfcUX67qH
 hBYpU0EE8WxTyXWfgcwVjvZ7eIw2g3cAa33qMv4BXpsrGdZGush+on0/TDts/XhwNXox
 mlB9QIgJwH3J7MHF7pcVWd1ZNYrph3vEW3BrjqBabAJr9HU89qUiC9+FQg5o9Xyd+dT6
 OTESB0IHQBjjB7o6Xu0hR6txPZsRyIamJyUtTCJlL83c4Yz8rbQXHXihsCmUmvNbEvCA
 zcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787709702; x=1788314502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2/bi1xUqEzJGwQhJxJ/uW+sFJ/Z7XjtbtxHaF/IR6eM=;
 b=PhPhPLxYpW8Q0ENhlhPWpzNJxdKNLu4wIjNJczAmL03BIa5cpPWQh4QTh048brNo6q
 uYWFqxFcDMxhDQ5GxM0MIWNFWapWOTJFamYN5iYFdb809dymchiyKU4yLB3LIZwYuceZ
 s9Tpf0Es0hnxqtzsrwQmLkxGhH/yxRmWB1i8S5Q6zvvSUNhONUb506Zp11lXxvPErKwL
 cHie24Ja9JzJNkX1WtQ34SIHJ3PKLgFNP5Zka6gVXgaAntfPn1SmxpgyU0Rww/UFOMww
 bYPA+iWsaClHI3FvH4SWyLuuWJUraTXP0yOP5soEmvCIjumqz36+w3YC57pzeGnsMAD4
 4PYw==
X-Gm-Message-State: AFuF++lIFSBCBUOzLWhJYq1GuCFkEWN3ixqDkXtaADybs1x2uaOFxjwW
 EoQyg9QSTlemuQ4mhKbd8aFOZTN5SH2OvHvmN4Xba9GUqHF50O4gK9CkWpTsxjSv11xg97nDoFB
 f2qed
X-Gm-Gg: AR+sD10j8ysNZiFGnD/jEJO7fo6gdNkZPZxLrg2dSbahUxORjU6gRnqhRaXxahjesaV
 vZY5KPsLBh/zqqGO1tVpgyXWKD+xaaOR7naj9rqt3Y27LOiRXejUOVS+BAiXEiAaipxUOrm8PXl
 ZBp5SNzMz6paLLakSZMPNX6onZHrNM0uly+eTs5R+TTFFeVnMgNARhoJEaMUy/JlChzsiNPInQB
 OVlR320+XTHIb7av93zSxohQLCch7u2/62+qtmI/l3CkF2FnO2cdhGFX2teQH/nA0J2mPyCLwv3
 P/7Hl9gwHy9m76HwA6tIQ9suz4ukUmDobQ0wBbGkCs9AxPQS9PU+1+9VOsuIN4WDdp9vYu4Z0gJ
 OhvGmwv4trtUPGZeDxECjtJNmuEkaO/541IHOnQjJ6aZ1lY+Qi6zcWnWwdI0YE0kA7Rz4SvifoP
 0itTP7OckA0reNISqXn+zYTIv0bW17Hi9S4YO/jE91dywKwTgQ4iMs/gkr517mH0UUpMORXBNOX
 37feOxqz38iAakH3y/tGTeRUPs=
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3966d412ab2mr6464238a91.9.1787709701719; 
 Tue, 25 Aug 2026 19:01:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396686e8aa2sm1935636a91.3.2026.08.25.19.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:01:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/5] app/test: make perf tests usable on wider range of
 systems
Date: Tue, 25 Aug 2026 18:56:42 -0700
Message-ID: <20260826020133.2644805-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

Several of the perf/autotests assume server-class machines: they run for
billions of iterations, or size hugepage allocations by total lcore count,
which makes them time out or fail to allocate on smaller systems and on
machines with high core counts but modest memory.

This series trims runtime and memory use without losing meaningful test
coverage, and reports resource shortfalls as skips rather than failures.
The goal is a perf suite that can be run regularly to catch large
regressions, so finishing reliably matters more than fine resolution.

Measured with "meson test --suite=perf-tests" on a 32 lcore system with
10 GB of hugepages, same machine and same session before and after:

                                          main     this series
    Ok                                      41              44
    Fail                                     1               0
    Timeout                                  4               0

    mempool_perf_autotest              timeout            414s
    mempool_perf_autotest_1core        timeout             83s
    mempool_perf_autotest_2cores       timeout             84s
    mempool_perf_autotest_allcores     timeout            200s
    rcu_qsbr_perf_autotest                495s             32s
    reciprocal_division_perf              252s              1s
    reciprocal_division                   104s   moved to fast-tests
    pmd_perf_autotest                     FAIL            skip

    total suite                        65.5 min        24.8 min

The 65.5 minutes understates it: four of those tests were killed at the
600 second timeout rather than finishing, so the real figure is unknown
and larger.

Note that with enough memory for the largest mempool, all four mempool
variants time out on main, including the single core one.  Memory is not
the only problem; the test also has no working bound on its own runtime.

Two distinct problems were behind that, and both needed fixing:

- test_loop() did a fixed number of objects per call, and the elapsed
time is only checked between calls.  A small bulk size needs many more
mempool operations for the same objects, and each operation is much
more expensive when many cores contend, so with bulk size 1 on 32
cores a single call took over 50 seconds and TIME_MS could not bound
anything.  The work per call is now limited by mempool operations.

- Each test point launches and joins every lcore.  That costs about 2 ms
on one core but over a second on 32, so the runtime is set by the
number of points rather than by the time spent measuring.  Above two
cores a reduced set of get/put bulk sizes is used.

On a machine with less memory the mempool sizing matters too: sizing the
pools by the cores actually exercised lets the one and two core variants
run where they previously could not allocate at all, and a shortfall is
now reported as a skip rather than a failure.

v2 changes:

- Patch 5 no longer drops the constant-values replay.  Morten pointed
out that mempools are commonly used with compile time constant request
sizes, so those paths are real regression signal, and NAKed the
removal.  The replay is kept but restricted to a subset of the bulk
sizes rather than the whole get/put diagonal.

- The bulk size tables keep 64 and RTE_MEMPOOL_CACHE_MAX_SIZE / 2.  The
latter is the bounce buffer limit in Morten's mempool optimization
work, above which requests bypass the cache, so it marks a real
change in behaviour.

- The mempool patches are squashed into one per test file.  The result
contains considerably more than was reviewed in v1, so the acks given
on the v1 mempool patches have been dropped rather than carried
forward.

- Added the test_loop() bound and the reduced bulk table described
above, plus per-point elapsed time and a flush before measuring, so a
run killed by a timeout shows where it got to.  That is how the
50 second points were found.

Stephen Hemminger (5):
  app/test/reciprocal_division: make it a fast test
  app/test/reciprocal_division_perf: reduce test time
  app/test/test_rcu_qsbr_perf: call quiescent more often
  app/test/test_pmd_perf: skip if no device available
  app/test/mempool_perf: adjust test for large core counts

app/test/test_mempool_perf.c             | 179 ++++++++++-----
app/test/test_pmd_perf.c                 |   2 +-
app/test/test_rcu_qsbr_perf.c            |   3 +-
app/test/test_reciprocal_division.c      | 279 +++++++++++++----------
app/test/test_reciprocal_division_perf.c |   4 +-
5 files changed, 281 insertions(+), 186 deletions(-)

-- 
2.53.0

