Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A80ECA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 20:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09746402D9;
	Sun, 11 Oct 2026 22:29:35 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id CC75C40279
 for <dev@dpdk.org>; Sun, 11 Oct 2026 22:29:32 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so275553a12.1
 for <dev@dpdk.org>; Sun, 11 Oct 2026 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791750572;
 x=1792355372; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DJJEWNHK7LodtMRspLhnnU0tRK3+5g+cazDByXmzEnU=;
 b=HpwKshjNMTKssudn9w8E2pTMv/dTH7qksKirm58srvAjaJsF0ChyJVpHD7y+ffa5RB
 QRm2CA3231gxYpYo3XCYK8ZXHlKW0vtJbFooDRFEMEpxUqm7JqbQRJBgaDF3L3+tjYOx
 CVN1EAR0Himm5FLGwgd5TkV6voTFkIdhBk4g3+s98jtlkH3fT3AM+vlWhsK2kQsE5hwq
 JQZSgeMKJTLFOA2tg3X5DBecUWbyeVJ2W39Hrbde49ZCRwMuL1p7xWOapPRQG4EYWIQX
 SgTn04jitZVG38yw0q5I50W6PkKskUX8er5SYnAK9rY8dLreLDiALUEe91m/8Surov6z
 H18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791750572; x=1792355372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DJJEWNHK7LodtMRspLhnnU0tRK3+5g+cazDByXmzEnU=;
 b=u4ZKQPEOIW/7XLomprnkW+2285oFZjvaNUAY8egaqXZ3m57I/br//AU8L7nsfFcYCx
 8l6IgP2Px43OdlYyqp+MqeJtmdMrJPO+J8k50oestBuO1jxs/K2Kr7OKuax95B2g1hu7
 rroFjdVgHLSyDw33gj+v/ZNc29r18/Kyee+NdiSJojeEd1ZVoa+A2NAInfOBBaQl75nF
 DFfEyhgNaZXVq9iyipQKfwbkBkqlNBvzYbXU7FnoIB76N98I7UVGekirW+0kmMii7SgP
 Tdwt33vhK5Byc9tN5R7UKEmgtLt58skNmyfJTNTJu3keEZIV7HX8ctEtaoOVOPCq1uIQ
 gILg==
X-Gm-Message-State: AFq9FYKNiIxiDRYrW+c3Wq2xy0aRDruGiCTUEeh8FZ4ZwcA0H/Fzz9o1
 CDNNeBS+CsLNdlFV+Bj23MpMfk3Y00TiDjmAonIi2Y9Rd/vW8tibtJ7X2vxnp05TuRuep1i5bIF
 UM3LPio0=
X-Gm-Gg: AYBFou0e3QeIhu7LX81Gt0yDw6i/I6JKSKUD9X5/0iIKj4UbdZCxd6uMcYgbSuwGodI
 HQlvaFmgLNkurfeNoGeJpe2XjwokxXnhbSM11w7axDSSGM9koAxdXjbonX+uR2qOk6R8CuSi4D7
 U55q0u55dg+EHv1h7gxXRqVW1JH/0oWopqP8YLbrXQQBeZbRS9y3u/s+oH7ecck41lXtXXG2iM5
 S/Gv0cN48BWUZVAikZ8CGRIlCKcBgVsX2HMoBsiwI9fVZgbLyDDzYIQ8ECyx2fd3xN+VC+OcXvX
 h85uNKG7oGhulw+nwdgT1eXhwX+4UrDGUwGiK6kgaWRdn0gLeFe3S6aKNLa5q4Jj3EWEz56UpU3
 SOtNXhO+/hQd5h7sQ1r1cikJrWTqqFIGI0qORjpw+e3evvE1WyD2dKW6lj69NqhDbMBluLeuN2M
 3AlyZ3SKbu/DQCcDOccx2n8PAPj+1f1AXcVpN0deqYb1jnydq1gunrl31jg1ii4RC5cDLiSM7kh
 DmylEIQZ3DlpkXQjgbjdZ/hzwEM0U3aNtK08g==
X-Received: by 2002:a17:90b:2ccb:b0:3a4:6e84:e7d8 with SMTP id
 98e67ed59e1d1-3ab3afd2c4cmr6439027a91.54.1791750570098; 
 Sun, 11 Oct 2026 13:29:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37817414sm14033765a91.2.2026.10.11.13.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 13:29:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFC] bpf: fix callback unload with concurrent Tx burst
Date: Sun, 11 Oct 2026 13:29:08 -0700
Message-ID: <20261011202927.166974-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011182158.124246-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
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

