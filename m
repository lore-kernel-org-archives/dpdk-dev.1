Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BECA6005
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 08:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A8C4025D;
	Mon, 19 Jan 2026 09:09:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF404025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 09:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768810166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nX+LECvoBlFclMki4Lh53CcLR9Cq2FxwYe7H6MP/OyE=;
 b=WtGCaBnT3JKlYimGdAPSyQF+4HGfAhBH72B9GxkZsCkKbT0mC3U9Dp9gPiDO9jrXVeZ/Sk
 aQFwOAB2SEsaMaMtdT1FVeJZXAEaUjk4mpOIARPu24XTEGMt5Z74tRfIbNmBoFC+W1m4KW
 9+5RPRzQaXhcmiutc7ET7bHiu2h4w1k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-jZ-pwBk3O3i3iuQ4iURrBA-1; Mon, 19 Jan 2026 03:09:24 -0500
X-MC-Unique: jZ-pwBk3O3i3iuQ4iURrBA-1
X-Mimecast-MFC-AGG-ID: jZ-pwBk3O3i3iuQ4iURrBA_1768810163
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b686eafcfso2739032e87.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 00:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768810163; x=1769414963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX+LECvoBlFclMki4Lh53CcLR9Cq2FxwYe7H6MP/OyE=;
 b=jscqwzhkSYnqRN8/mNznUI3573e7rd5jzjCKzfie5AaDlFVBI53nVu6y4UNi6S+vof
 JRMvNMoBFVt0ejdTe7VIw9cDnimduPua/hEg89CRIzbRt2QC8gix3Ge1XajXO8dBtdRm
 Sz0Hr3z+7FhsZphh/DMg8O4HEB4HndonI1hUCFMOsPb3rFY2kVw3kRmaVSGTI5Vrqi3f
 3oec5EYTYbRH3jVd/ls87yP7YN4753bMTKTJ+P52ckp3RVeK0Hf4rp3tlZCAH7UQ3CKD
 NPpjxMaDi/CfUbTOUNs4s+kRHtSIo2AAPXNw0IgPEhms9Hb9aRoMC9Id1gQI+9FTPk7B
 VgMw==
X-Gm-Message-State: AOJu0Ywg8zJPNzgcPPuXAevmlLP23/yiUU1ISRT+9tGAUhBfLixzOiZE
 mSWZOFFuVzV6TQb027hFc3RZL5P73FeRY1G/TFAsXEfOVBcgBiJZAlJMdwr2LyV24F91iHy0ODZ
 ItcVZMLDrBwxOUHJfkX1oNaU/L6olwxxGrlIBVjcYWPt1KUx4y+WINESFBdtZJvQohMPrs34QNP
 lomt4nCehkQ8sY+DNHGhA=
X-Gm-Gg: AY/fxX5byy3Oa5gyOqmqlAt35f7vJnzMyOdbVO6ZXELxEJ/emeLnM62w+QHlaxWPP9W
 upEOHWtTChUB0lR+oAxt24dhpvpTxmzNrCTpvp5cFFq9NNXF5ATZOhMH9854H0UjbMcK9QXXBEo
 GQM3cs/D6jqI6WvCSP19wstXLvyBE2E2Qdpn7GjHGHhC1Z5ybvTgT4gNqx+5LhpB/PZrXY
X-Received: by 2002:a05:6512:124e:b0:59b:78ad:fb9e with SMTP id
 2adb3069b0e04-59bafdb6400mr3476343e87.10.1768810162625; 
 Mon, 19 Jan 2026 00:09:22 -0800 (PST)
X-Received: by 2002:a05:6512:124e:b0:59b:78ad:fb9e with SMTP id
 2adb3069b0e04-59bafdb6400mr3476339e87.10.1768810162081; Mon, 19 Jan 2026
 00:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
 <CAJFAV8xQL=w1rA30jfgp1oAxancAA5jESFO8GRmko6am7Te6DQ@mail.gmail.com>
In-Reply-To: <CAJFAV8xQL=w1rA30jfgp1oAxancAA5jESFO8GRmko6am7Te6DQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 19 Jan 2026 09:09:10 +0100
X-Gm-Features: AZwV_QjUiQWRGOqR9yDxNRi4VV8FVrsh-gDB1ofSatPrXXzxR7m1K6-XsYFToBQ
Message-ID: <CAJFAV8y8rObNjwotr0FDCD50pZZfXvekA0m-fZeXMxGJKcLweg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Assign all unit tests to suites
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eifpGqUDWo2LH5f02WjKA6m85mUcOSjQ3Z4zFxHltaw_1768810163
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

Hello Bruce,

