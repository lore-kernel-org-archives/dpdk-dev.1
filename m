Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD09CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B513F40EE3;
	Tue,  6 Oct 2026 17:54:43 +0200 (CEST)
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
 by mails.dpdk.org (Postfix) with ESMTP id 0F71540262
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:54:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=81834; q=dns/txt;
 s=iport01; t=1791302081; x=1792511681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=yNcDNjhXgMQLQPO2LkbKAkHqDU94H/4djsf+RW/Cndk=;
 b=JUc4Ztn1CHf8/ATNubDt0iquJwhCdUvMmamML+mA7vdmPHqW0YfAO7ZX
 fJ0BfWR3bAvLB5J1vRt7G8w4A+pvZl/Q48UIB9WBJxMut52DvdUdIby+H
 gKnzJy38sh384Wz9Q7SynCCCRls4MXC9R2U1GePb/MmgnmXssw8hq53dK
 Y2lkmTwiiNmpQK5X4fRcF3Jp14bbN41Smk+y3pjwNhxdeFjEujpHqYTnk
 82kHPF26dKUZzD7RrMnJ9fAW5bqBWwDV52MKn6DRA+Hhm8y9uY7caiWXv
 gTHJ5xdBDb85Wk6Pk6gJDqeXsRBdEW8VeanLqRk3yWXQ1ygSKi58TKcl3 A==;
X-CSE-ConnectionGUID: PUDYp73hQmuwUSyRLvh5DA==
X-CSE-MsgGUID: Tu11SMFvR1eoTMYMB74kOA==
X-IPAS-Result: =?us-ascii?q?A0BNAgCAGMVq/5P/Ja1SCIJZghg/dWFCSYRXkXMDgROQN?=
 =?us-ascii?q?oFUin0UgWoPAQEBDzEgBAEBhQECAgKOCQImNAkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBCgEBBQEBAQIBBwWBDhOGFQgyDZATAgEDGgEIBAsBRhAfAQUCERUCAkYQG?=
 =?us-ascii?q?YIqWAGCdAO2Inp/M4EB3kiBaAELFAGBCi6FQIMfAYFxhAhEgxmBHycVBoFJR?=
 =?us-ascii?q?IEVMoEJgTh2g3wKFgkIQhODHIJqBIINFYEMgVqBA0qDQYkDhVYJgUEcA1ksA?=
 =?us-ascii?q?VUTFwsHBWGBBQOBBm4yHYEjPhcvWBsGBYEdgQkEE4IWIxk2eoEJXoErKWABE?=
 =?us-ascii?q?BeBCYIHAoJUggACAUlBDgdFUwklQxJHJiIIEgkBExowC4EbODwJKEEXDBBtP?=
 =?us-ascii?q?TcVGQQ9kUMegW4sAQExAQsGAQEsBAwbATUBExwTC1kKLxkEGxkUIgILknUdB?=
 =?us-ascii?q?wIBB4NtjCmDVopDlReEKIwilVQzhASBV5JAklSZCIJZoRkUhT2BaDyBWU0jF?=
 =?us-ascii?q?TuCZwlKGQ+DOIpQIwMWgRQBAoFrzRMoNT8HAgcPApF0gX0BAQ?=
IronPort-Data: A9a23:WyX4maPtRAbwu6HvrR24lsFynXyQoLVcMsEvi/4bfWQNrUpz0zUGz
 GdKWm3Qa/3ZamP8KthyPIuy801SvJSAnNY3S3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeap1yFjmD9k/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVzlV
 e/a+ZWFZgb9g2AsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj681TIHAuYtYYw+NqHlx15
 MY8NjBQQjnW0opawJrjIgVtrt4oIM+uOMYUvWttiGiBS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzM3wsYDUXUrsTIIgineylrnL+aDZf7lmSoMLb5kCOl1Uti+K9aYq9ltqiedgMx329i
 Hz8pmn+PjQrEfbAlTmi2yf57gPItWahMG4IL5W0++BCjEWfxSoUEhJ+fVu4qP2jg2a7UshBJ
 kgQvCEpqMAa8kCiRNj5RwCiqXusuxcGRddUF6sx7wTl4rHI7h6ZC24sSDNdd9s8t9cyWDkg2
 0XPmMnmbRRqupWOTHuH6qyUpCm/IjkOMWIHfmkPSg5t3jX4iJs4ghSKSpNoF7S4y4StXzrx2
 DuN6iM5gt3/kPI26klyxnif6xrEm3QDZlRdCtn/No590j5EWQ==
IronPort-HdrOrdr: A9a23:pTeyKa9+67hZdgPK7iJuk+D4I+orL9Y04lQ7vn2ZhyY4TiX+rb
 HKoB17726XtN9/Yh8dcLy7UpVoBEm9yXcX2/h0AV7dZmjbUQKTRekI0WKh+UyCJ8SUzIFgPM
 lbHpRWOZnXEUVwi9r87U2TFtYtx8TCzYWT7N2uqEuEiWpRGthdB8ATMHf8LnFL
X-Talos-CUID: 9a23:XJ8T5G4K9toOwZ/J2NsszHM4K9h6KX3kyWrPHnSpM0J3SOC5YArF
X-Talos-MUID: 9a23:ho8QLwV90bZFO5Dq/APx3WhZEel22f2jD3wooLAs5JWHEgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,143,1787011200"; d="scan'208";a="531432818"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
 by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 06 Oct 2026 15:54:38 +0000
