Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E6C369A2
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Apr 2025 00:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E4C402CE;
	Sat, 12 Apr 2025 02:04:43 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C1A674025F
 for <dev@dpdk.org>; Sat, 12 Apr 2025 02:04:41 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E9E6A21165AA; Fri, 11 Apr 2025 17:04:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9E6A21165AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744416280;
 bh=Vf7V+c3tsDfIPXIY42zg7MrQ5EZ98Rq3k7A/B6LhQhA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CT/9ykIk5xNi3c1cPHCUNFgH4jwMrjnG0ULy9NvQxU3qD9kmyoytllW1OIJcU6Gfg
 EC4h3Gq2HlC6srTjcA356tksVRWtqlJRdw2yWN9s5ey4Wlk6IGpWvn3CLkPuGbDI65
 ZPY6cHaImBLu7PHU6PKSbsEHGlxNcTHkeMn1OQVA=
Date: Fri, 11 Apr 2025 17:04:40 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v6 00/10] enable "app" to be compiled with MSVC
Message-ID: <20250412000440.GA13968@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8yhcDpvmBnCXtUw=z-+Hhz1DdzH=gWr+L3+dF4thUO0iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yhcDpvmBnCXtUw=z-+Hhz1DdzH=gWr+L3+dF4thUO0iw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Fri, Apr 11, 2025 at 08:49:40AM +0200, David Marchand wrote:
> Hello Andre,
> 
> On Mon, Feb 24, 2025 at 5:25 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > v6:
> > - remove "volatile" and use rte_atomic_xxx to access the RTE_ATOMIC
> >   qualified lcore_count, which is cleaner than using "volatile".
> >
> > v5:
> > - add "volatile" to declaration of lcore_count in test_ring_perf.c.
> >
> > v4:
> > - add explanation about the expression used in __rte_constant during v3.
> >
> > v3:
> > - use clever expression with _Generic for __rte_constant and use it
> >   where __builtin_constant_p was being used.
> > - use %u in csumonly.c and just cast variables to unsigned int.
> >
> > v2:
> > - use lcore_count as atomic always, not only when RTE_USE_C11_MEM_MODEL
> >   is set.
> > - use PRIu64 in csumonly.c instead of casting variables to int.
> >
> > Andre Muezerie (10):
> >   eal: add workaround for __builtin_constant_p
> >   test_alarm: avoid warning about different qualifiers
> >   test-pmd: fix printf format string mismatch
> >   test-pmd: do explicit 64-bit shift to avoid implicit conversion
> >   test-pmd: avoid undefined behavior
> >   test-pmd: avoid non-constant initializer
> >   test-pmd: don't return value from void function
> >   test/test-pmd: declare lcore_count atomic
> >   test: add workaround for __builtin_constant_p in test_memcpy_perf
> >   app: enable app directory to be compiled with MSVC
> >
> >  app/meson.build                     |  4 ---
> >  app/test-pmd/cmdline.c              | 16 +++++----
> >  app/test-pmd/cmdline_flow.c         | 22 ++++++------
> >  app/test-pmd/csumonly.c             | 23 ++++++------
> >  app/test-pmd/meson.build            |  1 -
> >  app/test-pmd/testpmd.c              |  2 +-
> >  app/test-pmd/testpmd.h              |  2 ++
> >  app/test-pmd/util.c                 |  2 +-
> >  app/test/test_alarm.c               | 12 +++----
> >  app/test/test_memcpy_perf.c         | 54 ++++++++++++++---------------
> >  app/test/test_ring_perf.c           | 13 +++----
> >  lib/eal/include/generic/rte_pause.h |  2 +-
> >  lib/eal/include/rte_common.h        | 34 +++++++++++++++++-
> >  13 files changed, 109 insertions(+), 78 deletions(-)
> 
> I replaced patch 5 with the alternative that I sent yesterday.
> Series applied.
> 
> We now have dpdk-test and dpdk-testpmd built with MSVC in the CI.
> We are still missing net/null and mempool/ring to do some basic test
> like devtools/test-null.sh.
> On the other hand, what prevents us from running the fast-tests
> testsuite in the CI?
> 

We are certainly close to the point where fast-tests testsuite can be run.
On my machine, with some fixes that are still under review, I'm seeing all
tests passing or getting skipped, except for memzone_autotest, which I also
see failing on Linux when the same parameters are used. So this test failure
does not look like is msvc-specific.

meson test -C build --suite fast-tests --test-args="--no-huge -m 8192" -t 4
…
56/93 DPDK:fast-tests / memzone_autotest                       FAIL            0.12s   (exit status 4294967295 or signal 4294967167 SIGinvalid)
>>> DPDK_TEST=memzone_autotest MESON_TEST_ITERATION=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=87 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 V:\github\dpdk13_drivers_used_vars\dpdk\build\app\dpdk-test.exe --no-huge -m 8192
Ok:                 73
Expected Fail:      0
Fail:               1
Unexpected Pass:    0
Skipped:            19
Timeout:            0

When running the same command on "main" branch I see less tests running and
more failures.
--
Andre Muezerie

> 
> -- 
> David Marchand