On Fri, 16 Jan 2026 at 14:24, David Marchand <david.marchand@redhat.com> wrote:
>
> On Thu, 11 Dec 2025 at 18:17, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Categorize all unit tests into one of the test suites: generally driver
> > tests or fast-tests. In order to add some of the tests to fast tests,
> > some additional work was required, hence the additional patches in this
> > set. Also, make the parameters for asan and hugepages clearer in each
> > test's definition.
> >
> > V4:
> > - export new internal functions using proper EXPORT_INTERNAL macros (patch 5)
> >
> > V3:
> >  - correct comment in patch 1
> >  - define "attic" suite for unstable tests and add red_autotest to it.
> >
> > V2:
> > - rename the parameters for fast-test
> > - fix issues with the tests to be added to fast-tests:
> >   * allow loading drivers from secondary processes
> >   * fix undefined behaviour flagged by asan in red test
> >   * skip unrunnable power tests, rather than failing
> > - add tests to driver-test suite also
> > - add patch fixing output in case we have no unattached tests
> >
> >
> > Bruce Richardson (11):
> >   app/test: make parameters clearer when adding fast tests
> >   app/test: fix undefined behaviour in red autotest
> >   app/test: reduce duration of secondary timer test
> >   app/test: fix timer loop hang on secondary process failure
> >   eal: add internal APIs to query loaded driver paths
> >   app/test: pass loaded driver info to secondary procs
> >   app/test: skip power capabilities test if unsupported
> >   app/test: add some unattached tests to fast-test suite
> >   app/test: add tests to driver test suite
> >   buildtools/get-test-suites: suppress empty output
> >   app/test: move red autotest to attic
> >
> >  app/test/process.h                     | 28 ++++++++++++-
> >  app/test/suites/meson.build            | 14 ++++++-
> >  app/test/test.h                        | 13 ++++++-
> >  app/test/test_acl.c                    |  2 +-
> >  app/test/test_alarm.c                  |  2 +-
> >  app/test/test_argparse.c               |  2 +-
> >  app/test/test_atomic.c                 |  2 +-
> >  app/test/test_bitcount.c               |  2 +-
> >  app/test/test_bitmap.c                 |  2 +-
> >  app/test/test_bitops.c                 |  2 +-
> >  app/test/test_bitratestats.c           |  2 +-
> >  app/test/test_bitset.c                 |  2 +-
> >  app/test/test_bpf.c                    |  6 +--
> >  app/test/test_byteorder.c              |  2 +-
> >  app/test/test_cfgfile.c                |  2 +-
> >  app/test/test_cksum.c                  |  2 +-
> >  app/test/test_cmdline.c                |  2 +-
> >  app/test/test_common.c                 |  2 +-
> >  app/test/test_compressdev.c            |  2 +-
> >  app/test/test_cpuflags.c               |  2 +-
> >  app/test/test_crc.c                    |  2 +-
> >  app/test/test_cryptodev_crosscheck.c   |  2 +-
> >  app/test/test_cycles.c                 |  2 +-
> >  app/test/test_debug.c                  |  2 +-
> >  app/test/test_devargs.c                |  2 +-
> >  app/test/test_dispatcher.c             |  2 +-
> >  app/test/test_distributor.c            |  2 +-
> >  app/test/test_eal_flags.c              | 24 ++++++------
> >  app/test/test_eal_fs.c                 |  2 +-
> >  app/test/test_errno.c                  |  2 +-
> >  app/test/test_ethdev_api.c             |  2 +-
> >  app/test/test_ethdev_link.c            |  2 +-
> >  app/test/test_event_crypto_adapter.c   |  2 +-
> >  app/test/test_event_eth_rx_adapter.c   |  4 +-
> >  app/test/test_event_eth_tx_adapter.c   |  2 +-
> >  app/test/test_event_ring.c             |  2 +-
> >  app/test/test_event_timer_adapter.c    |  2 +-
> >  app/test/test_event_vector_adapter.c   |  2 +-
> >  app/test/test_eventdev.c               |  4 +-
> >  app/test/test_external_mem.c           |  2 +-
> >  app/test/test_fbarray.c                |  2 +-
> >  app/test/test_fib.c                    |  2 +-
> >  app/test/test_fib6.c                   |  2 +-
> >  app/test/test_func_reentrancy.c        |  2 +-
> >  app/test/test_graph.c                  |  4 +-
> >  app/test/test_graph_feature_arc.c      |  2 +-
> >  app/test/test_hash.c                   |  2 +-
> >  app/test/test_hash_readwrite.c         |  2 +-
> >  app/test/test_interrupts.c             |  2 +-
> >  app/test/test_ipfrag.c                 |  2 +-
> >  app/test/test_ipsec.c                  |  2 +-
> >  app/test/test_ipsec_sad.c              |  2 +-
> >  app/test/test_kvargs.c                 |  2 +-
> >  app/test/test_latencystats.c           |  2 +-
> >  app/test/test_lcore_var.c              |  2 +-
> >  app/test/test_lcores.c                 |  2 +-
> >  app/test/test_logs.c                   |  2 +-
> >  app/test/test_lpm.c                    |  2 +-
> >  app/test/test_lpm6.c                   |  2 +-
> >  app/test/test_malloc.c                 |  2 +-
> >  app/test/test_mbuf.c                   |  2 +-
> >  app/test/test_mcslock.c                |  2 +-
> >  app/test/test_member.c                 |  2 +-
> >  app/test/test_memcpy.c                 |  2 +-
> >  app/test/test_memory.c                 |  2 +-
> >  app/test/test_mempool.c                |  2 +-
> >  app/test/test_memzone.c                |  2 +-
> >  app/test/test_meter.c                  |  2 +-
> >  app/test/test_metrics.c                |  2 +-
> >  app/test/test_mp_secondary.c           |  2 +-
> >  app/test/test_net_ether.c              |  2 +-
> >  app/test/test_net_ip6.c                |  2 +-
> >  app/test/test_pcapng.c                 |  2 +-
> >  app/test/test_pdcp.c                   |  2 +-
> >  app/test/test_pdump.c                  |  2 +-
> >  app/test/test_per_lcore.c              |  2 +-
> >  app/test/test_pflock.c                 |  2 +-
> >  app/test/test_pie.c                    |  2 +-
> >  app/test/test_pmd_ring.c               |  2 +-
> >  app/test/test_pmu.c                    |  2 +-
> >  app/test/test_power.c                  |  2 +-
> >  app/test/test_power_cpufreq.c          |  6 +--
> >  app/test/test_power_intel_uncore.c     |  2 +-
> >  app/test/test_power_kvm_vm.c           |  2 +-
> >  app/test/test_prefetch.c               |  2 +-
> >  app/test/test_ptr_compress.c           |  2 +-
> >  app/test/test_rawdev.c                 |  2 +-
> >  app/test/test_rcu_qsbr.c               |  2 +-
> >  app/test/test_red.c                    |  2 +-
> >  app/test/test_reorder.c                |  2 +-
> >  app/test/test_rib.c                    |  2 +-
> >  app/test/test_rib6.c                   |  2 +-
> >  app/test/test_ring.c                   |  2 +-
> >  app/test/test_rwlock.c                 |  8 ++--
> >  app/test/test_sched.c                  |  2 +-
> >  app/test/test_security.c               |  2 +-
> >  app/test/test_security_inline_macsec.c |  2 +-
> >  app/test/test_security_inline_proto.c  |  6 +--
> >  app/test/test_seqlock.c                |  2 +-
> >  app/test/test_service_cores.c          |  2 +-
> >  app/test/test_soring.c                 |  2 +-
> >  app/test/test_spinlock.c               |  2 +-
> >  app/test/test_stack.c                  |  4 +-
> >  app/test/test_string_fns.c             |  2 +-
> >  app/test/test_table.c                  |  2 +-
> >  app/test/test_tailq.c                  |  2 +-
> >  app/test/test_telemetry_data.c         |  2 +-
> >  app/test/test_telemetry_json.c         |  2 +-
> >  app/test/test_thash.c                  |  2 +-
> >  app/test/test_threads.c                |  2 +-
> >  app/test/test_ticketlock.c             |  2 +-
> >  app/test/test_timer.c                  |  2 +-
> >  app/test/test_timer_secondary.c        | 13 ++++---
> >  app/test/test_trace.c                  |  2 +-
> >  app/test/test_vdev.c                   |  2 +-
> >  app/test/test_version.c                |  2 +-
> >  buildtools/get-test-suites.py          |  5 ++-
> >  doc/guides/contributing/unit_test.rst  | 10 +++--
> >  lib/eal/common/eal_common_options.c    | 54 ++++++++++++++++++++++++--
> >  lib/eal/include/rte_eal.h              | 54 ++++++++++++++++++++++++++
> >  lib/sched/rte_red.h                    |  9 ++++-
> >  121 files changed, 315 insertions(+), 157 deletions(-)
>
> Series applied, thanks.

I can see a few failures, namely, for the daily tests on the main
branch in GHA, and it seems reproducible.

Attempt 1:
https://github.com/DPDK/dpdk/actions/runs/21121155333/job/60734135604
Attempt 2:
https://github.com/DPDK/dpdk/actions/runs/21121155333/job/60756716459

Could you have a look please?


-- 
David Marchand

