Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB4CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D8EC40612;
	Mon, 12 Oct 2026 23:09:57 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id DE3E740612
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:09:55 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so15841765e9.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791839395; x=1792444195; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=joYsp6kVBvJhSutz1h1TOVb257uAg7RVOGUKe6Uq+1s=;
 b=kmiGRLFaLmrQCv5ZCIsd6iKDen0faxScbNryoZfkfRjCn3mOcBfcT91YHlpkd8hKav
 tYbeZKFrDPvgEiPeOHwCPZQOvTTLLf1IwjpKjBrD2GFjS1+3P+GATncfk0bqHVzzn7KP
 XRU4crdcYoLJkYHxlm5SSgeopAAgZnOWZW7846joggRb1M7pRmvNxGxAV52wqW4JHh6z
 2+goDgF8txFY/JuMYLdOfTxZeQg5eGvTnkcToD8ewSbJTdyhzm6ek54tEyJwsNKC92A5
 cgA9Kde5H91vwobos1i/YWBuxcAJVTE3OW5vzLVdYyzyoIex9tmDB/DpRhZ6JV+WGnHn
 IO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791839395; x=1792444195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=joYsp6kVBvJhSutz1h1TOVb257uAg7RVOGUKe6Uq+1s=;
 b=Ttu9zvGUjgWizJJ9oMYq1wqRgq/m/Tn9NMSEk7yoWAnuQz0LA+LyrtoVRiyGKouYJo
 lFlY18W2cUnsTM++N4PIWEdZF3nKyZn2T7u2V0AKqGC6RKquUwDqyo/sJrYRwmv3vPsR
 0WgI3D/IfpOkxfl1Wt2tSSLupAxiT+xo0aRgcEaRHZUjtSL24IuqVW19xJqBJ2GorvBv
 Ac1TQCC0OkDfRjEt0yNud8nbL/KnrdrwAW4xt6yVGokGlO0cpNC1DO7LqVsFUlCib7iR
 Pwh7rlRuG4OFnn97Nq5D7IESLPqsQaWDrNYaGQH+E1I5mfWPYGDwMz3gdefMDeSu0VxY
 WSYQ==
X-Gm-Message-State: AFq9FYLnxSO9JiUXx1iRfmn1Eu/c4YV9PK3Iv/A+Q45mkXh+KTWxArT5
 MVZIDv7DyR2vuDNTbp0UIb6ZvSd01ujeuAMqwAxWVv++Okwlk8OmDfvK
X-Gm-Gg: AYBFou0SslNJDtUTco3L2ksJ60c02w9MHatnTjdL5TiGy9G2CeTcP0wMui2dp/PvUol
 TUmbY1q258HXOkNUuBam14hZ0NmPaZVf9RuYNWziedusFWKBPIq1soDjeW8VIjxyNqFfJH6BoqV
 kdWnxWP2aHF0qNI8YnlW3UsGqnD0a/sXskz6G7oTqNrRzUqEBCshkgoglnKU8UuwuNB0lIWgyip
 xxK8iCWc29znoewTY9hKEXRjqGMKbbc8wNWR8bFDMTzuTkhF7taVlJfv0ao35eOS9aFzW69JD00
 1XDzBdRSnYlCHrVYPc7KsWfihiXA+LpfpB8wmtf91bMh8OVVM3iIAv3KA+zr2AMNOGJ7qbL41QD
 1C4XIUNzVGcR+PGPvYhSievSeUzNj6MxFdeHpTUhZmqugukdPeN3Ezrd1hazYs0m82TCF08O0dq
 wNF8RcCXb60WyT1z240eFvR1csTHvbma5/P3c3JudMPCMilVr3OLX+d+iSK1s=
X-Received: by 2002:a05:600c:3e8f:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4a18e44653cmr211852635e9.4.1791839395377; 
 Mon, 12 Oct 2026 14:09:55 -0700 (PDT)
Received: from dpdk.lxd ([80.233.57.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm342208725e9.10.2026.10.12.14.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:09:53 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Cc: dev@dpdk.org,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v2 3/9] bpf: reject Tx callback installation with MT_LOCKFREE
Date: Mon, 12 Oct 2026 21:09:10 +0000
Message-ID: <20261012210917.161343-4-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012210917.161343-1-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
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