This is AI remix of the smp_mb barrier removal patch, the patch series from Marat.

The Rx/Tx callback use counter assumes only one thread at a time
does Rx/Tx burst on a queue. That is not true for Tx with
RTE_ETH_TX_OFFLOAD_MT_LOCKFREE. With two threads in the callback
the counter can be even while the program is still running, so
unload can destroy a BPF program that is in use. Without
enable_stdatomic the increment is not atomic and an update can be
lost, so unload can also wait forever.

Replace the odd/even counter with an atomic count of the threads
inside the callback. The datapath increments it on entry and
decrements it with release on exit. Unload clears cb and waits for
zero with acquire.

Make cb atomic. The datapath increment and cb load, and the unload
cb store and count load, are seq_cst; this replaces rte_smp_mb()
and rte_smp_rmb(). Install publishes cb with release so the
datapath sees bpf and jit.

On x86 the datapath is now two locked instructions per burst
instead of one.

Add a test that loads and unloads a Tx filter while worker lcores
transmit on the same MT_LOCKFREE queue of a null device.

Bugzilla ID: 2051
Fixes: a93ff62a8938 ("bpf: introduce basic Rx/Tx filters")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c      | 148 +++++++++++++++++++++++++++++++-
 lib/bpf/bpf_pkt.c        | 177 +++++++++++++++++----------------------
 lib/bpf/rte_bpf_ethdev.h |   2 +
 3 files changed, 225 insertions(+), 102 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..f21e906c6f 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4329,6 +4329,10 @@ test_bpf_elf_load(load_elf_image_t load_elf_image)
 #include <rte_ethdev.h>
 #include <rte_bpf_ethdev.h>
 #include <rte_bus_vdev.h>
+#include <rte_cycles.h>
+#include <rte_launch.h>
+#include <rte_lcore.h>
+#include <rte_pause.h>
 
 #include "test_bpf_filter.h"
 
@@ -4336,7 +4340,8 @@ test_bpf_elf_load(load_elf_image_t load_elf_image)
 #define BPF_TEST_POOLSIZE	256 /* at least 2x burst */
 #define BPF_TEST_PKT_LEN	64 /* Ether + IP + TCP */
 
-static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool *pool)
+static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool *pool,
+			   uint64_t tx_offloads)
 {
 	int ret;
 
@@ -4347,7 +4352,9 @@ static int null_vdev_setup(const char *name, uint16_t *port, struct rte_mempool
 	ret = rte_eth_dev_get_port_by_name(name, port);
 	TEST_ASSERT(ret == 0, "failed to get port id for %s: %d", name, ret);
 
-	struct rte_eth_conf conf = { };
+	struct rte_eth_conf conf = {
+		.txmode.offloads = tx_offloads,
+	};
 	ret = rte_eth_dev_configure(*port, 1, 1, &conf);
 	TEST_ASSERT(ret == 0, "failed to configure port %u: %d", *port, ret);
 
@@ -4488,7 +4495,7 @@ test_bpf_elf_tx_load(load_elf_image_t load_elf_image)
 					  SOCKET_ID_ANY);
 	TEST_ASSERT(mb_pool != NULL, "failed to create mempool");
 
-	ret = null_vdev_setup(null_dev, &port, mb_pool);
+	ret = null_vdev_setup(null_dev, &port, mb_pool, 0);
 	if (ret != 0)
 		goto fail;
 
@@ -4577,7 +4584,7 @@ test_bpf_elf_rx_load(load_elf_image_t load_elf_image)
 					  SOCKET_ID_ANY);
 	TEST_ASSERT(pool != NULL, "failed to create mempool");
 
-	ret = null_vdev_setup(null_dev, &port, pool);
+	ret = null_vdev_setup(null_dev, &port, pool, 0);
 	if (ret != 0)
 		goto fail;
 
@@ -4618,6 +4625,136 @@ test_bpf_elf_rx_load(load_elf_image_t load_elf_image)
 }
 
 
