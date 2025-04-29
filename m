Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F5DC369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 18:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B46B402A3;
	Tue, 29 Apr 2025 20:11:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 26B2D40277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 20:11:43 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53THT5HH017800;
 Tue, 29 Apr 2025 11:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ubKbTU89EvtQYUb2buy1fmi
 haOeIDwg3R/TzItEcNPQ=; b=IlsKmgdHqVGU7yhKiipJ0vWstx4xydYa6gyS8Gx
 Zt0fpSOAMW7q3ysYCsuthic2GnIXBLjJwTgin+zwODjZeIusdrp7Gs0F1znoCV0w
 d4nZvJJmcmCmyHYwhV9Z0pwPHmkiplnHaprWnIRxyGZoKUZJZ1TNbcDxA0EzkX/U
 F1GSjGWsDQs3W0zdLUFvdiaUYttWtdfn70ZT3qX4ZcvYqoXZygDEoDPeROiW6TQ9
 RD+xAhgBOEv/rNEtEHJntdNa4QtQQLJzzBN5nnJ6k3GGUlBTh9bUt7TegIyJriRe
 rdN1spCc7MC/U4j3aREgqiGTFm59mRFZ+tV6v67sM4WUHuw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 469g8adhvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 11:11:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Apr 2025 11:11:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Apr 2025 11:11:38 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 129463F7060;
 Tue, 29 Apr 2025 11:11:35 -0700 (PDT)
From: <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH] ethdev: remove callback checks from fast path
Date: Tue, 29 Apr 2025 23:41:30 +0530
Message-ID: <20250429181132.2544771-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=aeVhnQot c=1 sm=1 tr=0 ts=6811165b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=VMXhHCWA-yfY0gUsFDUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Bi6SFVcX0SF6m5q_dBXzCP6dyaiMWEIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzNCBTYWx0ZWRfX/RomYVilWdV3
 gc4aL6C32Lb7mqHYgNGz/DLDyzQReFEqjE6PjlDKAXllcgSX8SJ/05ktFY7EVxBd9FsYi7MU+i+
 oE8jIATvz3nwCsNHVzqRMddeBE+aBBk9WCk1uMMGtGlZQnKu3YTJi2LsnRRYLKa8LktLlsUln/Y
 yUvK1p0o6/flyQDHqxamafyiXvWm3TaCgkD8sxyO9A4TBh4bGzIfswRl1SCj1vX3s4O7S82ydQE
 mZdoAZh1IndqQD2p7q1AmQLfGkpPGsO0iuJw3ffIJm8HLFvQHoFBtXf8e6OHm56vFML95ifM72H
 ZoHVPLN1J/FZ10sUTD9FV9Lnca8Lxg+UXbrBRsPZBiM21wXzUzmvN3+ZGmfi28N5xTe30g/zJPz
 UVNtPxgT4TZenouy0IZN46WilokvMHGwJZaRYnoe2/RxtEnmlCsap7cpqyjvqA33iPeBPmH0
X-Proofpoint-ORIG-GUID: Bi6SFVcX0SF6m5q_dBXzCP6dyaiMWEIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
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

