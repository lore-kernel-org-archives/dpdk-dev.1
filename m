Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C8C87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 07:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74BD240668;
	Mon,  4 Aug 2025 09:48:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2ED29400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 09:48:01 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5745k3ho001353;
 Mon, 4 Aug 2025 00:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 TAoJozQVD45F0Qg+9wFk4IlCRCKIclpu9qqPFbrdoc=; b=aEnOeuqJieLMX25M4
 DpE+0NHaAOwt5FZox4vGO40IfzLG/EbqGCxhYF5xP5hD4Up0+Ob4AC0K1DSj4a6s
 aA70bkNPK42q1lo+UbHxOpvrA37mjWhCr9svk0iJsUUwJ4pviTAvWeWL0WWyaWh1
 0sZNC3yV7J+OEfN+QBd9mbDuyJ6OmEQCcX4U/h2/pw7XPEJqJRzuGDCVIKrYzeyi
 zfeVaIk7W8RVSianf5j6sunPvxIgBMWrqswREOu0QFO0MzANVl5ts9Dq+lrf9yQG
 Xeo2l24XhE+7L4Qaw5F6t82OCqvBo9GEzxJgtb/s25b8DBgSa1twR0Zk2ZmsY+Kx
 tW54g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48aq0hr6b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Aug 2025 00:47:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 4 Aug 2025 00:48:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 4 Aug 2025 00:48:01 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 980E35B6938;
 Mon,  4 Aug 2025 00:47:51 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 2/2] ethdev: remove callback checks from fast path
Date: Mon, 4 Aug 2025 13:16:24 +0530
Message-ID: <20250804074733.55145-2-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804074733.55145-1-skori@marvell.com>
References: <20250512150732.65743-1-skori@marvell.com>
 <20250804074733.55145-1-skori@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nEL9Mix_Zbt6g-ZWtjREpX8UEj8kqjzQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA0MCBTYWx0ZWRfXzIxFx8Bgcntx
 eWvbT33GOFhzSuUpiQmYLYxxpYcq1VMiIllq/sXulvXDTRK8i74HB/NC4E85DRyylt3eurXir42
 UKSOW4i3fBt2ExCM8UFkr/ZR6F601QXbYz7lYn11joYjvljkxXI6oSqon4YZffRMtyVtZkgAcaC
 uLiZk2peK67X6eST3e7PyjvSnKx7TUmzL7y74uWwcTqzV1S4Nu+vBZyoosBkq7U45ddfzmxzFzL
 y0I6o5DFrmFg8qLUXHY7IDVIUQYcCvQIB3D1B3zaaism7bNVMkr8ZBEpCEfvRC1ck/Vl0N1lvWk
 U3D128MgTKE5Q6p2fpt+5zh+17+N8tYUe7LCQb23JqAjZ8eG/mDGpjJSsP8Ewlmt+UmwOR/dVzM
 Egwju097Zpzh3hL+LzBVTp/zFshkU0TeGCssqjddfZXr7Hzalfas5UJqBDMC4NrgPq2nIhYF
X-Authority-Analysis: v=2.4 cv=PMkP+eqC c=1 sm=1 tr=0 ts=689065af cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=n02bokGJAAAA:8
 a=pK7X0mNQAAAA:8 a=VMXhHCWA-yfY0gUsFDUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=rszdq1ld3peujIA30KyE:22 a=5HA-qpC1VU4iIGLgRoNS:22
X-Proofpoint-GUID: nEL9Mix_Zbt6g-ZWtjREpX8UEj8kqjzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

rte_eth_fp_ops contains ops for fast path APIs. Each API
validates availability of callback and then invoke it.
These checks impact data path performace.

Hence removing these NULL checks instead using dummy
callbacks.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
v2..v3
 - rebase on top of tree.

 lib/ethdev/ethdev_driver.c | 55 +++++++++++++++++++++++++++++
 lib/ethdev/ethdev_driver.h | 71 ++++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 29 ++--------------
 3 files changed, 129 insertions(+), 26 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index ec0c1e1176..f89562b237 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -75,6 +75,20 @@ eth_dev_get(uint16_t port_id)
 	return eth_dev;
 }
 
+static void
+eth_dev_set_dummy_fops(struct rte_eth_dev *eth_dev)
+{
+	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
+	eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	eth_dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
+	eth_dev->rx_queue_count = rte_eth_queue_count_dummy;
+	eth_dev->tx_queue_count = rte_eth_queue_count_dummy;
+	eth_dev->rx_descriptor_status = rte_eth_descriptor_status_dummy;
+	eth_dev->tx_descriptor_status = rte_eth_descriptor_status_dummy;
+	eth_dev->recycle_tx_mbufs_reuse = rte_eth_recycle_tx_mbufs_reuse_dummy;
+	eth_dev->recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_dev_allocate)
 struct rte_eth_dev *
 rte_eth_dev_allocate(const char *name)
@@ -115,6 +129,7 @@ rte_eth_dev_allocate(const char *name)
 	}
 
 	eth_dev = eth_dev_get(port_id);
+	eth_dev_set_dummy_fops(eth_dev);
 	eth_dev->flow_fp_ops = &rte_flow_fp_default_ops;
 	strlcpy(eth_dev->data->name, name, sizeof(eth_dev->data->name));
 	eth_dev->data->port_id = port_id;