+#define BPF_MT_BURST		32
+#define BPF_MT_POOLSIZE		4096
+#define BPF_MT_ITERATIONS	1000
+
+static RTE_ATOMIC(bool) bpf_mt_stop;
+
+struct bpf_mt_arg {
+	uint16_t port;
+	struct rte_mempool *pool;
+};
+
+/* Transmit on the same queue as the other workers until told to stop. */
+static int
+bpf_mt_tx_worker(void *arg)
+{
+	const struct bpf_mt_arg *mt = arg;
+	struct rte_mbuf *pkts[BPF_MT_BURST];
+
+	while (!rte_atomic_load_explicit(&bpf_mt_stop, rte_memory_order_relaxed)) {
+		if (rte_pktmbuf_alloc_bulk(mt->pool, pkts, BPF_MT_BURST) != 0) {
+			rte_pause();
+			continue;
+		}
+		setup_mbufs(pkts, BPF_MT_BURST);
+
+		uint16_t sent = rte_eth_tx_burst(mt->port, 0, pkts, BPF_MT_BURST);
+		rte_pktmbuf_free_bulk(pkts + sent, BPF_MT_BURST - sent);
+	}
+	return 0;
+}
+
+/*
+ * Load and unload a Tx filter while several lcores do tx burst
+ * on the same MT_LOCKFREE queue.
+ */
+static int
+test_bpf_elf_tx_mt_lockfree(load_elf_image_t load_elf_image)
+{
+	static const struct rte_bpf_arg prog_arg = {
+		.type = RTE_BPF_ARG_PTR,
+		.size = sizeof(struct dummy_net),
+	};
+	static const char null_dev[] = "net_null_bpf_mt";
+	struct bpf_mt_arg mt = { .port = UINT16_MAX };
+	struct rte_eth_dev_info dev_info;
+	unsigned int lcore, workers = 0;
+	int ret;
+
+	RTE_LCORE_FOREACH_WORKER(lcore)
+		workers++;
+	if (workers < 2) {
+		printf("%s: need at least 2 worker lcores, skipping\n", __func__);
+		return TEST_SKIPPED;
+	}
+
+	mt.pool = rte_pktmbuf_pool_create("bpf_mt_test_pool", BPF_MT_POOLSIZE,
+					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+					  SOCKET_ID_ANY);
+	TEST_ASSERT_NOT_NULL(mt.pool, "failed to create mempool");
+
+	ret = null_vdev_setup(null_dev, &mt.port, mt.pool, RTE_ETH_TX_OFFLOAD_MT_LOCKFREE);
+	if (ret != 0)
+		goto fail;
+
+	ret = rte_eth_dev_info_get(mt.port, &dev_info);
+	if (ret != 0)
+		goto fail;
+	if (!(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE)) {
+		ret = TEST_SKIPPED;
+		goto fail;
+	}
+
+	rte_atomic_store_explicit(&bpf_mt_stop, false, rte_memory_order_relaxed);
+	RTE_LCORE_FOREACH_WORKER(lcore)
+		rte_eal_remote_launch(bpf_mt_tx_worker, &mt, lcore);
+
+	for (unsigned int i = 0; i < BPF_MT_ITERATIONS; i++) {
+		uint32_t flags = (i & 1) ? RTE_BPF_ETH_F_JIT : 0;
+		struct rte_bpf *bpf;
+		struct rte_bpf_jit jit;
+
+		bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len,
+				     "filter", NULL, 0, &prog_arg);
+		if (bpf == NULL) {
+			printf("%s@%d: failed to load BPF filter\n", __func__, __LINE__);
+			ret = TEST_FAILED;
+			break;
+		}
+
+		rte_bpf_get_jit(bpf, &jit);
+		if (jit.func == NULL)
+			flags = 0;
+
+		ret = rte_bpf_eth_tx_install(mt.port, 0, bpf, flags);
+		if (ret != 0) {
+			printf("%s@%d: install failed: %d\n", __func__, __LINE__, ret);
+			rte_bpf_destroy(bpf);
+			ret = TEST_FAILED;
+			break;
+		}
+
+		rte_delay_us(10);
+		rte_bpf_eth_tx_unload(mt.port, 0);
+	}
+
+	rte_atomic_store_explicit(&bpf_mt_stop, true, rte_memory_order_relaxed);
+	rte_eal_mp_wait_lcore();
+
+	if (ret == 0) {
+		unsigned int avail = rte_mempool_avail_count(mt.pool);
+
+		if (avail != BPF_MT_POOLSIZE) {
+			printf("%s: mempool available %u != %u\n",
+			       __func__, avail, BPF_MT_POOLSIZE);
+			ret = TEST_FAILED;
+		}
+	}
+
+fail:
+	if (mt.port != UINT16_MAX) {
+		rte_eth_dev_stop(mt.port);
+		rte_vdev_uninit(null_dev);
+	}
+	rte_mempool_free(mt.pool);
+
+	if (ret == TEST_SKIPPED)
+		return TEST_SKIPPED;
+	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
+}
+
 static int
 test_bpf_elf(void)
 {
@@ -4637,6 +4774,9 @@ test_bpf_elf(void)
 			ret = test_bpf_elf_rx_load(elf_image_loaders[li]);
 	}
 
