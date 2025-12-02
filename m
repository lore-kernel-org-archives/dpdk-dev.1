Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC72D116F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 15:50:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18EA940647;
	Tue,  2 Dec 2025 16:50:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4912D400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 16:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764690633; x=1796226633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QpDuWOdhXhCVdzT3h+XcvcdCIScuOCyULFVgrG//UAo=;
 b=X03AjaWHV9aoD306bYqimBb1S2i5RCb/259n567if9FiFD+FFhuMzCv6
 T6wWjvGAjqKRS0CQAWUd/YBOUzdtm4DBee4SqffQHwLqR7e+8AMbM29et
 nhjjTQILT0U/q8/fidjiG2YEsRcIm/1jmbEuSMcn1ZcFCwipXh0uG1Fod
 oculEil9QXF6xRrZeXMop0QLSNRsGQXlEQySbZwylcAWmtKObqWlK0KIE
 lOYPn2Hk3i6fHnkm2pgIQ3I/0XsGAZI3Ce20lFSxJm6KJScu0qRhqshse
 6nhtyQvtzHRobHBWarF58AyJb+VGU08io/t6XUmKMyIn2u6/P+pcMEQu+ Q==;
X-CSE-ConnectionGUID: oD2egv/LT420ZcaZNPLLdw==
X-CSE-MsgGUID: /QciutngQOiuloBtpyZAkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="78008728"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="78008728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 07:50:31 -0800
X-CSE-ConnectionGUID: U/3ktnlDRZ61VQneAmP7kA==
X-CSE-MsgGUID: j52ua8rjRki7HB7VNEAzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="194499156"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 02 Dec 2025 07:50:31 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/2] app/test: make parameters clearer when adding fast tests
Date: Tue,  2 Dec 2025 15:49:48 +0000
Message-ID: <20251202154948.1757169-3-bruce.richardson@intel.com>
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

For the fast tests, we have two extra parameters specifying when the
test can be run without hugepages or using ASan. The true/false nature
of these parameters is not very clear, so change things so that they are
explicitly specified as NOHUGE/HUGEPAGES and NOASAN/ASAN instead.
Explicitly validate the options in the meson.build files, rather than
just checking for one of the pair of options - which can hide errors.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
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

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 712dd65568..bbdb739df8 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -67,9 +67,19 @@ foreach suite:test_suites
         # special fast-test handling here
         foreach t: suite_tests
             params = t.split(':')
+            # check for valid options for asan and nohuge. Note, the extraction script runs tolower()
+            if params[1] != 'NOHUGE' and params[1] != 'HUGEPAGES'
+                error('Invalid parameter "@0@" for test "@1@". Must be NOHUGE or HUGEPAGES.'
+                    .format(params[1], params[0]))
+            endif
+            if params[2] != 'ASAN' and params[2] != 'NOASAN'
+                error('Invalid parameter "@0@" for test "@1@". Must be ASAN or NOASAN.'
+                    .format(params[2], params[0]))
+            endif
+
             test_name = params[0]
-            nohuge = params[1] == 'true'
-            asan = params[2] == 'true'
+            nohuge = params[1] == 'NOHUGE'
+            asan = params[2] == 'ASAN'
 
             test_args = []
             if nohuge
diff --git a/app/test/test.h b/app/test/test.h
index c6d7d23313..571d5ba1bd 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -207,9 +207,16 @@ void add_test_command(struct test_command *t);
 /* Register a test function as a particular type.
  * These can be used to build up test suites automatically
  */
-#define REGISTER_FAST_TEST(cmd, no_huge, ASan, func)  REGISTER_TEST_COMMAND(cmd, func)
 #define REGISTER_PERF_TEST REGISTER_TEST_COMMAND
 #define REGISTER_DRIVER_TEST REGISTER_TEST_COMMAND
 #define REGISTER_STRESS_TEST REGISTER_TEST_COMMAND
 
+/* fast tests are a bit special. They can be specified as supporting running without
+ * hugepages and/or under ASan.
+ * - The "no_huge" options should be passed as either "NOHUGE" or "HUGEPAGES"
+ * - The "ASan" options should be passed as either "ASAN" or "NOASAN"
+ */
+#define REGISTER_FAST_TEST(cmd, no_huge, ASan, func)  REGISTER_TEST_COMMAND(cmd, func)
+
+
 #endif
diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 43d13b5b0f..3dbca291f7 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1748,4 +1748,4 @@ test_acl(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(acl_autotest, true, true, test_acl);
+REGISTER_FAST_TEST(acl_autotest, NOHUGE, ASAN, test_acl);
diff --git a/app/test/test_alarm.c b/app/test/test_alarm.c
index 6445f713fe..3eed278bbf 100644
--- a/app/test/test_alarm.c
+++ b/app/test/test_alarm.c
@@ -76,4 +76,4 @@ test_alarm(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(alarm_autotest, true, true, test_alarm);
+REGISTER_FAST_TEST(alarm_autotest, NOHUGE, ASAN, test_alarm);
diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index d3b95c4e35..ff8452d9b3 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -1618,4 +1618,4 @@ test_argparse(void)
 	return unit_test_suite_runner(&argparse_test_suite);
 }
 
-REGISTER_FAST_TEST(argparse_autotest, true, true, test_argparse);
+REGISTER_FAST_TEST(argparse_autotest, NOHUGE, ASAN, test_argparse);
diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 3f26ce88d9..a7f5d3fa34 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -632,5 +632,5 @@ test_atomic(void)
 
 	return 0;
 }
-REGISTER_FAST_TEST(atomic_autotest, false, true, test_atomic);
+REGISTER_FAST_TEST(atomic_autotest, HUGEPAGES, ASAN, test_atomic);
 #endif /* RTE_TOOLCHAIN_MSVC */
diff --git a/app/test/test_bitcount.c b/app/test/test_bitcount.c
index 4f34d7c90f..ace4b6e2f9 100644
--- a/app/test/test_bitcount.c
+++ b/app/test/test_bitcount.c
@@ -171,4 +171,4 @@ test_bitcount(void)
 	return unit_test_suite_runner(&bitcount_test_suite);
 }
 
-REGISTER_FAST_TEST(bitcount_autotest, true, true, test_bitcount);
+REGISTER_FAST_TEST(bitcount_autotest, NOHUGE, ASAN, test_bitcount);
diff --git a/app/test/test_bitmap.c b/app/test/test_bitmap.c
index bab11812c7..a85fba52b0 100644
--- a/app/test/test_bitmap.c
+++ b/app/test/test_bitmap.c
@@ -269,4 +269,4 @@ test_bitmap(void)
 	return test_bitmap_all_set();
 }
 
-REGISTER_FAST_TEST(bitmap_autotest, true, true, test_bitmap);
+REGISTER_FAST_TEST(bitmap_autotest, NOHUGE, ASAN, test_bitmap);
diff --git a/app/test/test_bitops.c b/app/test/test_bitops.c
index 78a7df6bb1..fbb7612030 100644
--- a/app/test/test_bitops.c
+++ b/app/test/test_bitops.c
@@ -438,4 +438,4 @@ test_bitops(void)
 	return unit_test_suite_runner(&test_suite);
 }
 
-REGISTER_FAST_TEST(bitops_autotest, true, true, test_bitops);
+REGISTER_FAST_TEST(bitops_autotest, NOHUGE, ASAN, test_bitops);
diff --git a/app/test/test_bitratestats.c b/app/test/test_bitratestats.c
index 926133de58..bab4e4acbe 100644
--- a/app/test/test_bitratestats.c
+++ b/app/test/test_bitratestats.c
@@ -249,4 +249,4 @@ test_bitratestats(void)
 {
 	return unit_test_suite_runner(&bitratestats_testsuite);
 }
