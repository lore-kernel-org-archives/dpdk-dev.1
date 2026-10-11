Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0155CA9ECF
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 18:23:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 342BC402E9;
	Sun, 11 Oct 2026 20:22:57 +0200 (CEST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id AC396402DD
 for <dev@dpdk.org>; Sun, 11 Oct 2026 20:22:55 +0200 (CEST)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d71e7so489646a12.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791742975; x=1792347775; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=joYsp6kVBvJhSutz1h1TOVb257uAg7RVOGUKe6Uq+1s=;
 b=o40JlsTZOmW7L9lmBbFoASWGHN4ix0AlWB/oTXoOxK7fY2WDQh8v3ODHdiEnh5aULF
 rSmkCJMdh9OspfHdlN9qupjMCeX5OSyQ0ZyBza2VwzrfMWrGYuZPNvKLHBtZAhNbIfhB
 fstphT1hFWN+8OrN0z1kYeEySDCxqB77AnwQiztavdKKGyIPbXXI4p4hLZBzqaPkXrWk
 4l/3JOWBnIRZurhIeg/N5YhV3ggGt1XdWNEAx2wMml9tGxVj2F+E+zAlYqZK7MRXT9W/
 GyTgYzRJrnlz4x0w7SE7aJFGbm3Q356h6gzWg0w7LiJWZpX0BxctD2gQt1UKoY6+NvRs
 kURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791742975; x=1792347775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=joYsp6kVBvJhSutz1h1TOVb257uAg7RVOGUKe6Uq+1s=;
 b=PhnPOzvHrLgUqOqQ/AMB513CmqLUJrVwT3NWe4mzs4gSfBtAq6CxNZBbd6b6/BFe1F
 wUwqJPgwKWZyyVD1qcWdREFLCh+EL0ZjdUBl/mGbPcxGC8yaZ8a4NCKolbrY3JoIb3Bg
 lOUTOFAnxPtMWmqo0aellnzPhB5zXAQhG+0UXVTAqQ6J1tWSUmqiTfQGz6+E9h+LFXjI
 cXyHO48J83MKBsJ2qQKu2FcNbkBEWQhVpPJlYWKeKVVyAb1idfB8rvwX+f3zpQRMoorT
 Jw129CKxHOkMNQPjhQUcs9qn4m+WvL1YRVG4CYeDJTe3vSursOdT36ojN9CJAzrIp7Pi
 uhBQ==
X-Gm-Message-State: AFq9FYIpGoe4BOPGk0eY5a8+zc08enFLXcZkJ1H9kcHhQXMFg8PXUqyU
 KOuojnrYvbcg0bRt9sMESD9fEuiTCZKcCNbXBJpt1z/t1BCeaZLXJgQ0e1tOp6I1Cmc=
X-Gm-Gg: AYBFou1bNOJJwCEqa1pJixBwHsOBk3L/3jYsEap6D7Oe3tzTXhRHAfirQCm+lOH+3ZC
 Plj/jxP4TJ8eygNtbItKP7sWLQo3rclzOCEN6wMsSo4lsh17vH/vZN+Eq+2HgDilijEh1yuPpYj
 SYnLGbOky6A+cQnJjOcLcniTrENagyAunYrlpoIMBPGJdALo8p53oEPS7o3QehGCyNlbz54gi1C
 6X67+si9I1F0UXjNI7pUq2Xbyd4khd2kE60XXI7qMQu1xuk8Kdpog8ADl8WBlRLt9MOZ270IWOZ
 ZMF6GrHF9ZQfFdoKaUNoPjksE+OSvB5lLsBspeorDOZG3AxUd2cCeHYCz7pTwangSUku9G2K03W
 JdbUaD/O1tkppij9VTOLZfP8KxIY40JRpJbC4ZDJ0Gfj7GKtEJJP8fah6lKB1wicWqMHAf2L/kO
 l1lxCu9dcJp+sd/fiAxK9jOrCtHvB3msJ/w6PuOQgvOJh3H8lLr0mxlwthhDSgWptWcV8Vgw==
X-Received: by 2002:a05:6402:1cc2:b0:6ae:fc0f:e19 with SMTP id
 4fb4d7f45d1cf-6b17c4ee3e2mr6346309a12.42.1791742975198; 
 Sun, 11 Oct 2026 11:22:55 -0700 (PDT)
Received: from dpdk.lxd ([80.233.48.229]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179de7e23sm4083718a12.25.2026.10.11.11.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:22:53 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH 3/9] bpf: reject Tx callback installation with MT_LOCKFREE
Date: Sun, 11 Oct 2026 18:21:51 +0000
Message-ID: <20261011182158.124246-4-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The BPF ethdev packet callback synchronization mechanism expects only
one dataplane thread per port/queue pair at a time. When
RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled, multiple threads can invoke
rte_eth_tx_burst() concurrently on the same queue without locks. This
breaks the callback parity counter and can lead to use-after-free or
deadlocks during BPF program unload.

Reject BPF Tx callback installation with -ENOTSUP when
RTE_ETH_TX_OFFLOAD_MT_LOCKFREE is enabled on the port or queue.
Add a unit test in test_bpf verifying this rejection.

Bugzilla ID: 2051
Fixes: a93ff62a8938 ("bpf: introduce basic Rx/Tx filters")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Marat Khalili <qm2k21@gmail.com>
---
 app/test/test_bpf.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_pkt.c   |  46 ++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 3205afaa63..02523984b5 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4617,6 +4617,107 @@ test_bpf_elf_rx_load(load_elf_image_t load_elf_image)
 	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+static int
+null_vdev_mt_setup(const char *name, uint16_t *port, struct rte_mempool *pool)
+{
+	struct rte_eth_conf conf = {
+		.txmode = {
+			.offloads = RTE_ETH_TX_OFFLOAD_MT_LOCKFREE,
+		},
+	};
+	struct rte_eth_txconf txconf = { };
+	struct rte_eth_rxconf rxconf = { };
+	int ret;
+
+	ret = rte_vdev_init(name, NULL);
+	TEST_ASSERT(ret == 0, "rte_vdev_init(%s) failed: %d", name, ret);
+
+	ret = rte_eth_dev_get_port_by_name(name, port);
+	TEST_ASSERT(ret == 0, "failed to get port id for %s: %d", name, ret);
+
+	ret = rte_eth_dev_configure(*port, 1, 1, &conf);
+	TEST_ASSERT(ret == 0, "failed to configure port %u: %d", *port, ret);
+
+	ret = rte_eth_tx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY, &txconf);
+	TEST_ASSERT(ret == 0, "failed to setup tx queue port %u: %d", *port, ret);
+
+	ret = rte_eth_rx_queue_setup(*port, 0, BPF_TEST_BURST, SOCKET_ID_ANY,
+				     &rxconf, pool);
+	TEST_ASSERT(ret == 0, "failed to setup rx queue port %u: %d", *port, ret);
+
+	ret = rte_eth_dev_start(*port);
+	TEST_ASSERT(ret == 0, "failed to start port %u: %d", *port, ret);
+
+	return 0;
+}
+
+/* Test that installing a Tx filter is rejected when MT_LOCKFREE is enabled */
+static int
+test_bpf_elf_tx_mt_lockfree(load_elf_image_t load_elf_image)
+{
+	static const struct rte_bpf_arg prog_arg = {
+		.type = RTE_BPF_ARG_PTR,
+		.size = sizeof(struct dummy_net),
+	};
+	static const char null_dev[] = "net_null_bpf_mt";
+	struct rte_mempool *mb_pool = NULL;
+	struct rte_bpf *bpf = NULL;
+	uint16_t port = UINT16_MAX;
+	int ret;
+
+	mb_pool = rte_pktmbuf_pool_create("bpf_mt_test_pool", BPF_TEST_POOLSIZE,
+					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+					  SOCKET_ID_ANY);
+	TEST_ASSERT_NOT_NULL(mb_pool, "failed to create mempool");
+
+	ret = null_vdev_mt_setup(null_dev, &port, mb_pool);
+	if (ret != 0)
+		goto fail;
+
+	bpf = load_elf_image(app_test_bpf_filter_o, app_test_bpf_filter_o_len, "filter",
+			     NULL, 0, &prog_arg);
+	if (bpf == NULL) {
+		printf("%s@%d: failed to load BPF filter image\n",
+		       __func__, __LINE__);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+
+	/* Tx installation must fail with -ENOTSUP due to MT_LOCKFREE */
+	ret = rte_bpf_eth_tx_install(port, 0, bpf, 0);
+	if (ret != -ENOTSUP) {
+		printf("%s@%d: expected rte_bpf_eth_tx_install to return -ENOTSUP, got %d\n",
+		       __func__, __LINE__, ret);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+
+	/* Rx installation on the same port must still succeed */
+	ret = rte_bpf_eth_rx_install(port, 0, bpf, 0);
+	if (ret != 0) {
+		printf("%s@%d: expected rte_bpf_eth_rx_install to succeed, got %d\n",
+		       __func__, __LINE__, ret);
+		ret = TEST_FAILED;
+		goto fail;
+	}
+	rte_bpf_eth_rx_unload(port, 0);
+	/* bpf is destroyed by rte_bpf_eth_rx_unload */
+	bpf = NULL;
+
+	ret = TEST_SUCCESS;
+
+fail:
+	if (bpf != NULL)
+		rte_bpf_destroy(bpf);
+
+	if (port != UINT16_MAX) {
+		rte_eth_dev_stop(port);
+		rte_vdev_uninit(null_dev);
+	}
+
+	rte_mempool_free(mb_pool);
+	return ret;
+}
 
 static int
 test_bpf_elf(void)
@@ -4633,6 +4734,8 @@ test_bpf_elf(void)
 			ret = test_bpf_elf_load(elf_image_loaders[li]);
 		if (ret == TEST_SUCCESS)
 			ret = test_bpf_elf_tx_load(elf_image_loaders[li]);
+		if (ret == TEST_SUCCESS)
+			ret = test_bpf_elf_tx_mt_lockfree(elf_image_loaders[li]);
 		if (ret == TEST_SUCCESS)
 			ret = test_bpf_elf_rx_load(elf_image_loaders[li]);
 	}
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 4223ef624e..eab85f7417 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -552,6 +552,48 @@ rte_bpf_eth_tx_unload(uint16_t port, uint16_t queue)
 	rte_spinlock_unlock(&cbh->lock);
 }
 