Received: from rtp-orb-10405.cisco.com (rtp-orb-10405.cisco.com [64.100.22.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 828F618000274;
 Tue,  6 Oct 2026 15:54:38 +0000 (GMT)
From: Randy L Tice <rtice@cisco.com>
To: dev@dpdk.org
Cc: Morten =?utf-8?q?Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 1/1] mbuf: add runtime metadata dynamic-field storage
Date: Tue, 06 Oct 2026 11:54:37 -0400
Message-Id: <179130207755.4.14751953894988772444.v4-0001-mbuf-add-runtime-metadata-dynamic-field-storage.patch@cisco.com>
In-Reply-To: <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
References: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Outbound-Client-TLS: ANONYMOUS; rtp-orb-10405.cisco.com [64.100.22.53];
 TLSv1.2; ECDHE-RSA-AES256-GCM-SHA384; 256
X-Outbound-SMTP-Client: 64.100.22.53, rtp-orb-10405.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com
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

From: Randy L Tice <rtice@cisco.com>
Date: Thu, 03 Sep 2026 09:13:28 -0400

Add an EAL option to reserve optional cache-line-aligned metadata
storage in every pktmbuf object without changing sizeof(struct rte_mbuf).
The --mbuf-metadata-size option configures the metadata size at primary
process initialization time and shares the value with secondary
processes.

The storage is placed after the fixed struct rte_mbuf header and before
application private data. Mbuf pool constructors, private-data accessors,
and drivers that program hardware offsets from the start of an mbuf now
use rte_mbuf_size() so the configured metadata area is included in mbuf
object layout calculations.

The metadata area is managed by the existing mbuf dynamic-field registry.
Fields registered with RTE_MBUF_DYNFIELD_F_METADATA are allocated from
this metadata area and are not copied by generic mbuf copy and clone
operations. Dynamic fields registered without this flag continue to use
the existing copied dynamic-field storage and are prevented from
overlapping the metadata area.

The existing per-pool private-data area is not sufficient for this use
case because it has no global registry and is configured independently
for each mbuf pool. Multiple modules using private data would need
out-of-band coordination to avoid overlapping layouts, especially when
mbuf pools are created by different components.

Reject octeontx mempool allocation when mbuf metadata is configured,
because that mempool requires the hardware mbuf header offset to remain
128 bytes.

Signed-off-by: Randy L Tice <rtice@cisco.com>
---
 app/test-crypto-perf/cperf_test_common.c      |  8 +-
 app/test-pmd/testpmd.c                        |  2 +-
 app/test/suites/meson.build                   | 14 +++
 app/test/test_cryptodev.c                     |  4 +-
 app/test/test_cryptodev.h                     |  3 +-
 app/test/test_event_crypto_adapter.c          |  2 +-
 app/test/test_mbuf.c                          | 82 ++++++++++++++---
 app/test/test_pdcp.c                          |  2 +-
 doc/guides/linux_gsg/eal_args.include.rst     |  8 ++
 doc/guides/prog_guide/mbuf_lib.rst            | 16 ++++
 doc/guides/rel_notes/release_26_11.rst        | 21 ++++-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  8 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     |  8 +-
 drivers/event/cnxk/cn10k_worker.h             |  6 +-
 drivers/event/cnxk/cn20k_eventdev.c           |  2 +-
 drivers/event/cnxk/cn20k_worker.h             | 10 +--
 drivers/event/cnxk/cn9k_worker.h              | 23 ++---
 drivers/event/cnxk/cnxk_eventdev_adptr.c      |  2 +-
 drivers/mempool/dpaa/dpaa_mempool.c           |  2 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |  6 +-
 drivers/mempool/octeontx/meson.build          |  1 -
 .../mempool/octeontx/rte_mempool_octeontx.c   |  6 ++
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  6 +-
 drivers/net/bnxt/bnxt_rxr.c                   |  2 +-
 drivers/net/bnxt/bnxt_txr.c                   |  2 +-
 drivers/net/cnxk/cn10k_ethdev_sec.c           |  2 +-
 drivers/net/cnxk/cn10k_rx.h                   | 58 +++++++------
 drivers/net/cnxk/cn20k_ethdev_sec.c           |  2 +-
 drivers/net/cnxk/cn20k_rx.h                   | 19 ++--
 drivers/net/cnxk/cnxk_eswitch.c               |  4 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  6 +-
 drivers/net/cnxk/cnxk_ethdev_dp.h             |  2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c            |  6 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  2 +-
 drivers/net/mlx5/mlx5_trigger.c               |  6 +-
 drivers/net/nfp/flower/nfp_flower.c           |  2 +-
 drivers/net/nfp/nfp_rxtx.c                    |  2 +-
 drivers/net/pfe/pfe_hif.c                     |  2 +-
 drivers/net/pfe/pfe_hif_lib.c                 |  4 +-
 drivers/net/sfc/sfc_rx.c                      |  2 +-
 drivers/net/softnic/rte_eth_softnic_mempool.c |  4 +-
 examples/fips_validation/fips_validation.h    |  2 +-
 examples/fips_validation/main.c               |  2 +-
 examples/ntb/ntb_fwd.c                        |  2 +-
 lib/cryptodev/rte_crypto.h                    |  4 +-
 lib/eal/common/eal_common_config.c            |  3 +
 lib/eal/common/eal_common_mcfg.c              | 16 +++-
 lib/eal/common/eal_common_options.c           | 20 +++++
 lib/eal/common/eal_internal_cfg.h             |  3 +
 lib/eal/common/eal_memcfg.h                   |  4 +-
 lib/eal/common/eal_option_list.h              |  1 +
 lib/eal/common/eal_private.h                  |  1 +
 lib/eal/freebsd/eal.c                         |  3 +-
 lib/eal/linux/eal.c                           |  3 +-
 lib/mbuf/mbuf_history.c                       |  4 +-
 lib/mbuf/rte_mbuf.c                           | 17 ++--
 lib/mbuf/rte_mbuf.h                           |  9 +-
 lib/mbuf/rte_mbuf_core.h                      | 37 ++++++++
 lib/mbuf/rte_mbuf_dyn.c                       | 87 +++++++++++++++----
 lib/mbuf/rte_mbuf_dyn.h                       | 11 ++-
 lib/pcapng/rte_pcapng.c                       |  2 +-
 lib/vhost/vhost.h                             |  2 +-
 62 files changed, 438 insertions(+), 164 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index 0bcaa6dfd8..9cb0e61ce7 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -21,7 +21,7 @@ fill_single_seg_mbuf(struct rte_mbuf *m, struct rte_mempool *mp,
 		void *obj, uint32_t mbuf_offset, uint16_t segment_sz,
 		uint16_t headroom, uint16_t data_len)
 {
-	uint32_t mbuf_hdr_size = sizeof(struct rte_mbuf);
+	uint32_t mbuf_hdr_size = rte_mbuf_size();
 
 	/* start of buffer is after mbuf structure and priv data */
 	m->priv_size = 0;
@@ -47,7 +47,7 @@ fill_multi_seg_mbuf(struct rte_mbuf *m, struct rte_mempool *mp,
 		void *obj, uint32_t mbuf_offset, uint16_t segment_sz,
 		uint16_t headroom, uint16_t data_len, uint16_t segments_nb)
 {
-	uint16_t mbuf_hdr_size = sizeof(struct rte_mbuf);
+	uint32_t mbuf_hdr_size = rte_mbuf_size();
 	uint16_t remaining_segments = segments_nb;
 	rte_iova_t next_seg_phys_addr = rte_mempool_virt2iova(obj) +
 			 mbuf_offset + mbuf_hdr_size;
@@ -196,7 +196,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 				crypto_op_private_size;
 	uint16_t crypto_op_total_size_padded =
 				RTE_CACHE_LINE_ROUNDUP(crypto_op_total_size);
-	uint32_t mbuf_size = sizeof(struct rte_mbuf) + options->segment_sz;
+	uint32_t mbuf_size = rte_mbuf_size() + options->segment_sz;
 	uint32_t max_size = options->max_buffer_size + options->digest_sz;
 	uint32_t segment_data_len = options->segment_sz - options->headroom_sz -
 				    options->tailroom_sz;
@@ -228,7 +228,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 				(mbuf_size * segments_nb);
 		params.dst_buf_offset = *dst_buf_offset;
 		/* Destination buffer will be one segment only */
-		obj_size += max_size + sizeof(struct rte_mbuf) +
+		obj_size += max_size + rte_mbuf_size() +
 			options->headroom_sz + options->tailroom_sz;
 	}
 
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index cab2fa1556..6b42f27492 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1268,7 +1268,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 #ifndef RTE_EXEC_ENV_WINDOWS
 	uint32_t mb_size;
 
-	mb_size = sizeof(struct rte_mbuf) + mbuf_seg_size;
+	mb_size = rte_mbuf_size() + mbuf_seg_size;
 #endif
 	mbuf_poolname_build(socket_id, pool_name, sizeof(pool_name), size_idx);
 	if (!is_proc_primary()) {
diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 786c459c24..2c051d3796 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -122,6 +122,20 @@ foreach suite:test_suites
     endif
 endforeach
 
+mbuf_metadata_args = test_no_huge_args + ['--no-shconf', '--mbuf-metadata-size=256']
+if get_option('default_library') == 'shared'
+    mbuf_metadata_args += ['-d', dpdk_drivers_build_dir]
+endif
+if is_linux
+    mbuf_metadata_args += ['--file-prefix=mbuf_autotest_with_metadata']
+endif
+test('mbuf_autotest_with_metadata', dpdk_test,
+    args : mbuf_metadata_args,
+    env: ['DPDK_TEST=mbuf_autotest'],
+    timeout : timeout_seconds_fast,
+    is_parallel : false,
+    suite : 'fast-tests')
+
 # standalone test for telemetry
 if not is_windows and dpdk_conf.has('RTE_LIB_TELEMETRY')
     test_args = [dpdk_test]
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index fd02107baf..fff0ff487a 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -263,11 +263,11 @@ create_mbuf_from_heap(int pkt_len, uint8_t pattern)
 	/* Set the default values to the mbuf */
 	m->nb_segs = 1;
 	m->port = RTE_MBUF_PORT_INVALID;
-	m->buf_len = MBUF_SIZE - sizeof(struct rte_mbuf) - RTE_PKTMBUF_HEADROOM;
+	m->buf_len = MBUF_SIZE - rte_mbuf_size() - RTE_PKTMBUF_HEADROOM;
 	rte_pktmbuf_reset_headroom(m);
 	__rte_mbuf_sanity_check(m, 1);
 
-	m->buf_addr = (char *)m + sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM;
+	m->buf_addr = (char *)m + rte_mbuf_size() + RTE_PKTMBUF_HEADROOM;
 
 	memset(m->buf_addr, pattern, m->buf_len);
 	dst = (uint8_t *)rte_pktmbuf_append(m, pkt_len);
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index d125dea958..d7e403df33 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -5,6 +5,7 @@
 #define TEST_CRYPTODEV_H_
 
 #include <rte_cryptodev.h>
+#include <rte_mbuf.h>
 #include <rte_security.h>
 
 #define MAX_NUM_OPS_INFLIGHT            (4096)
@@ -16,7 +17,7 @@
 #define NUM_MBUFS                       (8191)
 #define MBUF_CACHE_SIZE                 (256)
 #define MBUF_DATAPAYLOAD_SIZE		(4096 + DIGEST_BYTE_LENGTH_SHA512)
-#define MBUF_SIZE			(sizeof(struct rte_mbuf) + \
+#define MBUF_SIZE			(rte_mbuf_size() + \
 		RTE_PKTMBUF_HEADROOM + MBUF_DATAPAYLOAD_SIZE)
 #define LARGE_MBUF_DATAPAYLOAD_SIZE	(UINT16_MAX - RTE_PKTMBUF_HEADROOM)
 #define LARGE_MBUF_SIZE			(RTE_PKTMBUF_HEADROOM + LARGE_MBUF_DATAPAYLOAD_SIZE)
diff --git a/app/test/test_event_crypto_adapter.c b/app/test/test_event_crypto_adapter.c
index cac1584f40..8ff1c83c16 100644
--- a/app/test/test_event_crypto_adapter.c
+++ b/app/test/test_event_crypto_adapter.c
@@ -48,7 +48,7 @@ test_event_crypto_adapter(void)
 #define NUM_CORES                  1
 #define CRYPTODEV_NAME_NULL_PMD    crypto_null
 
-#define MBUF_SIZE              (sizeof(struct rte_mbuf) + \
+#define MBUF_SIZE              (rte_mbuf_size() + \
 				RTE_PKTMBUF_HEADROOM + PACKET_LENGTH)
 #define IV_OFFSET              (sizeof(struct rte_crypto_op) + \
 				sizeof(struct rte_crypto_sym_op) + \
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..b7caf7fffd 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -625,11 +625,11 @@ test_attach_from_different_pool(struct rte_mempool *pktmbuf_pool,
 		GOTO_FAIL("data room size should be 0\n");
 	if (rte_pktmbuf_priv_size(clone->pool) != MBUF2_PRIV_SIZE)
 		GOTO_FAIL("data room size should be %d\n", MBUF2_PRIV_SIZE);
-	memset(clone + 1, 0, MBUF2_PRIV_SIZE);
+	memset(rte_mbuf_to_priv(clone), 0, MBUF2_PRIV_SIZE);
 
 	/* save data pointer to compare it after detach() */
 	c_data = rte_pktmbuf_mtod(clone, char *);
-	if (c_data != (char *)clone + sizeof(*clone) + MBUF2_PRIV_SIZE)
+	if (c_data != (char *)clone + rte_mbuf_size() + MBUF2_PRIV_SIZE)
 		GOTO_FAIL("bad data pointer in clone");
 	if (rte_pktmbuf_headroom(clone) != 0)
 		GOTO_FAIL("bad headroom in clone");
@@ -654,11 +654,11 @@ test_attach_from_different_pool(struct rte_mempool *pktmbuf_pool,
 		GOTO_FAIL("data room size should be 0\n");
 	if (rte_pktmbuf_priv_size(clone2->pool) != MBUF2_PRIV_SIZE)
 		GOTO_FAIL("data room size should be %d\n", MBUF2_PRIV_SIZE);
-	memset(clone2 + 1, 0, MBUF2_PRIV_SIZE);
+	memset(rte_mbuf_to_priv(clone2), 0, MBUF2_PRIV_SIZE);
 
 	/* save data pointer to compare it after detach() */
 	c_data2 = rte_pktmbuf_mtod(clone2, char *);
-	if (c_data2 != (char *)clone2 + sizeof(*clone2) + MBUF2_PRIV_SIZE)
+	if (c_data2 != (char *)clone2 + rte_mbuf_size() + MBUF2_PRIV_SIZE)
 		GOTO_FAIL("bad data pointer in clone2");
 	if (rte_pktmbuf_headroom(clone2) != 0)
 		GOTO_FAIL("bad headroom in clone2");
@@ -2561,15 +2561,15 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 		.align = alignof(uint16_t),
 		.flags = 0,
 	};
-	const struct rte_mbuf_dynfield dynfield3 = {
-		.name = "test-dynfield3",
+	const struct rte_mbuf_dynfield dynfield_fixed = {
+		.name = "test-dynfield-fixed",
 		.size = sizeof(uint8_t),
 		.align = alignof(uint8_t),
 		.flags = 0,
 	};
 	const struct rte_mbuf_dynfield dynfield_fail_big = {
 		.name = "test-dynfield-fail-big",
-		.size = 256,
+		.size = sizeof(struct rte_mbuf),
 		.align = 1,
 		.flags = 0,
 	};
@@ -2583,7 +2583,25 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 		.name = "test-dynfield",
 		.size = sizeof(uint8_t),
 		.align = alignof(uint8_t),
-		.flags = 1,
+		.flags = RTE_MBUF_DYNFIELD_F_METADATA << 1,
+	};
+	const struct rte_mbuf_dynfield metadata_field = {
+		.name = "test-metadata-field",
+		.size = sizeof(uint64_t),
+		.align = alignof(uint64_t),
+		.flags = RTE_MBUF_DYNFIELD_F_METADATA,
+	};
+	const struct rte_mbuf_dynfield dynfield_metadata_bad_offset = {
+		.name = "test-dynfield-metadata-bad-offset",
+		.size = sizeof(uint64_t),
+		.align = alignof(uint64_t),
+		.flags = RTE_MBUF_DYNFIELD_F_METADATA,
+	};
+	const struct rte_mbuf_dynfield dynfield_copy_bad_offset = {
+		.name = "test-dynfield-copy-bad-offset",
+		.size = 2 * sizeof(uint64_t),
+		.align = alignof(uint64_t),
+		.flags = 0,
 	};
 	const struct rte_mbuf_dynflag dynflag_fail_flag = {
 		.name = "test-dynflag",
@@ -2602,7 +2620,9 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 		.flags = 0,
 	};
 	struct rte_mbuf *m = NULL;
+	struct rte_mbuf *mc = NULL;
 	int offset, offset2, offset3;
+	int metadata_field_offset;
 	int flag, flag2, flag3;
 	int ret;
 
@@ -2624,7 +2644,7 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 		GOTO_FAIL("failed to register dynamic field 2, offset2=%d: %s",
 			offset2, strerror(errno));
 
-	offset3 = rte_mbuf_dynfield_register_offset(&dynfield3,
+	offset3 = rte_mbuf_dynfield_register_offset(&dynfield_fixed,
 				offsetof(struct rte_mbuf, dynfield1[1]));
 	if (offset3 != offsetof(struct rte_mbuf, dynfield1[1])) {
 		if (rte_errno == EBUSY)
@@ -2654,6 +2674,33 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 	if (ret != -1)
 		GOTO_FAIL("dynamic field creation should fail (invalid flag)");
 
+	if (rte_mbuf_metadata_size_get() > 0) {
+		metadata_field_offset = rte_mbuf_dynfield_register_offset(&metadata_field,
+				offsetof(struct rte_mbuf, metadata));
+		if (metadata_field_offset != offsetof(struct rte_mbuf, metadata))
+			GOTO_FAIL("failed to register metadata field, offset=%d: %s",
+				metadata_field_offset, strerror(errno));
+
+		ret = rte_mbuf_dynfield_register_offset(&dynfield_metadata_bad_offset,
+				offsetof(struct rte_mbuf, dynfield1[0]));
+		if (ret != -1)
+			GOTO_FAIL("metadata dynamic field creation should fail outside metadata");
+
+		ret = rte_mbuf_dynfield_register_offset(&dynfield_copy_bad_offset,
+				offsetof(struct rte_mbuf, metadata));
+		if (ret != -1)
+			GOTO_FAIL("copied dynamic field creation should fail in metadata");
+
+		ret = rte_mbuf_dynfield_register_offset(&dynfield_copy_bad_offset,
+				offsetof(struct rte_mbuf, metadata) - sizeof(uint64_t));
+		if (ret != -1)
+			GOTO_FAIL("copied dynamic field creation should fail when straddling metadata");
+	} else {
+		ret = rte_mbuf_dynfield_register(&metadata_field);
+		if (ret != -1)
+			GOTO_FAIL("metadata dynamic field creation should fail without metadata area");
+	}
+
 	ret = rte_mbuf_dynflag_register(&dynflag_fail_flag);
 	if (ret != -1)
 		GOTO_FAIL("dynamic flag creation should fail (invalid flag)");
@@ -2693,13 +2740,29 @@ test_mbuf_dyn(struct rte_mempool *pktmbuf_pool)
 	if (*RTE_MBUF_DYNFIELD(m, offset2, uint16_t *) != 1000)
 		GOTO_FAIL("failed to read dynamic field");
 
+	if (rte_mbuf_metadata_size_get() > 0) {
+		*RTE_MBUF_DYNFIELD(m, metadata_field_offset, uint64_t *) =
+			UINT64_C(0x8877665544332211);
+		mc = rte_pktmbuf_alloc(pktmbuf_pool);
+		if (mc == NULL)
+			GOTO_FAIL("Cannot allocate mbuf for dynamic field copy test");
+		*RTE_MBUF_DYNFIELD(mc, metadata_field_offset, uint64_t *) =
+			UINT64_C(0xa5a5a5a5a5a5a5a5);
+		rte_mbuf_dynfield_copy(mc, m);
+		if (*RTE_MBUF_DYNFIELD(mc, metadata_field_offset, uint64_t *) !=
+				UINT64_C(0xa5a5a5a5a5a5a5a5))
+			GOTO_FAIL("copied metadata dynamic field");
+	}
+
 	/* set a dynamic flag */
 	m->ol_flags |= (1ULL << flag);
 
 	rte_mbuf_dyn_dump(stdout);
+	rte_pktmbuf_free(mc);
 	rte_pktmbuf_free(m);
 	return 0;
 fail:
+	rte_pktmbuf_free(mc);
 	rte_pktmbuf_free(m);
 	return -1;
 }
@@ -2776,7 +2839,6 @@ test_mbuf(void)
 	struct rte_mempool *pktmbuf_pool = NULL;
 	struct rte_mempool *pktmbuf_pool2 = NULL;
 
-
 	RTE_BUILD_BUG_ON(sizeof(struct rte_mbuf) != RTE_CACHE_LINE_MIN_SIZE * 2);
 
 	/* create pktmbuf pool if it does not exist */
diff --git a/app/test/test_pdcp.c b/app/test/test_pdcp.c
index 784e2dddd9..c91bb68dae 100644
--- a/app/test/test_pdcp.c
+++ b/app/test/test_pdcp.c
@@ -27,7 +27,7 @@
 #define NB_BASIC_TESTS RTE_DIM(pdcp_test_params)
 #define NB_SDAP_TESTS RTE_DIM(list_pdcp_sdap_tests)
 #define PDCP_IV_LEN 16
-#define PDCP_MBUF_SIZE	(sizeof(struct rte_mbuf) + \
+#define PDCP_MBUF_SIZE	(rte_mbuf_size() + \
 			 RTE_PKTMBUF_HEADROOM + RTE_PDCP_CTRL_PDU_SIZE_MAX)
 
 /* Assert that condition is true, or goto the mark */
diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 32c24c8e41..eb7048a4cf 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -285,6 +285,14 @@ Other options
 
     Pool ops name for mbuf to use.
 
+*   ``--mbuf-metadata-size``:
+
+    Size of the global per-mbuf metadata area.
+    The value must be a multiple of the cache line size and is shared by the
+    primary process with secondary processes.
+    Secondary processes may omit this option, but if specified it must match
+    the value used by the primary process.
+
 *   ``--telemetry``:
 
     Enable telemetry (enabled by default).
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index cf64add109..96dd02cbd7 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -234,6 +234,22 @@ The dynamic fields and flags are managed with the functions ``rte_mbuf_dyn*``.
 
 It is not possible to unregister fields or flags.
 
+The EAL option ``--mbuf-metadata-size`` can add extra cache-line-aligned
+metadata storage to every pktmbuf object.  This storage is placed after the
+fixed ``struct rte_mbuf`` header and before the application private data area,
+so ``sizeof(struct rte_mbuf)`` does not change.  The option defaults to ``0``.
+The primary process configures this value and shares it with secondary
+processes.  Secondary processes may omit this option, but if specified it must
+match the primary process value.
+The extra storage is reserved for dynamic fields registered with
+``RTE_MBUF_DYNFIELD_F_METADATA``.  These fields are not copied by mbuf copy,
+clone, or attach operations.  Dynamic fields registered without this flag
+continue to use the existing copied dynamic-field storage and cannot overlap the
+metadata area.  Code that needs the runtime mbuf object size, such as
+application private-data accessors or drivers programming offsets from the
+start of an mbuf, should use ``rte_mbuf_size()`` instead of
+``sizeof(struct rte_mbuf)``.
+
 .. _direct_indirect_buffer:
 
 Direct and Indirect Buffers
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..4e27d466eb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,26 @@ New Features
   Added the experimental ``rte_cpu_socket_id()`` function
   to map an OS logical CPU ID to the NUMA socket containing that CPU.
 
+* **Added optional mbuf metadata storage.**
+
+  Added ``--mbuf-metadata-size`` EAL option to enable a
+  cache-line-aligned metadata area in every pktmbuf object.
+  The storage is placed after the fixed ``struct rte_mbuf`` header and
+  before application private data, leaving ``sizeof(struct rte_mbuf)``
+  unchanged.
+  The primary process configures this value and shares it with secondary
+  processes.
+  Secondary processes may omit the option, but if specified it must match
+  the primary process value.
+  The metadata area is reserved for dynamic fields registered with
+  ``RTE_MBUF_DYNFIELD_F_METADATA``.
+  These fields are not copied by generic mbuf copy, clone, or attach
+  operations.
+  Dynamic fields registered without this flag continue to use the existing
+  copied dynamic-field storage and cannot overlap the metadata area.
+  Code that needs the runtime mbuf object size should use
+  ``rte_mbuf_size()`` instead of ``sizeof(struct rte_mbuf)``.
+
 * **Added TPID support to VLAN tag insertion.**
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
@@ -338,7 +358,6 @@ Known Issues
    Also, make sure to start the actual text at the margin.
    =======================================================
 
-
 Tested Platforms
 ----------------
 
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 870e65c049..670930e1f7 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -1406,7 +1406,7 @@ cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 			wqe_hdr = (wqe_hdr - 1) & ~(BIT_ULL(7) - 1);
 
 			/* Pointer to WQE header */
-			*(uint64_t *)(m + 1) = wqe_hdr;
+			*(uint64_t *)RTE_PTR_ADD(m, rte_mbuf_size()) = wqe_hdr;
 
 			/* Reserve SG list after end of last mbuf data location. */
 			rxphdr = wqe_hdr + 8;
@@ -1422,8 +1422,8 @@ cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 			/* Reserve space for WQE, NIX_RX_PARSE_S and SG_S.
 			 * Populate SG_S with num segs and seg length
 			 */
-			wqe_hdr = (uintptr_t)(m + 1);
-			*(uint64_t *)(m + 1) = wqe_hdr;
+			wqe_hdr = (uintptr_t)RTE_PTR_ADD(m, rte_mbuf_size());
+			*(uint64_t *)wqe_hdr = wqe_hdr;
 
 			sg2 = (struct roc_sg2list_comp *)(wqe_hdr + 8 * 8);
 			sg2->u.s.len[0] = rte_pktmbuf_pkt_len(m);
@@ -1443,7 +1443,7 @@ cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 
 		/* Word 2 and 3 */
 		inst_23 = vdupq_n_u64(0);
-		u64_1 = (((uint64_t)m + sizeof(struct rte_mbuf)) >> 3) << 3 | 1;
+		u64_1 = (((uint64_t)m + rte_mbuf_size()) >> 3) << 3 | 1;
 		inst_23 = vsetq_lane_u64(u64_1, inst_23, 1);
 		vst1q_u64(&inst->w2.u64, inst_23);
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 18100ff1f8..670473fded 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -1557,7 +1557,7 @@ cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 			wqe_hdr = (wqe_hdr - 1) & ~(BIT_ULL(7) - 1);
 
 			/* Pointer to WQE header */
-			*(uint64_t *)(m + 1) = wqe_hdr;
+			*(uint64_t *)RTE_PTR_ADD(m, rte_mbuf_size()) = wqe_hdr;
 
 			/* Reserve SG list after end of last mbuf data location. */
 			rxphdr = wqe_hdr + 8;
@@ -1573,8 +1573,8 @@ cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 			/* Reserve space for WQE, NIX_RX_PARSE_S and SG_S.
 			 * Populate SG_S with num segs and seg length
 			 */
-			wqe_hdr = (uintptr_t)(m + 1);
-			*(uint64_t *)(m + 1) = wqe_hdr;
+			wqe_hdr = (uintptr_t)RTE_PTR_ADD(m, rte_mbuf_size());
+			*(uint64_t *)wqe_hdr = wqe_hdr;
 
 			sg2 = (struct roc_sg2list_comp *)(wqe_hdr + 8 * 8);
 			sg2->u.s.len[0] = rte_pktmbuf_pkt_len(m);
@@ -1594,7 +1594,7 @@ cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 
 		/* Word 2 and 3 */
 		inst_23 = vdupq_n_u64(0);
-		u64_1 = (((uint64_t)m + sizeof(struct rte_mbuf)) >> 3) << 3 | 1;
+		u64_1 = (((uint64_t)m + rte_mbuf_size()) >> 3) << 3 | 1;
 		inst_23 = vsetq_lane_u64(u64_1, inst_23, 1);
 		vst1q_u64(&inst->w2.u64, inst_23);
 
diff --git a/drivers/event/cnxk/cn10k_worker.h b/drivers/event/cnxk/cn10k_worker.h
index 9b6abdf18d..3c642f63a2 100644
--- a/drivers/event/cnxk/cn10k_worker.h
+++ b/drivers/event/cnxk/cn10k_worker.h
@@ -95,7 +95,7 @@ cn10k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 		uint64_t sg_w1;
 
 		mbuf = (struct rte_mbuf *)((uintptr_t)wqe[0] -
-					   sizeof(struct rte_mbuf));
+					   rte_mbuf_size());
 		/* Pick first mbuf's aura handle assuming all
 		 * mbufs are from a vec and are from same RQ.
 		 */
@@ -114,7 +114,7 @@ cn10k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 		struct nix_cqe_hdr_s *cqe = (struct nix_cqe_hdr_s *)wqe[0];
 
 		mbuf = (struct rte_mbuf *)((char *)cqe -
-					   sizeof(struct rte_mbuf));
+					   rte_mbuf_size());
 
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
@@ -171,7 +171,7 @@ cn10k_sso_hws_post_process(struct cn10k_sso_hws *ws, uint64_t *u64,
 		uintptr_t cpth = 0;
 		uint64_t mbuf;
 
-		mbuf = u64[1] - sizeof(struct rte_mbuf);
+		mbuf = u64[1] - rte_mbuf_size();
 		rte_prefetch0((void *)mbuf);
 
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 29495eb4f9..d763adf0c4 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -760,7 +760,7 @@ cn20k_sso_rxq_enable(struct cnxk_eth_dev *cnxk_eth_dev, uint16_t rq_id, uint16_t
 	rq->sso_ena = 1;
 	rq->tt = tt;
 	rq->hwgrp = queue_conf->ev.queue_id;
-	wqe_skip = RTE_ALIGN_CEIL(sizeof(struct rte_mbuf), ROC_CACHE_LINE_SZ);
+	wqe_skip = RTE_ALIGN_CEIL(rte_mbuf_size(), ROC_CACHE_LINE_SZ);
 	wqe_skip = wqe_skip / ROC_CACHE_LINE_SZ;
 	rq->wqe_skip = wqe_skip;
 
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index 6442113e09..e6f969b0a2 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -48,7 +48,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 {
 	uint64_t mbuf_init = 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
 	struct cnxk_timesync_info *tstamp = ws->tstamp[port_id];
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	uint32_t m_sz = rte_mbuf_size();
 	void *lookup_mem = ws->lookup_mem;
 	uint64_t meta_aura = 0, laddr = 0;
 	uintptr_t lbase = ws->lmt_base;
@@ -93,7 +93,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 	if (flags & NIX_RX_OFFLOAD_SECURITY_F && non_vec) {
 		uint64_t sg_w1;
 
-		mbuf = (struct rte_mbuf *)((uintptr_t)wqe[0] - sizeof(struct rte_mbuf));
+		mbuf = (struct rte_mbuf *)((uintptr_t)wqe[0] - m_sz);
 		/* Pick first mbuf's aura handle assuming all
 		 * mbufs are from a vec and are from same RQ.
 		 */
@@ -114,7 +114,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 	while (non_vec) {
 		struct nix_cqe_hdr_s *cqe = (struct nix_cqe_hdr_s *)wqe[0];
 
-		mbuf = (struct rte_mbuf *)((char *)cqe - sizeof(struct rte_mbuf));
+		mbuf = (struct rte_mbuf *)((char *)cqe - m_sz);
 
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
@@ -165,7 +165,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 static __rte_always_inline void
 cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32_t flags)
 {
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	uint32_t m_sz = rte_mbuf_size();
 	uintptr_t sa_base = 0;
 
 	u64[0] = (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull << 36)) << 4 |
@@ -183,7 +183,7 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 		uintptr_t cpth = 0;
 		uint64_t mbuf;
 
-		mbuf = u64[1] - sizeof(struct rte_mbuf);
+		mbuf = u64[1] - m_sz;
 		rte_prefetch0((void *)mbuf);
 
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
diff --git a/drivers/event/cnxk/cn9k_worker.h b/drivers/event/cnxk/cn9k_worker.h
index 513d397991..7fa467a210 100644
--- a/drivers/event/cnxk/cn9k_worker.h
+++ b/drivers/event/cnxk/cn9k_worker.h
@@ -232,21 +232,22 @@ cn9k_sso_hws_dual_get_work(uint64_t base, uint64_t pair_base,
 		     "		tbnz %[tag], 63, .Lrty%=	\n"
 		     ".Ldone%=:	str %[gw], [%[pong]]		\n"
 		     "		dmb ld				\n"
-		     "		sub %[mbuf], %[wqp], #0x80	\n"
+		     "		sub %[mbuf], %[wqp], %[mbuf_hdr_sz]\n"
 		     "		prfm pldl1keep, [%[mbuf]]	\n"
 		     : [tag] "=&r"(gw.u64[0]), [wqp] "=&r"(gw.u64[1]),
 		       [mbuf] "=&r"(mbuf)
 		     : [tag_loc] "r"(base + SSOW_LF_GWS_TAG),
 		       [wqp_loc] "r"(base + SSOW_LF_GWS_WQP),
 		       [gw] "r"(dws->gw_wdata),
-		       [pong] "r"(pair_base + SSOW_LF_GWS_OP_GET_WORK0));
+		       [pong] "r"(pair_base + SSOW_LF_GWS_OP_GET_WORK0),
+		       [mbuf_hdr_sz] "r" ((uint64_t)rte_mbuf_size()));
 #else
 	gw.u64[0] = plt_read64(base + SSOW_LF_GWS_TAG);
 	while ((BIT_ULL(63)) & gw.u64[0])
 		gw.u64[0] = plt_read64(base + SSOW_LF_GWS_TAG);
 	gw.u64[1] = plt_read64(base + SSOW_LF_GWS_WQP);
 	plt_write64(dws->gw_wdata, pair_base + SSOW_LF_GWS_OP_GET_WORK0);
-	mbuf = (uint64_t)((char *)gw.u64[1] - sizeof(struct rte_mbuf));
+	mbuf = (uint64_t)((char *)gw.u64[1] - rte_mbuf_size());
 #endif
 
 	if (gw.u64[1])
@@ -284,19 +285,20 @@ cn9k_sso_hws_get_work(struct cn9k_sso_hws *ws, struct rte_event *ev,
 		     "		ldr %[wqp], [%[wqp_loc]]	\n"
 		     "		tbnz %[tag], 63, .Lrty%=	\n"
 		     ".Ldone%=:	dmb ld				\n"
-		     "		sub %[mbuf], %[wqp], #0x80	\n"
+		     "		sub %[mbuf], %[wqp], %[mbuf_hdr_sz]\n"
 		     "		prfm pldl1keep, [%[mbuf]]	\n"
 		     : [tag] "=&r"(gw.u64[0]), [wqp] "=&r"(gw.u64[1]),
 		       [mbuf] "=&r"(mbuf)
 		     : [tag_loc] "r"(ws->base + SSOW_LF_GWS_TAG),
-		       [wqp_loc] "r"(ws->base + SSOW_LF_GWS_WQP));
+		       [wqp_loc] "r"(ws->base + SSOW_LF_GWS_WQP),
+		       [mbuf_hdr_sz] "r" ((uint64_t)rte_mbuf_size()));
 #else
 	gw.u64[0] = plt_read64(ws->base + SSOW_LF_GWS_TAG);
 	while ((BIT_ULL(63)) & gw.u64[0])
 		gw.u64[0] = plt_read64(ws->base + SSOW_LF_GWS_TAG);
 
 	gw.u64[1] = plt_read64(ws->base + SSOW_LF_GWS_WQP);
-	mbuf = (uint64_t)((char *)gw.u64[1] - sizeof(struct rte_mbuf));
+	mbuf = (uint64_t)((char *)gw.u64[1] - rte_mbuf_size());
 #endif
 
 	if (gw.u64[1])
@@ -332,18 +334,19 @@ cn9k_sso_hws_get_work_empty(uint64_t base, struct rte_event *ev,
 		     "		ldr %[wqp], [%[wqp_loc]]	\n"
 		     "		tbnz %[tag], 63, .Lrty%=	\n"
 		     ".Ldone%=:	dmb ld				\n"
-		     "		sub %[mbuf], %[wqp], #0x80	\n"
+		     "		sub %[mbuf], %[wqp], %[mbuf_hdr_sz]\n"
 		     : [tag] "=&r"(gw.u64[0]), [wqp] "=&r"(gw.u64[1]),
 		       [mbuf] "=&r"(mbuf)
 		     : [tag_loc] "r"(base + SSOW_LF_GWS_TAG),
-		       [wqp_loc] "r"(base + SSOW_LF_GWS_WQP));
+		       [wqp_loc] "r"(base + SSOW_LF_GWS_WQP),
+		       [mbuf_hdr_sz] "r" ((uint64_t)rte_mbuf_size()));
 #else
 	gw.u64[0] = plt_read64(base + SSOW_LF_GWS_TAG);
 	while ((BIT_ULL(63)) & gw.u64[0])
 		gw.u64[0] = plt_read64(base + SSOW_LF_GWS_TAG);
 
 	gw.u64[1] = plt_read64(base + SSOW_LF_GWS_WQP);
-	mbuf = (uint64_t)((char *)gw.u64[1] - sizeof(struct rte_mbuf));
+	mbuf = (uint64_t)((char *)gw.u64[1] - rte_mbuf_size());
 #endif
 
 	if (gw.u64[1])
@@ -671,7 +674,7 @@ cn9k_sso_hws_xmit_sec_one(const struct cn9k_eth_txq *txq, uint64_t base,
 	cmd23 = vsetq_lane_u64((((uint64_t)RTE_EVENT_TYPE_CPU << 28) |
 				CNXK_ETHDEV_SEC_OUTB_EV_SUB << 20),
 			       cmd23, 0);
-	cmd23 = vsetq_lane_u64(((uintptr_t)m + sizeof(struct rte_mbuf)) | 1,
+	cmd23 = vsetq_lane_u64(((uintptr_t)m + rte_mbuf_size()) | 1,
 			       cmd23, 1);
 
 	dptr += l2_len - ROC_ONF_IPSEC_OUTB_MAX_L2_INFO_SZ -
diff --git a/drivers/event/cnxk/cnxk_eventdev_adptr.c b/drivers/event/cnxk/cnxk_eventdev_adptr.c
index 5678e5d264..843badbc2e 100644
--- a/drivers/event/cnxk/cnxk_eventdev_adptr.c
+++ b/drivers/event/cnxk/cnxk_eventdev_adptr.c
@@ -135,7 +135,7 @@ cnxk_sso_rxq_enable(struct cnxk_eth_dev *cnxk_eth_dev, uint16_t rq_id,
 	rq->tt = ev->sched_type;
 	rq->hwgrp = ev->queue_id;
 	rq->flow_tag_width = 20;
-	wqe_skip = RTE_ALIGN_CEIL(sizeof(struct rte_mbuf), ROC_CACHE_LINE_SZ);
+	wqe_skip = RTE_ALIGN_CEIL(rte_mbuf_size(), ROC_CACHE_LINE_SZ);
 	wqe_skip = wqe_skip / ROC_CACHE_LINE_SZ;
 	rq->wqe_skip = wqe_skip;
 	rq->tag_mask = (port_id & 0xF) << 20;
diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 2f8555a026..f5a107ed23 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -110,7 +110,7 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_dpaa_bpid_info[bpid].size = elem_max_size;
 	rte_dpaa_bpid_info[bpid].bp = bp;
 	rte_dpaa_bpid_info[bpid].meta_data_size =
-		sizeof(struct rte_mbuf) + rte_pktmbuf_priv_size(mp);
+		rte_mbuf_size() + rte_pktmbuf_priv_size(mp);
 	rte_dpaa_bpid_info[bpid].dpaa_ops_index = mp->ops_index;
 	rte_dpaa_bpid_info[bpid].ptov_off = 0;
 	rte_dpaa_bpid_info[bpid].flags = 0;
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index ee001d8ce0..003e8243a0 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -119,7 +119,7 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	/* Set parameters of buffer pool list */
 	bp_list->buf_pool.num_bufs = mp->size;
 	bp_list->buf_pool.size = mp->elt_size
-			- sizeof(struct rte_mbuf) - rte_pktmbuf_priv_size(mp);
+			- rte_mbuf_size() - rte_pktmbuf_priv_size(mp);
 	bp_list->buf_pool.bpid = dpbp_attr.bpid;
 	bp_list->buf_pool.h_bpool_mem = NULL;
 	bp_list->buf_pool.dpbp_node = avail_dpbp;
@@ -138,7 +138,7 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 
 	bpid = dpbp_attr.bpid;
 
-	rte_dpaa2_bpid_info[bpid].meta_data_size = sizeof(struct rte_mbuf)
+	rte_dpaa2_bpid_info[bpid].meta_data_size = rte_mbuf_size()
 				+ rte_pktmbuf_priv_size(mp);
 	rte_dpaa2_bpid_info[bpid].bp_list = bp_list;
 	rte_dpaa2_bpid_info[bpid].bpid = bpid;
@@ -332,7 +332,7 @@ int rte_dpaa2_bpid_info_init(struct rte_mempool *mp)
 		       sizeof(struct dpaa2_bp_info) * MAX_BPID);
 	}
 
-	rte_dpaa2_bpid_info[bpid].meta_data_size = sizeof(struct rte_mbuf)
+	rte_dpaa2_bpid_info[bpid].meta_data_size = rte_mbuf_size()
 				+ rte_pktmbuf_priv_size(mp);
 	rte_dpaa2_bpid_info[bpid].bp_list = bp_info->bp_list;
 	rte_dpaa2_bpid_info[bpid].bpid = bpid;
diff --git a/drivers/mempool/octeontx/meson.build b/drivers/mempool/octeontx/meson.build
index 3ccecac75d..3344defac8 100644
--- a/drivers/mempool/octeontx/meson.build
+++ b/drivers/mempool/octeontx/meson.build
@@ -6,7 +6,6 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
     reason = 'only supported on 64-bit Linux'
     subdir_done()
 endif
-
 sources = files(
         'octeontx_fpavf.c',
         'rte_mempool_octeontx.c',
diff --git a/drivers/mempool/octeontx/rte_mempool_octeontx.c b/drivers/mempool/octeontx/rte_mempool_octeontx.c
index 631e521b58..20c96774a1 100644
--- a/drivers/mempool/octeontx/rte_mempool_octeontx.c
+++ b/drivers/mempool/octeontx/rte_mempool_octeontx.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2017 Cavium, Inc
  */
 
+#include <errno.h>
 #include <stdio.h>
 #include <rte_mempool.h>
 #include <rte_malloc.h>
@@ -17,6 +18,11 @@ octeontx_fpavf_alloc(struct rte_mempool *mp)
 	uint32_t object_size;
 	int rc = 0;
 
+	if (rte_mbuf_metadata_size_get() != 0) {
+		fpavf_log_err("mbuf metadata area is not supported");
+		return -ENOTSUP;
+	}
+
 	object_size = mp->elt_size + mp->header_size + mp->trailer_size;
 
 	pool = octeontx_fpa_bufpool_create(object_size, memseg_count,
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 9c99dcec20..1bff1335bd 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -431,7 +431,7 @@ af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		bufs[i] = (struct rte_mbuf *)
 				xsk_umem__get_data(umem->buffer, addr +
 					umem->mb_pool->header_size);
-		bufs[i]->data_off = offset - sizeof(struct rte_mbuf) -
+		bufs[i]->data_off = offset - rte_mbuf_size() -
 			rte_pktmbuf_priv_size(umem->mb_pool) -
 			umem->mb_pool->header_size;
 		bufs[i]->port = rxq->port;
@@ -1061,7 +1061,7 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
 	dev_info->max_rx_pktlen = getpagesize() -
 				  sizeof(struct rte_mempool_objhdr) -
-				  sizeof(struct rte_mbuf) -
+				  rte_mbuf_size() -
 				  RTE_PKTMBUF_HEADROOM - XDP_PACKET_HEADROOM;
 #else
 	dev_info->max_rx_pktlen = ETH_AF_XDP_FRAME_SIZE - XDP_PACKET_HEADROOM;
@@ -1419,7 +1419,7 @@ xsk_umem_info *xdp_umem_configure(struct pmd_internals *internals,
 			rte_mempool_calc_obj_size(mb_pool->elt_size,
 						  mb_pool->flags, NULL);
 		usr_config.frame_headroom = mb_pool->header_size +
-						sizeof(struct rte_mbuf) +
+						rte_mbuf_size() +
 						rte_pktmbuf_priv_size(mb_pool) +
 						RTE_PKTMBUF_HEADROOM;
 
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 98bdbc136a..d18925ef4c 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -1527,7 +1527,7 @@ int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
 	struct bnxt_rx_ring_info *rxr;
 	struct bnxt_ring *ring;
 
-	rxq->rx_buf_size = BNXT_MAX_PKT_LEN + sizeof(struct rte_mbuf);
+	rxq->rx_buf_size = BNXT_MAX_PKT_LEN + rte_mbuf_size();
 
 	if (rxq->rx_ring != NULL) {
 		rxr = rxq->rx_ring;
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 36188346f1..285cb0bb43 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -213,7 +213,7 @@ bnxt_invalid_nb_segs(struct rte_mbuf *tx_pkt)
 
 static int bnxt_invalid_mbuf(struct rte_mbuf *mbuf)
 {
-	uint32_t mbuf_size = sizeof(struct rte_mbuf) + mbuf->priv_size;
+	uint32_t mbuf_size = rte_mbuf_size() + mbuf->priv_size;
 	const char *reason;
 
 	if (unlikely(rte_eal_iova_mode() != RTE_IOVA_VA &&
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 0682294099..8b338b755b 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -551,7 +551,7 @@ cn10k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 	switch ((gw[0] >> 28) & 0xF) {
 	case RTE_EVENT_TYPE_ETHDEV:
 		/* Event from inbound inline dev due to IPSEC packet bad L4 */
-		mbuf = (struct rte_mbuf *)(gw[1] - sizeof(struct rte_mbuf));
+		mbuf = (struct rte_mbuf *)(gw[1] - rte_mbuf_size());
 		plt_nix_dbg("Received mbuf %p from inline dev inbound", mbuf);
 		cnxk_pktmbuf_free_no_cache(mbuf);
 		return;
diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
index e55910b575..cf06bf09cd 100644
--- a/drivers/net/cnxk/cn10k_rx.h
+++ b/drivers/net/cnxk/cn10k_rx.h
@@ -174,7 +174,8 @@ static __rte_always_inline void
 nix_sec_reass_first_frag_update(struct rte_mbuf *head, const uint8_t *m_ipptr,
 				uint64_t fsz, uint64_t cq_w1, uint16_t *ihl)
 {
-	union nix_rx_parse_u *rx = (union nix_rx_parse_u *)((uintptr_t)(head + 1) + 8);
+	union nix_rx_parse_u *rx =
+		(union nix_rx_parse_u *)RTE_PTR_ADD(head, rte_mbuf_size() + 8);
 	uint16_t fragx_sum = vaddv_u16(vreinterpret_u16_u64(vdup_n_u64(fsz)));
 	uint8_t lcptr = rx->lcptr;
 	uint16_t tot_len;
@@ -287,7 +288,7 @@ nix_sec_attach_frags(const struct cpt_cn10k_parse_hdr_s *hdr,
 	nix_sec_reass_frags_get(hdr, next_mbufs);
 
 	/* Frag-0: */
-	wqe = (uint64_t *)(head + 1);
+	wqe = (uint64_t *)RTE_PTR_ADD(head, rte_mbuf_size());
 	rlen = ((*(wqe + 10)) >> 16) & 0xFFFF;
 
 	frag_rx = (union nix_rx_parse_u *)(wqe + 1);
@@ -304,7 +305,7 @@ nix_sec_attach_frags(const struct cpt_cn10k_parse_hdr_s *hdr,
 		cnxk_ip_reassembly_dynfield(mbuf, off)->next_frag = next_mbufs[frag_i];
 		cnxk_ip_reassembly_dynfield(mbuf, off)->nb_frags = num_frags;
 		mbuf = next_mbufs[frag_i];
-		wqe = (uint64_t *)(mbuf + 1);
+		wqe = (uint64_t *)RTE_PTR_ADD(mbuf, rte_mbuf_size());
 		rlen = ((*(wqe + 10)) >> 16) & 0xFFFF;
 
 		frag_rx = (union nix_rx_parse_u *)(wqe + 1);
@@ -353,7 +354,7 @@ nix_sec_reassemble_frags(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbu
 	fsz_w1 = nix_sec_reass_frags_get(hdr, next_mbufs);
 
 	/* Frag-0: */
-	wqe = (uint64_t *)(head + 1);
+	wqe = (uint64_t *)RTE_PTR_ADD(head, rte_mbuf_size());
 
 	/* First fragment data len is already update by caller */
 	m_ipptr = ((const uint8_t *)hdr + ((cq_w5 >> 16) & 0xFF));
@@ -363,7 +364,7 @@ nix_sec_reassemble_frags(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbu
 	/* Frag-1: */
 	head->next = next_mbufs[0];
 	mbuf = next_mbufs[0];
-	wqe = (uint64_t *)(mbuf + 1);
+	wqe = (uint64_t *)RTE_PTR_ADD(mbuf, rte_mbuf_size());
 	frag_rx = (union nix_rx_parse_u *)(wqe + 1);
 	frag_size = fsz_w1 & 0xFFFF;
 	fsz_w1 >>= 16;
@@ -379,7 +380,7 @@ nix_sec_reassemble_frags(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbu
 	if (num_frags > 2) {
 		mbuf->next = next_mbufs[1];
 		mbuf = next_mbufs[1];
-		wqe = (uint64_t *)(mbuf + 1);
+		wqe = (uint64_t *)RTE_PTR_ADD(mbuf, rte_mbuf_size());
 		frag_rx = (union nix_rx_parse_u *)(wqe + 1);
 		frag_size = fsz_w1 & 0xFFFF;
 		fsz_w1 >>= 16;
@@ -396,7 +397,7 @@ nix_sec_reassemble_frags(const struct cpt_cn10k_parse_hdr_s *hdr, struct rte_mbu
 	if (num_frags > 3) {
 		mbuf->next = next_mbufs[2];
 		mbuf = next_mbufs[2];
-		wqe = (uint64_t *)(mbuf + 1);
+		wqe = (uint64_t *)RTE_PTR_ADD(mbuf, rte_mbuf_size());
 		frag_rx = (union nix_rx_parse_u *)(wqe + 1);
 		frag_size = fsz_w1 & 0xFFFF;
 		fsz_w1 >>= 16;
@@ -473,7 +474,7 @@ nix_sec_meta_to_mbuf_sc(uint64_t cq_w1, uint64_t cq_w5, const uint64_t sa_base,
 		inner = nix_sec_oop_process(hdr, mbuf, &mbuf_init);
 	} else {
 		inner = (struct rte_mbuf *)(rte_be_to_cpu_64(hdr->wqe_ptr) -
-					    sizeof(struct rte_mbuf));
+					    rte_mbuf_size());
 
 		/* Store meta in lmtline to free
 		 * Assume all meta's from same aura.
@@ -728,15 +729,16 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf,
 	/* Use inner rx parse for meta pkts sg list */
 	if (cq_w1 & BIT(11) && flags & NIX_RX_OFFLOAD_SECURITY_F) {
 		const uint64_t *wqe;
-		/* Rx Inject packet must have Match ID 0xFFFF and for this
-		 * wqe will get from address stored at mbuf+1 location
-		 */
-		rx_inj = ((flags & NIX_RX_REAS_F) && ((hdr->w0.match_id == 0xFFFFU) ||
-					       (hdr->w0.cookie == 0xFFFFFFFFU)));
-		if (rx_inj)
-			wqe = (const uint64_t *)*((uint64_t *)(mbuf + 1));
-		else
-			wqe = (const uint64_t *)(mbuf + 1);
+			/* Rx Inject packet must have Match ID 0xFFFF. For this,
+			 * WQE is fetched from the post-mbuf header area.
+			 */
+			rx_inj = ((flags & NIX_RX_REAS_F) && ((hdr->w0.match_id == 0xFFFFU) ||
+						       (hdr->w0.cookie == 0xFFFFFFFFU)));
+			if (rx_inj)
+				wqe = (const uint64_t *)*((uint64_t *)
+					RTE_PTR_ADD(mbuf, rte_mbuf_size()));
+			else
+				wqe = (const uint64_t *)RTE_PTR_ADD(mbuf, rte_mbuf_size());
 
 		if (!(flags & NIX_RX_REAS_F) || hdr->w0.pkt_fmt != ROC_IE_OT_SA_PKT_FMT_FULL)
 			rx = (const union nix_rx_parse_u *)(wqe + 1);
@@ -826,7 +828,8 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf,
 		struct rte_mbuf *next_frag = next_mbufs[frag_i];
 		uint16_t lcptr, ldptr = 0;
 
-		rx = (const union nix_rx_parse_u *)((uintptr_t)(next_frag + 1) + 8);
+		rx = (const union nix_rx_parse_u *)RTE_PTR_ADD(next_frag,
+							       rte_mbuf_size() + 8);
 		lcptr = (*((const uint64_t *)rx + 4) >> 16) & 0xFF;
 		eol = ((const rte_iova_t *)(rx + 1) + ((rx->desc_sizem1 + 1) << 1));
 		sg = *(const uint64_t *)(rx + 1);
@@ -1325,11 +1328,12 @@ cn10k_nix_inj_pkts(struct rte_security_session **sess, struct cnxk_ethdev_inj_cf
 
 		if (m->nb_segs > 1) {
 			/* Will reserve NIX Rx descriptor with SG list after end of
-			 * last mbuf data location. and pointer to this will be
-			 * stored at 1st mbuf space for Rx path multi-seg processing.
+			 * last mbuf data location. Pointer to this will be stored
+			 * in the post-mbuf header area for Rx path multi-seg
+			 * processing.
 			 */
 			/* Pointer to WQE header */
-			*(uint64_t *)(m + 1) = cptres;
+			*(uint64_t *)RTE_PTR_ADD(m, rte_mbuf_size()) = cptres;
 			/* Reserve 8 Dwords of WQE Hdr + Rx Parse Hdr */
 			rxphdr = cptres + 8;
 			dptr = rxphdr + 7 * 8;
@@ -1355,7 +1359,7 @@ cn10k_nix_inj_pkts(struct rte_security_session **sess, struct cnxk_ethdev_inj_cf
 		/* Set PF func */
 		w0 &= 0xFFFF000000000000UL;
 		cmd23 = vsetq_lane_u64(w0, cmd23, 0);
-		cmd23 = vsetq_lane_u64(((uint64_t)m + sizeof(struct rte_mbuf)) | 1, cmd23, 1);
+		cmd23 = vsetq_lane_u64(((uint64_t)m + rte_mbuf_size()) | 1, cmd23, 1);
 
 		sa_base &= ~0xFFFFUL;
 		sa = (uintptr_t)roc_nix_inl_ot_ipsec_inb_sa(sa_base, sess_priv.sa_idx);
@@ -1499,7 +1503,7 @@ cn10k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts,
 			uint16_t port;
 
 			mbuf0 = (struct rte_mbuf *)((uintptr_t)mbufs[0] -
-						    sizeof(struct rte_mbuf));
+						    rte_mbuf_size());
 			/* Pick first mbuf's aura handle assuming all
 			 * mbufs are from a vec and are from same RQ.
 			 */
@@ -1651,10 +1655,10 @@ cn10k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts,
 		} else {
 			mbuf01 =
 				vsubq_u64(vld1q_u64((uint64_t *)cq0),
-					  vdupq_n_u64(sizeof(struct rte_mbuf)));
+					  vdupq_n_u64(rte_mbuf_size()));
 			mbuf23 =
 				vsubq_u64(vld1q_u64((uint64_t *)(cq0 + 16)),
-					  vdupq_n_u64(sizeof(struct rte_mbuf)));
+					  vdupq_n_u64(rte_mbuf_size()));
 		}
 
 		/* Move mbufs to scalar registers for future use */
@@ -1793,9 +1797,9 @@ cn10k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts,
 			wqe23 = vrev64q_u8(wqe23);
 			/* Adjust wqe pointers to point to mbuf */
 			wqe01 = vsubq_u64(wqe01,
-					  vdupq_n_u64(sizeof(struct rte_mbuf)));
+					  vdupq_n_u64(rte_mbuf_size()));
 			wqe23 = vsubq_u64(wqe23,
-					  vdupq_n_u64(sizeof(struct rte_mbuf)));
+					  vdupq_n_u64(rte_mbuf_size()));
 
 			/* Extract sa idx from cookie area and add to sa_base */
 			sa01 = vzip1q_u64(inner0, inner1);
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index 65f0235a46..945b253ff4 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -546,7 +546,7 @@ cn20k_eth_sec_sso_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type type
 	switch ((gw[0] >> 28) & 0xF) {
 	case RTE_EVENT_TYPE_ETHDEV:
 		/* Event from inbound inline dev due to IPSEC packet bad L4 */
-		mbuf = (struct rte_mbuf *)(gw[1] - sizeof(struct rte_mbuf));
+		mbuf = (struct rte_mbuf *)(gw[1] - rte_mbuf_size());
 		plt_nix_dbg("Received mbuf %p from inline dev inbound", mbuf);
 		cnxk_pktmbuf_free_no_cache(mbuf);
 		return;
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index f8fa6de2b9..25cdab5704 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -215,7 +215,7 @@ nix_sec_oop_process(uintptr_t cpth, uint64_t buf_sz)
 	offset = addr % (buf_sz & 0xFFFFFFFF);
 	mbuf = (struct rte_mbuf *)(addr - offset + (buf_sz >> 32));
 
-	rx = (union nix_rx_parse_u *)(((uintptr_t)(mbuf + 1)) + 8);
+	rx = (union nix_rx_parse_u *)RTE_PTR_ADD(mbuf, rte_mbuf_size() + 8);
 	mbuf->pkt_len = rx->pkt_lenm1 + 1;
 	mbuf->data_len = rx->pkt_lenm1 + 1;
 	mbuf->data_off = addr - (uint64_t)mbuf->buf_addr;
@@ -702,7 +702,7 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, co
 	uint64_t mbuf_init = rxq->mbuf_initializer;
 	const void *lookup_mem = rxq->lookup_mem;
 	const uint64_t data_off = rxq->data_off;
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	uint32_t m_sz = rte_mbuf_size();
 	const uint64_t wdata = rxq->wdata;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
@@ -815,7 +815,7 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 	uint64_t mbuf_init = rxq->mbuf_initializer;
 	const void *lookup_mem = rxq->lookup_mem;
 	const uint64_t data_off = rxq->data_off;
-	uint8_t m_sz = sizeof(struct rte_mbuf);
+	uint32_t m_sz = rte_mbuf_size();
 	const uint64_t wdata = rxq->wdata;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
@@ -1016,7 +1016,7 @@ cn20k_nix_inj_pkts(struct rte_security_session **sess, struct cnxk_ethdev_inj_cf
 		/* Set PF func */
 		w0 &= 0xFFFF000000000000UL;
 		cmd23 = vsetq_lane_u64(w0, cmd23, 0);
-		cmd23 = vsetq_lane_u64(((uint64_t)m + sizeof(struct rte_mbuf)) | 1, cmd23, 1);
+		cmd23 = vsetq_lane_u64(((uint64_t)m + rte_mbuf_size()) | 1, cmd23, 1);
 
 		sa = (uintptr_t)roc_nix_inl_ow_ipsec_inb_sa(sa_base, sess_priv.sa_idx);
 		ucode_cmd[0] = (ROC_IE_OW_MAJOR_OP_PROCESS_INBOUND_IPSEC << 48 | 1UL << 54 |
@@ -1179,7 +1179,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 			uint64_t sg_w1;
 			uint16_t port;
 
-			mbuf0 = (struct rte_mbuf *)((uintptr_t)mbufs[0] - sizeof(struct rte_mbuf));
+			mbuf0 = (struct rte_mbuf *)((uintptr_t)mbufs[0] -
+						    rte_mbuf_size());
 			/* Pick first mbuf's aura handle assuming all
 			 * mbufs are from a vec and are from same RQ.
 			 */
@@ -1293,9 +1294,9 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 			mbuf23 = vqsubq_u64(mbuf23, data_off);
 		} else {
 			mbuf01 = vsubq_u64(vld1q_u64((uint64_t *)cq0),
-					   vdupq_n_u64(sizeof(struct rte_mbuf)));
+					   vdupq_n_u64(rte_mbuf_size()));
 			mbuf23 = vsubq_u64(vld1q_u64((uint64_t *)(cq0 + 16)),
-					   vdupq_n_u64(sizeof(struct rte_mbuf)));
+					   vdupq_n_u64(rte_mbuf_size()));
 		}
 
 		/* Move mbufs to scalar registers for future use */
@@ -1428,8 +1429,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 			wqe23 = vzip2q_u64(inner2, inner3);
 
 			/* Adjust wqe pointers to point to mbuf */
-			wqe01 = vsubq_u64(wqe01, vdupq_n_u64(sizeof(struct rte_mbuf)));
-			wqe23 = vsubq_u64(wqe23, vdupq_n_u64(sizeof(struct rte_mbuf)));
+			wqe01 = vsubq_u64(wqe01, vdupq_n_u64(rte_mbuf_size()));
+			wqe23 = vsubq_u64(wqe23, vdupq_n_u64(rte_mbuf_size()));
 
 			/* Extract sa idx from cookie area and add to sa_base */
 			sa01 = vzip1q_u64(inner0, inner1);
diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index 57e2c490df..8781156611 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -393,11 +393,11 @@ cnxk_eswitch_rxq_setup(struct cnxk_eswitch_dev *eswitch_dev, uint16_t qid, uint1
 	rq->wqe_caching = ROC_NIX_RQ_DEFAULT_WQE_CACHING;
 
 	/* Calculate first mbuf skip */
-	first_skip = (sizeof(struct rte_mbuf));
+	first_skip = rte_mbuf_size();
 	first_skip += RTE_PKTMBUF_HEADROOM;
 	first_skip += rte_pktmbuf_priv_size(lpb_pool);
 	rq->first_skip = first_skip;
-	rq->later_skip = sizeof(struct rte_mbuf) + rte_pktmbuf_priv_size(lpb_pool);
+	rq->later_skip = rte_mbuf_size() + rte_pktmbuf_priv_size(lpb_pool);
 	rq->lpb_size = lpb_pool->elt_size;
 	if (roc_errata_nix_no_meta_aura())
 		rq->lpb_drop_ena = true;
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 9a4da870cd..24fe1f455b 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -963,11 +963,11 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 	rq->wqe_caching = ROC_NIX_RQ_DEFAULT_WQE_CACHING;
 
 	/* Calculate first mbuf skip */
-	first_skip = (sizeof(struct rte_mbuf));
+	first_skip = rte_mbuf_size();
 	first_skip += RTE_PKTMBUF_HEADROOM;
 	first_skip += rte_pktmbuf_priv_size(lpb_pool);
 	rq->first_skip = first_skip;
-	rq->later_skip = sizeof(struct rte_mbuf) + rte_pktmbuf_priv_size(lpb_pool);
+	rq->later_skip = rte_mbuf_size() + rte_pktmbuf_priv_size(lpb_pool);
 	rq->lpb_size = lpb_pool->elt_size;
 	if (roc_errata_nix_no_meta_aura())
 		rq->lpb_drop_ena = !(dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY);
@@ -978,7 +978,7 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 		/* WQE skip is needed when poll mode is enabled in CN10KA_B0 and above
 		 * for Inline IPsec traffic to CQ without inline device.
 		 */
-		wqe_skip = RTE_ALIGN_CEIL(sizeof(struct rte_mbuf), ROC_CACHE_LINE_SZ);
+		wqe_skip = RTE_ALIGN_CEIL(rte_mbuf_size(), ROC_CACHE_LINE_SZ);
 		wqe_skip = wqe_skip / ROC_CACHE_LINE_SZ;
 		rq->wqe_skip = wqe_skip;
 	}
diff --git a/drivers/net/cnxk/cnxk_ethdev_dp.h b/drivers/net/cnxk/cnxk_ethdev_dp.h
index cd31a36936..cbf9564a4a 100644
--- a/drivers/net/cnxk/cnxk_ethdev_dp.h
+++ b/drivers/net/cnxk/cnxk_ethdev_dp.h
@@ -113,7 +113,7 @@ cnxk_pktmbuf_detach(struct rte_mbuf *m, uint64_t *aura)
 	refcount = rte_mbuf_refcnt_update(md, -1);
 
 	priv_size = rte_pktmbuf_priv_size(mp);
-	mbuf_size = (uint32_t)(sizeof(struct rte_mbuf) + priv_size);
+	mbuf_size = rte_mbuf_size() + priv_size;
 	buf_len = rte_pktmbuf_data_room_size(mp);
 
 	m->priv_size = priv_size;
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 61eb55ba43..c1f9bf8669 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -102,7 +102,7 @@ cnxk_nix_inl_meta_pool_cb(uint64_t *aura_handle, uintptr_t *mpool, uint32_t buf_
 	}
 
 	/* Init mempool private area */
-	first_skip = sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM;
+	first_skip = rte_mbuf_size() + RTE_PKTMBUF_HEADROOM;
 	memset(&mbp_priv, 0, sizeof(mbp_priv));
 	mbp_priv.mbuf_data_room_size = (buf_sz - first_skip +
 					RTE_PKTMBUF_HEADROOM);
@@ -648,7 +648,7 @@ rte_pmd_cnxk_inl_ipsec_res(struct rte_mbuf *mbuf)
 	if (!mbuf || !(mbuf->ol_flags & RTE_MBUF_F_RX_SEC_OFFLOAD))
 		return NULL;
 
-	wqe = (uintptr_t)(mbuf + 1);
+	wqe = (uintptr_t)RTE_PTR_ADD(mbuf, rte_mbuf_size());
 	rx = (const union nix_rx_parse_u *)(wqe + 8);
 	desc_size = (rx->desc_sizem1 + 1) * 16;
 
@@ -874,7 +874,7 @@ cnxk_nix_inl_dev_probe(struct rte_pci_driver *pci_drv,
 	}
 
 	/* WQE skip is one for DPDK */
-	wqe_skip = RTE_ALIGN_CEIL(sizeof(struct rte_mbuf), ROC_CACHE_LINE_SZ);
+	wqe_skip = RTE_ALIGN_CEIL(rte_mbuf_size(), ROC_CACHE_LINE_SZ);
 	wqe_skip = wqe_skip / ROC_CACHE_LINE_SZ;
 	inl_dev->wqe_skip = wqe_skip;
 	rc = roc_nix_inl_dev_init(inl_dev);
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 3b2daba79e..ac5a0152e5 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1758,7 +1758,7 @@ mempool_element_size_valid(struct rte_mempool *mp)
 	uint32_t min_size;
 
 	/* elt_size includes mbuf header and headroom */
-	min_size = mp->elt_size - sizeof(struct rte_mbuf) -
+	min_size = mp->elt_size - rte_mbuf_size() -
 			RTE_PKTMBUF_HEADROOM;
 
 	/* account for up to 512B of alignment */
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 2a91e02b45..fe14a92e56 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -122,15 +122,15 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 static struct rte_mbuf *
 mlx5_alloc_null_mbuf(uint32_t data_len)
 {
-	size_t alloc_size = sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM +
+	size_t alloc_size = rte_mbuf_size() + RTE_PKTMBUF_HEADROOM +
 		rte_align32pow2(data_len);
 	struct rte_mbuf *m;
 
 	m = mlx5_malloc(MLX5_MEM_ZERO, alloc_size, 0, SOCKET_ID_ANY);
 	if (m == NULL)
 		return NULL;
-	m->buf_addr = RTE_PTR_ADD(m, sizeof(*m));
-	m->buf_len = alloc_size - sizeof(*m);
+	m->buf_addr = RTE_PTR_ADD(m, rte_mbuf_size());
+	m->buf_len = alloc_size - rte_mbuf_size();
 	rte_mbuf_iova_set(m, rte_mem_virt2iova(m->buf_addr));
 	m->data_off = RTE_PKTMBUF_HEADROOM;
 	m->refcnt = 1;
diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/nfp_flower.c
index 14a8992376..341067a91d 100644
--- a/drivers/net/nfp/flower/nfp_flower.c
+++ b/drivers/net/nfp/flower/nfp_flower.c
@@ -446,7 +446,7 @@ nfp_flower_init_ctrl_vnic(struct nfp_app_fw_flower *app_fw_flower,
 		 */
 		rxq->mem_pool = mp;
 		rxq->mbuf_size = rxq->mem_pool->elt_size;
-		rxq->mbuf_size -= (sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM);
+		rxq->mbuf_size -= (rte_mbuf_size() + RTE_PKTMBUF_HEADROOM);
 		hw->flbufsz = rxq->mbuf_size;
 
 		rxq->rx_count = CTRL_VNIC_NB_DESC;
diff --git a/drivers/net/nfp/nfp_rxtx.c b/drivers/net/nfp/nfp_rxtx.c
index 19c8324549..154d1299de 100644
--- a/drivers/net/nfp/nfp_rxtx.c
+++ b/drivers/net/nfp/nfp_rxtx.c
@@ -673,7 +673,7 @@ nfp_net_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	rxq->mem_pool = mp;
 	rxq->mbuf_size = rxq->mem_pool->elt_size;
-	rxq->mbuf_size -= (sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM);
+	rxq->mbuf_size -= (rte_mbuf_size() + RTE_PKTMBUF_HEADROOM);
 	nfp_rx_queue_setup_flbufsz(hw, rxq);
 
 	rxq->rx_count = nb_desc;
diff --git a/drivers/net/pfe/pfe_hif.c b/drivers/net/pfe/pfe_hif.c
index abb9cde996..fb99ae64c8 100644
--- a/drivers/net/pfe/pfe_hif.c
+++ b/drivers/net/pfe/pfe_hif.c
@@ -63,7 +63,7 @@ pfe_hif_release_buffers(struct pfe_hif *hif)
 			if (i < hif->shm->rx_buf_pool_cnt &&
 			    !hif->shm->rx_buf_pool[i]) {
 				mbuf = hif->rx_buf_vaddr[i] + PFE_PKT_HEADER_SZ
-					- sizeof(struct rte_mbuf)
+					- rte_mbuf_size()
 					- RTE_PKTMBUF_HEADROOM
 					- mb_priv->mbuf_priv_size;
 				hif->shm->rx_buf_pool[i] = mbuf;
diff --git a/drivers/net/pfe/pfe_hif_lib.c b/drivers/net/pfe/pfe_hif_lib.c
index 541ba365c6..eda87040fa 100644
--- a/drivers/net/pfe/pfe_hif_lib.c
+++ b/drivers/net/pfe/pfe_hif_lib.c
@@ -115,7 +115,7 @@ hif_lib_client_release_rx_buffers(struct hif_client_s *client)
 			 * "mbuf->data_offset - PFE_PKT_HEADER_SZ"
 			 */
 				buf = buf + PFE_PKT_HEADER_SZ
-					- sizeof(struct rte_mbuf)
+					- rte_mbuf_size()
 					- RTE_PKTMBUF_HEADROOM
 					- mb_priv->mbuf_priv_size;
 				rte_pktmbuf_free((struct rte_mbuf *)buf);
@@ -413,7 +413,7 @@ hif_lib_receive_pkt(struct hif_client_rx_queue *queue,
 			mb_priv = rte_mempool_get_priv(pool);
 
 			mbuf = desc->data + PFE_PKT_HEADER_SZ
-				- sizeof(struct rte_mbuf)
+				- rte_mbuf_size()
 				- RTE_PKTMBUF_HEADROOM
 				- mb_priv->mbuf_priv_size;
 			mbuf->next = NULL;
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index 1d4101b9e9..204c40be9a 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1002,7 +1002,7 @@ sfc_rx_mbuf_data_alignment(struct rte_mempool *mb_pool)
 	order = rte_bsf32(RTE_CACHE_LINE_SIZE);
 
 	/* Data offset from mbuf object start */
-	data_off = sizeof(struct rte_mbuf) + rte_pktmbuf_priv_size(mb_pool) +
+	data_off = rte_mbuf_size() + rte_pktmbuf_priv_size(mb_pool) +
 		RTE_PKTMBUF_HEADROOM;
 
 	order = MIN(order, rte_bsf32(data_off));
diff --git a/drivers/net/softnic/rte_eth_softnic_mempool.c b/drivers/net/softnic/rte_eth_softnic_mempool.c
index d5c569f94e..0721bcec39 100644
--- a/drivers/net/softnic/rte_eth_softnic_mempool.c
+++ b/drivers/net/softnic/rte_eth_softnic_mempool.c
@@ -10,7 +10,7 @@
 
 #include "rte_eth_softnic_internals.h"
 
-#define BUFFER_SIZE_MIN        (sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM)
+#define BUFFER_SIZE_MIN        (rte_mbuf_size() + RTE_PKTMBUF_HEADROOM)
 
 int
 softnic_mempool_init(struct pmd_internals *p)
@@ -78,7 +78,7 @@ softnic_mempool_create(struct pmd_internals *p,
 		params->pool_size,
 		params->cache_size,
 		0,
-		params->buffer_size - sizeof(struct rte_mbuf),
+		params->buffer_size - rte_mbuf_size(),
 		p->params.cpu_id);
 
 	if (m == NULL)
diff --git a/examples/fips_validation/fips_validation.h b/examples/fips_validation/fips_validation.h
index 881c759033..d4ef32fc9b 100644
--- a/examples/fips_validation/fips_validation.h
+++ b/examples/fips_validation/fips_validation.h
@@ -16,7 +16,7 @@
 #define MAX_CASE_LINE		15
 #define MAX_LINE_CHAR		204800 /* max number of characters per line */
 #define MAX_NB_TESTS		10240
-#define DEF_MBUF_SEG_SIZE	(UINT16_MAX - sizeof(struct rte_mbuf) - \
+#define DEF_MBUF_SEG_SIZE	(UINT16_MAX - rte_mbuf_size() - \
 				RTE_PKTMBUF_HEADROOM)
 #define MAX_STRING_SIZE		64
 #define MAX_FILE_NAME_SIZE	256
diff --git a/examples/fips_validation/main.c b/examples/fips_validation/main.c
index 2b6d55aa51..9cfb480441 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -200,7 +200,7 @@ cryptodev_fips_validate_app_init(void)
 
 	ret = -ENOMEM;
 	env.mpool = rte_pktmbuf_pool_create("FIPS_MEMPOOL", nb_mbufs,
-			0, 0, sizeof(struct rte_mbuf) + RTE_PKTMBUF_HEADROOM +
+			0, 0, rte_mbuf_size() + RTE_PKTMBUF_HEADROOM +
 			env.mbuf_data_room, rte_socket_id());
 	if (!env.mpool)
 		return ret;
diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index 33f3c1ef17..00e9256f0b 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -1108,7 +1108,7 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
 
 	snprintf(pool_name, sizeof(pool_name), "ntb_mbuf_pool_%u", socket_id);
 	mp = rte_mempool_create_empty(pool_name, nb_mbuf,
-				      (mbuf_seg_size + sizeof(struct rte_mbuf)),
+				      mbuf_seg_size + rte_mbuf_size(),
 				      MEMPOOL_CACHE_SIZE,
 				      sizeof(struct rte_pktmbuf_pool_private),
 				      socket_id, 0);
diff --git a/lib/cryptodev/rte_crypto.h b/lib/cryptodev/rte_crypto.h
index dcf4a36fb2..646a246578 100644
--- a/lib/cryptodev/rte_crypto.h
+++ b/lib/cryptodev/rte_crypto.h
@@ -426,8 +426,8 @@ rte_crypto_sym_op_alloc_from_mbuf_priv_data(struct rte_mbuf *m)
 			sizeof(struct rte_crypto_sym_op))))
 		return NULL;
 
-	/* private data starts immediately after the mbuf header in the mbuf. */
-	struct rte_crypto_op *op = (struct rte_crypto_op *)(m + 1);
+	/* private data starts after the mbuf object header. */
+	struct rte_crypto_op *op = rte_mbuf_to_priv(m);
 
 	__rte_crypto_op_reset(op, RTE_CRYPTO_OP_TYPE_SYMMETRIC);
 
diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index e2e69a75fb..f93060c1f6 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -9,6 +9,9 @@
 #include "eal_filesystem.h"
 #include "eal_memcfg.h"
 
+RTE_EXPORT_SYMBOL(rte_mbuf_metadata_size)
+uint16_t rte_mbuf_metadata_size;
+
 /* early configuration structure, when memory config is not mmapped */
 static struct rte_mem_config early_mem_config = {
 	.mlock = RTE_RWLOCK_INITIALIZER,
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 84ee3f3959..c034f09a0a 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -46,15 +46,27 @@ eal_mcfg_check_version(void)
 	return 0;
 }
 
-void
+int
 eal_mcfg_update_internal(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	if (internal_conf->mbuf_metadata_size_set &&
+			internal_conf->mbuf_metadata_size != mcfg->mbuf_metadata_size) {
+		EAL_LOG(ERR,
+			"Secondary process mbuf metadata size %zu does not match primary value %u",
+			internal_conf->mbuf_metadata_size, mcfg->mbuf_metadata_size);
+		return -1;
+	}
+
 	internal_conf->legacy_mem = mcfg->legacy_mem;
 	internal_conf->single_file_segments = mcfg->single_file_segments;
+	internal_conf->mbuf_metadata_size = mcfg->mbuf_metadata_size;
+	rte_mbuf_metadata_size = mcfg->mbuf_metadata_size;
+
+	return 0;
 }
 
 void
@@ -66,6 +78,8 @@ eal_mcfg_update_from_internal(void)
 
 	mcfg->legacy_mem = internal_conf->legacy_mem;
 	mcfg->single_file_segments = internal_conf->single_file_segments;
+	mcfg->mbuf_metadata_size = internal_conf->mbuf_metadata_size;
+	rte_mbuf_metadata_size = internal_conf->mbuf_metadata_size;
 	/* record current DPDK version */
 	mcfg->version = RTE_VERSION;
 }
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..a1c09ab9fd 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -554,6 +554,9 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	internal_cfg->create_uio_dev = 0;
 	internal_cfg->iova_mode = RTE_IOVA_DC;
 	internal_cfg->user_mbuf_pool_ops_name = NULL;
+	internal_cfg->mbuf_metadata_size = 0;
+	internal_cfg->mbuf_metadata_size_set = false;
+	rte_mbuf_metadata_size = 0;
 	CPU_ZERO(&internal_cfg->ctrl_cpuset);
 	internal_cfg->init_complete = 0;
 	internal_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
@@ -2409,6 +2412,23 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
+	if (args.mbuf_metadata_size != NULL) {
+		char *end = NULL;
+		unsigned long size;
+
+		errno = 0;
+		size = strtoul(args.mbuf_metadata_size, &end, 0);
+		if (errno != 0 || args.mbuf_metadata_size[0] == '\0' ||
+				end == NULL || *end != '\0' ||
+				size > UINT16_MAX ||
+				size % RTE_CACHE_LINE_SIZE != 0) {
+			EAL_LOG(ERR, "invalid mbuf metadata size parameter");
+			return -1;
+		}
+		int_cfg->mbuf_metadata_size = size;
+		int_cfg->mbuf_metadata_size_set = true;
+		rte_mbuf_metadata_size = size;
+	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
 	/* create runtime data directory. In no_shconf mode, skip any errors */
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 07cd35167d..88684c5348 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -94,6 +94,9 @@ struct internal_config {
 	char *hugepage_dir;         /**< specific hugetlbfs directory to use */
 	char *user_mbuf_pool_ops_name;
 			/**< user defined mbuf pool ops name */
+	size_t mbuf_metadata_size; /**< Global per-mbuf metadata size. */
+	bool mbuf_metadata_size_set;
+	/**< True if mbuf metadata size was explicitly set. */
 	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
diff --git a/lib/eal/common/eal_memcfg.h b/lib/eal/common/eal_memcfg.h
index 2b3b3b62ba..99a2af1e2b 100644
--- a/lib/eal/common/eal_memcfg.h
+++ b/lib/eal/common/eal_memcfg.h
@@ -77,6 +77,8 @@ struct rte_mem_config {
 	uint32_t legacy_mem; /**< stored legacy mem parameter. */
 	uint32_t single_file_segments;
 	/**< stored single file segments parameter. */
+	uint32_t mbuf_metadata_size;
+	/**< stored per-mbuf metadata area size. */
 
 	uint64_t tsc_hz;
 	/**< TSC rate */
@@ -87,7 +89,7 @@ struct rte_mem_config {
 };
 
 /* update internal config from shared mem config */
-void
+int
 eal_mcfg_update_internal(void);
 
 /* update shared mem config from internal config */
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index b72f243cc6..e14cf68770 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -48,6 +48,7 @@ OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color
 LIST_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)
 OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp)
 STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore)
+STR_ARG("--mbuf-metadata-size", NULL, "Global per-mbuf metadata area size", mbuf_metadata_size)
 STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name)
 STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
 STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 6340bab8be..e279150ddf 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -40,6 +40,7 @@ struct lcore_config {
 };
 
 extern struct lcore_config lcore_config[RTE_MAX_LCORE];
+extern uint16_t rte_mbuf_metadata_size;
 
 /**
  * The global RTE configuration structure.
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 8b1ba5b99b..e5b4f6bdab 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -317,7 +317,8 @@ rte_config_init(void)
 			EAL_LOG(ERR, "Primary process refused secondary attachment");
 			return -1;
 		}
-		eal_mcfg_update_internal();
+		if (eal_mcfg_update_internal() < 0)
+			return -1;
 		break;
 	case RTE_PROC_AUTO:
 	case RTE_PROC_INVALID:
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index fc2e9b8c0e..0577cce7d5 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -401,7 +401,8 @@ rte_config_init(void)
 			EAL_LOG(ERR, "Primary process refused secondary attachment");
 			return -1;
 		}
-		eal_mcfg_update_internal();
+		if (eal_mcfg_update_internal() < 0)
+			return -1;
 		break;
 	case RTE_PROC_AUTO:
 	case RTE_PROC_INVALID:
diff --git a/lib/mbuf/mbuf_history.c b/lib/mbuf/mbuf_history.c
index b025d12fc8..fb06d7fcfa 100644
--- a/lib/mbuf/mbuf_history.c
+++ b/lib/mbuf/mbuf_history.c
@@ -85,7 +85,7 @@ mbuf_history_get_stats(struct rte_mempool *mp, FILE *f)
 		.f = f
 	};
 
-	if (mp->elt_size < sizeof(struct rte_mbuf)) {
+	if (mp->elt_size < rte_mbuf_size()) {
 		MBUF_LOG(ERR, "Invalid mempool element size (less than mbuf)");
 		return;
 	}
@@ -129,7 +129,7 @@ mbuf_history_get_stats(struct rte_mempool *mp, FILE *f)
 static void
 mbuf_history_get_stats_walking(struct rte_mempool *mp, void *arg)
 {
-	if (mp->elt_size < sizeof(struct rte_mbuf))
+	if (mp->elt_size < rte_mbuf_size())
 		return; /* silently ignore while walking in all mempools */
 
 	mbuf_history_get_stats(mp, arg);
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 005bfaa573..97f6680992 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -39,7 +39,7 @@ rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
 
 	RTE_ASSERT(mp->private_data_size >=
 		   sizeof(struct rte_pktmbuf_pool_private));
-	RTE_ASSERT(mp->elt_size >= sizeof(struct rte_mbuf));
+	RTE_ASSERT(mp->elt_size >= rte_mbuf_size());
 
 	rte_mbuf_history_init();
 
@@ -47,15 +47,15 @@ rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
 	user_mbp_priv = opaque_arg;
 	if (user_mbp_priv == NULL) {
 		memset(&default_mbp_priv, 0, sizeof(default_mbp_priv));
-		if (mp->elt_size > sizeof(struct rte_mbuf))
-			roomsz = mp->elt_size - sizeof(struct rte_mbuf);
+		if (mp->elt_size > rte_mbuf_size())
+			roomsz = mp->elt_size - rte_mbuf_size();
 		else
 			roomsz = 0;
 		default_mbp_priv.mbuf_data_room_size = roomsz;
 		user_mbp_priv = &default_mbp_priv;
 	}
 
-	RTE_ASSERT(mp->elt_size >= sizeof(struct rte_mbuf) +
+	RTE_ASSERT(mp->elt_size >= rte_mbuf_size() +
 		((user_mbp_priv->flags & RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
 			sizeof(struct rte_mbuf_ext_shared_info) :
 			user_mbp_priv->mbuf_data_room_size) +
@@ -86,7 +86,7 @@ rte_pktmbuf_init(struct rte_mempool *mp,
 		   sizeof(struct rte_pktmbuf_pool_private));
 
 	priv_size = rte_pktmbuf_priv_size(mp);
-	mbuf_size = sizeof(struct rte_mbuf) + priv_size;
+	mbuf_size = rte_mbuf_size() + priv_size;
 	buf_len = rte_pktmbuf_data_room_size(mp);
 
 	RTE_ASSERT(RTE_ALIGN(priv_size, RTE_MBUF_PRIV_ALIGN) == priv_size);
@@ -177,7 +177,7 @@ __rte_pktmbuf_init_extmem(struct rte_mempool *mp,
 	struct rte_mbuf_ext_shared_info *shinfo;
 
 	priv_size = rte_pktmbuf_priv_size(mp);
-	mbuf_size = sizeof(struct rte_mbuf) + priv_size;
+	mbuf_size = rte_mbuf_size() + priv_size;
 	buf_len = rte_pktmbuf_data_room_size(mp);
 
 	RTE_ASSERT(RTE_ALIGN(priv_size, RTE_MBUF_PRIV_ALIGN) == priv_size);
@@ -241,7 +241,7 @@ rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 		rte_errno = EINVAL;
 		return NULL;
 	}
-	elt_size = sizeof(struct rte_mbuf) + (unsigned)priv_size +
+	elt_size = rte_mbuf_size() + (unsigned int)priv_size +
 		(unsigned)data_room_size;
 	memset(&mbp_priv, 0, sizeof(mbp_priv));
 	mbp_priv.mbuf_data_room_size = data_room_size;
@@ -332,8 +332,7 @@ rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 		rte_errno = ENOMEM;
 		return NULL;
 	}
-	elt_size = sizeof(struct rte_mbuf) +
-		   (unsigned int)priv_size +
+	elt_size = rte_mbuf_size() + (unsigned int)priv_size +
 		   sizeof(struct rte_mbuf_ext_shared_info);
 
 	memset(&mbp_priv, 0, sizeof(mbp_priv));
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 60ec8158cd..559b58a968 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -217,7 +217,8 @@ rte_mbuf_data_iova_default(const struct rte_mbuf *mb)
 static inline struct rte_mbuf *
 rte_mbuf_from_indirect(struct rte_mbuf *mi)
 {
-	return (struct rte_mbuf *)RTE_PTR_SUB(mi->buf_addr, sizeof(*mi) + mi->priv_size);
+	return (struct rte_mbuf *)RTE_PTR_SUB(mi->buf_addr,
+		rte_mbuf_size() + mi->priv_size);
 }
 
 /**
@@ -238,7 +239,7 @@ rte_mbuf_from_indirect(struct rte_mbuf *mi)
 static inline char *
 rte_mbuf_buf_addr(struct rte_mbuf *mb, struct rte_mempool *mp)
 {
-	return (char *)mb + sizeof(*mb) + rte_pktmbuf_priv_size(mp);
+	return (char *)mb + rte_mbuf_size() + rte_pktmbuf_priv_size(mp);
 }
 
 /**
@@ -289,7 +290,7 @@ rte_mbuf_to_baddr(struct rte_mbuf *md)
 static inline void *
 rte_mbuf_to_priv(struct rte_mbuf *m)
 {
-	return RTE_PTR_ADD(m, sizeof(struct rte_mbuf));
+	return RTE_PTR_ADD(m, rte_mbuf_size());
 }
 
 /**
@@ -1390,7 +1391,7 @@ static inline void rte_pktmbuf_detach(struct rte_mbuf *m)
 		__rte_pktmbuf_free_direct(m);
 	}
 	priv_size = rte_pktmbuf_priv_size(mp);
-	mbuf_size = (uint32_t)(sizeof(struct rte_mbuf) + priv_size);
+	mbuf_size = rte_mbuf_size() + priv_size;
 	buf_len = rte_pktmbuf_data_room_size(mp);
 
 	m->priv_size = priv_size;
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index 98b0bd9ca7..68660e2020 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -20,12 +20,29 @@
 #include <stdint.h>
 
 #include <rte_byteorder.h>
+#include <rte_common.h>
 #include <rte_stdatomic.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
+extern uint16_t rte_mbuf_metadata_size;
+
+/**
+ * Return the configured per-mbuf metadata size.
+ *
+ * The value is configured with the ``--mbuf-metadata-size`` EAL option.
+ *
+ * @return
+ *   The per-mbuf metadata size in bytes.
+ */
+static inline uint16_t
+rte_mbuf_metadata_size_get(void)
+{
+	return rte_mbuf_metadata_size;
+}
+
 /*
  * Packet Offload Features Flags. It also carry packet type information.
  * Critical resources. Both rx/tx shared these bits. Be cautious on any change
@@ -686,8 +703,28 @@ struct __rte_cache_aligned rte_mbuf {
 	uint16_t timesync;
 
 	uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
+
+	alignas(RTE_CACHE_LINE_SIZE)
+	RTE_MARKER8 metadata;
+	/**< Optional cache-line-aligned per-mbuf metadata area. */
 };
 
+/**
+ * Return the mbuf object size.
+ *
+ * This is the fixed ``struct rte_mbuf`` size plus the runtime-configured
+ * per-mbuf metadata size. Use this helper for object-layout calculations that
+ * need to include the metadata area, such as locating application private data.
+ *
+ * @return
+ *   The mbuf object size in bytes.
+ */
+static inline uint32_t
+rte_mbuf_size(void)
+{
+	return sizeof(struct rte_mbuf) + rte_mbuf_metadata_size_get();
+}
+
 /**
  * Function typedef of callback to free externally attached buffer.
  */
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..9a24900918 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdalign.h>
+#include <stddef.h>
 #include <sys/queue.h>
 #include <stdint.h>
 #include <limits.h>
@@ -46,14 +47,15 @@ static struct rte_tailq_elem mbuf_dynflag_tailq = {
 EAL_REGISTER_TAILQ(mbuf_dynflag_tailq);
 
 struct mbuf_dyn_shm {
+	size_t free_space_size;
+	/** Bitfield of available flags. */
+	uint64_t free_flags;
 	/**
 	 * For each mbuf byte, free_space[i] != 0 if space is free.
 	 * The value is the size of the biggest aligned element that
 	 * can fit in the zone.
 	 */
-	uint8_t free_space[sizeof(struct rte_mbuf)];
-	/** Bitfield of available flags. */
-	uint64_t free_flags;
+	uint16_t free_space[];
 };
 static struct mbuf_dyn_shm *shm;
 
@@ -67,15 +69,15 @@ process_score(void)
 	size_t off, align, size, i;
 
 	/* first, erase previous info */
-	for (i = 0; i < sizeof(struct rte_mbuf); i++) {
+	for (i = 0; i < shm->free_space_size; i++) {
 		if (shm->free_space[i])
 			shm->free_space[i] = 1;
 	}
 
 	off = 0;
-	while (off < sizeof(struct rte_mbuf)) {
+	while (off < shm->free_space_size) {
 		/* get the size of the free zone */
-		for (size = 0; (off + size) < sizeof(struct rte_mbuf) &&
+		for (size = 0; (off + size) < shm->free_space_size &&
 			     shm->free_space[off + size]; size++)
 			;
 		if (size == 0) {
@@ -99,21 +101,38 @@ process_score(void)
 	}
 }
 
+static size_t
+mbuf_dynfield_size(void)
+{
+	return rte_mbuf_size();
+}
+
+static void
+mark_free_space(size_t offset, size_t size)
+{
+	size_t i;
+
+	for (i = offset; i < offset + size; i++)
+		shm->free_space[i] = 1;
+}
+
 /* Mark the area occupied by a mbuf field as available in the shm. */
 #define mark_free(field)						\
-	memset(&shm->free_space[offsetof(struct rte_mbuf, field)],	\
-		1, sizeof(((struct rte_mbuf *)0)->field))
+	mark_free_space(offsetof(struct rte_mbuf, field),	\
+		sizeof(((struct rte_mbuf *)0)->field))
 
 /* Allocate and initialize the shared memory. Assume tailq is locked */
 static int
 init_shared_mem(void)
 {
 	const struct rte_memzone *mz;
+	size_t shm_size;
 	uint64_t mask;
 
+	shm_size = sizeof(*shm) + mbuf_dynfield_size() * sizeof(shm->free_space[0]);
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve_aligned(RTE_MBUF_DYN_MZNAME,
-						sizeof(struct mbuf_dyn_shm),
+						shm_size,
 						SOCKET_ID_ANY, 0,
 						RTE_CACHE_LINE_SIZE);
 	} else {
@@ -130,11 +149,14 @@ init_shared_mem(void)
 		/* init free_space, keep it sync'd with
 		 * rte_mbuf_dynfield_copy().
 		 */
-		memset(shm, 0, sizeof(*shm));
+		memset(shm, 0, shm_size);
+		shm->free_space_size = mbuf_dynfield_size();
 		mark_free(dynfield1);
 #if !RTE_IOVA_IN_MBUF
 		mark_free(dynfield2);
 #endif
+		mark_free_space(offsetof(struct rte_mbuf, metadata),
+			rte_mbuf_metadata_size_get());
 
 		/* init free_flags */
 		for (mask = RTE_MBUF_F_FIRST_FREE; mask <= RTE_MBUF_F_LAST_FREE; mask <<= 1)
@@ -147,14 +169,40 @@ init_shared_mem(void)
 }
 
 /* check if this offset can be used */
+static bool
+dynfield_in_metadata(size_t offset, size_t size)
+{
+	size_t metadata_offset = offsetof(struct rte_mbuf, metadata);
+	size_t metadata_size = rte_mbuf_metadata_size_get();
+
+	return offset >= metadata_offset &&
+		size <= metadata_size &&
+		offset - metadata_offset <= metadata_size - size;
+}
+
+static bool
+dynfield_overlaps_metadata(size_t offset, size_t size)
+{
+	size_t metadata_offset = offsetof(struct rte_mbuf, metadata);
+	size_t metadata_end = metadata_offset + rte_mbuf_metadata_size_get();
+
+	return offset < metadata_end && offset + size > metadata_offset;
+}
+
 static int
-check_offset(size_t offset, size_t size, size_t align)
+check_offset(size_t offset, size_t size, size_t align, unsigned int flags)
 {
 	size_t i;
 
+	if ((flags & RTE_MBUF_DYNFIELD_F_METADATA) != 0 &&
+			!dynfield_in_metadata(offset, size))
+		return -1;
+	if ((flags & RTE_MBUF_DYNFIELD_F_METADATA) == 0 &&
+			dynfield_overlaps_metadata(offset, size))
+		return -1;
 	if ((offset & (align - 1)) != 0)
 		return -1;
-	if (offset + size > sizeof(struct rte_mbuf))
+	if (offset + size > shm->free_space_size)
 		return -1;
 
 	for (i = 0; i < size; i++) {
@@ -265,10 +313,10 @@ __rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 		 * containing room for larger fields are kept for later.
 		 */
 		for (offset = 0;
-		     offset < sizeof(struct rte_mbuf);
+		     offset < shm->free_space_size;
 		     offset++) {
 			if (check_offset(offset, params->size,
-						params->align) == 0 &&
+						params->align, params->flags) == 0 &&
 					shm->free_space[offset] < best_zone) {
 				best_zone = shm->free_space[offset];
 				req = offset;
@@ -279,7 +327,8 @@ __rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 			return -1;
 		}
 	} else {
-		if (check_offset(req, params->size, params->align) < 0) {
+		if (check_offset(req, params->size, params->align,
+				params->flags) < 0) {
 			rte_errno = EBUSY;
 			return -1;
 		}
@@ -334,7 +383,7 @@ rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 {
 	int ret;
 
-	if (params->size >= sizeof(struct rte_mbuf)) {
+	if (params->size >= mbuf_dynfield_size()) {
 		rte_errno = EINVAL;
 		return -1;
 	}
@@ -342,7 +391,7 @@ rte_mbuf_dynfield_register_offset(const struct rte_mbuf_dynfield *params,
 		rte_errno = EINVAL;
 		return -1;
 	}
-	if (params->flags != 0) {
+	if ((params->flags & ~RTE_MBUF_DYNFIELD_F_METADATA) != 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
@@ -570,10 +619,10 @@ void rte_mbuf_dyn_dump(FILE *out)
 			dynflag->params.flags);
 	}
 	fprintf(out, "Free space in mbuf (0 = occupied, value = free zone alignment):\n");
-	for (i = 0; i < sizeof(struct rte_mbuf); i++) {
+	for (i = 0; i < shm->free_space_size; i++) {
 		if ((i % 8) == 0)
 			fprintf(out, "  %4.4zx: ", i);
-		fprintf(out, "%2.2x%s", shm->free_space[i],
+		fprintf(out, "%4.4x%s", shm->free_space[i],
 			(i % 8 != 7) ? " " : "\n");
 	}
 	fprintf(out, "Free bit in mbuf->ol_flags (0 = occupied, 1 = free):\n");
diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 20ce505bb4..e1d52fcc0e 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -69,6 +69,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <rte_bitops.h>
 #include <rte_stdatomic.h>
 
 #ifdef __cplusplus
@@ -80,6 +81,14 @@ extern "C" {
  */
 #define RTE_MBUF_DYN_NAMESIZE 64
 
+/**
+ * Allocate this dynamic field from the mbuf metadata area.
+ *
+ * Metadata dynamic fields are not copied during mbuf clone, copy, or attach.
+ * The metadata area is configured by the mbuf-metadata-size EAL option.
+ */
+#define RTE_MBUF_DYNFIELD_F_METADATA RTE_BIT32(0)
+
 /**
  * Structure describing the parameters of a mbuf dynamic field.
  */
@@ -87,7 +96,7 @@ struct rte_mbuf_dynfield {
 	char name[RTE_MBUF_DYN_NAMESIZE]; /**< Name of the field. */
 	size_t size;        /**< The number of bytes to reserve. */
 	size_t align;       /**< The alignment constraint (power of 2). */
-	unsigned int flags; /**< Reserved for future use, must be 0. */
+	unsigned int flags; /**< Dynamic field flags. */
 };
 
 /**
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b5d1026891..077e6d936f 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -473,7 +473,7 @@ rte_pcapng_mbuf_size(uint32_t length)
 		   sizeof(struct rte_vlan_hdr) <= RTE_PKTMBUF_HEADROOM);
 
 	/* The flags and queue information are added at the end. */
-	return sizeof(struct rte_mbuf)
+	return rte_mbuf_size()
 		+ RTE_ALIGN(length, sizeof(uint32_t))
 		+ pcapng_optlen(sizeof(uint32_t)) /* flag option */
 		+ pcapng_optlen(sizeof(uint32_t)) /* queue option */
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index bb4708aed5..e8887928b1 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -1070,7 +1070,7 @@ restore_mbuf(struct rte_mbuf *m)
 
 	while (m) {
 		priv_size = rte_pktmbuf_priv_size(m->pool);
-		mbuf_size = sizeof(struct rte_mbuf) + priv_size;
+		mbuf_size = rte_mbuf_size() + priv_size;
 		/* start of buffer is after mbuf structure and priv data */
 
 		m->buf_addr = (char *)m + mbuf_size;
-- 
2.35.6