Removing these NULL checks instead using dummy callbacks.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 lib/ethdev/ethdev_driver.c | 47 ++++++++++++++++++++++
 lib/ethdev/ethdev_driver.h | 82 ++++++++++++++++++++++++++++++++++++++
 lib/ethdev/ethdev_pci.h    | 19 +++++++++
 lib/ethdev/rte_ethdev.h    | 20 +---------
 4 files changed, 150 insertions(+), 18 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index ec0c1e1176..75073f98cf 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -847,6 +847,53 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
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
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_rx_queue_count_dummy)
+uint32_t
+rte_eth_rx_queue_count_dummy(void *queue __rte_unused)
+{
+	return -ENOTSUP;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_tx_queue_count_dummy)
+int
+rte_eth_tx_queue_count_dummy(void *queue __rte_unused)
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
+
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
 int
 rte_eth_representor_id_get(uint16_t port_id,
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..ec00f16ed3 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1874,6 +1874,88 @@ rte_eth_pkt_burst_dummy(void *queue __rte_unused,
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
+ * Dummy DPDK callback for Rx queue count.
+ *
+ * @param queue
+ *  Pointer to Rx queue
+ */
+__rte_internal
+uint32_t
+rte_eth_rx_queue_count_dummy(void *queue __rte_unused);
+
+/**
+ * @internal
+ * Dummy DPDK callback for Tx queue count.
+ *
+ * @param queue
+ *  Pointer to Tx queue
+ */
+__rte_internal
+int
+rte_eth_tx_queue_count_dummy(void *queue __rte_unused);
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
diff --git a/lib/ethdev/ethdev_pci.h b/lib/ethdev/ethdev_pci.h
index 2229ffa252..1bd49ab822 100644
--- a/lib/ethdev/ethdev_pci.h
+++ b/lib/ethdev/ethdev_pci.h
@@ -16,6 +16,20 @@
 extern "C" {
 #endif
 
+static inline void
+rte_eth_set_dummy_fops(struct rte_eth_dev *eth_dev)
+{
+	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
+	eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	eth_dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
+	eth_dev->rx_queue_count = rte_eth_rx_queue_count_dummy;
+	eth_dev->tx_queue_count = rte_eth_tx_queue_count_dummy;
+	eth_dev->rx_descriptor_status = rte_eth_descriptor_status_dummy;
+	eth_dev->tx_descriptor_status = rte_eth_descriptor_status_dummy;
+	eth_dev->recycle_tx_mbufs_reuse = rte_eth_recycle_tx_mbufs_reuse_dummy;
+	eth_dev->recycle_rx_descriptors_refill = rte_eth_recycle_rx_descriptors_refill_dummy;
+}
+
 /**
  * Copy pci device info to the Ethernet device data.
  * Shared memory (eth_dev->data) only updated by primary process, so it is safe
@@ -147,6 +161,11 @@ rte_eth_dev_pci_generic_probe(struct rte_pci_device *pci_dev,
 	if (!eth_dev)
 		return -ENOMEM;
 
+	/* Update fast path ops with dummy callbacks. Driver will update
+	 * them with required callbacks in the init function.
+	 */
+	rte_eth_set_dummy_fops(eth_dev);
+
 	ret = dev_init(eth_dev);
 	if (ret)
 		rte_eth_dev_release_port(eth_dev);
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..aa67b69134 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6399,8 +6399,6 @@ rte_eth_rx_queue_count(uint16_t port_id, uint16_t queue_id)
 		return -EINVAL;
 #endif
 
-	if (p->rx_queue_count == NULL)
-		return -ENOTSUP;
 	return (int)p->rx_queue_count(qd);
 }
 
@@ -6471,8 +6469,6 @@ rte_eth_rx_descriptor_status(uint16_t port_id, uint16_t queue_id,
 	if (qd == NULL)
 		return -ENODEV;
 #endif
-	if (p->rx_descriptor_status == NULL)
-		return -ENOTSUP;
 	return p->rx_descriptor_status(qd, offset);
 }
 
@@ -6542,8 +6538,6 @@ static inline int rte_eth_tx_descriptor_status(uint16_t port_id,
 	if (qd == NULL)
 		return -ENODEV;
 #endif
-	if (p->tx_descriptor_status == NULL)
-		return -ENOTSUP;
 	return p->tx_descriptor_status(qd, offset);
 }
 
@@ -6786,9 +6780,6 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
-	if (!p->tx_pkt_prepare)
-		return nb_pkts;
-
 	return p->tx_pkt_prepare(qd, tx_pkts, nb_pkts);
 }
 
@@ -6985,8 +6976,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 		return 0;
 	}
 #endif
-	if (p1->recycle_tx_mbufs_reuse == NULL)
-		return 0;
 
 #ifdef RTE_ETHDEV_DEBUG_RX
 	if (rx_port_id >= RTE_MAX_ETHPORTS ||
@@ -7010,8 +6999,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id, uint16_t rx_queue_id,
 		return 0;
 	}
 #endif
-	if (p2->recycle_rx_descriptors_refill == NULL)
-		return 0;
 
 	/* Copy used *rte_mbuf* buffer pointers from Tx mbuf ring
 	 * into Rx mbuf ring.
@@ -7131,14 +7118,11 @@ rte_eth_tx_queue_count(uint16_t port_id, uint16_t queue_id)
 		goto out;
 	}
 #endif
-	if (fops->tx_queue_count == NULL) {
-		rc = -ENOTSUP;
-		goto out;
-	}
-
 	rc = fops->tx_queue_count(qd);
 
+#ifdef RTE_ETHDEV_DEBUG_TX
 out:
+#endif
 	rte_eth_trace_tx_queue_count(port_id, queue_id, rc);
 	return rc;
 }
-- 
2.43.0

