Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBA606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=lsr7BQnM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65957406A2;
	Tue, 17 Nov 2026 16:57:47 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTPS id 5DCB1402EB
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=mnfQVfoSm1rEHtkJ+al4iLIgFRGgw9ntbfSqVrgHYFQ=;
 b=lsr7BQnMvJrkfHpVJx4HByis3tLnXJzcLZfmdSn+YHf5zSk/YpYtGI87oGh03w
 WB3wpmUtiVyDI3N0Dk9ahiUVUOPvXX7JCEjy+wQ9iO2Dgort5S7pqvaJ1M+6EhUp
 6BSRLRtmCEy5erqs7zyunazem2f4NMZ+lHEPu6rgU2mhU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v7 11/29] net/hinic3: add SP230 Rx queue interrupt handling
Date: Tue, 17 Nov 2026 23:56:52 +0800
Message-ID: <20261117155711.1048-12-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261117155711.1048-1-yejiacheng4@h-partners.com>
References: <20261109162033.1144-1-yejiacheng4@h-partners.com>
 <20261117155711.1048-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgC3S5drefxqC7WJBQ--.4821S13
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr45tr15Jry7XryDXw1xAFb_yoWrXw15pF
 W5KF9Yyry8XF429rsxCa17uw13Wws7KryUWF97Ca4j9ryaqrn5XFyUJa45ZFn2krWDA3W2
 vr4rCayqgF1jq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uio7tUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxBUXmr8eXADoQAA3Q
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
 drivers/net/hinic3/hinic3_ethdev.c | 36 +++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 391967dbe4..75f2f5f6fc 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1505,6 +1505,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	uint16_t msix_intr;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
 		return 0;
 
@@ -1767,11 +1770,8 @@ hinic3_init_rxq_msix_attr(void *hwdev, uint16_t msix_index)
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
@@ -1800,6 +1800,10 @@ hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)
  * - -ENOTSUP if MSI-X interrupts are not supported.
  * - Error code if enabling event file descriptors fails.
  * - -ENOMEM if allocating interrupt vectors fails.
+ *
+ * On SP230 with per-queue MSI-X vectors, when the application does not
+ * request Rx interrupts, the queue vector is named in each RQ context but
+ * never enabled, and no interrupt resources are allocated.
  */
 static int
 hinic3_init_rxq_intr(struct rte_eth_dev *dev)
@@ -1812,8 +1816,25 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 
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
@@ -1831,8 +1852,8 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 	intr_handle->intr_vec =
 		rte_zmalloc("hinic_intr_vec", nb_rx_queues * sizeof(int), 0);
 	if (intr_handle->intr_vec == NULL) {
-		PMD_DRV_LOG(ERR, "Failed to allocate intr_vec");
 		rte_intr_efd_disable(intr_handle);
+		PMD_DRV_LOG(ERR, "Failed to allocate intr_vec");
 		return -ENOMEM;
 	}
 	intr_handle->vec_list_size = nb_rx_queues;
@@ -1847,6 +1868,9 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
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

