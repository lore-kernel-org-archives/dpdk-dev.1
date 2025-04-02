Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1131BC36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 362E94066E;
	Thu,  3 Apr 2025 01:25:00 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 76DCA40661
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:58 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6ecfc2cb1aaso3005736d6.3
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636298;
 x=1744241098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8N2ZL+WU92csri26VMTSYWNb/wyOG7KuWGJAHtIIOM=;
 b=u4k01SNtevJhRmPhpd/PQFiH8e5OICaM6oIdIKHKOypF7rlnDj+lXQ02zaPJgJ9QDY
 gY5ZVN6G7FokYLJLxJcIMIgX8yNY984qnZSG9G1wTW5SZirkKe1kckwhX/gK5mYbAPzt
 wzn5Ioph3gODXpYduoRtr1vghuK/GTiRAgic0vgN2/aBWju9j1RbN1O/f7ll5nrGEVJK
 Prit/IjOql6bSN5PcR+k2ePTS2Db1ljmUebAob0cXPcHlZ5MlZeGiR+kMTt5aIKRDW0B
 sVSGlHGG5i/Jzb81zs7lASAe13z2+a7F2vpQfQ8hZ7veAtJuj7UU9vX206uG6ILFVl7s
 AnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636298; x=1744241098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8N2ZL+WU92csri26VMTSYWNb/wyOG7KuWGJAHtIIOM=;
 b=UxpRqbb5joQbmD6ddDhk6UbU5gT1LLDzRLHdMsBDSrXbzdY1zSfUt5mx2XerflRx1Q
 Mhphaix+4Ts/wcdaBR4oyP82YlVNvJ7+Qf4XshjnpQ7Y2fixF+DbAEflikKygg4Ib5Vj
 ShYAFGni7HIEWwOTAfBCxx/A6joM1PEDZzD+Cj8qlXLW1QQ3SakOKtKMiqwIRIk+LbK7
 mxyZd3zCZeBhDpg5vBju8Sim4PmiM3VN+q1EBXdpgSKoGKpt16EaLUBNaaP8Z7eLLaBf
 D/mUQKJKXI7E5Dqs31su6VeJ1O7r7o/+JVQTkfzVftLN25PdtpYda1L56NKp6Whod9Ev
 V8aQ==
X-Gm-Message-State: AOJu0YyBnEqVRxusV/1dPCpb9Z6Z0ZPXnMyvY9V+74MCbeosPE8dCg0q
 aOodY7+hXv22rFWL1X0h+vCBpb7jVrnzbcF8LluWRkJ3ex7lXvPRjrRRuUUgQ+egu5UTP8RvhO+
 1
X-Gm-Gg: ASbGncv2auEbWPnwc1PGCBaydkDXGEb2T0YCWnDjAlN/WMvRyyo84jRrfrHWAvFhjHC
 OvzibhoSObU98sT7cmwfPXS9dWGjDZWXhsK+7ALOdOV/qJtC/LSKZixVa8QC1PGElpTKGUiVFmc
 aOKOYneQMJ+aAmuXd/EP2P9Krc2UVmP3ghKgtyfDxAZiCqA+v3uABYEFEY/Vr+X7E32XLhDLvMx
 jjBGgddJE9GT4IufYnBD4d5WcrEwfi7WJVcCDrACzlDwbRGzqqv8KIlyQOUVauv3DKSwxMGuVCD
 AtLzIntofHSjP1A8qEyYch895VXrRFCPdPa326OmUMLCzQUUPEC7UE3k3Y/rRKCdoAsJfZeLKfF
 xaDRQvMkJ2Rlubet49g==
X-Google-Smtp-Source: AGHT+IF5U8DDsnBkD1Nx5aroO0Bp4DCyV0VwhUxikDFa4M2udXH8qbe5pL+OKy2U4vtxoRtHVF6t0g==
X-Received: by 2002:a05:6214:1c4a:b0:6ed:1da2:afb9 with SMTP id
 6a1803df08f44-6eed621ac94mr233619646d6.19.1743636297548; 
 Wed, 02 Apr 2025 16:24:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 David Hunt <david.hunt@intel.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Harman Kalra <hkalra@marvell.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH v12 06/10] test: replace use word sanity
