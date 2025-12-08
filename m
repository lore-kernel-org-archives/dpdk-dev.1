Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC8D3B7DE
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A889F402A0;
	Mon,  8 Dec 2025 12:52:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 270734003C
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:52:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194770; x=1796730770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cSlf5li8wG9eZgQ8fBD4nLZiCiLh5IT2Jr2T+NhA3l4=;
 b=JBu14JVK9zMGhkWET8dDeD+NCkL/ajBvw1IsRWFNQK8EnP0slhV+SWCg
 PktFClkcXPjQ5Y8bLxzkS/URHYvCTQejc7HVn1D/xbyIvhPHCO6AiCLcv
 281GK6OuUvBSAq6yl/k5Z/s9zBt5df2wJiWq0ipjBwWOrLJAZfmE4j3/B
 SiJQMU8mgqiqnNzdjdfmlnhwkUa7GrKEY/t4D420o7snuOeNv8e8FufIf
 h+dzV0dAjyTxE3Qb1pCpFlEqQaL23fjN6e2HhcXBY6lW9ggOUmA6C5LdM
 vwy03iCKT1W2AerArGr0Gwjx8Z3Uf4v2JIe+URAPDdKzbswzwAcRUOMIX Q==;
X-CSE-ConnectionGUID: hi7ALAjHQ+uZM9FgOCnWzA==
X-CSE-MsgGUID: lXVqrTijQDK97D/NBo5DqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096046"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096046"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:49 -0800
X-CSE-ConnectionGUID: QxBeB1T7TxeVE9zwu48sHw==
X-CSE-MsgGUID: rHI4ikPMSX+EekMfJGDXdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970629"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 00/11] Assign all unit tests to suites
Date: Mon,  8 Dec 2025 11:52:34 +0000
Message-ID: <20251208115245.3809624-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202154948.1757169-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
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

Categorize all unit tests into one of the test suites: generally driver
tests or fast-tests. In order to add some of the tests to fast tests,
some additional work was required, hence the additional patches in this
set. Also, make the parameters for asan and hugepages clearer in each
test's definition.

V3:
 - correct comment in patch 1
 - define "attic" suite for unstable tests and add red_autotest to it.

V2:
- rename the parameters for fast-test
- fix issues with the tests to be added to fast-tests:
  * allow loading drivers from secondary processes
  * fix undefined behaviour flagged by asan in red test
  * skip unrunnable power tests, rather than failing
- add tests to driver-test suite also
- add patch fixing output in case we have no unattached tests