+	if (ret == TEST_SUCCESS)
+		ret = test_bpf_elf_tx_mt_lockfree(load_elf_image_direct);
+
 	return ret;
 }
 
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..e9fe4aeb5a 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -26,8 +26,8 @@
 
 struct __rte_cache_aligned bpf_eth_cbi {
 	/* used by both data & control path */
-	RTE_ATOMIC(uint32_t) use;    /*usage counter */
-	const struct rte_eth_rxtx_callback *cb;  /* callback handle */
+	RTE_ATOMIC(uint32_t) use;    /* number of datapath threads in callback */
+	RTE_ATOMIC(const struct rte_eth_rxtx_callback *) cb;  /* callback handle */
 	struct rte_bpf *bpf;
 	struct rte_bpf_jit jit;
 	/* used by control path only */
@@ -36,12 +36,6 @@ struct __rte_cache_aligned bpf_eth_cbi {
 	uint16_t queue;
 };
 
-/*
- * Odd number means that callback is used by datapath.
- * Even number means that callback is not used by datapath.
- */
-#define BPF_ETH_CBI_INUSE  1
-
 /*
  * List to manage RX/TX installed callbacks.
  */
@@ -75,45 +69,50 @@ static struct bpf_eth_cbh tx_cbh = {
 };
 
 /*
- * Marks given callback as used by datapath.
+ * Removing an rx/tx callback is done in two steps (similar to RCU).
+ * The callback is removed from the ethdev queue so later bursts do not
+ * call it, but a burst already in progress may still be running it.
+ *
+ * The use counter is the number of threads inside the callback.
+ * There can be more than one on a Tx queue with MT_LOCKFREE.
+ *
+ * Datapath increments use then loads cb; unload stores cb then loads use.
+ * These are seq_cst, so either the datapath sees cb == NULL and skips
+ * the program, or unload sees use != 0 and waits for zero. The release
+ * decrement pairs with the acquire wait, so the program is destroyed
+ * only after its last use.
+ */
+
+/*
+ * Enter the callback. Returns true if the BPF program may be run.
  */
-static __rte_always_inline void
-bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
+static inline bool
+bpf_eth_cbi_enter(struct bpf_eth_cbi *cbi)
 {
-	cbi->use++;
-	/* make sure no store/load reordering could happen */
-	rte_smp_mb();
+	rte_atomic_fetch_add_explicit(&cbi->use, 1, rte_memory_order_seq_cst);
+	return rte_atomic_load_explicit(&cbi->cb, rte_memory_order_seq_cst) != NULL;
 }
 
 /*
- * Marks given callback list as not used by datapath.
+ * Leave the callback.
  */
-static __rte_always_inline void
-bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
+static inline void
+bpf_eth_cbi_exit(struct bpf_eth_cbi *cbi)
 {
-	/* make sure all previous loads are completed */
-	rte_smp_rmb();
-	cbi->use++;
+	rte_atomic_fetch_sub_explicit(&cbi->use, 1, rte_memory_order_release);
 }
 
 /*
  * Waits till datapath finished using given callback.
+ * Must be called after cb is cleared.
  */
 static void
 bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
 {
-	uint32_t puse;
+	__rte_atomic uint32_t *use = (__rte_atomic uint32_t *)(uintptr_t)&cbi->use;
 
-	/* make sure all previous loads and stores are completed */
-	rte_smp_mb();
-
-	puse = cbi->use;
-
-	/* in use, busy wait till current RX/TX iteration is finished */
-	if ((puse & BPF_ETH_CBI_INUSE) != 0) {
-		RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t *)(uintptr_t)&cbi->use,
-			UINT32_MAX, !=, puse, rte_memory_order_relaxed);
-	}
+	if (rte_atomic_load_explicit(use, rte_memory_order_seq_cst) != 0)
+		RTE_WAIT_UNTIL_MASKED(use, UINT32_MAX, ==, 0, rte_memory_order_acquire);
 }
 
 static void
