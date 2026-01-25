Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03285E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14A14042C;
	Sun, 25 Jan 2026 21:24:42 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 09489402C3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 21:24:38 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43591b55727so3734261f8f.3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 12:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769372677;
 x=1769977477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrKqg0XwhQiUchrk0B8KPngnbOB/G2Vtpeis05cr+BA=;
 b=ISuyFyqOSoXB6OjSUARTUpzY8n7qYOvYSOWXJClQZK6s86yMopBrG77uskdvS+VpFA
 zL2QrYbZU9Enw1kSmvZOxPE6a28Z+Z2tKNLpbKUQvXTRjqfTRnodZosver0plfeKpQv0
 t1H/yLXSHCXH1qQQtUZHOUHY/cz436e3h3ai3iEwXBaARvtHNqWR/MqhgoJ3goUPcoDi
 qgVsp+L65zYRy4KVG8D8167ccJVF6I4SpTULJ56g1QEN4BMSEOtO9Y/1LB8vl//hya/U
 +pUzyCysVB9EoFPlzb53JCrv9FTNbn2ROfcvTIfl8KzoJ6DpcDEOUx48hYOrnhFmXw3L
 Zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769372677; x=1769977477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jrKqg0XwhQiUchrk0B8KPngnbOB/G2Vtpeis05cr+BA=;
 b=HuAJJ0FKU7wiqVf2dIpbqwplNFIJG0z/QZrteDmLqRIGEsblPux63oOSsxAPVD9ieq
 nTTTU+2stjepuM9AAPM+uSZhnYkyGq87+bjpHpOiIxkZujDzxvjdPZnyRUXpbm3eUkaA
 0LYeDOckeNbRCIiaZanh2C1BVX/kAIGRq4tY+TxhkFFQL7I+7IM9DTY2DHLaWiZ7uGeb
 9BP4Ct5vXHJyuaQnG3WP94cM7Zale8L7OehG8rrOCap1koUcBkfVwjVvEGpG+mttrEU5
 QmwWBNZz6lRP8CCWb7VbO2SrJAZmkOUujTf0WzrngO6nLoQ7zoN/AcY04MG9CZpA/YOb
 10qw==
X-Gm-Message-State: AOJu0YzVfw5GAlrjFjgb9iKFxSr2WOJX56Hos5xzvUrmU4wIKGq38CdL
 HyPdOo7uWSj0qBz/1dY4quhAjq4Naeyas/sLQvSFwKHJCNbsx8Qj1HBOBXdNthMdysd50nnpiUw
 Ww0lJ
X-Gm-Gg: AZuq6aIL51QuSz/KAwAh15R3x1hyn1mYMjZ1bemFSdfMrUnT12Tq5fzvP6P4laMMKNu
 C8JFsVbnH/kmSCPjmshSEF7tCevH608Tyd8OX8adKqOIP36OtlUbv4AI9ErUvQ+GmYhbHDqsNlI
 G50yc0ybwjrViYkplkVKDDir9RTr8FtGGpvBwKbu5Bb/rOpT3n6OMSSmYlGncl3qAHRL/QikVV/
 nC3fnwzrbufXa5FRpKRzsS7isMMtx5y5+YBKVCV8qu284JaLDngVFCIs6iZPfPVkE7cwGahEVD2
 Cdql21yKAmPHpETHGhFZObS4yemZv2qAMC4CqEdlCcwNopvY/nH6nbs8+3jP6FyktcosmwCFHvW
 /hMnuAwnLN9dn0miDLn8aL7OElkutOgekRdRCZ2KuEI/ziHpmlwK6qNeVKPdaoAfgMntVlkCjZm
 FDfMJVLUeRtufrr6tP/ymQPtGA8hCJGOSEEIfcsbkd/U25ibfvtA==
X-Received: by 2002:a05:6000:18a6:b0:430:f255:14b3 with SMTP id
 ffacd0b85a97d-435ca39adc3mr4447785f8f.43.1769372677608; 
 Sun, 25 Jan 2026 12:24:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bedsm23682024f8f.17.2026.01.25.12.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 12:24:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH v7 4/5] net/null: add check for pool vs packet size
Date: Sun, 25 Jan 2026 12:23:04 -0800
Message-ID: <20260125202425.532542-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125202425.532542-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260125202425.532542-1-stephen@networkplumber.org>
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

The mbuf pool passed when setting up queue must have space
in the mbuf to hold the requested packet size; otherwise the
code in eth_null_copy_rx() would generate invalid mbuf.