-REGISTER_FAST_TEST(bitratestats_autotest, true, true, test_bitratestats);
+REGISTER_FAST_TEST(bitratestats_autotest, NOHUGE, ASAN, test_bitratestats);
diff --git a/app/test/test_bitset.c b/app/test/test_bitset.c
index 88b2d8bab0..320faae5ab 100644
--- a/app/test/test_bitset.c
+++ b/app/test/test_bitset.c
@@ -909,4 +909,4 @@ test_bitset(void)
 	return unit_test_suite_runner(&bitset_tests);
 }
 
-REGISTER_FAST_TEST(bitset_autotest, true, true, test_bitset);
+REGISTER_FAST_TEST(bitset_autotest, NOHUGE, ASAN, test_bitset);
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index b7c94ba1c7..615798fed0 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3278,7 +3278,7 @@ test_bpf(void)
 
 #endif /* !RTE_LIB_BPF */
 
-REGISTER_FAST_TEST(bpf_autotest, true, true, test_bpf);
+REGISTER_FAST_TEST(bpf_autotest, NOHUGE, ASAN, test_bpf);
 
 #ifdef TEST_BPF_ELF_LOAD
 
@@ -3751,7 +3751,7 @@ test_bpf_elf(void)
 
 #endif /* !TEST_BPF_ELF_LOAD */
 
-REGISTER_FAST_TEST(bpf_elf_autotest, true, true, test_bpf_elf);
+REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE, ASAN, test_bpf_elf);
 
 #ifndef RTE_HAS_LIBPCAP
 
@@ -3969,4 +3969,4 @@ test_bpf_convert(void)
 
 #endif /* RTE_HAS_LIBPCAP */
 
-REGISTER_FAST_TEST(bpf_convert_autotest, true, true, test_bpf_convert);
+REGISTER_FAST_TEST(bpf_convert_autotest, NOHUGE, ASAN, test_bpf_convert);
diff --git a/app/test/test_byteorder.c b/app/test/test_byteorder.c
index 67ca7ebbc8..6ffa6d4c55 100644
--- a/app/test/test_byteorder.c
+++ b/app/test/test_byteorder.c
@@ -63,4 +63,4 @@ test_byteorder(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(byteorder_autotest, true, true, test_byteorder);
+REGISTER_FAST_TEST(byteorder_autotest, NOHUGE, ASAN, test_byteorder);
diff --git a/app/test/test_cfgfile.c b/app/test/test_cfgfile.c
index b189d9d7a5..a0fe6034e9 100644
--- a/app/test/test_cfgfile.c
+++ b/app/test/test_cfgfile.c
@@ -399,4 +399,4 @@ test_cfgfile(void)
 	return unit_test_suite_runner(&test_cfgfile_suite);
 }
 
-REGISTER_FAST_TEST(cfgfile_autotest, true, true, test_cfgfile);
+REGISTER_FAST_TEST(cfgfile_autotest, NOHUGE, ASAN, test_cfgfile);
diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
index f2ab5af5a7..e77c0694a7 100644
--- a/app/test/test_cksum.c
+++ b/app/test/test_cksum.c
@@ -267,4 +267,4 @@ test_cksum(void)
 }
 #undef GOTO_FAIL
 