Date: Wed,  2 Apr 2025 16:23:16 -0700
Message-ID: <20250402232441.440346-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

The word "sanity" is on the not-allowed inclusive naming
list. Replace the unnecessary usage in tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bitmap.c             |  4 +--
 app/test/test_bpf.c                |  6 ++--
 app/test/test_common.c             |  2 +-
 app/test/test_distributor.c        | 46 +++++++++++++++---------------
 app/test/test_eal_flags.c          | 20 ++++++-------
 app/test/test_hash.c               |  2 +-
 app/test/test_interrupts.c         |  9 +++---
 app/test/test_link_bonding_mode4.c |  2 +-
 app/test/test_mbuf.c               |  2 +-
 app/test/test_rawdev.c             |  2 +-
 app/test/test_timer.c              | 10 +++----
 11 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/app/test/test_bitmap.c b/app/test/test_bitmap.c
index bab11812c7..a074b64f2e 100644
--- a/app/test/test_bitmap.c
+++ b/app/test/test_bitmap.c
@@ -33,7 +33,7 @@ test_bitmap_scan_operations(struct rte_bitmap *bmp)
 	}
 
 	if (slab1_magic != out_slab) {
-		printf("Scan operation sanity failed.\n");
+		printf("Scan operation magic number check failed.\n");
 		return TEST_FAILED;
 	}
 
@@ -43,7 +43,7 @@ test_bitmap_scan_operations(struct rte_bitmap *bmp)
 	}
 
 	if (slab2_magic != out_slab) {
-		printf("Scan operation sanity failed.\n");
+		printf("Scan operation magic number check failed.\n");
 		return TEST_FAILED;
 	}
 
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 90e10d7d2c..683331b399 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3343,9 +3343,9 @@ test_bpf_match(pcap_t *pcap, const char *str,
 	return ret;
 }
 
-/* Basic sanity test can we match a IP packet */
+/* Basic test can we match a IP packet */
 static int
-test_bpf_filter_sanity(pcap_t *pcap)
+test_bpf_filter_match(pcap_t *pcap)
 {
 	const uint32_t plen = 100;
 	struct rte_mbuf mb, *m;
@@ -3484,7 +3484,7 @@ test_bpf_convert(void)
 		return -1;
 	}
 
-	rc = test_bpf_filter_sanity(pcap);
+	rc = test_bpf_filter_match(pcap);
 	for (i = 0; i < RTE_DIM(sample_filters); i++)
 		rc |= test_bpf_filter(pcap, sample_filters[i]);
 
diff --git a/app/test/test_common.c b/app/test/test_common.c
index 6dbd7fc9a9..f0327dca99 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -20,7 +20,7 @@
 	{printf(x "() test failed!\n");\
 	return -1;}
 
-/* this is really a sanity check */
+/* this is really a consistency check */
 static int
 test_macros(int __rte_unused unused_parm)
 {
diff --git a/app/test/test_distributor.c b/app/test/test_distributor.c
index 60fe96ea82..b32aa78989 100644
--- a/app/test/test_distributor.c
+++ b/app/test/test_distributor.c
@@ -81,7 +81,7 @@ clear_packet_count(void)
 			rte_memory_order_relaxed);
 }
 
-/* this is the basic worker function for sanity test
+/* this is the basic worker function
  * it does nothing but return packets and count them.
  */
 static int
@@ -106,7 +106,7 @@ handle_work(void *arg)
 	return 0;
 }
 
-/* do basic sanity testing of the distributor. This test tests the following:
+/* do basic testing of the distributor. This test tests the following:
  * - send 32 packets through distributor with the same tag and ensure they
  *   all go to the one worker
  * - send 32 packets through the distributor with two different tags and
@@ -118,7 +118,7 @@ handle_work(void *arg)
  *   not necessarily in the same order (as different flows).
  */
 static int
