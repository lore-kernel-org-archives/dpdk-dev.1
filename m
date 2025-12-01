Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37D3D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C1540653;
	Mon,  1 Dec 2025 12:45:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D81EB4013F;
 Mon,  1 Dec 2025 12:45:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589508; x=1796125508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tYHWB0xR3njc0O+7QEQ+ogByuGm8FwxRHoNnvvMJQEg=;
 b=VtCCrkHm2rt+gGHbOZ7uMq0pxLtsn89Yw87F0RPciv5MiLJ9xC9EZ9dI
 thR87vcJAIMW4rBwnBnvOQ1GcN87/2GSP/LWVK3rgOVOAIj1GnFCbOQjW
 YW4j94Ik4CP+iZgmFQ74kttHHKYGyV94qvzvVo8yPHgKm8MkUkNwQAij3
 kvKfKGSmHkiImkOnhNvWVSR+TQHqG/l+GG/93J/Od+ddoHEFgqewtI9MQ
 1hEZJ00OuN654wq2lwAkR+qc1Fp04pZPV7WCbj9snBXieU6qIemJLJMSV
 4W9tmip+v9F3EsEewArDDN23IotbCyGD/M8vY1ThJs07EbCkt8pcME786 g==;
X-CSE-ConnectionGUID: tUAImQoZQ2S0UOidNqYCRQ==
X-CSE-MsgGUID: ybxv9r1KQICRH9+GolfRpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991698"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991698"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:07 -0800
X-CSE-ConnectionGUID: BmS9MrdSThO0MD0nr72mJQ==
X-CSE-MsgGUID: BQQefaQmTqGo+82+dWcNrw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 04/31] eventdev: fix variable shadowing issues
Date: Mon,  1 Dec 2025 11:44:21 +0000
Message-ID: <20251201114448.1441377-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