Fixes: c743e50c475f ("null: new poll mode driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_null.c               | 48 ++++++--------------------
 doc/guides/rel_notes/release_26_03.rst |  2 ++
 drivers/net/null/rte_eth_null.c        |  3 ++
 3 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/app/test/test_pmd_null.c b/app/test/test_pmd_null.c
index 3104f1ced0..72503d64c7 100644
--- a/app/test/test_pmd_null.c
+++ b/app/test/test_pmd_null.c
@@ -221,9 +221,7 @@ test_null_tx_basic(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Statistics verification
- */
+/* Test: Statistics verification */
 static int
 test_null_stats(void)
 {
@@ -271,9 +269,7 @@ test_null_stats(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Custom packet size
- */
+/* Test: Custom packet size */
 static int
 test_null_custom_size(void)
 {
@@ -314,9 +310,7 @@ test_null_custom_size(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Copy mode
- */
+/* Test: Copy mode */
 static int
 test_null_copy_mode(void)
 {
@@ -346,9 +340,7 @@ test_null_copy_mode(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: No-RX mode
- */
+/* Test: No-RX mode */
 static int
 test_null_no_rx_mode(void)
 {
@@ -384,9 +376,7 @@ test_null_no_rx_mode(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Link status
- */
+/* Test: Link status */
 static int
 test_null_link_status(void)
 {
@@ -422,9 +412,7 @@ test_null_link_status(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Device info
- */
+/* Test: Device info */
 static int
 test_null_dev_info(void)
 {
@@ -462,9 +450,7 @@ test_null_dev_info(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Multiple RX/TX bursts
- */
+/* Test: Multiple RX/TX bursts */
 static int
 test_null_multiple_bursts(void)
 {
@@ -685,9 +671,7 @@ test_null_reta_config(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: Stats reset
- */
+/* Test: Stats reset */
 static int
 test_null_stats_reset(void)
 {
@@ -730,9 +714,7 @@ test_null_stats_reset(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test: MAC address operations
- */
+/* Test: MAC address operations */
 static int
 test_null_mac_addr(void)
 {
@@ -772,9 +754,7 @@ test_null_promisc_allmulti(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Multi-threaded TX test structures and worker function
- */
+/* Multi-threaded TX test structures and worker function */
 #define MT_TX_BURSTS_PER_LCORE 100
 #define MT_TX_BURST_SIZE 8
 
@@ -794,9 +774,6 @@ mt_tx_worker(void *arg)
 	unsigned int burst;
 	uint16_t nb_tx;
 
-	args->tx_count = 0;
-	args->error = 0;
-
 	for (burst = 0; burst < MT_TX_BURSTS_PER_LCORE; burst++) {
 		/* Allocate mbufs */
 		if (rte_pktmbuf_alloc_bulk(args->pool, bufs, MT_TX_BURST_SIZE) != 0) {
@@ -834,7 +811,7 @@ test_null_mt_tx(void)
 {
 	struct rte_eth_dev_info dev_info;
 	struct rte_mempool *mt_pool;
-	struct mt_tx_args worker_args[RTE_MAX_LCORE];
+	struct mt_tx_args worker_args[RTE_MAX_LCORE] = { 0 };
 	struct rte_eth_stats stats;
 	unsigned int lcore_id;
 	unsigned int num_workers = 0;
@@ -885,10 +862,7 @@ test_null_mt_tx(void)
 			break;
 
 		worker_args[num_workers].port = port_id;
-		worker_args[num_workers].queue = 0;  /* All use same queue */
 		worker_args[num_workers].pool = mt_pool;
-		worker_args[num_workers].tx_count = 0;
-		worker_args[num_workers].error = 0;
 
 		ret = rte_eal_remote_launch(mt_tx_worker,
 					    &worker_args[num_workers],
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 9f2f2ff58f..e59d839164 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -58,6 +58,8 @@ New Features
 * **Updated NULL ethernet driver.**
 
   * Changed info response to match mbuf limits.
+  * Added validation that mbuf pool data size is large enough for
+    packet size argument.
 
 
 Removed Items
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 3e743a23a9..81001d9326 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -241,6 +241,9 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 
 	packet_size = internals->packet_size;
 
+	if (rte_pktmbuf_data_room_size(mb_pool) < packet_size)
+		return -ENOSPC;
+
 	internals->rx_null_queues[rx_queue_id].mb_pool = mb_pool;
 	dev->data->rx_queues[rx_queue_id] =
 		&internals->rx_null_queues[rx_queue_id];
-- 
2.51.0