-sanity_test(struct worker_params *wp, struct rte_mempool *p)
+basic_test(struct worker_params *wp, struct rte_mempool *p)
 {
 	struct rte_distributor *db = wp->dist;
 	struct rte_mbuf *bufs[BURST];
@@ -127,7 +127,7 @@ sanity_test(struct worker_params *wp, struct rte_mempool *p)
 	unsigned int retries;
 	unsigned int processed;
 
-	printf("=== Basic distributor sanity tests ===\n");
+	printf("=== Basic distributor tests ===\n");
 	clear_packet_count();
 	if (rte_mempool_get_bulk(p, (void *)bufs, BURST) != 0) {
 		printf("line %d: Error getting mbufs from pool\n", __LINE__);
@@ -164,7 +164,7 @@ sanity_test(struct worker_params *wp, struct rte_mempool *p)
 		printf("Worker %u handled %u packets\n", i,
 			rte_atomic_load_explicit(&worker_stats[i].handled_packets,
 					rte_memory_order_relaxed));
-	printf("Sanity test with all zero hashes done.\n");
+	printf("Test with all zero hashes done.\n");
 
 	/* pick two flows and check they go correctly */
 	if (rte_lcore_count() >= 3) {
@@ -192,7 +192,7 @@ sanity_test(struct worker_params *wp, struct rte_mempool *p)
 				rte_atomic_load_explicit(
 					&worker_stats[i].handled_packets,
 					rte_memory_order_relaxed));
-		printf("Sanity test with two hash values done\n");
+		printf("Test with two hash values done\n");
 	}
 
 	/* give a different hash value to each packet,
@@ -220,11 +220,11 @@ sanity_test(struct worker_params *wp, struct rte_mempool *p)
 		printf("Worker %u handled %u packets\n", i,
 			rte_atomic_load_explicit(&worker_stats[i].handled_packets,
 					rte_memory_order_relaxed));
-	printf("Sanity test with non-zero hashes done\n");
+	printf("Test with non-zero hashes done\n");
 
 	rte_mempool_put_bulk(p, (void *)bufs, BURST);
 
-	/* sanity test with BIG_BATCH packets to ensure they all arrived back
+	/* test with BIG_BATCH packets to ensure they all arrived back
 	 * from the returned packets function */
 	clear_packet_count();
 	struct rte_mbuf *many_bufs[BIG_BATCH], *return_bufs[BIG_BATCH];
@@ -289,7 +289,7 @@ sanity_test(struct worker_params *wp, struct rte_mempool *p)
 			return -1;
 		}
 	}
-	printf("Sanity test of returned packets done\n");
+	printf("Test of returned packets done\n");
 
 	rte_mempool_put_bulk(p, (void *)many_bufs, BIG_BATCH);
 
@@ -327,20 +327,20 @@ handle_work_with_free_mbufs(void *arg)
 	return 0;
 }
 
-/* Perform a sanity test of the distributor with a large number of packets,
+/* Perform a test of the distributor with a large number of packets,
  * where we allocate a new set of mbufs for each burst. The workers then
  * free the mbufs. This ensures that we don't have any packet leaks in the
  * library.
  */
 static int
-sanity_test_with_mbuf_alloc(struct worker_params *wp, struct rte_mempool *p)
+basic_test_with_mbuf_alloc(struct worker_params *wp, struct rte_mempool *p)
 {
 	struct rte_distributor *d = wp->dist;
 	unsigned i;
 	struct rte_mbuf *bufs[BURST];
 	unsigned int processed;
 
-	printf("=== Sanity test with mbuf alloc/free (%s) ===\n", wp->name);
+	printf("=== Test with mbuf alloc/free (%s) ===\n", wp->name);
 
 	clear_packet_count();
 	for (i = 0; i < ((1<<ITER_POWER)); i += BURST) {
@@ -368,7 +368,7 @@ sanity_test_with_mbuf_alloc(struct worker_params *wp, struct rte_mempool *p)
 		return -1;
 	}
 
-	printf("Sanity test with mbuf alloc/free passed\n\n");
+	printf("Test with mbuf alloc/free passed\n\n");
 	return 0;
 }
 
