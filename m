Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1087CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 15:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79DFD40268;
	Tue,  2 Dec 2025 16:50:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 14CAD400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 16:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764690631; x=1796226631;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z7TvdDULIZpSiOSVpJDNOEblJvBudFN72T7+ol1hM8M=;
 b=Dc8majoDk2kQO7k3bIJLUPdB07oIfvKLAh0lMiNfm0Zednh4B8vOfnd2
 CyKxfW4wlXbFQM0uF4FkqL0eZUfKZg7gMmfZuuTMPn2rMWyY9VHmtG+tq
 O/NxW1NAYvdk8MF9/7khvsTayT1JBihA/aA/0GpIAnT3KERBOkL6weddY
 Is8kmC2YMxlLSw8wE2yh5rTWUVswPVFY1TAyLF/fOV74vZLKvi4s/YCbh
 MS1ppvoclRwAz9DRQgutTIZlpFeVJtwEBc2qhlBeBEQDpyPi6e4ezTilj
 XVQup37ykGaQLGnfRBX59MQFXhSdCN92k6nUsrgfDxjonHhawNMuCZvA2 w==;
X-CSE-ConnectionGUID: jkbk1GaVSEW/xCaxkdhV0g==
X-CSE-MsgGUID: 7L9YqNEMRhyvSKTo9/xH2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="78008722"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="78008722"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 07:50:29 -0800
X-CSE-ConnectionGUID: VjwPZAwLSSe0rEKwevfwgA==
X-CSE-MsgGUID: bEnfAY5mTIiySC35XfsxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="194499138"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 02 Dec 2025 07:50:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/2] improve fast-tests suite
Date: Tue,  2 Dec 2025 15:49:46 +0000
Message-ID: <20251202154948.1757169-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Add some additional unattached tests to the fast-test suite to expand
its scope to all suitable tests. Also, improve readability of the test
calls by replacing the true/false options for nohuge and asan with
explicit values for NOHUGE and ASAN.