@@ -262,16 +261,12 @@ bpf_rx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	__rte_unused uint16_t max_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 1);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static uint16_t
@@ -280,15 +275,12 @@ bpf_rx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	__rte_unused uint16_t max_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 1) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 1);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static uint16_t
@@ -296,15 +288,12 @@ bpf_tx_callback_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	struct rte_mbuf *pkt[], uint16_t nb_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 0) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_vm(cbi->bpf, pkt, nb_pkts, 0);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static uint16_t
@@ -312,15 +301,12 @@ bpf_tx_callback_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	struct rte_mbuf *pkt[], uint16_t nb_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 0) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_jit(&cbi->jit, pkt, nb_pkts, 0);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 /*
@@ -333,15 +319,12 @@ bpf_rx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	__rte_unused uint16_t max_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 1) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 1);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static uint16_t
@@ -350,15 +333,12 @@ bpf_rx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	__rte_unused uint16_t max_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 1) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 1);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static uint16_t
@@ -366,15 +346,12 @@ bpf_tx_callback_mb_vm(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	struct rte_mbuf *pkt[], uint16_t nb_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 0) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_mb_vm(cbi->bpf, pkt, nb_pkts, 0);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static uint16_t
@@ -382,15 +359,12 @@ bpf_tx_callback_mb_jit(__rte_unused uint16_t port, __rte_unused uint16_t queue,
 	struct rte_mbuf *pkt[], uint16_t nb_pkts, void *user_param)
 {
 	struct bpf_eth_cbi *cbi;
-	uint16_t rc;
 
 	cbi = user_param;
-	bpf_eth_cbi_inuse(cbi);
-	rc = (cbi->cb != NULL) ?
-		pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 0) :
-		nb_pkts;
-	bpf_eth_cbi_unuse(cbi);
-	return rc;
+	if (bpf_eth_cbi_enter(cbi))
+		nb_pkts = pkt_filter_mb_jit(&cbi->jit, pkt, nb_pkts, 0);
+	bpf_eth_cbi_exit(cbi);
+	return nb_pkts;
 }
 
 static rte_rx_callback_fn
@@ -438,8 +412,7 @@ static void
 bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 {
 	/* mark this cbi as empty */
-	bc->cb = NULL;
-	rte_smp_mb();
+	rte_atomic_store_explicit(&bc->cb, NULL, rte_memory_order_seq_cst);
 
 	/* make sure datapath doesn't use bpf anymore, then destroy bpf */
 	bpf_eth_cbi_wait(bc);
@@ -450,16 +423,21 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
 static void
 bpf_eth_unload(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
 {
+	const struct rte_eth_rxtx_callback *cb;
 	struct bpf_eth_cbi *bc;
 
 	bc = bpf_eth_cbh_find(cbh, port, queue);
-	if (bc == NULL || bc->cb == NULL)
+	if (bc == NULL)
+		return;
+
+	cb = rte_atomic_load_explicit(&bc->cb, rte_memory_order_relaxed);
+	if (cb == NULL)
 		return;
 
 	if (cbh->type == BPF_ETH_RX)
-		rte_eth_remove_rx_callback(port, queue, bc->cb);
+		rte_eth_remove_rx_callback(port, queue, cb);
 	else
-		rte_eth_remove_tx_callback(port, queue, bc->cb);
+		rte_eth_remove_tx_callback(port, queue, cb);
 
 	bpf_eth_cbi_unload(bc);
 }
@@ -494,6 +472,7 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	struct rte_bpf *bpf, uint32_t flags)
 {
 	int32_t rc;
+	const struct rte_eth_rxtx_callback *cb;
 	struct bpf_eth_cbi *bc;
 	rte_rx_callback_fn frx;
 	rte_tx_callback_fn ftx;
@@ -534,18 +513,20 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 		return -ENOMEM;
 
 	/* remove old one, if any */
-	if (bc->cb != NULL)
-		bpf_eth_unload(cbh, port, queue);
+	bpf_eth_unload(cbh, port, queue);
 
 	bc->bpf = bpf;
 	bc->jit = jit;
 
 	if (cbh->type == BPF_ETH_RX)
-		bc->cb = rte_eth_add_rx_callback(port, queue, frx, bc);
+		cb = rte_eth_add_rx_callback(port, queue, frx, bc);
 	else
-		bc->cb = rte_eth_add_tx_callback(port, queue, ftx, bc);
+		cb = rte_eth_add_tx_callback(port, queue, ftx, bc);
+
+	/* publish bpf and jit to the datapath */
+	rte_atomic_store_explicit(&bc->cb, cb, rte_memory_order_release);
 
-	if (bc->cb == NULL) {
+	if (cb == NULL) {
 		rc = -rte_errno;
 		bpf_eth_cbi_cleanup(bc);
 	} else
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index 686fda8d94..9f14a624d4 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -14,6 +14,8 @@
  *   same port/queue from different threads in parallel.
  * - though it allows load/unload at runtime
  *   (while RX/TX is ongoing on given port/queue).
+ * - TX burst on the same port/queue may be called from more than
+ *   one thread when RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled.
  * - allows only one BPF program per port/queue,
  * i.e. new load will replace previously loaded for that port/queue BPF program.
  * Filter behaviour - if BPF program returns zero value for a given packet,
-- 
2.53.0

