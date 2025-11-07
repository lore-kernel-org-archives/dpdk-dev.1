Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C847CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:51:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD2A440689;
	Fri,  7 Nov 2025 16:51:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D77C54066F;
 Fri,  7 Nov 2025 16:51:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530661; x=1794066661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ry52tCfvYqMdmKr2C4SmUa+7d/2HivS8r6thiYy7lg4=;
 b=BretlmvVN9hxKN0zT45NisO+S0vKpIWKE2WPgJG4L+6PLyWZUZSQnxdO
 plVqUcMT1n5gzn54RQqqY1OdS/+CpPvOdLY2DAVdW1WNfbHzvgPPcbkYG
 8gbiTQOyj7MExDn/6sngbZ9AUltMAN6ZYMSV0kbryLV0oCjl7BN2jk2s7
 R2qIHV/S6Cz3r26EvTxXsqCLdQrlkkXoBkJhtIHtsWmYOLfjhg0e5O5MR
 9/IMpxMq0tvgYzv4oKtLShzAC+MtD4FKk/Wfxw+4R6LzpT1wwL5J29XWN
 CnLeOYh0esQ2o2si41FGBWJqOACfoboZ1wO+PmboML4HQMNRZ9kcJSXrQ Q==;
X-CSE-ConnectionGUID: Pz1TWt0gQfCcJzU/WhgpLQ==
X-CSE-MsgGUID: KK6ug9P6TRaZD9Gj9nHpkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151830"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151830"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:00 -0800
X-CSE-ConnectionGUID: mzhWMKGyQwGE+torHxpMyw==
X-CSE-MsgGUID: JH7wNYyDSo66XhPMxkw5pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321641"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:50:59 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Nikhil Rao <nikhil.rao@intel.com>,
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC PATCH v2 04/33] eventdev: fix variable shadowing issues
Date: Fri,  7 Nov 2025 15:50:00 +0000
Message-ID: <20251107155034.436809-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

Rename a macro variable to avoid shadowing conflicts, and reduce the
scope of another variable for the same reason.

Fixes: a3bbf2e09756 ("eventdev: add eth Tx adapter implementation")
Fixes: 7f33abd49b26 ("eventdev/eth_rx: support appropriately report idle")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eventdev/rte_event_eth_rx_adapter.c | 5 ++---
 lib/eventdev/rte_event_eth_tx_adapter.c | 8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 994f256322..d564e14b72 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -1191,7 +1191,6 @@ rxa_intr_thread(void *arg)
 static inline bool
 rxa_intr_ring_dequeue(struct event_eth_rx_adapter *rx_adapter)
 {
-	uint32_t n;
 	uint32_t nb_rx = 0;
 	int rxq_empty;
 	struct eth_event_enqueue_buffer *buf;
@@ -1260,9 +1259,9 @@ rxa_intr_ring_dequeue(struct event_eth_rx_adapter *rx_adapter)
 		if (rxa_shared_intr(dev_info, queue)) {
 			uint16_t i;
 			uint16_t nb_queues;
+			uint32_t n = 0;
 
 			nb_queues = dev_info->dev->data->nb_rx_queues;
-			n = 0;
 			for (i = dev_info->next_q_idx; i < nb_queues; i++) {
 				uint8_t enq_buffer_full;
 
@@ -1289,7 +1288,7 @@ rxa_intr_ring_dequeue(struct event_eth_rx_adapter *rx_adapter)
 						RTE_MAX_RXTX_INTR_VEC_ID - 1 :
 						0;
 		} else {
-			n = rxa_eth_rx(rx_adapter, port, queue, nb_rx,
+			uint32_t n = rxa_eth_rx(rx_adapter, port, queue, nb_rx,
 				rx_adapter->max_nb_rx,
 				&rxq_empty, buf, stats);
 			rx_adapter->qd_valid = !rxq_empty;
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index 83b6af0955..91c7be55c7 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -64,11 +64,11 @@ do { \
 
 #define TXA_CHECK_OR_ERR_RET(id) \
 do {\
-	int ret; \
+	int _ret; \
 	RTE_EVENT_ETH_TX_ADAPTER_ID_VALID_OR_ERR_RET((id), -EINVAL); \
-	ret = txa_init(); \
-	if (ret != 0) \
-		return ret; \
+	_ret = txa_init(); \
+	if (_ret != 0) \
+		return _ret; \
 	if (!txa_adapter_exist((id))) \
 		return -EINVAL; \
 } while (0)
-- 
2.48.1

