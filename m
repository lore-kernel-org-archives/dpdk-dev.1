Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73A60A2611
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=KSH67MV8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC0C406A2;
	Fri, 20 Nov 2026 17:35:25 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 233ED402E3
 for <dev@dpdk.org>; Fri, 20 Nov 2026 17:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=9V6yCeIckjR9ZdDxT/dUwaYj8qa8GYNRIG3goxr2KqY=;
 b=KSH67MV887H9l3bEXAvS/M841wGWN9TncBnLdLFLt4/vlbrJHEAOYyG8inXjNg
 8fPxwvf0xNWMCJqkMKGFTqm0U16FSIwe8wOObi/GfG4QC4Hhd+JzHKowP/A7InBB
 9B0z9UowK+OzrPN9VSGALMiKlOJuzb+vIf4HYgPo52nFY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 10/28] net/hinic3: add SP230 Rx queue interrupt handling
Date: Sat, 21 Nov 2026 00:34:35 +0800
Message-ID: <20261120163454.1159-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHL5q7dgBrCNqsBQ--.46998S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWkKw13Aw1rAF15tw4UXFb_yoW7CFyxpF
 Z8KF95ArW8XF42grsxGw43uw43Ww4fKry7W3s7Ga4jvryaqrn5uFyUJw15ZFn7CrWDA3Wa
 vF4rGayDKF1jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_-UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMgCosmsAdsALEQAA3v
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SP230 raises the aggregated Rx interrupt even when the application does
not request queue interrupts, and nothing acknowledges it. The HTN tile
has no microcode to mask it and its RQ context has no invalid-INTR
encoding, unlike the STN tile used by SP560.

The INTR field is a plain vector index, so 0 selects the AEQ vector and
every Rx queue raises there. With per-queue MSI-X vectors available,
program the queue vector and leave it disabled: Rx keeps polling and no
interrupt is delivered. hinic3_dev_rx_queue_intr_enable() returns 0 for
SP230 without touching the hardware, so an application that needs Rx
interrupts must set intr_conf.rxq at configure time.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 77 +++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index e74dfa22da..34d7753ff8 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1503,6 +1503,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	uint16_t msix_intr;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
 		return 0;
 
@@ -1765,11 +1768,8 @@ hinic3_init_rxq_msix_attr(void *hwdev, uint16_t msix_index)
 	info.resend_timer_cfg = HINIC3_TXRX_MSIX_RESEND_TIMER_CFG;
 	info.msix_index = msix_index;
 	err = hinic3_set_interrupt_cfg(hwdev, info);
-	if (err) {
-		PMD_DRV_LOG(ERR, "Set msix attr failed, msix_index %d",
-			    msix_index);
+	if (err)
 		return -EFAULT;
-	}
 
 	return 0;
 }
@@ -1786,6 +1786,38 @@ hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)
 	}
 }
 
+/**
+ * Check that the Rx queue vectors fit in the device MSI-X vector table.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] nb_rx_queues
+ * Number of Rx queues to be given a vector.
+ *
+ * @return
+ * 0 if the configuration fits, -EINVAL otherwise.
+ */
+static int
+hinic3_check_rxq_intr_vec(struct rte_eth_dev *dev, uint32_t nb_rx_queues)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t num_irqs = HINIC3_HWIF_NUM_IRQS(nic_dev->hwdev->hwif);
+	uint32_t last_vec;
+
+	if (nb_rx_queues == 0)
+		return 0;
+
+	last_vec = (uint32_t)HINIC3_RX_VEC_START + nb_rx_queues - 1;
+	if (last_vec >= (uint32_t)num_irqs) {
+		PMD_DRV_LOG(ERR,
+			    "Not enough MSI-X vectors for %u Rx queues, need %u vectors, have %u",
+			    nb_rx_queues, last_vec + 1, num_irqs);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * Initialize RX queue interrupts by enabling MSI-X, allocate interrupt vectors,
  * and configure interrupt attributes for each RX queue.
@@ -1798,6 +1830,11 @@ hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)
  * - -ENOTSUP if MSI-X interrupts are not supported.
  * - Error code if enabling event file descriptors fails.
  * - -ENOMEM if allocating interrupt vectors fails.
+ * - -EINVAL if the Rx queues do not fit in the MSI-X vector table.
+ *
+ * On SP230 with per-queue MSI-X vectors, when the application does not
+ * request Rx interrupts, the queue vector is named in each RQ context but
+ * never enabled, and no interrupt resources are allocated.
  */
 static int
 hinic3_init_rxq_intr(struct rte_eth_dev *dev)
@@ -1810,8 +1847,29 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 
 	intr_handle = dev->intr_handle;
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	if (!dev->data->dev_conf.intr_conf.rxq)
+
+	if (!dev->data->dev_conf.intr_conf.rxq) {
+		/*
+		 * SP230 raises the Rx MSI-X vector even without Rx interrupts.
+		 * Name a valid vector in the RQ context; the vector is never
+		 * enabled, so no interrupt is reported.
+		 */
+		if (!HINIC3_IS_SP230_NIC(nic_dev) ||
+		    !rte_intr_cap_multiple(intr_handle))
+			return 0;
+
+		err = hinic3_check_rxq_intr_vec(dev, dev->data->nb_rx_queues);
+		if (err)
+			return err;
+
+		for (i = 0; i < dev->data->nb_rx_queues; i++) {
+			rxq = dev->data->rx_queues[i];
+			rxq->dp_intr_en = 1;
+			rxq->msix_entry_idx = (uint16_t)(i + HINIC3_RX_VEC_START);
+		}
+
 		return 0;
+	}
 
 	if (!rte_intr_cap_multiple(intr_handle)) {
 		PMD_DRV_LOG(ERR, "Rx queue interrupts require MSI-X interrupts (vfio-pci driver)");
@@ -1819,6 +1877,10 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 	}
 
 	nb_rx_queues = dev->data->nb_rx_queues;
+	err = hinic3_check_rxq_intr_vec(dev, nb_rx_queues);
+	if (err)
+		return err;
+
 	err = rte_intr_efd_enable(intr_handle, nb_rx_queues);
 	if (err) {
 		PMD_DRV_LOG(ERR,
@@ -1829,8 +1891,8 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 	intr_handle->intr_vec =
 		rte_zmalloc("hinic_intr_vec", nb_rx_queues * sizeof(int), 0);
 	if (intr_handle->intr_vec == NULL) {
-		PMD_DRV_LOG(ERR, "Failed to allocate intr_vec");
 		rte_intr_efd_disable(intr_handle);
+		PMD_DRV_LOG(ERR, "Failed to allocate intr_vec");
 		return -ENOMEM;
 	}
 	intr_handle->vec_list_size = nb_rx_queues;
@@ -1845,6 +1907,9 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 		err = hinic3_init_rxq_msix_attr(nic_dev->hwdev,
 						rxq->msix_entry_idx);
 		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Set msix attr failed, msix_index %d",
+				    rxq->msix_entry_idx);
 			hinic3_deinit_rxq_intr(dev);
 			return err;
 		}
-- 
2.33.0

