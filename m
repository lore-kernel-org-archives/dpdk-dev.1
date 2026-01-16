Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14601D4899D
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 13:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D988542E0B;
	Fri, 16 Jan 2026 14:25:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E275E42D99
 for <dev@dpdk.org>; Fri, 16 Jan 2026 14:24:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768569899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g5uDqpw72uoWtZjn2RUF6vwdlEo3KbqEmGnmC1yQ0OE=;
 b=Vtxbum5uuBFXaqP4NFD4o+5blI2uXPWgo0hrNs/OvwEzWE9tBKxunjiR3kiwpNfaxdMWh6
 /mDxUEuS9xY6iHpuIU6vJ7g9G7IiOWopkAPXtt7kmgz/CQE/LhToppWySXhW42OhHr7lwI
 x6M0A3ufXyPaT6/RQk5Z0bzwp9rgjxA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-LZDOIjiuP6-YdUS7hNiA3g-1; Fri, 16 Jan 2026 08:24:58 -0500
X-MC-Unique: LZDOIjiuP6-YdUS7hNiA3g-1
X-Mimecast-MFC-AGG-ID: LZDOIjiuP6-YdUS7hNiA3g_1768569897
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b6f3890e4so1773337e87.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 05:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768569896; x=1769174696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5uDqpw72uoWtZjn2RUF6vwdlEo3KbqEmGnmC1yQ0OE=;
 b=PHy5KOotP4Ktn7WVQI53a++dhOJCrz7rxmJivYxI8FPmN9alD5vfbTGR85XTjnWD2G
 AKPw6Q8/9NertprzyLJ4yTVr3SBBCMoXB3hyP7QijakTazNGWJT3Qbp7Ei6b0hx6wSAH
 Pnfa4dA1HeG4tY1T2eFzexnHHtPoPlgAqQJPcIJR/7JnyMKRHUNFOwBgB/ZfERw4GduN
 RMkgB4aRera9oA4YhuhluqRBDpGJNphUHANEK8pNM829nTwc+ziYIHLzl+aYDOzDjFJm
 q+0L6TBhGSyVQtWy6mIqdJehjmUeZe5Gh+TOMGlN7qlZFe4EFPvj8V6KzuZXAkwYUN5r
 BDJA==
X-Gm-Message-State: AOJu0YwDnQxZQ06Wa2T14ysWBEj1+KgmthG/VH/UDVmrHdsW0t2dhK3t
 JXDpHElK1fFQ5Pa28utu/Rtcpkko4p4QYj5R70kDDBNOGDS6+iQdGKoR6S30mu2yTe+5TR+x+hb
 UeVy29Uz/NI2dSMPRbaZFKJiLfCq2/9PjmVNfOhIyy43579yXculgpuRNlMaw8Nn5iYxINUekG9
 Rwm79Nshd+/wjvEd6Uau0=
X-Gm-Gg: AY/fxX5iTHcYS7ziCqGM4m9FP37XtzoG1b5agxmbT4QALEXg0pbo+T9nDDCqe9YEQzf
 jm/aAlviBnNrgoC238G/5TqyaSDAzO0u3aPt/8mu8xO+6+CARTLm6eZpTQ6BFv+pxvwpqEFCrLI
 eg1NGcYNjil0mDANAsclMuSVzWxk85hMkeJpHTur6OwohOEGFBG8x17qIOvXzq+Rg6N9dO
X-Received: by 2002:a05:6512:3d03:b0:59b:6853:f085 with SMTP id
 2adb3069b0e04-59baeed3f49mr950336e87.16.1768569896358; 
 Fri, 16 Jan 2026 05:24:56 -0800 (PST)
X-Received: by 2002:a05:6512:3d03:b0:59b:6853:f085 with SMTP id
 2adb3069b0e04-59baeed3f49mr950331e87.16.1768569895864; Fri, 16 Jan 2026
 05:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251211171709.714229-1-bruce.richardson@intel.com>
In-Reply-To: <20251211171709.714229-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 Jan 2026 14:24:44 +0100
X-Gm-Features: AZwV_QhmS8EU57GIYn-hDBh6NkCih0FNE7_wGv4wmjKaqxFZ9lcYRyk9_jZYjbk
Message-ID: <CAJFAV8xQL=w1rA30jfgp1oAxancAA5jESFO8GRmko6am7Te6DQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Assign all unit tests to suites
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PHtOYVT_txK-lN0ZJCzM8Nai6xAhQU3wC5sP7fQqgFE_1768569897
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

