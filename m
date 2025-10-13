Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC85ACCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:20:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D400B40651;
	Mon, 13 Oct 2025 23:20:37 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 7B96A40651
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:36 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id C83641D00119;
 Mon, 13 Oct 2025 17:20:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 17:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390435; x=
 1760476835; bh=CX1GCmtoDNHznfTYRrss1hpRA6CYXbg50VsZlI9slX4=; b=K
 uTRw1vVmqzjFrplHA3RN9OLge7yNU1czVVHYCtCxijlaS0kdJfQfypRthTzXVhcg
 HumIOwQBsds6UdgoMJfKeA8mamdpfFG9UeKGNdHVnFtwE9UMzQIoXsPDG2p2NqQu
 C3Pk/0er/jTDvr+lyjl3GVEVFs6mSLGPOEYi5Zirok3AVCeoNI7metG5fnr5O6Qi
 pMcGMfbPkFNQV4mW2l98xlujwp09NRh7Obld4GAxPkSj74azLa+I0kEaMrrwMOiC
 4FI5h0YTpsKIXlTEr4Q8v/8elb6Ztd8mpKFk2pKtx2ElSa1NM30cwFRR8OTHlDEF
 Pu32zHSh/eDw36PvUIfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390435; x=1760476835; bh=C
 X1GCmtoDNHznfTYRrss1hpRA6CYXbg50VsZlI9slX4=; b=E3FKYwvn4tsFQYlJ6
 GDvJrPFYnGml/dtngpfRBjuB8Dtue6D1oy1uK31lwgFErTU1cHOv0FxuEBinDG1I
 KxvDoy3FU7M5TaBaYkZGP7Jbg+zeUl3xyza/x+2rTeyAkQspiaqOAXoMknN94e3s
 U2BgAfS4nXnxetHwX90EmjOdL17KUkuQApVN/qdK1rZxCgv7shLv3gsBvRq9xvzi
 /fGhNHZoLbYhr+kr57Db+/FauzKLV9g4Z6tFqE78Ie+jxgsu+qg21jd6uX8bPv7x
 7zzBNFk61VD2iUu8NKGOAZ6x7xtMFvKb3XYm/fifcGhVbmmiobA6Kighq4Kep2iG
 r+n9w==
X-ME-Sender: <xms:I23taI68WUnvPEiitQfQ0LEjz7SYmWyKZrd-5m8PAqA4o5cs_4Qcjg>
 <xme:I23taC02gdW3nZALVjbE-6q8wRaK_a1PJNmZ2C725VSGLPwca3Ez_zMqz7ocu6BSL
 08c5dyag-UJ4dTZd3gJ6kqbT-8gJzoPZ4tjQnqkF7YM7qXo-dSdZA>
X-ME-Received: <xmr:I23taDDHZUyf4c5Mhav_XebobOsed-m9GSzoODbKpbPTGWIhFdbo5RfrIW0e0-0YPAwPTGvGq6mGEqC3EFAfXiXLNTu3E8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepteeuhedvveehteethfegte
 etjeeuffekgfdvgeektdettdduueeguefgveeigeetnecuffhomhgrihhnpeifihhkihhp
 vgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohep
 iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpd
 hrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopehv
 ihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhutggvrd
 hrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehmsgesshhmrghr
 thhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvg
 htfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:I23taNMw_C9H0DHOWuqivT0oA0kCH8psDWBx8Wr5oX7eAorH1TfliA>
 <xmx:I23taIa2hUerOsaZUmuHf8XRFq3drsKyuPvsZVu1FfG_sg85vJVYlg>
 <xmx:I23taMuKYPGWMvB0pHXKFbs0ZedOMw-fkQGDbpuV2ffvoDNSY4fsbA>
 <xmx:I23taKNJZ-bpd8asKmhHtq_XFQMerQwlvjEhnjDdEPcVUXLWZ_4yrA>
 <xmx:I23taIk3DTTWlU0DvW7hcvdWu645Rp4K601upTCeQuLByJ6mszzdRQ-R>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v4 3/7] mbuf: record mbuf operations history
Date: Mon, 13 Oct 2025 23:16:03 +0200
Message-ID: <20251013212019.892032-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013212019.892032-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251013212019.892032-1-thomas@monjalon.net>
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