+/*
+ * Check if the supplied port/queue pair is suitable for BPF callback execution.
+ */
+static int
+bpf_eth_check_mt(const struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue)
+{
+	struct rte_eth_txq_info qinfo;
+	struct rte_eth_conf conf;
+	int ret;
+
+	if (cbh->type == BPF_ETH_TX) {
+		ret = rte_eth_dev_conf_get(port, &conf);
+		if (ret != 0) {
+			RTE_BPF_LOG_LINE(ERR,
+				"%s(%u, %u): failed to get device configuration: %d;",
+				__func__, port, queue, ret);
+			return ret;
+		}
+
+		if ((conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE) != 0) {
+			RTE_BPF_LOG_LINE(ERR,
+				"%s(%u, %u): MT_LOCKFREE Tx offload is enabled on port;",
+				__func__, port, queue);
+			return -ENOTSUP;
+		}
+
+		/*
+		 * Ignore errors from tx_queue_info_get: the PMD might not implement
+		 * txq_info_get (e.g. net/null), or the queue might not be set up yet.
+		 */
+		if (rte_eth_tx_queue_info_get(port, queue, &qinfo) == 0 &&
+				(qinfo.conf.offloads & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE) != 0) {
+			RTE_BPF_LOG_LINE(ERR,
+				"%s(%u, %u): MT_LOCKFREE Tx offload is enabled on queue;",
+				__func__, port, queue);
+			return -ENOTSUP;
+		}
+	}
+
+	return 0;
+}
+
 static int
 bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	struct rte_bpf *bpf, uint32_t flags)
@@ -572,6 +614,10 @@ bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	if (bpf->prm.nb_prog_arg != 1)
 		return -EINVAL;
 
+	rc = bpf_eth_check_mt(cbh, port, queue);
+	if (rc != 0)
+		return rc;
+
 	if (cbh->type == BPF_ETH_RX)
 		frx = select_rx_callback(bpf->prm.prog_arg[0].type, flags);
 	else
-- 
2.43.0