On Thu, 11 Dec 2025 at 18:17, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Categorize all unit tests into one of the test suites: generally driver
> tests or fast-tests. In order to add some of the tests to fast tests,
> some additional work was required, hence the additional patches in this
> set. Also, make the parameters for asan and hugepages clearer in each
> test's definition.
>
> V4:
> - export new internal functions using proper EXPORT_INTERNAL macros (patch 5)
>
> V3:
>  - correct comment in patch 1
>  - define "attic" suite for unstable tests and add red_autotest to it.
>
> V2:
> - rename the parameters for fast-test
> - fix issues with the tests to be added to fast-tests:
>   * allow loading drivers from secondary processes
>   * fix undefined behaviour flagged by asan in red test
>   * skip unrunnable power tests, rather than failing
> - add tests to driver-test suite also
> - add patch fixing output in case we have no unattached tests
>
>
> Bruce Richardson (11):
>   app/test: make parameters clearer when adding fast tests
>   app/test: fix undefined behaviour in red autotest
>   app/test: reduce duration of secondary timer test
>   app/test: fix timer loop hang on secondary process failure
>   eal: add internal APIs to query loaded driver paths
>   app/test: pass loaded driver info to secondary procs
>   app/test: skip power capabilities test if unsupported
>   app/test: add some unattached tests to fast-test suite
>   app/test: add tests to driver test suite
>   buildtools/get-test-suites: suppress empty output
>   app/test: move red autotest to attic
>
>  app/test/process.h                     | 28 ++++++++++++-
>  app/test/suites/meson.build            | 14 ++++++-
>  app/test/test.h                        | 13 ++++++-
>  app/test/test_acl.c                    |  2 +-
>  app/test/test_alarm.c                  |  2 +-
>  app/test/test_argparse.c               |  2 +-
>  app/test/test_atomic.c                 |  2 +-
>  app/test/test_bitcount.c               |  2 +-
>  app/test/test_bitmap.c                 |  2 +-
>  app/test/test_bitops.c                 |  2 +-
>  app/test/test_bitratestats.c           |  2 +-
>  app/test/test_bitset.c                 |  2 +-
>  app/test/test_bpf.c                    |  6 +--
>  app/test/test_byteorder.c              |  2 +-
>  app/test/test_cfgfile.c                |  2 +-
>  app/test/test_cksum.c                  |  2 +-
>  app/test/test_cmdline.c                |  2 +-
>  app/test/test_common.c                 |  2 +-
>  app/test/test_compressdev.c            |  2 +-
>  app/test/test_cpuflags.c               |  2 +-
>  app/test/test_crc.c                    |  2 +-
>  app/test/test_cryptodev_crosscheck.c   |  2 +-
>  app/test/test_cycles.c                 |  2 +-
>  app/test/test_debug.c                  |  2 +-
>  app/test/test_devargs.c                |  2 +-
>  app/test/test_dispatcher.c             |  2 +-
>  app/test/test_distributor.c            |  2 +-
>  app/test/test_eal_flags.c              | 24 ++++++------
>  app/test/test_eal_fs.c                 |  2 +-
>  app/test/test_errno.c                  |  2 +-
>  app/test/test_ethdev_api.c             |  2 +-
>  app/test/test_ethdev_link.c            |  2 +-
>  app/test/test_event_crypto_adapter.c   |  2 +-
>  app/test/test_event_eth_rx_adapter.c   |  4 +-
>  app/test/test_event_eth_tx_adapter.c   |  2 +-
>  app/test/test_event_ring.c             |  2 +-
>  app/test/test_event_timer_adapter.c    |  2 +-
>  app/test/test_event_vector_adapter.c   |  2 +-
>  app/test/test_eventdev.c               |  4 +-
>  app/test/test_external_mem.c           |  2 +-
>  app/test/test_fbarray.c                |  2 +-
>  app/test/test_fib.c                    |  2 +-
>  app/test/test_fib6.c                   |  2 +-
>  app/test/test_func_reentrancy.c        |  2 +-
>  app/test/test_graph.c                  |  4 +-
>  app/test/test_graph_feature_arc.c      |  2 +-
>  app/test/test_hash.c                   |  2 +-
>  app/test/test_hash_readwrite.c         |  2 +-
>  app/test/test_interrupts.c             |  2 +-
>  app/test/test_ipfrag.c                 |  2 +-
>  app/test/test_ipsec.c                  |  2 +-
>  app/test/test_ipsec_sad.c              |  2 +-
>  app/test/test_kvargs.c                 |  2 +-
>  app/test/test_latencystats.c           |  2 +-
>  app/test/test_lcore_var.c              |  2 +-
>  app/test/test_lcores.c                 |  2 +-
>  app/test/test_logs.c                   |  2 +-
>  app/test/test_lpm.c                    |  2 +-
>  app/test/test_lpm6.c                   |  2 +-
>  app/test/test_malloc.c                 |  2 +-
>  app/test/test_mbuf.c                   |  2 +-
>  app/test/test_mcslock.c                |  2 +-
>  app/test/test_member.c                 |  2 +-
>  app/test/test_memcpy.c                 |  2 +-
>  app/test/test_memory.c                 |  2 +-
>  app/test/test_mempool.c                |  2 +-
>  app/test/test_memzone.c                |  2 +-
>  app/test/test_meter.c                  |  2 +-
>  app/test/test_metrics.c                |  2 +-
>  app/test/test_mp_secondary.c           |  2 +-
>  app/test/test_net_ether.c              |  2 +-
>  app/test/test_net_ip6.c                |  2 +-
>  app/test/test_pcapng.c                 |  2 +-
>  app/test/test_pdcp.c                   |  2 +-
>  app/test/test_pdump.c                  |  2 +-
>  app/test/test_per_lcore.c              |  2 +-
>  app/test/test_pflock.c                 |  2 +-
>  app/test/test_pie.c                    |  2 +-
>  app/test/test_pmd_ring.c               |  2 +-
>  app/test/test_pmu.c                    |  2 +-
>  app/test/test_power.c                  |  2 +-
>  app/test/test_power_cpufreq.c          |  6 +--
>  app/test/test_power_intel_uncore.c     |  2 +-
>  app/test/test_power_kvm_vm.c           |  2 +-
>  app/test/test_prefetch.c               |  2 +-
>  app/test/test_ptr_compress.c           |  2 +-
>  app/test/test_rawdev.c                 |  2 +-
>  app/test/test_rcu_qsbr.c               |  2 +-
>  app/test/test_red.c                    |  2 +-
>  app/test/test_reorder.c                |  2 +-
>  app/test/test_rib.c                    |  2 +-
>  app/test/test_rib6.c                   |  2 +-
>  app/test/test_ring.c                   |  2 +-
>  app/test/test_rwlock.c                 |  8 ++--
>  app/test/test_sched.c                  |  2 +-
>  app/test/test_security.c               |  2 +-
>  app/test/test_security_inline_macsec.c |  2 +-
>  app/test/test_security_inline_proto.c  |  6 +--
>  app/test/test_seqlock.c                |  2 +-
>  app/test/test_service_cores.c          |  2 +-
>  app/test/test_soring.c                 |  2 +-
>  app/test/test_spinlock.c               |  2 +-
>  app/test/test_stack.c                  |  4 +-
>  app/test/test_string_fns.c             |  2 +-
>  app/test/test_table.c                  |  2 +-
>  app/test/test_tailq.c                  |  2 +-
>  app/test/test_telemetry_data.c         |  2 +-
>  app/test/test_telemetry_json.c         |  2 +-
>  app/test/test_thash.c                  |  2 +-
>  app/test/test_threads.c                |  2 +-
>  app/test/test_ticketlock.c             |  2 +-
>  app/test/test_timer.c                  |  2 +-
>  app/test/test_timer_secondary.c        | 13 ++++---
>  app/test/test_trace.c                  |  2 +-
>  app/test/test_vdev.c                   |  2 +-
>  app/test/test_version.c                |  2 +-
>  buildtools/get-test-suites.py          |  5 ++-
>  doc/guides/contributing/unit_test.rst  | 10 +++--
>  lib/eal/common/eal_common_options.c    | 54 ++++++++++++++++++++++++--
>  lib/eal/include/rte_eal.h              | 54 ++++++++++++++++++++++++++
>  lib/sched/rte_red.h                    |  9 ++++-
>  121 files changed, 315 insertions(+), 157 deletions(-)

Series applied, thanks.


-- 
David Marchand