Bruce Richardson (2):
  app/test: add some unattached tests to fast-test suite
  app/test: make parameters clearer when adding fast tests

 app/test/suites/meson.build           | 14 ++++++++++++--
 app/test/test.h                       |  9 ++++++++-
 app/test/test_acl.c                   |  2 +-
 app/test/test_alarm.c                 |  2 +-
 app/test/test_argparse.c              |  2 +-
 app/test/test_atomic.c                |  2 +-
 app/test/test_bitcount.c              |  2 +-
 app/test/test_bitmap.c                |  2 +-
 app/test/test_bitops.c                |  2 +-
 app/test/test_bitratestats.c          |  2 +-
 app/test/test_bitset.c                |  2 +-
 app/test/test_bpf.c                   |  6 +++---
 app/test/test_byteorder.c             |  2 +-
 app/test/test_cfgfile.c               |  2 +-
 app/test/test_cksum.c                 |  2 +-
 app/test/test_cmdline.c               |  2 +-
 app/test/test_common.c                |  2 +-
 app/test/test_compressdev.c           |  2 +-
 app/test/test_cpuflags.c              |  2 +-
 app/test/test_crc.c                   |  2 +-
 app/test/test_cycles.c                |  2 +-
 app/test/test_debug.c                 |  2 +-
 app/test/test_devargs.c               |  2 +-
 app/test/test_dispatcher.c            |  2 +-
 app/test/test_distributor.c           |  2 +-
 app/test/test_eal_flags.c             | 24 ++++++++++++------------
 app/test/test_eal_fs.c                |  2 +-
 app/test/test_errno.c                 |  2 +-
 app/test/test_ethdev_link.c           |  2 +-
 app/test/test_event_crypto_adapter.c  |  2 +-
 app/test/test_event_eth_tx_adapter.c  |  2 +-
 app/test/test_event_ring.c            |  2 +-
 app/test/test_event_vector_adapter.c  |  2 +-
 app/test/test_eventdev.c              |  4 ++--
 app/test/test_external_mem.c          |  2 +-
 app/test/test_fbarray.c               |  2 +-
 app/test/test_fib.c                   |  2 +-
 app/test/test_fib6.c                  |  2 +-
 app/test/test_func_reentrancy.c       |  2 +-
 app/test/test_graph.c                 |  4 ++--
 app/test/test_graph_feature_arc.c     |  2 +-
 app/test/test_hash.c                  |  2 +-
 app/test/test_hash_readwrite.c        |  2 +-
 app/test/test_interrupts.c            |  2 +-
 app/test/test_ipfrag.c                |  2 +-
 app/test/test_ipsec.c                 |  2 +-
 app/test/test_ipsec_sad.c             |  2 +-
 app/test/test_kvargs.c                |  2 +-
 app/test/test_latencystats.c          |  2 +-
 app/test/test_lcore_var.c             |  2 +-
 app/test/test_lcores.c                |  2 +-
 app/test/test_logs.c                  |  2 +-
 app/test/test_lpm.c                   |  2 +-
 app/test/test_lpm6.c                  |  2 +-
 app/test/test_malloc.c                |  2 +-
 app/test/test_mbuf.c                  |  2 +-
 app/test/test_mcslock.c               |  2 +-
 app/test/test_member.c                |  2 +-
 app/test/test_memcpy.c                |  2 +-
 app/test/test_memory.c                |  2 +-
 app/test/test_mempool.c               |  2 +-
 app/test/test_memzone.c               |  2 +-
 app/test/test_meter.c                 |  2 +-
 app/test/test_metrics.c               |  2 +-
 app/test/test_mp_secondary.c          |  2 +-
 app/test/test_net_ether.c             |  2 +-
 app/test/test_net_ip6.c               |  2 +-
 app/test/test_pcapng.c                |  2 +-
 app/test/test_pdcp.c                  |  2 +-
 app/test/test_pdump.c                 |  2 +-
 app/test/test_per_lcore.c             |  2 +-
 app/test/test_pflock.c                |  2 +-
 app/test/test_pie.c                   |  2 +-
 app/test/test_pmd_ring.c              |  2 +-
 app/test/test_pmu.c                   |  2 +-
 app/test/test_power.c                 |  2 +-
 app/test/test_power_cpufreq.c         |  2 +-
 app/test/test_power_intel_uncore.c    |  2 +-
 app/test/test_power_kvm_vm.c          |  2 +-
 app/test/test_prefetch.c              |  2 +-
 app/test/test_ptr_compress.c          |  2 +-
 app/test/test_rawdev.c                |  2 +-
 app/test/test_rcu_qsbr.c              |  2 +-
 app/test/test_red.c                   |  2 +-
 app/test/test_reorder.c               |  2 +-
 app/test/test_rib.c                   |  2 +-
 app/test/test_rib6.c                  |  2 +-
 app/test/test_ring.c                  |  2 +-
 app/test/test_rwlock.c                |  8 ++++----
 app/test/test_sched.c                 |  2 +-
 app/test/test_security.c              |  2 +-
 app/test/test_seqlock.c               |  2 +-
 app/test/test_service_cores.c         |  2 +-
 app/test/test_soring.c                |  2 +-
 app/test/test_spinlock.c              |  2 +-
 app/test/test_stack.c                 |  4 ++--
 app/test/test_string_fns.c            |  2 +-
 app/test/test_table.c                 |  2 +-
 app/test/test_tailq.c                 |  2 +-
 app/test/test_telemetry_data.c        |  2 +-
 app/test/test_telemetry_json.c        |  2 +-
 app/test/test_thash.c                 |  2 +-
 app/test/test_threads.c               |  2 +-
 app/test/test_ticketlock.c            |  2 +-
 app/test/test_timer.c                 |  2 +-
 app/test/test_timer_secondary.c       |  2 +-
 app/test/test_trace.c                 |  2 +-
 app/test/test_vdev.c                  |  2 +-
 app/test/test_version.c               |  2 +-
 buildtools/get-test-suites.py         |  2 +-
 doc/guides/contributing/unit_test.rst | 10 ++++++----
 111 files changed, 153 insertions(+), 134 deletions(-)

--
2.51.0