From: Shani Peretz <shperetz@nvidia.com>

This feature is designed to monitor the lifecycle of mbufs
as they move between the application and the PMD.
It will allow to track the operations and transitions
of each mbuf throughout the system, helping in debugging
and understanding objects flow.

As a debug feature impacting the data path, it is disabled by default.

The implementation uses a dynamic field to store a 64-bit
atomic history value in each mbuf. Each operation is represented
by a 4-bit value, allowing up to 16 operations to be tracked.
Atomic operations ensure thread safety for cloned mbufs accessed
by multiple lcores. The dynamic field is automatically initialized
when the first mbuf pool is created.

Some operations done in the mbuf library are marked.
More operations from other libraries or the application can be marked.

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 config/rte_config.h                     |   1 +
 doc/guides/howto/debug_troubleshoot.rst |   6 +
 doc/guides/prog_guide/mbuf_lib.rst      |   7 +
 doc/guides/rel_notes/release_25_11.rst  |   6 +
 lib/mbuf/mbuf_history.c                 | 227 ++++++++++++++++++++++++
 lib/mbuf/meson.build                    |   2 +
 lib/mbuf/rte_mbuf.c                     |   6 +-
 lib/mbuf/rte_mbuf.h                     |  13 +-
 lib/mbuf/rte_mbuf_dyn.h                 |  18 ++
 lib/mbuf/rte_mbuf_history.h             | 203 +++++++++++++++++++++
 10 files changed, 486 insertions(+), 3 deletions(-)
 create mode 100644 lib/mbuf/mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h

diff --git a/config/rte_config.h b/config/rte_config.h
index 05344e2619..aee137717b 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -64,6 +64,7 @@
 
 /* mbuf defines */
 #define RTE_MBUF_DEFAULT_MEMPOOL_OPS "ring_mp_mc"
+/* RTE_MBUF_HISTORY_DEBUG is not set */
 
 /* ether defines */
 #define RTE_MAX_QUEUES_PER_PORT 1024
diff --git a/doc/guides/howto/debug_troubleshoot.rst b/doc/guides/howto/debug_troubleshoot.rst
index df69fa8bcc..16feeb1e54 100644
--- a/doc/guides/howto/debug_troubleshoot.rst
+++ b/doc/guides/howto/debug_troubleshoot.rst
@@ -217,6 +217,12 @@ Memory objects close to NUMA :numref:`dtg_mempool`.
      desired value and frequently uses ``rte_pktmbuf_prefree_seg`` and does
      not release MBUF back to mempool.
 
+   The mbuf lifecycle can be tracked
+   by defining the compilation flag ``RTE_MBUF_HISTORY_DEBUG``.
+   Then the libraries will mark the mbufs,
+   and more marks can be added in the application.
+   Some dump functions must be used to collect the history.
+
 #. Lower performance between the pipeline processing stages can be
 
    * The NUMA instance for packets or objects from NIC, mempool, and ring
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index badc0f3501..ae72eecc61 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -273,6 +273,13 @@ perform sanity checks (such as buffer corruption, bad type, and so on).
 When ``RTE_ENABLE_ASSERT`` is enabled,
 more basic checks are done in many functions.
 
+When ``RTE_MBUF_HISTORY_DEBUG`` is enabled,
+the mbuf lifecycle is tracked.
+More marks can be added by the application
+by calling functions like ``rte_mbuf_history_mark_bulk()``.
+Then the history can be stored in a file
+by calling functions like ``rte_mbuf_history_dump_all()``.
+
 
 Use Cases
 ---------
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c3b94e1896..6854090096 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -60,6 +60,12 @@ New Features
   Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
   and some devices already support this speed.
 
+* **Added mbuf tracking for debug.**
+
+  Added history dynamic field in mbuf (disabled by default)
+  to store successive states of the mbuf lifecycle.
+  Some functions were added to dump statistics.
+
 * **Updated NXP DPAA2 ethernet driver.**
 
   * Enabled software taildrop for ordered queues.