@@ -434,13 +434,13 @@ handle_work_for_shutdown_test(void *arg)
 }
 
 
-/* Perform a sanity test of the distributor with a large number of packets,
+/* Perform a test of the distributor with a large number of packets,
  * where we allocate a new set of mbufs for each burst. The workers then
  * free the mbufs. This ensures that we don't have any packet leaks in the
  * library.
  */
 static int
-sanity_test_with_worker_shutdown(struct worker_params *wp,
+basic_test_with_worker_shutdown(struct worker_params *wp,
 		struct rte_mempool *p)
 {
 	struct rte_distributor *d = wp->dist;
@@ -450,7 +450,7 @@ sanity_test_with_worker_shutdown(struct worker_params *wp,
 	unsigned int failed = 0;
 	unsigned int processed = 0;
 
-	printf("=== Sanity test of worker shutdown ===\n");
+	printf("=== Test of worker shutdown ===\n");
 
 	clear_packet_count();
 
@@ -516,7 +516,7 @@ sanity_test_with_worker_shutdown(struct worker_params *wp,
 	if (failed)
 		return -1;
 
-	printf("Sanity test with worker shutdown passed\n\n");
+	printf("Test with worker shutdown passed\n\n");
 	return 0;
 }
 
@@ -612,13 +612,13 @@ handle_and_mark_work(void *arg)
 	return 0;
 }
 
-/* sanity_mark_test sends packets to workers which mark them.
+/* mark_test sends packets to workers which mark them.
  * Every packet has also encoded sequence number.
  * The returned packets are sorted and verified if they were handled
  * by proper workers.
  */
 static int
-sanity_mark_test(struct worker_params *wp, struct rte_mempool *p)
+mark_test(struct worker_params *wp, struct rte_mempool *p)
 {
 	const unsigned int buf_count = 24;
 	const unsigned int burst = 8;
@@ -899,13 +899,13 @@ test_distributor(void)
 
 		rte_eal_mp_remote_launch(handle_work,
 				&worker_params, SKIP_MAIN);
-		if (sanity_test(&worker_params, p) < 0)
+		if (basic_test(&worker_params, p) < 0)
 			goto err;
 		quit_workers(&worker_params, p);
 
 		rte_eal_mp_remote_launch(handle_work_with_free_mbufs,
 				&worker_params, SKIP_MAIN);
-		if (sanity_test_with_mbuf_alloc(&worker_params, p) < 0)
+		if (basic_test_with_mbuf_alloc(&worker_params, p) < 0)
 			goto err;
 		quit_workers(&worker_params, p);
 
@@ -913,7 +913,7 @@ test_distributor(void)
 			rte_eal_mp_remote_launch(handle_work_for_shutdown_test,
 					&worker_params,
 					SKIP_MAIN);
-			if (sanity_test_with_worker_shutdown(&worker_params,
+			if (basic_test_with_worker_shutdown(&worker_params,
 					p) < 0)
 				goto err;
 			quit_workers(&worker_params, p);
@@ -928,7 +928,7 @@ test_distributor(void)
 
 			rte_eal_mp_remote_launch(handle_and_mark_work,
 					&worker_params, SKIP_MAIN);
-			if (sanity_mark_test(&worker_params, p) < 0)
+			if (mark_test(&worker_params, p) < 0)
 				goto err;
 			quit_workers(&worker_params, p);
 
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index e32f83d3c8..bf7fc5ce32 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -314,7 +314,7 @@ get_number_of_sockets(void)
 
 /*
  * Test that the app doesn't run with invalid allow option.
- * Final tests ensures it does run with valid options as sanity check (one
+ * Final tests ensures it does run with valid options as basic test (one
  * test for with Domain+BDF, second for just with BDF)
  */
 static int
@@ -382,7 +382,7 @@ test_allow_flag(void)
 
 /*
  * Test that the app doesn't run with invalid blocklist option.
- * Final test ensures it does run with valid options as sanity check
+ * Final test ensures it does run with valid options as basic check.
  */
 static int
 test_invalid_b_flag(void)
@@ -429,7 +429,7 @@ test_invalid_b_flag(void)
 
 /*
  *  Test that the app doesn't run with invalid vdev option.
- *  Final test ensures it does run with valid options as sanity check
+ *  Final test ensures it does run with valid options basic check.
  */
 static int
 test_invalid_vdev_flag(void)
@@ -554,7 +554,7 @@ test_missing_c_flag(void)
 	/* bad coremask value */
 	const char *argv3[] = { prgname, prefix, mp_flag,
 				"-c", "error" };
-	/* sanity check of tests - valid coremask value */
+	/* check of tests - valid coremask value */
 	const char *argv4[] = { prgname, prefix, mp_flag,
 				"-c", "1" };
 	/* -l flag but no corelist value */
@@ -581,7 +581,7 @@ test_missing_c_flag(void)
 				"-l", RTE_STR(RTE_MAX_LCORE) };
 	const char * const argv14[] = { prgname, prefix, mp_flag,
 				"-l", "1-"RTE_STR(RTE_MAX_LCORE) };
-	/* sanity check test - valid corelist value */
+	/* check test - valid corelist value */
 	const char * const argv15[] = { prgname, prefix, mp_flag,
 				 "-l", "1-2,3" };
 
@@ -613,7 +613,7 @@ test_missing_c_flag(void)
 				 "--lcores", "(4-7)=(1,3)" };
 	const char * const argv28[] = { prgname, prefix, mp_flag,
 				 "--lcores", "[4-7]@(1,3)" };
-	/* sanity check of tests - valid lcores value */
+	/* more complex valid lcores value */
 	const char * const argv29[] = { prgname, prefix, mp_flag,
 				 "--lcores",
 				 "0-1,2@(5-7),(3-5)@(0,2),(0,6),7"};
@@ -744,7 +744,7 @@ test_main_lcore_flag(void)
 
 /*
  * Test that the app doesn't run with invalid -n flag option.
- * Final test ensures it does run with valid options as sanity check
+ * Final test ensures it does run with valid options as basic check.
  * Since -n is not compulsory for MP, we instead use --no-huge and --no-shconf
  * flags.
  */
@@ -772,10 +772,10 @@ test_invalid_n_flag(void)
 	/* zero is invalid */
 	const char *argv3[] = { prgname, prefix, no_huge, no_shconf,
 				"-n", "0" };
-	/* sanity test - check with good value */
+	/* check with good value */
 	const char *argv4[] = { prgname, prefix, no_huge, no_shconf,
 				"-n", "2" };
-	/* sanity test - check with no -n flag */
+	/* check with no -n flag */
 	const char *argv5[] = { prgname, prefix, no_huge, no_shconf};
 
 	if (launch_proc(argv1) == 0
@@ -977,7 +977,7 @@ test_misc_flags(void)
 	 * All cases, apart from the first, app should run.
 	 * No further testing of output done.
 	 */
-	/* sanity check - failure with invalid option */
+	/* failure with invalid option */
 	const char *argv0[] = {prgname, prefix, mp_flag, "--invalid-opt"};
 
 	/* With --no-pci */
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..15b0a2f3d4 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -1140,7 +1140,7 @@ fbk_hash_unit_test(void)
 		.socket_id = 0,
 	};
 
-	/* this is a sanity check for "same name" test
+	/* this is a check for "same name" test
 	 * creating this hash will check if we are actually able to create
 	 * multiple hashes with different names (instead of having just one).
 	 */
diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 3952f9685f..42b830e936 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -48,7 +48,7 @@ static union intr_pipefds pfds;
  * Check if the interrupt handle is valid.
  */
 static inline int
-test_interrupt_handle_sanity_check(struct rte_intr_handle *intr_handle)
+test_interrupt_handle_check(struct rte_intr_handle *intr_handle)
 {
 	if (!intr_handle || rte_intr_fd_get(intr_handle) < 0)
 		return -1;
@@ -164,7 +164,7 @@ test_interrupt_handle_compare(struct rte_intr_handle *intr_handle_l,
 #else
 /* to be implemented for bsd later */
 static inline int
-test_interrupt_handle_sanity_check(struct rte_intr_handle *intr_handle)
+test_interrupt_handle_check(struct rte_intr_handle *intr_handle)
 {
 	RTE_SET_USED(intr_handle);
 
@@ -215,7 +215,7 @@ test_interrupt_callback(void *arg)
 		return;
 	}
 
-	if (test_interrupt_handle_sanity_check(intr_handle) < 0) {
+	if (test_interrupt_handle_check(intr_handle) < 0) {
 		printf("null or invalid intr_handle for %s\n", __func__);
 		flag = -1;
 		return;
@@ -241,7 +241,8 @@ static void
 test_interrupt_callback_1(void *arg)
 {
 	struct rte_intr_handle *intr_handle = arg;
-	if (test_interrupt_handle_sanity_check(intr_handle) < 0) {
+
+	if (test_interrupt_handle_check(intr_handle) < 0) {
 		printf("null or invalid intr_handle for %s\n", __func__);
 		flag = -1;
 		return;
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93..299b89f669 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -224,7 +224,7 @@ add_member(struct member_conf *member, uint8_t start)
 	struct rte_ether_addr addr, addr_check;
 	int retval;
 
-	/* Some sanity check */
+	/* Some basic tests. */
 	RTE_VERIFY(test_params.member_ports <= member &&
 		member - test_params.member_ports < (int)RTE_DIM(test_params.member_ports));
 	RTE_VERIFY(member->bonding == 0);
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index 3fbb5dea8b..1cc50b158f 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -1702,7 +1702,7 @@ test_mbuf_validate_tx_offload(const char *test_name,
 	struct rte_mbuf *m = NULL;
 	int ret = 0;
 
-	/* alloc a mbuf and do sanity check */
+	/* alloc a mbuf and do some basic checks */
 	m = rte_pktmbuf_alloc(pktmbuf_pool);
 	if (m == NULL)
 		GOTO_FAIL("%s: mbuf allocation failed!\n", __func__);
diff --git a/app/test/test_rawdev.c b/app/test/test_rawdev.c
index d34691dacf..0d4f0ce1fa 100644
--- a/app/test/test_rawdev.c
+++ b/app/test/test_rawdev.c
@@ -47,7 +47,7 @@ test_rawdev_selftests(void)
 	int ret = 0;
 	int i;
 
-	/* basic sanity on rawdev infrastructure */
+	/* basic check on rawdev infrastructure */
 	if (test_rawdev_selftest_skeleton() < 0)
 		return -1;
 
diff --git a/app/test/test_timer.c b/app/test/test_timer.c
index 3411b7fe20..70a4d981fe 100644
--- a/app/test/test_timer.c
+++ b/app/test/test_timer.c
@@ -498,11 +498,11 @@ timer_basic_main_loop(__rte_unused void *arg)
 }
 
 static int
-timer_sanity_check(void)
+timer_check(void)
 {
 #ifdef RTE_LIBEAL_USE_HPET
 	if (eal_timer_source != EAL_TIMER_HPET) {
-		printf("Not using HPET, can't sanity check timer sources\n");
+		printf("Not using HPET, can't check timer sources\n");
 		return 0;
 	}
 
@@ -546,9 +546,9 @@ test_timer(void)
 		return TEST_SKIPPED;
 	}
 
-	/* sanity check our timer sources and timer config values */
-	if (timer_sanity_check() < 0) {
-		printf("Timer sanity checks failed\n");
+	/* check our timer sources and timer config values */
+	if (timer_check() < 0) {
+		printf("Timer checks failed\n");
 		return TEST_FAILED;
 	}
 
-- 
2.47.2