Bruce Richardson (11):
  app/test: make parameters clearer when adding fast tests
  app/test: fix undefined behaviour in red autotest
  app/test: reduce duration of secondary timer test
  app/test: fix timer loop hang on secondary process failure
  eal: add internal APIs to query loaded driver paths
  app/test: pass loaded driver info to secondary procs
  app/test: skip power capabilities test if unsupported
  app/test: add some unattached tests to fast-test suite
  app/test: add tests to driver test suite
  buildtools/get-test-suites: suppress empty output
  app/test: move red autotest to attic

 app/test/process.h                     | 28 ++++++++++++-
 app/test/suites/meson.build            | 14 ++++++-
 app/test/test.h                        | 13 ++++++-
 app/test/test_acl.c                    |  2 +-
 app/test/test_alarm.c                  |  2 +-
 app/test/test_argparse.c               |  2 +-
 app/test/test_atomic.c                 |  2 +-
 app/test/test_bitcount.c               |  2 +-
 app/test/test_bitmap.c                 |  2 +-
 app/test/test_bitops.c                 |  2 +-
 app/test/test_bitratestats.c           |  2 +-
 app/test/test_bitset.c                 |  2 +-
 app/test/test_bpf.c                    |  6 +--
 app/test/test_byteorder.c              |  2 +-
 app/test/test_cfgfile.c                |  2 +-
 app/test/test_cksum.c                  |  2 +-
 app/test/test_cmdline.c                |  2 +-
 app/test/test_common.c                 |  2 +-
 app/test/test_compressdev.c            |  2 +-
 app/test/test_cpuflags.c               |  2 +-
 app/test/test_crc.c                    |  2 +-
 app/test/test_cryptodev_crosscheck.c   |  2 +-
 app/test/test_cycles.c                 |  2 +-
 app/test/test_debug.c                  |  2 +-
 app/test/test_devargs.c                |  2 +-
 app/test/test_dispatcher.c             |  2 +-
 app/test/test_distributor.c            |  2 +-
 app/test/test_eal_flags.c              | 24 ++++++------
 app/test/test_eal_fs.c                 |  2 +-
 app/test/test_errno.c                  |  2 +-
 app/test/test_ethdev_api.c             |  2 +-
 app/test/test_ethdev_link.c            |  2 +-
 app/test/test_event_crypto_adapter.c   |  2 +-
 app/test/test_event_eth_rx_adapter.c   |  4 +-
 app/test/test_event_eth_tx_adapter.c   |  2 +-
 app/test/test_event_ring.c             |  2 +-
 app/test/test_event_timer_adapter.c    |  2 +-
 app/test/test_event_vector_adapter.c   |  2 +-
 app/test/test_eventdev.c               |  4 +-
 app/test/test_external_mem.c           |  2 +-
 app/test/test_fbarray.c                |  2 +-
 app/test/test_fib.c                    |  2 +-
 app/test/test_fib6.c                   |  2 +-
 app/test/test_func_reentrancy.c        |  2 +-
 app/test/test_graph.c                  |  4 +-
 app/test/test_graph_feature_arc.c      |  2 +-
 app/test/test_hash.c                   |  2 +-
 app/test/test_hash_readwrite.c         |  2 +-
 app/test/test_interrupts.c             |  2 +-
 app/test/test_ipfrag.c                 |  2 +-
 app/test/test_ipsec.c                  |  2 +-
 app/test/test_ipsec_sad.c              |  2 +-
 app/test/test_kvargs.c                 |  2 +-
 app/test/test_latencystats.c           |  2 +-
 app/test/test_lcore_var.c              |  2 +-
 app/test/test_lcores.c                 |  2 +-
 app/test/test_logs.c                   |  2 +-
 app/test/test_lpm.c                    |  2 +-
 app/test/test_lpm6.c                   |  2 +-
 app/test/test_malloc.c                 |  2 +-
 app/test/test_mbuf.c                   |  2 +-
 app/test/test_mcslock.c                |  2 +-
 app/test/test_member.c                 |  2 +-
 app/test/test_memcpy.c                 |  2 +-
 app/test/test_memory.c                 |  2 +-
 app/test/test_mempool.c                |  2 +-
 app/test/test_memzone.c                |  2 +-
 app/test/test_meter.c                  |  2 +-
 app/test/test_metrics.c                |  2 +-
 app/test/test_mp_secondary.c           |  2 +-
 app/test/test_net_ether.c              |  2 +-
 app/test/test_net_ip6.c                |  2 +-
 app/test/test_pcapng.c                 |  2 +-
 app/test/test_pdcp.c                   |  2 +-
 app/test/test_pdump.c                  |  2 +-
 app/test/test_per_lcore.c              |  2 +-
 app/test/test_pflock.c                 |  2 +-
 app/test/test_pie.c                    |  2 +-
 app/test/test_pmd_ring.c               |  2 +-
 app/test/test_pmu.c                    |  2 +-
 app/test/test_power.c                  |  2 +-
 app/test/test_power_cpufreq.c          |  6 +--
 app/test/test_power_intel_uncore.c     |  2 +-
 app/test/test_power_kvm_vm.c           |  2 +-
 app/test/test_prefetch.c               |  2 +-
 app/test/test_ptr_compress.c           |  2 +-
 app/test/test_rawdev.c                 |  2 +-
 app/test/test_rcu_qsbr.c               |  2 +-
 app/test/test_red.c                    |  2 +-
 app/test/test_reorder.c                |  2 +-
 app/test/test_rib.c                    |  2 +-
 app/test/test_rib6.c                   |  2 +-
 app/test/test_ring.c                   |  2 +-
 app/test/test_rwlock.c                 |  8 ++--
 app/test/test_sched.c                  |  2 +-
 app/test/test_security.c               |  2 +-
 app/test/test_security_inline_macsec.c |  2 +-
 app/test/test_security_inline_proto.c  |  6 +--
 app/test/test_seqlock.c                |  2 +-
 app/test/test_service_cores.c          |  2 +-
 app/test/test_soring.c                 |  2 +-
 app/test/test_spinlock.c               |  2 +-
 app/test/test_stack.c                  |  4 +-
 app/test/test_string_fns.c             |  2 +-
 app/test/test_table.c                  |  2 +-
 app/test/test_tailq.c                  |  2 +-
 app/test/test_telemetry_data.c         |  2 +-
 app/test/test_telemetry_json.c         |  2 +-
 app/test/test_thash.c                  |  2 +-
 app/test/test_threads.c                |  2 +-
 app/test/test_ticketlock.c             |  2 +-
 app/test/test_timer.c                  |  2 +-
 app/test/test_timer_secondary.c        | 13 ++++---
 app/test/test_trace.c                  |  2 +-
 app/test/test_vdev.c                   |  2 +-
 app/test/test_version.c                |  2 +-
 buildtools/get-test-suites.py          |  5 ++-
 doc/guides/contributing/unit_test.rst  | 10 +++--
 lib/eal/common/eal_common_options.c    | 54 ++++++++++++++++++++++++--
 lib/eal/include/rte_eal.h              | 52 +++++++++++++++++++++++++
 lib/sched/rte_red.h                    |  9 ++++-
 121 files changed, 313 insertions(+), 157 deletions(-)

--
2.51.0