diff --git a/lib/mbuf/mbuf_history.c b/lib/mbuf/mbuf_history.c
new file mode 100644
index 0000000000..e3203c0d5c
--- /dev/null
+++ b/lib/mbuf/mbuf_history.c
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 NVIDIA Corporation & Affiliates
+ */
+
+#include <rte_errno.h>
+#include <eal_export.h>
+#include <rte_bitops.h>
+#include <rte_mempool.h>
+
+#include "rte_mbuf_history.h"
+#include "rte_mbuf_dyn.h"
+#include "rte_mbuf.h"
+#include "mbuf_log.h"
+
+/* Dynamic field offset */
+RTE_EXPORT_SYMBOL(rte_mbuf_history_field_offset);
+int rte_mbuf_history_field_offset = -1;
+
+#ifdef RTE_MBUF_HISTORY_DEBUG
+
+#define HISTORY_LAST_MASK (RTE_BIT64(RTE_MBUF_HISTORY_BITS) - 1)
+
+/* Dynamic field definition for mbuf history */
+static const struct rte_mbuf_dynfield mbuf_dynfield_history = {
+	.name = RTE_MBUF_DYNFIELD_HISTORY_NAME,
+	.size = sizeof(rte_mbuf_history_t),
+	.align = RTE_ALIGN(sizeof(rte_mbuf_history_t), 8),
+};
+
+/* Context structure for statistics counting and history printing */
+struct count_and_print_ctx {
+	uint64_t *stats;
+	FILE *f;
+};
+
+static uint64_t
+mbuf_history_get(const struct rte_mbuf *m)
+{
+	if (rte_mbuf_history_field_offset < 0 || m == NULL)
+		return 0;
+
+	rte_mbuf_history_t *history = RTE_MBUF_DYNFIELD(m,
+			rte_mbuf_history_field_offset, rte_mbuf_history_t *);
+
+	return rte_atomic_load_explicit(history, rte_memory_order_acquire);
+}
+
+static int
+mbuf_history_print(FILE *f, const struct rte_mbuf *m, uint64_t history)
+{
+	return fprintf(f, "mbuf %p: %016" PRIx64 "\n", m, history);
+}
+
+static void
+mbuf_history_count_stats_and_print(struct rte_mempool *mp __rte_unused,
+		void *opaque, void *obj, unsigned obj_idx __rte_unused)
+{
+	struct count_and_print_ctx *ctx = (struct count_and_print_ctx *)opaque;
+	struct rte_mbuf *m = (struct rte_mbuf *)obj;
+	uint64_t history, last_op;
+
+	if (obj == NULL || ctx == NULL || ctx->stats == NULL || ctx->f == NULL)
+		return;
+
+	history = mbuf_history_get(m);
+	/* Extract the most recent operation */
+	last_op = history & HISTORY_LAST_MASK;
+	RTE_ASSERT(last_op < RTE_MBUF_HISTORY_OP_MAX);
+
+	ctx->stats[last_op]++;
+	ctx->stats[RTE_MBUF_HISTORY_OP_MAX]++; /* total */
+
+	if (history != 0)
+		mbuf_history_print(ctx->f, m, history);
+}
+
+static void
+mbuf_history_get_stats(struct rte_mempool *mp, FILE *f)
+{
+	uint64_t stats[RTE_MBUF_HISTORY_OP_MAX + 1] = {0};
+	struct count_and_print_ctx ctx = {
+		.stats = stats,
+		.f = f
+	};
+
+	if (mp->elt_size < sizeof(struct rte_mbuf)) {
+		MBUF_LOG(ERR, "Invalid mempool element size (less than mbuf)");
+		return;
+	}
+
+	if (f == NULL)
+		return;
+
+	/* Output mempool header */
+	fprintf(f, "mempool <%s>@%p\n", mp->name, mp);
+
+	/* Single pass: collect statistics and print mbuf history */
+	rte_mempool_obj_iter(mp, mbuf_history_count_stats_and_print, &ctx);
+
+	/* Calculate total allocated mbufs */
+	uint64_t total_allocated =
+		stats[RTE_MBUF_HISTORY_OP_LIB_ALLOC] +
+		stats[RTE_MBUF_HISTORY_OP_PMD_ALLOC] +
+		stats[RTE_MBUF_HISTORY_OP_APP_ALLOC] +
+		stats[RTE_MBUF_HISTORY_OP_RX] +
+		stats[RTE_MBUF_HISTORY_OP_TX] +
+		stats[RTE_MBUF_HISTORY_OP_PREP_TX] +
+		stats[RTE_MBUF_HISTORY_OP_BUSY_TX] +
+		stats[RTE_MBUF_HISTORY_OP_ENQUEUE] +
+		stats[RTE_MBUF_HISTORY_OP_DEQUEUE];
+
+	/* Print statistics summary */
+	fprintf(f, "  populated = %u\n", mp->populated_size);
+	fprintf(f, "  never allocated = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_NEVER]);
+	fprintf(f, "  lib free = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_LIB_FREE]);
+	fprintf(f, "  PMD free = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_PMD_FREE]);
+	fprintf(f, "  app free = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_APP_FREE]);
+	fprintf(f, "  allocated = %" PRIu64 "\n", total_allocated);
+	fprintf(f, "  lib alloc = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_LIB_ALLOC]);
+	fprintf(f, "  PMD alloc = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_PMD_ALLOC]);
+	fprintf(f, "  app alloc = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_APP_ALLOC]);
+	fprintf(f, "  Rx = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_RX]);
+	fprintf(f, "  Tx = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_TX]);
+	fprintf(f, "  prep Tx = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_PREP_TX]);
+	fprintf(f, "  busy Tx = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_BUSY_TX]);
+	fprintf(f, "  enqueue = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_ENQUEUE]);
+	fprintf(f, "  dequeue = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_DEQUEUE]);
+	fprintf(f, "  user defined 1 = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_USR1]);
+	fprintf(f, "  user defined 2 = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_USR2]);
+	fprintf(f, "  counted total = %" PRIu64 "\n", stats[RTE_MBUF_HISTORY_OP_MAX]);
+}
+
+static void
+mbuf_history_get_stats_walking(struct rte_mempool *mp, void *arg)
+{
+	if (mp->elt_size < sizeof(struct rte_mbuf))
+		return; /* silently ignore while walking in all mempools */
+
+	mbuf_history_get_stats(mp, arg);
+}
+
+#endif /* RTE_MBUF_HISTORY_DEBUG */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump, 25.11)
+void rte_mbuf_history_dump(FILE *f, const struct rte_mbuf *m)
+{
+#ifndef RTE_MBUF_HISTORY_DEBUG
+	RTE_SET_USED(f);
+	RTE_SET_USED(m);
+	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
+#else
+	if (f == NULL) {
+		MBUF_LOG(ERR, "Invalid mbuf dump file");
+		return;
+	}
+	if (m == NULL) {
+		MBUF_LOG(ERR, "Invalid mbuf pointer");
+		return;
+	}
+	if (rte_mbuf_history_field_offset < 0) {
+		MBUF_LOG(WARNING, "mbuf history not initialized, call rte_mbuf_history_init()");
+		return;
+	}
+	mbuf_history_print(f, m, mbuf_history_get(m));
+#endif
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_mempool, 25.11)
+void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool *mp)
+{
+#ifndef RTE_MBUF_HISTORY_DEBUG
+	RTE_SET_USED(f);
+	RTE_SET_USED(mp);
+	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
+#else
+	if (f == NULL) {
+		MBUF_LOG(ERR, "Invalid mbuf dump file");
+		return;
+	}
+	if (mp == NULL) {
+		MBUF_LOG(ERR, "Invalid mempool pointer");
+		return;
+	}
+	if (rte_mbuf_history_field_offset < 0) {
+		MBUF_LOG(WARNING, "mbuf history not initialized, call rte_mbuf_history_init()");
+		return;
+	}
+	mbuf_history_get_stats(mp, f);
+#endif
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_dump_all, 25.11)
+void rte_mbuf_history_dump_all(FILE *f)
+{
+#ifndef RTE_MBUF_HISTORY_DEBUG
+	RTE_SET_USED(f);
+	MBUF_LOG(INFO, "mbuf history recorder is not enabled");
+#else
+	if (f == NULL) {
+		MBUF_LOG(ERR, "Invalid mbuf dump file");
+		return;
+	}
+	if (rte_mbuf_history_field_offset < 0) {
+		MBUF_LOG(WARNING, "mbuf history not initialized, call rte_mbuf_history_init()");
+		return;
+	}
+	fprintf(f, "mbuf history statistics:\n");
+	rte_mempool_walk(mbuf_history_get_stats_walking, f);
+#endif
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mbuf_history_init, 25.11)
+void rte_mbuf_history_init(void)
+{
+#ifdef RTE_MBUF_HISTORY_DEBUG
+	if (rte_mbuf_history_field_offset >= 0) {
+		/* already initialized */
+		return;
+	}
+
+	rte_mbuf_history_field_offset = rte_mbuf_dynfield_register(&mbuf_dynfield_history);
+	if (rte_mbuf_history_field_offset < 0) {
+		MBUF_LOG(ERR, "Failed to register mbuf history dynamic field: %s\n",
+			rte_strerror(rte_errno));
+	}
+#endif
+}
diff --git a/lib/mbuf/meson.build b/lib/mbuf/meson.build
index 0435c5e628..a394db2b19 100644
--- a/lib/mbuf/meson.build
+++ b/lib/mbuf/meson.build
@@ -2,6 +2,7 @@
 # Copyright(c) 2017 Intel Corporation
 
 sources = files(
+        'mbuf_history.c',
         'rte_mbuf.c',
         'rte_mbuf_ptype.c',
         'rte_mbuf_pool_ops.c',
@@ -13,5 +14,6 @@ headers = files(
         'rte_mbuf_ptype.h',
         'rte_mbuf_pool_ops.h',
         'rte_mbuf_dyn.h',
+        'rte_mbuf_history.h',
 )
 deps += ['mempool']
diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 22d7cfc475..d96c2196a3 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -41,6 +41,8 @@ rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg)
 		   sizeof(struct rte_pktmbuf_pool_private));
 	RTE_ASSERT(mp->elt_size >= sizeof(struct rte_mbuf));
 
+	rte_mbuf_history_init();
+
 	/* if no structure is provided, assume no mbuf private area */
 	user_mbp_priv = opaque_arg;
 	if (user_mbp_priv == NULL) {
@@ -515,8 +517,10 @@ void rte_pktmbuf_free_bulk(struct rte_mbuf **mbufs, unsigned int count)
 		} while (m != NULL);
 	}
 
-	if (nb_pending > 0)
+	if (nb_pending > 0) {
+		rte_mbuf_history_mark_bulk(pending, nb_pending, RTE_MBUF_HISTORY_OP_LIB_FREE);
 		rte_mempool_put_bulk(pending[0]->pool, (void **)pending, nb_pending);
+	}
 }
 
 /* Creates a shallow copy of mbuf */
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 06ab7502a5..a6c6b21253 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -40,6 +40,7 @@
 #include <rte_branch_prediction.h>
 #include <rte_mbuf_ptype.h>
 #include <rte_mbuf_core.h>
+#include <rte_mbuf_history.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -607,6 +608,7 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
 	if (rte_mempool_get(mp, &ret.ptr) < 0)
 		return NULL;
 	__rte_mbuf_raw_sanity_check(ret.m);
+	rte_mbuf_history_mark(ret.m, RTE_MBUF_HISTORY_OP_LIB_ALLOC);
 	return ret.m;
 }
 
@@ -642,9 +644,12 @@ static __rte_always_inline int
 rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
 {
 	int rc = rte_mempool_get_bulk(mp, (void **)mbufs, count);
-	if (likely(rc == 0))
-		for (unsigned int idx = 0; idx < count; idx++)
+	if (likely(rc == 0)) {
+		for (unsigned int idx = 0; idx < count; idx++) {
 			__rte_mbuf_raw_sanity_check(mbufs[idx]);
+			rte_mbuf_history_mark(mbufs[idx], RTE_MBUF_HISTORY_OP_LIB_ALLOC);
+		}
+	}
 	return rc;
 }
 
@@ -667,6 +672,7 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
 {
 	__rte_mbuf_raw_sanity_check(m);
 	rte_mempool_put(m->pool, m);
+	rte_mbuf_history_mark(m, RTE_MBUF_HISTORY_OP_LIB_FREE);
 }
 
 /**
@@ -701,6 +707,7 @@ rte_mbuf_raw_free_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned
 		RTE_ASSERT(m != NULL);
 		RTE_ASSERT(m->pool == mp);
 		__rte_mbuf_raw_sanity_check(m);
+		rte_mbuf_history_mark(mbufs[idx], RTE_MBUF_HISTORY_OP_LIB_FREE);
 	}
 
 	rte_mempool_put_bulk(mp, (void **)mbufs, count);
@@ -1013,6 +1020,8 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	if (unlikely(rc))
 		return rc;
 
+	rte_mbuf_history_mark_bulk(mbufs, count, RTE_MBUF_HISTORY_OP_LIB_ALLOC);
+
 	/* To understand duff's device on loop unwinding optimization, see
 	 * https://en.wikipedia.org/wiki/Duff's_device.
 	 * Here while() loop is used rather than do() while{} to avoid extra
diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 865c90f579..dc1d4f146a 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -69,6 +69,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
+#include <rte_stdatomic.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -240,6 +241,23 @@ void rte_mbuf_dyn_dump(FILE *out);
  * and parameters together.
  */
 
+/**
+ * The mbuf history dynamic field provides lifecycle tracking
+ * for mbuf objects through the system.
+ * It records a fixed set of predefined operations for debugging.
+ */
+#define RTE_MBUF_DYNFIELD_HISTORY_NAME "rte_mbuf_dynfield_history"
+
+/**
+ * Type for mbuf history dynamic field.
+ *
+ * Use atomic operations to support cloned mbufs
+ * accessed simultaneously by multiple lcores.
+ *
+ * The size is 64-bit for better performance on modern systems.
+ */
+typedef RTE_ATOMIC(uint64_t) rte_mbuf_history_t;
+
 /*
  * The metadata dynamic field provides some extra packet information
  * to interact with RTE Flow engine. The metadata in sent mbufs can be
diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
new file mode 100644
index 0000000000..915fb13dac
--- /dev/null
+++ b/lib/mbuf/rte_mbuf_history.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 NVIDIA Corporation & Affiliates
+ */
+
+#ifndef _RTE_MBUF_HISTORY_H_
+#define _RTE_MBUF_HISTORY_H_
+
+/**
+ * @file
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * These functions allow to track history of mbuf objects using a dynamic field.
+ *
+ * It tracks the lifecycle of mbuf objects through the system
+ * with a fixed set of predefined events to maintain performance.
+ *
+ * The history is stored as an atomic value (64-bit) in a dynamic field of the mbuf,
+ * with each event encoded in 4 bits, allowing up to 16 events to be tracked.
+ * Atomic operations ensure thread safety for cloned mbufs accessed by multiple lcores.
+ */
+
+#include <rte_common.h>
+#include <rte_debug.h>
+
+#include <rte_mbuf_dyn.h>
+
+/* Forward declaration to avoid circular dependency. */
+struct rte_mbuf;
+struct rte_mempool;
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Number of bits for each history operation.
+ */
+#define RTE_MBUF_HISTORY_BITS 4
+
+/**
+ * Maximum number of history operations that can be stored.
+ */
+#define RTE_MBUF_HISTORY_MAX (sizeof(rte_mbuf_history_t) * 8 / RTE_MBUF_HISTORY_BITS)
+
+/**
+ * History operation types.
+ */
+enum rte_mbuf_history_op {
+	RTE_MBUF_HISTORY_OP_NEVER     =  0, /**< Initial state - never allocated */
+	RTE_MBUF_HISTORY_OP_LIB_FREE  =  1, /**< Freed back to pool */
+	RTE_MBUF_HISTORY_OP_PMD_FREE  =  2, /**< Freed by PMD */
+	RTE_MBUF_HISTORY_OP_APP_FREE  =  3, /**< Freed by application */
+	RTE_MBUF_HISTORY_OP_LIB_ALLOC =  4, /**< Allocation in mbuf library */
+	RTE_MBUF_HISTORY_OP_PMD_ALLOC =  5, /**< Allocated by PMD for Rx */
+	RTE_MBUF_HISTORY_OP_APP_ALLOC =  6, /**< Allocated by application */
+	RTE_MBUF_HISTORY_OP_RX        =  7, /**< Received */
+	RTE_MBUF_HISTORY_OP_TX        =  8, /**< Sent */
+	RTE_MBUF_HISTORY_OP_PREP_TX   =  9, /**< Being prepared before Tx */
+	RTE_MBUF_HISTORY_OP_BUSY_TX   = 10, /**< Returned due to Tx busy */
+	RTE_MBUF_HISTORY_OP_ENQUEUE   = 11, /**< Enqueued for processing */
+	RTE_MBUF_HISTORY_OP_DEQUEUE   = 12, /**< Dequeued for processing */
+	/*                              13,      reserved for future */
+	RTE_MBUF_HISTORY_OP_USR2      = 14, /**< Application-defined event 2 */
+	RTE_MBUF_HISTORY_OP_USR1      = 15, /**< Application-defined event 1 */
+	RTE_MBUF_HISTORY_OP_MAX       = 16, /**< Maximum number of operation types */
+};
+
+/**
+ * Global offset for the history dynamic field (set during initialization).
+ */
+extern int rte_mbuf_history_field_offset;
+
+/**
+ * Initialize the mbuf history system.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * This function registers the dynamic field for mbuf history tracking.
+ * It should be called once during application initialization.
+ *
+ * Note: This function is called by rte_pktmbuf_pool_create,
+ * so explicit invocation is usually not required.
+ */
+__rte_experimental
+void rte_mbuf_history_init(void);
+
+/**
+ * Mark an mbuf with a history event.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * @param m
+ *   Pointer to the mbuf.
+ * @param op
+ *   The operation to record.
+ */
+static inline void rte_mbuf_history_mark(struct rte_mbuf *m, uint32_t op)
+{
+#ifndef RTE_MBUF_HISTORY_DEBUG
+	RTE_SET_USED(m);
+	RTE_SET_USED(op);
+#else
+	RTE_ASSERT(rte_mbuf_history_field_offset >= 0);
+	RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
+	if (unlikely(m == NULL))
+		return;
+
+	rte_mbuf_history_t *history_field = RTE_MBUF_DYNFIELD(m,
+			rte_mbuf_history_field_offset, rte_mbuf_history_t *);
+	uint64_t old_history = rte_atomic_load_explicit(history_field,
+			rte_memory_order_acquire);
+	uint64_t new_history;
+	do {
+		new_history = (old_history << RTE_MBUF_HISTORY_BITS) | op;
+	} while (unlikely(!rte_atomic_compare_exchange_weak_explicit(history_field,
+			&old_history, new_history,
+			rte_memory_order_release, rte_memory_order_acquire)));
+#endif
+}
+
+/**
+ * Mark multiple mbufs with a history event.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * @param mbufs
+ *   Array of mbuf pointers.
+ * @param n
+ *   Number of mbufs to mark.
+ * @param op
+ *   The operation to record.
+ */
+static inline void rte_mbuf_history_mark_bulk(struct rte_mbuf * const *mbufs,
+		uint32_t n, uint32_t op)
+{
+#ifndef RTE_MBUF_HISTORY_DEBUG
+	RTE_SET_USED(mbufs);
+	RTE_SET_USED(n);
+	RTE_SET_USED(op);
+#else
+	RTE_ASSERT(rte_mbuf_history_field_offset >= 0);
+	RTE_ASSERT(op < RTE_MBUF_HISTORY_OP_MAX);
+	if (unlikely(mbufs == NULL))
+		return;
+
+	while (n--)
+		rte_mbuf_history_mark(*mbufs++, op);
+#endif
+}
+
+/**
+ * Dump mbuf history for a single mbuf to a file.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * @param f
+ *   File pointer to write the history to.
+ * @param m
+ *   Pointer to the mbuf to dump history for.
+ */
+__rte_experimental
+void rte_mbuf_history_dump(FILE *f, const struct rte_mbuf *m);
+
+/**
+ * Dump mbuf history statistics for a single mempool to a file.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * @param f
+ *   File pointer to write the history statistics to.
+ * @param mp
+ *   Pointer to the mempool to dump history for.
+ */
+__rte_experimental
+void rte_mbuf_history_dump_mempool(FILE *f, struct rte_mempool *mp);
+
+/**
+ * Dump mbuf history statistics for all mempools to a file.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * @param f
+ *   File pointer to write the history statistics to.
+ */
+__rte_experimental
+void rte_mbuf_history_dump_all(FILE *f);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_MBUF_HISTORY_H_ */
-- 
2.51.0