-REGISTER_FAST_TEST(cksum_autotest, true, true, test_cksum);
+REGISTER_FAST_TEST(cksum_autotest, NOHUGE, ASAN, test_cksum);
diff --git a/app/test/test_cmdline.c b/app/test/test_cmdline.c
index 1d8020995c..604bef088a 100644
--- a/app/test/test_cmdline.c
+++ b/app/test/test_cmdline.c
@@ -60,4 +60,4 @@ test_cmdline(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(cmdline_autotest, true, true, test_cmdline);
+REGISTER_FAST_TEST(cmdline_autotest, NOHUGE, ASAN, test_cmdline);
diff --git a/app/test/test_common.c b/app/test/test_common.c
index 6dbd7fc9a9..8f7f791444 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -354,4 +354,4 @@ test_common(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(common_autotest, true, true, test_common);
+REGISTER_FAST_TEST(common_autotest, NOHUGE, ASAN, test_common);
diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index dcea8e2f30..c4a4c59883 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -4255,4 +4255,4 @@ test_compressdev(void)
 	return unit_test_suite_runner(&compressdev_testsuite);
 }
 
-REGISTER_FAST_TEST(compressdev_autotest, false, true, test_compressdev);
+REGISTER_FAST_TEST(compressdev_autotest, HUGEPAGES, ASAN, test_compressdev);
diff --git a/app/test/test_cpuflags.c b/app/test/test_cpuflags.c
index 22ab4dff0a..44fcb03c84 100644
--- a/app/test/test_cpuflags.c
+++ b/app/test/test_cpuflags.c
@@ -327,4 +327,4 @@ test_cpuflags(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(cpuflags_autotest, true, true, test_cpuflags);
+REGISTER_FAST_TEST(cpuflags_autotest, NOHUGE, ASAN, test_cpuflags);
diff --git a/app/test/test_crc.c b/app/test/test_crc.c
index f18eff7217..7cc16e6a18 100644
--- a/app/test/test_crc.c
+++ b/app/test/test_crc.c
@@ -140,4 +140,4 @@ crc_autotest(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(crc_autotest, true, true, crc_autotest);
+REGISTER_FAST_TEST(crc_autotest, NOHUGE, ASAN, crc_autotest);
diff --git a/app/test/test_cycles.c b/app/test/test_cycles.c
index a7654de176..ed2315a6de 100644
--- a/app/test/test_cycles.c
+++ b/app/test/test_cycles.c
@@ -53,4 +53,4 @@ test_user_delay_us(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(user_delay_us, true, true, test_user_delay_us);
+REGISTER_FAST_TEST(user_delay_us, NOHUGE, ASAN, test_user_delay_us);
diff --git a/app/test/test_debug.c b/app/test/test_debug.c
index 5ff9068e2b..d460f9cd56 100644
--- a/app/test/test_debug.c
+++ b/app/test/test_debug.c
@@ -183,4 +183,4 @@ test_debug(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(debug_autotest, true, true, test_debug);
+REGISTER_FAST_TEST(debug_autotest, NOHUGE, ASAN, test_debug);
diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
index 4166b2bea2..0476039924 100644
--- a/app/test/test_devargs.c
+++ b/app/test/test_devargs.c
@@ -320,4 +320,4 @@ test_devargs(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(devargs_autotest, true, true, test_devargs);
+REGISTER_FAST_TEST(devargs_autotest, NOHUGE, ASAN, test_devargs);
diff --git a/app/test/test_dispatcher.c b/app/test/test_dispatcher.c
index 6eb3f572cf..6f9e1f663f 100644
--- a/app/test/test_dispatcher.c
+++ b/app/test/test_dispatcher.c
@@ -1053,4 +1053,4 @@ test_dispatcher(void)
 	return unit_test_suite_runner(&test_suite);
 }
 
-REGISTER_FAST_TEST(dispatcher_autotest, false, true, test_dispatcher);
+REGISTER_FAST_TEST(dispatcher_autotest, HUGEPAGES, ASAN, test_dispatcher);
diff --git a/app/test/test_distributor.c b/app/test/test_distributor.c
index 60fe96ea82..44e9ce17df 100644
--- a/app/test/test_distributor.c
+++ b/app/test/test_distributor.c
@@ -953,4 +953,4 @@ test_distributor(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(distributor_autotest, false, true, test_distributor);
+REGISTER_FAST_TEST(distributor_autotest, HUGEPAGES, ASAN, test_distributor);
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..f958a4c354 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -1692,15 +1692,15 @@ test_memory_flags(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(eal_flags_c_opt_autotest, false, false, test_missing_c_flag);
-REGISTER_FAST_TEST(eal_flags_main_opt_autotest, false, false, test_main_lcore_flag);
-REGISTER_FAST_TEST(eal_flags_n_opt_autotest, false, false, test_invalid_n_flag);
-REGISTER_FAST_TEST(eal_flags_hpet_autotest, false, false, test_no_hpet_flag);
-REGISTER_FAST_TEST(eal_flags_no_huge_autotest, false, false, test_no_huge_flag);
-REGISTER_FAST_TEST(eal_flags_a_opt_autotest, false, false, test_allow_flag);
-REGISTER_FAST_TEST(eal_flags_b_opt_autotest, false, false, test_invalid_b_flag);
-REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, false, false, test_invalid_vdev_flag);
-REGISTER_FAST_TEST(eal_flags_r_opt_autotest, false, false, test_invalid_r_flag);
-REGISTER_FAST_TEST(eal_flags_mem_autotest, false, false, test_memory_flags);
-REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, false, false, test_file_prefix);
-REGISTER_FAST_TEST(eal_flags_misc_autotest, false, false, test_misc_flags);
+REGISTER_FAST_TEST(eal_flags_c_opt_autotest, HUGEPAGES, NOASAN, test_missing_c_flag);
+REGISTER_FAST_TEST(eal_flags_main_opt_autotest, HUGEPAGES, NOASAN, test_main_lcore_flag);
+REGISTER_FAST_TEST(eal_flags_n_opt_autotest, HUGEPAGES, NOASAN, test_invalid_n_flag);
+REGISTER_FAST_TEST(eal_flags_hpet_autotest, HUGEPAGES, NOASAN, test_no_hpet_flag);
+REGISTER_FAST_TEST(eal_flags_no_huge_autotest, HUGEPAGES, NOASAN, test_no_huge_flag);
+REGISTER_FAST_TEST(eal_flags_a_opt_autotest, HUGEPAGES, NOASAN, test_allow_flag);
+REGISTER_FAST_TEST(eal_flags_b_opt_autotest, HUGEPAGES, NOASAN, test_invalid_b_flag);
+REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, HUGEPAGES, NOASAN, test_invalid_vdev_flag);
+REGISTER_FAST_TEST(eal_flags_r_opt_autotest, HUGEPAGES, NOASAN, test_invalid_r_flag);
+REGISTER_FAST_TEST(eal_flags_mem_autotest, HUGEPAGES, NOASAN, test_memory_flags);
+REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, HUGEPAGES, NOASAN, test_file_prefix);
+REGISTER_FAST_TEST(eal_flags_misc_autotest, HUGEPAGES, NOASAN, test_misc_flags);
diff --git a/app/test/test_eal_fs.c b/app/test/test_eal_fs.c
index 8cd287fa9d..ff9eabc198 100644
--- a/app/test/test_eal_fs.c
+++ b/app/test/test_eal_fs.c
@@ -185,4 +185,4 @@ test_eal_fs(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(eal_fs_autotest, true, true, test_eal_fs);
+REGISTER_FAST_TEST(eal_fs_autotest, NOHUGE, ASAN, test_eal_fs);
diff --git a/app/test/test_errno.c b/app/test/test_errno.c
index b429962fb9..2468208199 100644
--- a/app/test/test_errno.c
+++ b/app/test/test_errno.c
@@ -94,4 +94,4 @@ test_errno(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(errno_autotest, true, true, test_errno);
+REGISTER_FAST_TEST(errno_autotest, NOHUGE, ASAN, test_errno);
diff --git a/app/test/test_ethdev_link.c b/app/test/test_ethdev_link.c
index 06221f0f2f..0698a11ad8 100644
--- a/app/test/test_ethdev_link.c
+++ b/app/test/test_ethdev_link.c
@@ -172,4 +172,4 @@ test_link_status(void)
 	return unit_test_suite_runner(&link_status_testsuite);
 }
 
-REGISTER_FAST_TEST(ethdev_link_status, true, true, test_link_status);
+REGISTER_FAST_TEST(ethdev_link_status, NOHUGE, ASAN, test_link_status);
diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index 2204a521d0..80e3381953 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -1625,5 +1625,5 @@ test_event_crypto_adapter(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(event_crypto_adapter_autotest, true, true,
+REGISTER_FAST_TEST(event_crypto_adapter_autotest, NOHUGE, ASAN,
 		test_event_crypto_adapter);
diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
index 482b8e69e3..9da7b366e3 100644
--- a/app/test/test_event_eth_tx_adapter.c
+++ b/app/test/test_event_eth_tx_adapter.c
@@ -1010,4 +1010,4 @@ test_event_eth_tx_adapter_common(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(event_eth_tx_adapter_autotest, false, true, test_event_eth_tx_adapter_common);
+REGISTER_FAST_TEST(event_eth_tx_adapter_autotest, HUGEPAGES, ASAN, test_event_eth_tx_adapter_common);
diff --git a/app/test/test_event_ring.c b/app/test/test_event_ring.c
index 3bfb5109b7..08acb52673 100644
--- a/app/test/test_event_ring.c
+++ b/app/test/test_event_ring.c
@@ -256,4 +256,4 @@ test_event_ring(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(event_ring_autotest, true, true, test_event_ring);
+REGISTER_FAST_TEST(event_ring_autotest, NOHUGE, ASAN, test_event_ring);
diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
index 739352bdff..4d776296b4 100644
--- a/app/test/test_event_vector_adapter.c
+++ b/app/test/test_event_vector_adapter.c
@@ -709,5 +709,5 @@ test_event_vector_adapter(void)
 #endif
 
 /* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
+ * REGISTER_FAST_TEST(event_vector_adapter_autotest, NOHUGE, ASAN, test_event_vector_adapter);
  */
diff --git a/app/test/test_eventdev.c b/app/test/test_eventdev.c
index e97754bd47..e6be8d05b8 100644
--- a/app/test/test_eventdev.c
+++ b/app/test/test_eventdev.c
@@ -1529,10 +1529,10 @@ test_eventdev_selftest_cn20k(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(eventdev_common_autotest, true, true, test_eventdev_common);
+REGISTER_FAST_TEST(eventdev_common_autotest, NOHUGE, ASAN, test_eventdev_common);
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-REGISTER_FAST_TEST(eventdev_selftest_sw, true, true, test_eventdev_selftest_sw);
+REGISTER_FAST_TEST(eventdev_selftest_sw, NOHUGE, ASAN, test_eventdev_selftest_sw);
 REGISTER_DRIVER_TEST(eventdev_selftest_octeontx, test_eventdev_selftest_octeontx);
 REGISTER_DRIVER_TEST(eventdev_selftest_dpaa2, test_eventdev_selftest_dpaa2);
 REGISTER_DRIVER_TEST(eventdev_selftest_dlb2, test_eventdev_selftest_dlb2);
diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index ac77de1440..ea7b6d8577 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -587,4 +587,4 @@ test_external_mem(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(external_mem_autotest, false, true, test_external_mem);
+REGISTER_FAST_TEST(external_mem_autotest, HUGEPAGES, ASAN, test_external_mem);
diff --git a/app/test/test_fbarray.c b/app/test/test_fbarray.c
index 6ca509b898..b1228a9635 100644
--- a/app/test/test_fbarray.c
+++ b/app/test/test_fbarray.c
@@ -933,4 +933,4 @@ test_fbarray(void)
 	return unit_test_suite_runner(&fbarray_test_suite);
 }
 
-REGISTER_FAST_TEST(fbarray_autotest, true, true, test_fbarray);
+REGISTER_FAST_TEST(fbarray_autotest, NOHUGE, ASAN, test_fbarray);
diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index ecd3fb4297..accf904087 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -629,5 +629,5 @@ test_slow_fib(void)
 	return unit_test_suite_runner(&fib_slow_tests);
 }
 
-REGISTER_FAST_TEST(fib_autotest, true, true, test_fib);
+REGISTER_FAST_TEST(fib_autotest, NOHUGE, ASAN, test_fib);
 REGISTER_PERF_TEST(fib_slow_autotest, test_slow_fib);
diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index 843a4086c1..0c337525aa 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -640,5 +640,5 @@ test_slow_fib6(void)
 	return unit_test_suite_runner(&fib6_slow_tests);
 }
 
-REGISTER_FAST_TEST(fib6_autotest, true, true, test_fib6);
+REGISTER_FAST_TEST(fib6_autotest, NOHUGE, ASAN, test_fib6);
 REGISTER_PERF_TEST(fib6_slow_autotest, test_slow_fib6);
diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index 51e3069611..531655ca79 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -511,4 +511,4 @@ test_func_reentrancy(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(func_reentrancy_autotest, false, true, test_func_reentrancy);
+REGISTER_FAST_TEST(func_reentrancy_autotest, HUGEPAGES, ASAN, test_func_reentrancy);
diff --git a/app/test/test_graph.c b/app/test/test_graph.c
index 635b8dd527..4e063eb029 100644
--- a/app/test/test_graph.c
+++ b/app/test/test_graph.c
@@ -1150,7 +1150,7 @@ graph_autotest_fn(void)
 	return unit_test_suite_runner(&graph_testsuite);
 }
 
-REGISTER_FAST_TEST(graph_autotest, true, true, graph_autotest_fn);
+REGISTER_FAST_TEST(graph_autotest, NOHUGE, ASAN, graph_autotest_fn);
 
 static int
 test_node_list_dump(void)
@@ -1162,4 +1162,4 @@ test_node_list_dump(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(node_list_dump, true, true, test_node_list_dump);
+REGISTER_FAST_TEST(node_list_dump, NOHUGE, ASAN, test_node_list_dump);
diff --git a/app/test/test_graph_feature_arc.c b/app/test/test_graph_feature_arc.c
index 6d445e6865..0653f24948 100644
--- a/app/test/test_graph_feature_arc.c
+++ b/app/test/test_graph_feature_arc.c
@@ -1368,6 +1368,6 @@ graph_feature_arc_autotest_fn(void)
 	return unit_test_suite_runner(&graph_feature_arc_testsuite);
 }
 
-REGISTER_FAST_TEST(graph_feature_arc_autotest, true, true, graph_feature_arc_autotest_fn);
+REGISTER_FAST_TEST(graph_feature_arc_autotest, NOHUGE, ASAN, graph_feature_arc_autotest_fn);
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..6be61ee611 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -2405,4 +2405,4 @@ test_hash(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(hash_autotest, true, true, test_hash);
+REGISTER_FAST_TEST(hash_autotest, NOHUGE, ASAN, test_hash);
diff --git a/app/test/test_hash_readwrite.c b/app/test/test_hash_readwrite.c
index 4d140439e4..8d96662628 100644
--- a/app/test/test_hash_readwrite.c
+++ b/app/test/test_hash_readwrite.c
@@ -775,5 +775,5 @@ test_hash_rw_func_main(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(hash_readwrite_func_autotest, false, true, test_hash_rw_func_main);
+REGISTER_FAST_TEST(hash_readwrite_func_autotest, HUGEPAGES, ASAN, test_hash_rw_func_main);
 REGISTER_PERF_TEST(hash_readwrite_perf_autotest, test_hash_rw_perf_main);
diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 3952f9685f..a772428abe 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -594,4 +594,4 @@ test_interrupt(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(interrupt_autotest, true, true, test_interrupt);
+REGISTER_FAST_TEST(interrupt_autotest, NOHUGE, ASAN, test_interrupt);
diff --git a/app/test/test_ipfrag.c b/app/test/test_ipfrag.c
index 95d7952b4d..5a77affcb5 100644
--- a/app/test/test_ipfrag.c
+++ b/app/test/test_ipfrag.c
@@ -505,4 +505,4 @@ test_ipfrag(void)
 }
 
 
-REGISTER_FAST_TEST(ipfrag_autotest, false, true, test_ipfrag);
+REGISTER_FAST_TEST(ipfrag_autotest, HUGEPAGES, ASAN, test_ipfrag);
diff --git a/app/test/test_ipsec.c b/app/test/test_ipsec.c
index ac63c3b6d3..572d964935 100644
--- a/app/test/test_ipsec.c
+++ b/app/test/test_ipsec.c
@@ -2617,4 +2617,4 @@ test_ipsec(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(ipsec_autotest, true, true, test_ipsec);
+REGISTER_FAST_TEST(ipsec_autotest, NOHUGE, ASAN, test_ipsec);
diff --git a/app/test/test_ipsec_sad.c b/app/test/test_ipsec_sad.c
index c8dc3f0387..1290bf7ea0 100644
--- a/app/test/test_ipsec_sad.c
+++ b/app/test/test_ipsec_sad.c
@@ -899,4 +899,4 @@ test_ipsec_sad(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(ipsec_sad_autotest, true, true, test_ipsec_sad);
+REGISTER_FAST_TEST(ipsec_sad_autotest, NOHUGE, ASAN, test_ipsec_sad);
diff --git a/app/test/test_kvargs.c b/app/test/test_kvargs.c
index 43bb7a0243..fc94da1482 100644
--- a/app/test/test_kvargs.c
+++ b/app/test/test_kvargs.c
@@ -364,4 +364,4 @@ test_kvargs(void)
 	return unit_test_suite_runner(&kvargs_test_suite);
 }
 
-REGISTER_FAST_TEST(kvargs_autotest, true, true, test_kvargs);
+REGISTER_FAST_TEST(kvargs_autotest, NOHUGE, ASAN, test_kvargs);
diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index 676a99d385..4f10dcad45 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -246,4 +246,4 @@ static int test_latencystats(void)
 	return unit_test_suite_runner(&latencystats_testsuite);
 }
 
-REGISTER_FAST_TEST(latencystats_autotest, true, true, test_latencystats);
+REGISTER_FAST_TEST(latencystats_autotest, NOHUGE, ASAN, test_latencystats);
diff --git a/app/test/test_lcore_var.c b/app/test/test_lcore_var.c
index bcf785b321..9e4643ceb4 100644
--- a/app/test/test_lcore_var.c
+++ b/app/test/test_lcore_var.c
@@ -411,4 +411,4 @@ static int test_lcore_var(void)
 	return unit_test_suite_runner(&lcore_var_testsuite);
 }
 
-REGISTER_FAST_TEST(lcore_var_autotest, true, false, test_lcore_var);
+REGISTER_FAST_TEST(lcore_var_autotest, NOHUGE, NOASAN, test_lcore_var);
diff --git a/app/test/test_lcores.c b/app/test/test_lcores.c
index bd5c0dd94b..bb74088728 100644
--- a/app/test/test_lcores.c
+++ b/app/test/test_lcores.c
@@ -422,4 +422,4 @@ test_lcores(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(lcores_autotest, true, true, test_lcores);
+REGISTER_FAST_TEST(lcores_autotest, NOHUGE, ASAN, test_lcores);
diff --git a/app/test/test_logs.c b/app/test/test_logs.c
index 43b09704a3..f14efce64c 100644
--- a/app/test/test_logs.c
+++ b/app/test/test_logs.c
@@ -158,4 +158,4 @@ test_logs(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(logs_autotest, true, true, test_logs);
+REGISTER_FAST_TEST(logs_autotest, NOHUGE, ASAN, test_logs);
diff --git a/app/test/test_lpm.c b/app/test/test_lpm.c
index b93e11d700..a27c58daeb 100644
--- a/app/test/test_lpm.c
+++ b/app/test/test_lpm.c
@@ -1584,4 +1584,4 @@ test_lpm(void)
 	return global_status;
 }
 
-REGISTER_FAST_TEST(lpm_autotest, true, true, test_lpm);
+REGISTER_FAST_TEST(lpm_autotest, NOHUGE, ASAN, test_lpm);
diff --git a/app/test/test_lpm6.c b/app/test/test_lpm6.c
index b930fa3f0c..70b60c8e0d 100644
--- a/app/test/test_lpm6.c
+++ b/app/test/test_lpm6.c
@@ -1767,4 +1767,4 @@ test_lpm6(void)
 	return global_status;
 }
 
-REGISTER_FAST_TEST(lpm6_autotest, true, true, test_lpm6);
+REGISTER_FAST_TEST(lpm6_autotest, NOHUGE, ASAN, test_lpm6);
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index ce8fc5dd06..38c312f85c 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -1166,4 +1166,4 @@ test_malloc(void)
 	return unit_test_suite_runner(&test_suite);
 }
 
-REGISTER_FAST_TEST(malloc_autotest, false, true, test_malloc);
+REGISTER_FAST_TEST(malloc_autotest, HUGEPAGES, ASAN, test_malloc);
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index 17be977f31..95556c3d6f 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -2953,4 +2953,4 @@ test_mbuf(void)
 }
 #undef GOTO_FAIL
 
-REGISTER_FAST_TEST(mbuf_autotest, false, true, test_mbuf);
+REGISTER_FAST_TEST(mbuf_autotest, HUGEPAGES, ASAN, test_mbuf);
diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
index 8fcbc11a08..95ad87a79f 100644
--- a/app/test/test_mcslock.c
+++ b/app/test/test_mcslock.c
@@ -241,4 +241,4 @@ test_mcslock(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(mcslock_autotest, false, true, test_mcslock);
+REGISTER_FAST_TEST(mcslock_autotest, HUGEPAGES, ASAN, test_mcslock);
diff --git a/app/test/test_member.c b/app/test/test_member.c
index a93787a10c..8eeb733fdb 100644
--- a/app/test/test_member.c
+++ b/app/test/test_member.c
@@ -996,4 +996,4 @@ test_member(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(member_autotest, true, true, test_member);
+REGISTER_FAST_TEST(member_autotest, NOHUGE, ASAN, test_member);
diff --git a/app/test/test_memcpy.c b/app/test/test_memcpy.c
index 802dc4631b..858bd5750f 100644
--- a/app/test/test_memcpy.c
+++ b/app/test/test_memcpy.c
@@ -129,4 +129,4 @@ test_memcpy(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(memcpy_autotest, true, true, test_memcpy);
+REGISTER_FAST_TEST(memcpy_autotest, NOHUGE, ASAN, test_memcpy);
diff --git a/app/test/test_memory.c b/app/test/test_memory.c
index ea37f62338..92fdc194ad 100644
--- a/app/test/test_memory.c
+++ b/app/test/test_memory.c
@@ -110,4 +110,4 @@ test_memory(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(memory_autotest, false, true, test_memory);
+REGISTER_FAST_TEST(memory_autotest, HUGEPAGES, ASAN, test_memory);
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 63356998fd..c8d4137f4f 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -1122,4 +1122,4 @@ test_mempool(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(mempool_autotest, false, true, test_mempool);
+REGISTER_FAST_TEST(mempool_autotest, HUGEPAGES, ASAN, test_mempool);
diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 506725ea41..8e0546f9b0 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -1162,4 +1162,4 @@ test_memzone(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(memzone_autotest, false, true, test_memzone);
+REGISTER_FAST_TEST(memzone_autotest, HUGEPAGES, ASAN, test_memzone);
diff --git a/app/test/test_meter.c b/app/test/test_meter.c
index 6241b75ba0..35512bb465 100644
--- a/app/test/test_meter.c
+++ b/app/test/test_meter.c
@@ -713,4 +713,4 @@ test_meter(void)
 
 }
 
-REGISTER_FAST_TEST(meter_autotest, true, true, test_meter);
+REGISTER_FAST_TEST(meter_autotest, NOHUGE, ASAN, test_meter);
diff --git a/app/test/test_metrics.c b/app/test/test_metrics.c
index 917bee2e37..740af55300 100644
--- a/app/test/test_metrics.c
+++ b/app/test/test_metrics.c
@@ -326,4 +326,4 @@ test_metrics(void)
 	return unit_test_suite_runner(&metrics_testsuite);
 }
 
-REGISTER_FAST_TEST(metrics_autotest, true, true, test_metrics);
+REGISTER_FAST_TEST(metrics_autotest, NOHUGE, ASAN, test_metrics);
diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index 2593454b2c..ae52c67ca1 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -222,4 +222,4 @@ test_mp_secondary(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(multiprocess_autotest, false, false, test_mp_secondary);
+REGISTER_FAST_TEST(multiprocess_autotest, HUGEPAGES, NOASAN, test_mp_secondary);
diff --git a/app/test/test_net_ether.c b/app/test/test_net_ether.c
index 1cb6845a9c..f560773850 100644
--- a/app/test/test_net_ether.c
+++ b/app/test/test_net_ether.c
@@ -162,4 +162,4 @@ test_net_ether(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(net_ether_autotest, true, true, test_net_ether);
+REGISTER_FAST_TEST(net_ether_autotest, NOHUGE, ASAN, test_net_ether);
diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
index e4642c9a39..73108c6f87 100644
--- a/app/test/test_net_ip6.c
+++ b/app/test/test_net_ip6.c
@@ -218,4 +218,4 @@ test_net_ipv6(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(net_ipv6_autotest, true, true, test_net_ipv6);
+REGISTER_FAST_TEST(net_ipv6_autotest, NOHUGE, ASAN, test_net_ipv6);
diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index bcf99724fa..438401122b 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -464,4 +464,4 @@ test_pcapng(void)
 	return unit_test_suite_runner(&test_pcapng_suite);
 }
 
-REGISTER_FAST_TEST(pcapng_autotest, true, true, test_pcapng);
+REGISTER_FAST_TEST(pcapng_autotest, NOHUGE, ASAN, test_pcapng);
diff --git a/app/test/test_pdcp.c b/app/test/test_pdcp.c
index 0a2827f2ef..bb697d100b 100644
--- a/app/test/test_pdcp.c
+++ b/app/test/test_pdcp.c
@@ -2388,4 +2388,4 @@ test_pdcp(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(pdcp_autotest, false, true, test_pdcp);
+REGISTER_FAST_TEST(pdcp_autotest, HUGEPAGES, ASAN, test_pdcp);
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 1d3fe6e2d5..ffcefe61be 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -218,4 +218,4 @@ test_pdump(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(pdump_autotest, true, false, test_pdump);
+REGISTER_FAST_TEST(pdump_autotest, NOHUGE, NOASAN, test_pdump);
diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
index e0674b0e70..51f1d79d93 100644
--- a/app/test/test_per_lcore.c
+++ b/app/test/test_per_lcore.c
@@ -118,4 +118,4 @@ test_per_lcore(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(per_lcore_autotest, true, true, test_per_lcore);
+REGISTER_FAST_TEST(per_lcore_autotest, NOHUGE, ASAN, test_per_lcore);
diff --git a/app/test/test_pflock.c b/app/test/test_pflock.c
index 162049201f..19196dc381 100644
--- a/app/test/test_pflock.c
+++ b/app/test/test_pflock.c
@@ -194,4 +194,4 @@ test_pflock(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(pflock_autotest, true, true, test_pflock);
+REGISTER_FAST_TEST(pflock_autotest, NOHUGE, ASAN, test_pflock);
diff --git a/app/test/test_pie.c b/app/test/test_pie.c
index 72ef3869d0..b5976ca8f3 100644
--- a/app/test/test_pie.c
+++ b/app/test/test_pie.c
@@ -1082,6 +1082,6 @@ test_pie_all(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(pie_autotest, true, true, test_pie);
+REGISTER_FAST_TEST(pie_autotest, NOHUGE, ASAN, test_pie);
 REGISTER_PERF_TEST(pie_perf, test_pie_perf);
 REGISTER_PERF_TEST(pie_all, test_pie_all);
diff --git a/app/test/test_pmd_ring.c b/app/test/test_pmd_ring.c
index e83b9dd6b8..5cdda56318 100644
--- a/app/test/test_pmd_ring.c
+++ b/app/test/test_pmd_ring.c
@@ -593,4 +593,4 @@ test_pmd_ring(void)
 	return unit_test_suite_runner(&test_pmd_ring_suite);
 }
 
-REGISTER_FAST_TEST(ring_pmd_autotest, true, true, test_pmd_ring);
+REGISTER_FAST_TEST(ring_pmd_autotest, NOHUGE, ASAN, test_pmd_ring);
diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 10513bf9c9..7fea677e7b 100644
--- a/app/test/test_pmu.c
+++ b/app/test/test_pmu.c
@@ -53,5 +53,5 @@ test_pmu(void)
 }
 
 /* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
+ * REGISTER_FAST_TEST(pmu_autotest, NOHUGE, ASAN, test_pmu);
  */
diff --git a/app/test/test_power.c b/app/test/test_power.c
index 38507411bd..bc4837b68e 100644
--- a/app/test/test_power.c
+++ b/app/test/test_power.c
@@ -78,4 +78,4 @@ test_power(void)
 }
 #endif
 
-REGISTER_FAST_TEST(power_autotest, true, true, test_power);
+REGISTER_FAST_TEST(power_autotest, NOHUGE, ASAN, test_power);
diff --git a/app/test/test_power_cpufreq.c b/app/test/test_power_cpufreq.c
index 0331b37fe0..74993f41ff 100644
--- a/app/test/test_power_cpufreq.c
+++ b/app/test/test_power_cpufreq.c
@@ -678,5 +678,5 @@ test_power_caps(void)
 
 #endif
 
-REGISTER_FAST_TEST(power_cpufreq_autotest, false, true, test_power_cpufreq);
+REGISTER_FAST_TEST(power_cpufreq_autotest, HUGEPAGES, ASAN, test_power_cpufreq);
 REGISTER_TEST_COMMAND(power_caps_autotest, test_power_caps);
diff --git a/app/test/test_power_intel_uncore.c b/app/test/test_power_intel_uncore.c
index 973dc7a945..ff69176372 100644
--- a/app/test/test_power_intel_uncore.c
+++ b/app/test/test_power_intel_uncore.c
@@ -303,4 +303,4 @@ test_power_intel_uncore(void)
 }
 #endif
 
-REGISTER_FAST_TEST(power_intel_uncore_autotest, true, true, test_power_intel_uncore);
+REGISTER_FAST_TEST(power_intel_uncore_autotest, NOHUGE, ASAN, test_power_intel_uncore);
diff --git a/app/test/test_power_kvm_vm.c b/app/test/test_power_kvm_vm.c
index 1c72ba5a4e..21fa992478 100644
--- a/app/test/test_power_kvm_vm.c
+++ b/app/test/test_power_kvm_vm.c
@@ -263,4 +263,4 @@ test_power_kvm_vm(void)
 }
 #endif
 
-REGISTER_FAST_TEST(power_kvm_vm_autotest, false, true, test_power_kvm_vm);
+REGISTER_FAST_TEST(power_kvm_vm_autotest, HUGEPAGES, ASAN, test_power_kvm_vm);
diff --git a/app/test/test_prefetch.c b/app/test/test_prefetch.c
index 46e6828e6a..52d7a22314 100644
--- a/app/test/test_prefetch.c
+++ b/app/test/test_prefetch.c
@@ -35,4 +35,4 @@ test_prefetch(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(prefetch_autotest, true, true, test_prefetch);
+REGISTER_FAST_TEST(prefetch_autotest, NOHUGE, ASAN, test_prefetch);
diff --git a/app/test/test_ptr_compress.c b/app/test/test_ptr_compress.c
index 807b19eaf6..ab21dce525 100644
--- a/app/test/test_ptr_compress.c
+++ b/app/test/test_ptr_compress.c
@@ -190,4 +190,4 @@ test_ptr_compress(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(ptr_compress_autotest, true, true, test_ptr_compress);
+REGISTER_FAST_TEST(ptr_compress_autotest, NOHUGE, ASAN, test_ptr_compress);
diff --git a/app/test/test_rawdev.c b/app/test/test_rawdev.c
index d1d250c9ac..d2b6343a72 100644
--- a/app/test/test_rawdev.c
+++ b/app/test/test_rawdev.c
@@ -74,4 +74,4 @@ test_rawdev_selftests(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(rawdev_autotest, true, true, test_rawdev_selftests);
+REGISTER_FAST_TEST(rawdev_autotest, NOHUGE, ASAN, test_rawdev_selftests);
diff --git a/app/test/test_rcu_qsbr.c b/app/test/test_rcu_qsbr.c
index 72d8e0377e..7ef5ad47f6 100644
--- a/app/test/test_rcu_qsbr.c
+++ b/app/test/test_rcu_qsbr.c
@@ -1418,4 +1418,4 @@ test_rcu_qsbr_main(void)
 	return -1;
 }
 
-REGISTER_FAST_TEST(rcu_qsbr_autotest, true, true, test_rcu_qsbr_main);
+REGISTER_FAST_TEST(rcu_qsbr_autotest, NOHUGE, ASAN, test_rcu_qsbr_main);
diff --git a/app/test/test_red.c b/app/test/test_red.c
index aa91a53562..ef263a1e99 100644
--- a/app/test/test_red.c
+++ b/app/test/test_red.c
@@ -1872,6 +1872,6 @@ test_red_all(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(red_autotest, true, true, test_red);
+REGISTER_FAST_TEST(red_autotest, NOHUGE, ASAN, test_red);
 REGISTER_PERF_TEST(red_perf, test_red_perf);
 REGISTER_PERF_TEST(red_all, test_red_all);
diff --git a/app/test/test_reorder.c b/app/test/test_reorder.c
index aaa2c57086..85ba035a8c 100644
--- a/app/test/test_reorder.c
+++ b/app/test/test_reorder.c
@@ -552,4 +552,4 @@ test_reorder(void)
 }
 
 
-REGISTER_FAST_TEST(reorder_autotest, true, true, test_reorder);
+REGISTER_FAST_TEST(reorder_autotest, NOHUGE, ASAN, test_reorder);
diff --git a/app/test/test_rib.c b/app/test/test_rib.c
index c7454f2c47..624f897e8c 100644
--- a/app/test/test_rib.c
+++ b/app/test/test_rib.c
@@ -363,5 +363,5 @@ test_slow_rib(void)
 	return unit_test_suite_runner(&rib_slow_tests);
 }
 
-REGISTER_FAST_TEST(rib_autotest, true, true, test_rib);
+REGISTER_FAST_TEST(rib_autotest, NOHUGE, ASAN, test_rib);
 REGISTER_PERF_TEST(rib_slow_autotest, test_slow_rib);
diff --git a/app/test/test_rib6.c b/app/test/test_rib6.c
index ba54a3794e..54fb1a0d66 100644
--- a/app/test/test_rib6.c
+++ b/app/test/test_rib6.c
@@ -362,5 +362,5 @@ test_slow_rib6(void)
 	return unit_test_suite_runner(&rib6_slow_tests);
 }
 
-REGISTER_FAST_TEST(rib6_autotest, true, true, test_rib6);
+REGISTER_FAST_TEST(rib6_autotest, NOHUGE, ASAN, test_rib6);
 REGISTER_PERF_TEST(rib6_slow_autotest, test_slow_rib6);
diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index 3078348b2f..35a187229b 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -1248,4 +1248,4 @@ test_ring(void)
 	return -1;
 }
 
-REGISTER_FAST_TEST(ring_autotest, true, true, test_ring);
+REGISTER_FAST_TEST(ring_autotest, NOHUGE, ASAN, test_ring);
diff --git a/app/test/test_rwlock.c b/app/test/test_rwlock.c
index 785317621d..3acd4e6704 100644
--- a/app/test/test_rwlock.c
+++ b/app/test/test_rwlock.c
@@ -507,7 +507,7 @@ try_rwlock_test_rde_wro(void)
 	return process_try_lcore_stats();
 }
 
-REGISTER_FAST_TEST(rwlock_test1_autotest, true, true, rwlock_test1);
-REGISTER_FAST_TEST(rwlock_rda_autotest, true, true, try_rwlock_test_rda);
-REGISTER_FAST_TEST(rwlock_rds_wrm_autotest, true, true, try_rwlock_test_rds_wrm);
-REGISTER_FAST_TEST(rwlock_rde_wro_autotest, true, true, try_rwlock_test_rde_wro);
+REGISTER_FAST_TEST(rwlock_test1_autotest, NOHUGE, ASAN, rwlock_test1);
+REGISTER_FAST_TEST(rwlock_rda_autotest, NOHUGE, ASAN, try_rwlock_test_rda);
+REGISTER_FAST_TEST(rwlock_rds_wrm_autotest, NOHUGE, ASAN, try_rwlock_test_rds_wrm);
+REGISTER_FAST_TEST(rwlock_rde_wro_autotest, NOHUGE, ASAN, try_rwlock_test_rde_wro);
diff --git a/app/test/test_sched.c b/app/test/test_sched.c
index 6daee90bca..73d0ac5aeb 100644
--- a/app/test/test_sched.c
+++ b/app/test/test_sched.c
@@ -215,4 +215,4 @@ test_sched(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(sched_autotest, true, true, test_sched);
+REGISTER_FAST_TEST(sched_autotest, NOHUGE, ASAN, test_sched);
diff --git a/app/test/test_security.c b/app/test/test_security.c
index 23fc7ffb4f..13bf63c0b7 100644
--- a/app/test/test_security.c
+++ b/app/test/test_security.c
@@ -2314,4 +2314,4 @@ test_security(void)
 	return unit_test_suite_runner(&security_testsuite);
 }
 
-REGISTER_FAST_TEST(security_autotest, false, true, test_security);
+REGISTER_FAST_TEST(security_autotest, HUGEPAGES, ASAN, test_security);
diff --git a/app/test/test_seqlock.c b/app/test/test_seqlock.c
index c5e5e645cb..090e706b6d 100644
--- a/app/test/test_seqlock.c
+++ b/app/test/test_seqlock.c
@@ -187,4 +187,4 @@ test_seqlock(void)
 	return rc;
 }
 
-REGISTER_FAST_TEST(seqlock_autotest, true, true, test_seqlock);
+REGISTER_FAST_TEST(seqlock_autotest, NOHUGE, ASAN, test_seqlock);
diff --git a/app/test/test_service_cores.c b/app/test/test_service_cores.c
index d95a71f80b..cb99ffb31c 100644
--- a/app/test/test_service_cores.c
+++ b/app/test/test_service_cores.c
@@ -1081,7 +1081,7 @@ test_service_common(void)
 	return unit_test_suite_runner(&service_tests);
 }
 
-REGISTER_FAST_TEST(service_autotest, true, true, test_service_common);
+REGISTER_FAST_TEST(service_autotest, NOHUGE, ASAN, test_service_common);
 
 static struct unit_test_suite service_perf_tests  = {
 	.suite_name = "service core performance test suite",
diff --git a/app/test/test_soring.c b/app/test/test_soring.c
index 3c1944424e..e09d94958b 100644
--- a/app/test/test_soring.c
+++ b/app/test/test_soring.c
@@ -438,4 +438,4 @@ test_soring(void)
 	return -1;
 }
 
-REGISTER_FAST_TEST(soring_autotest, true, true, test_soring);
+REGISTER_FAST_TEST(soring_autotest, NOHUGE, ASAN, test_soring);
diff --git a/app/test/test_spinlock.c b/app/test/test_spinlock.c
index 34e0ef9422..f909ed7b18 100644
--- a/app/test/test_spinlock.c
+++ b/app/test/test_spinlock.c
@@ -303,4 +303,4 @@ test_spinlock(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(spinlock_autotest, true, true, test_spinlock);
+REGISTER_FAST_TEST(spinlock_autotest, NOHUGE, ASAN, test_spinlock);
diff --git a/app/test/test_stack.c b/app/test/test_stack.c
index 9150cc9fed..46ee08c07e 100644
--- a/app/test/test_stack.c
+++ b/app/test/test_stack.c
@@ -379,5 +379,5 @@ test_lf_stack(void)
 #endif
 }
 
-REGISTER_FAST_TEST(stack_autotest, false, true, test_stack);
-REGISTER_FAST_TEST(stack_lf_autotest, false, true, test_lf_stack);
+REGISTER_FAST_TEST(stack_autotest, HUGEPAGES, ASAN, test_stack);
+REGISTER_FAST_TEST(stack_lf_autotest, HUGEPAGES, ASAN, test_lf_stack);
diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 1a2830575e..b5bcb7ae22 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -328,4 +328,4 @@ test_string_fns(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(string_autotest, true, true, test_string_fns);
+REGISTER_FAST_TEST(string_autotest, NOHUGE, ASAN, test_string_fns);
diff --git a/app/test/test_table.c b/app/test/test_table.c
index 27d2407517..99e6a48b19 100644
--- a/app/test/test_table.c
+++ b/app/test/test_table.c
@@ -206,4 +206,4 @@ test_table(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(table_autotest, true, true, test_table);
+REGISTER_FAST_TEST(table_autotest, NOHUGE, ASAN, test_table);
diff --git a/app/test/test_tailq.c b/app/test/test_tailq.c
index 2ff2877344..f6ae1e334f 100644
--- a/app/test/test_tailq.c
+++ b/app/test/test_tailq.c
@@ -125,4 +125,4 @@ test_tailq(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(tailq_autotest, true, true, test_tailq);
+REGISTER_FAST_TEST(tailq_autotest, NOHUGE, ASAN, test_tailq);
diff --git a/app/test/test_telemetry_data.c b/app/test/test_telemetry_data.c
index 59898ff5e9..de96d1141c 100644
--- a/app/test/test_telemetry_data.c
+++ b/app/test/test_telemetry_data.c
@@ -615,4 +615,4 @@ telemetry_data_autotest(void)
 }
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(telemetry_data_autotest, true, true, telemetry_data_autotest);
+REGISTER_FAST_TEST(telemetry_data_autotest, NOHUGE, ASAN, telemetry_data_autotest);
diff --git a/app/test/test_telemetry_json.c b/app/test/test_telemetry_json.c
index 758e89303f..a5e050fe65 100644
--- a/app/test/test_telemetry_json.c
+++ b/app/test/test_telemetry_json.c
@@ -213,4 +213,4 @@ test_telemetry_json(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(telemetry_json_autotest, true, true, test_telemetry_json);
+REGISTER_FAST_TEST(telemetry_json_autotest, NOHUGE, ASAN, test_telemetry_json);
diff --git a/app/test/test_thash.c b/app/test/test_thash.c
index f43a5ddd2b..012925865f 100644
--- a/app/test/test_thash.c
+++ b/app/test/test_thash.c
@@ -1060,4 +1060,4 @@ test_thash(void)
 	return unit_test_suite_runner(&thash_tests);
 }
 
-REGISTER_FAST_TEST(thash_autotest, true, true, test_thash);
+REGISTER_FAST_TEST(thash_autotest, NOHUGE, ASAN, test_thash);
diff --git a/app/test/test_threads.c b/app/test/test_threads.c
index 6d6881a4f6..f1e4b1af6b 100644
--- a/app/test/test_threads.c
+++ b/app/test/test_threads.c
@@ -280,4 +280,4 @@ test_threads(void)
 	return unit_test_suite_runner(&threads_test_suite);
 }
 
-REGISTER_FAST_TEST(threads_autotest, true, true, test_threads);
+REGISTER_FAST_TEST(threads_autotest, NOHUGE, ASAN, test_threads);
diff --git a/app/test/test_ticketlock.c b/app/test/test_ticketlock.c
index 8ac2e90876..13895d20c1 100644
--- a/app/test/test_ticketlock.c
+++ b/app/test/test_ticketlock.c
@@ -315,4 +315,4 @@ test_ticketlock(void)
 	return ret;
 }
 
-REGISTER_FAST_TEST(ticketlock_autotest, true, true, test_ticketlock);
+REGISTER_FAST_TEST(ticketlock_autotest, NOHUGE, ASAN, test_ticketlock);
diff --git a/app/test/test_timer.c b/app/test/test_timer.c
index 3411b7fe20..bddf49ecc0 100644
--- a/app/test/test_timer.c
+++ b/app/test/test_timer.c
@@ -601,4 +601,4 @@ test_timer(void)
 	return TEST_SUCCESS;
 }
 
-REGISTER_FAST_TEST(timer_autotest, false, true, test_timer);
+REGISTER_FAST_TEST(timer_autotest, HUGEPAGES, ASAN, test_timer);
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index d860656f27..b765fba5a5 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -224,4 +224,4 @@ test_timer_secondary(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(timer_secondary_autotest, false, true, test_timer_secondary);
+REGISTER_FAST_TEST(timer_secondary_autotest, HUGEPAGES, ASAN, test_timer_secondary);
diff --git a/app/test/test_trace.c b/app/test/test_trace.c
index 52b5ba5cbb..2eda2de91d 100644
--- a/app/test/test_trace.c
+++ b/app/test/test_trace.c
@@ -254,4 +254,4 @@ test_trace(void)
 
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-REGISTER_FAST_TEST(trace_autotest, true, true, test_trace);
+REGISTER_FAST_TEST(trace_autotest, NOHUGE, ASAN, test_trace);
diff --git a/app/test/test_vdev.c b/app/test/test_vdev.c
index 3e262f30bc..a871609bab 100644
--- a/app/test/test_vdev.c
+++ b/app/test/test_vdev.c
@@ -166,4 +166,4 @@ test_vdev(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(vdev_autotest, true, true, test_vdev);
+REGISTER_FAST_TEST(vdev_autotest, NOHUGE, ASAN, test_vdev);
diff --git a/app/test/test_version.c b/app/test/test_version.c
index 52f269fb9c..f49de0e080 100644
--- a/app/test/test_version.c
+++ b/app/test/test_version.c
@@ -25,4 +25,4 @@ test_version(void)
 	return 0;
 }
 
-REGISTER_FAST_TEST(version_autotest, true, true, test_version);
+REGISTER_FAST_TEST(version_autotest, NOHUGE, ASAN, test_version);
diff --git a/buildtools/get-test-suites.py b/buildtools/get-test-suites.py
index c3a99a862e..73f1d9c9e1 100644
--- a/buildtools/get-test-suites.py
+++ b/buildtools/get-test-suites.py
@@ -18,7 +18,7 @@ def get_fast_test_params(test_name, ln):
     "Extract the extra fast-test parameters from the line"
     (_, rest_of_line) = ln.split(test_name, 1)
     (_, nohuge, asan, _func) = rest_of_line.split(',', 3)
-    return f":{nohuge.strip().lower()}:{asan.strip().lower()}"
+    return f":{nohuge.strip()}:{asan.strip()}"
 
 for fname in input_list:
     with open(fname, "r", encoding="utf-8") as f:
diff --git a/doc/guides/contributing/unit_test.rst b/doc/guides/contributing/unit_test.rst
index c0f0d2988f..30c6849252 100644
--- a/doc/guides/contributing/unit_test.rst
+++ b/doc/guides/contributing/unit_test.rst
@@ -188,9 +188,11 @@ There are two important functions for interacting with the test harness:
       The test is automatically added to the Meson test suite `<MESON_SUITE>` by this macro.
       Examples would be ``REGISTER_DRIVER_TEST``, or ``REGISTER_PERF_TEST``.
       **NOTE:** The ``REGISTER_FAST_TEST`` macro is slightly different,
-      in that it takes two additional parameters,
-      specifying whether the test can be run using ``--no-huge``,
-      and whether the test can be run using Address Sanitization (ASAN)
+      in that it takes two additional parameters before the function name:
+      the hugepage requirement (``NOHUGE`` if the test can run without hugepages,
+      or ``HUGEPAGES`` if hugepages are required),
+      and Address Sanitizer compatibility (``ASAN`` if the test can run with ASan enabled,
+      or ``NOASAN`` if it cannot).
 
    ``unit_test_suite_runner(struct unit_test_suite *)``
       Returns a runner for a full test suite object,
@@ -318,7 +320,7 @@ of the unit test suite structure, for example:
        return ret;
    }
 
-   REGISTER_FAST_TEST(example_autotest, true /*no-huge*/, false /*ASan*/, example_tests);
+   REGISTER_FAST_TEST(example_autotest, NOHUGE, ASAN, example_tests);
 
 
 Designing a test
-- 
2.51.0