@@ -847,6 +862,46 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_tx_pkt_prepare_dummy)
+uint16_t
+rte_eth_tx_pkt_prepare_dummy(void *queue __rte_unused,
+		struct rte_mbuf **pkts __rte_unused,
+		uint16_t nb_pkts)
+{
+	return nb_pkts;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_queue_count_dummy)
+int
+rte_eth_queue_count_dummy(void *queue __rte_unused)
+{
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_descriptor_status_dummy)
+int
+rte_eth_descriptor_status_dummy(void *queue __rte_unused,
+		uint16_t offset __rte_unused)
+{
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_tx_mbufs_reuse_dummy)
+uint16_t
+rte_eth_recycle_tx_mbufs_reuse_dummy(void *queue __rte_unused,
+		struct rte_eth_recycle_rxq_info *recycle_rxq_info __rte_unused)
+{
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_rx_descriptors_refill_dummy)
+void
+rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
+		uint16_t nb __rte_unused)
+{
+	/* No action. */
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
 int
 rte_eth_representor_id_get(uint16_t port_id,
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..71085bddff 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1874,6 +1874,77 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
 		struct rte_mbuf **pkts __rte_unused,
 		uint16_t nb_pkts __rte_unused);
 
+/**
+ * @internal
+ * Dummy DPDK callback for Tx packet prepare.
+ *
+ * @param queue
+ *  Pointer to Tx queue
+ * @param pkts
+ *  Packet array
+ * @param nb_pkts
+ *  Number of packets in packet array
+ */
+__rte_internal
+uint16_t
+rte_eth_tx_pkt_prepare_dummy(void *queue __rte_unused,
+		struct rte_mbuf **pkts __rte_unused,
+		uint16_t nb_pkts __rte_unused);
+
+/**
+ * @internal
+ * Dummy DPDK callback for queue count.
+ *
+ * @param queue
+ *  Pointer to Rx/Tx queue
+ */
+__rte_internal
+int
+rte_eth_queue_count_dummy(void *queue __rte_unused);
+
+/**
+ * @internal
+ * Dummy DPDK callback for descriptor status.
+ *
+ * @param queue
+ *  Pointer to Rx/Tx queue
+ * @param offset
+ *  The offset of the descriptor starting from tail (0 is the next
+ *  packet to be received by the driver).
+ */
+__rte_internal
+int
+rte_eth_descriptor_status_dummy(void *queue __rte_unused,
+		uint16_t offset __rte_unused);
+
+/**
+ * @internal
+ * Dummy DPDK callback for recycle Tx mbufs reuse.
+ *
+ * @param queue
+ *  Pointer to Tx queue
+ * @param recycle_rxq_info
+ *  Pointer to recycle Rx queue info
+ */
+__rte_internal
+uint16_t
+rte_eth_recycle_tx_mbufs_reuse_dummy(void *queue __rte_unused,
+		struct rte_eth_recycle_rxq_info *recycle_rxq_info __rte_unused);
+
+/**
+ * @internal
+ * Dummy DPDK callback Rx descriptor refill.
+ *
+ * @param queue
+ *  Pointer Rx queue
+ * @param offset
+ *  number of descriptors to refill
+ */
+__rte_internal
+void
+rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
+		uint16_t nb __rte_unused);
+
 /**
  * Allocate an unique switch domain identifier.
  *
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 4ccb0c62d2..5d7fc5ee9d 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6402,8 +6402,6 @@ rte_eth_rx_queue_count(uint16_t port_id, uint16_t queue_id)
 		return -EINVAL;
 #endif
 
-	if (p->rx_queue_count == NULL)
-		return -ENOTSUP;
 	return p->rx_queue_count(qd);
 }
 
@@ -6474,8 +6472,6 @@ rte_eth_rx_descriptor_status(uint16_t port_id, uint16_t queue_id,
 	if (qd == NULL)
 		return -ENODEV;
 #endif
-	if (p->rx_descriptor_status == NULL)
-		return -ENOTSUP;
 	return p->rx_descriptor_status(qd, offset);
 }
 
@@ -6545,8 +6541,6 @@ static inline int rte_eth_tx_descriptor_status(uint16_t port_id,
 	if (qd == NULL)
 		return -ENODEV;
 #endif
-	if (p->tx_descriptor_status == NULL)
-		return -ENOTSUP;
 	return p->tx_descriptor_status(qd, offset);
 }
 
@@ -6789,9 +6783,6 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
-	if (!p->tx_pkt_prepare)
-		return nb_pkts;
-
 	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
 }
 
@@ -6988,8 +6979,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 		return 0;
 	}
 #endif
-	if (p1->recycle_tx_mbufs_reuse == NULL)
-		return 0;
 
 #ifdef RTE_ETHDEV_DEBUG_RX
 	if (rx_port_id >= RTE_MAX_ETHPORTS ||
@@ -7013,8 +7002,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 		return 0;
 	}
 #endif
-	if (p2->recycle_rx_descriptors_refill == NULL)
-		return 0;
 
 	/* Copy used *rte_mbuf* buffer pointers from Tx mbuf ring
 	 * into Rx mbuf ring.
@@ -7110,15 +7097,13 @@ rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
 #ifdef RTE_ETHDEV_DEBUG_TX
 	if (port_id >= RTE_MAX_ETHPORTS || !rte_eth_dev_is_valid_port(port_id)) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Invalid port_id=%u", port_id);
-		rc = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	if (queue_id >= RTE_MAX_QUEUES_PER_PORT) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Invalid queue_id=%u for port_id=%u",
 				    queue_id, port_id);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 #endif
 
@@ -7130,18 +7115,10 @@ rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
 	if (qd == NULL) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Invalid queue_id=%u for port_id=%u",
 				    queue_id, port_id);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 #endif
-	if (fops->tx_queue_count == NULL) {
-		rc = -ENOTSUP;
-		goto out;
-	}
-
 	rc = fops->tx_queue_count(qd);
-
-out:
 	rte_eth_trace_tx_queue_count(port_id, queue_id, rc);
 	return rc;
 }
-- 
2.43.0

