Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7EA606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=QQcZk9Kr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E17E740E17;
	Fri, 30 Oct 2026 15:48:08 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTPS id A4F6740B9C
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=taDIqOO6LwJODXc31YaCgjMwVvZwWY9LRhRSd0GW6BA=;
 b=QQcZk9Kr/ln1qDLTW/wik9D4AAoA4WCT3d6NnXomZJ7WrNSgQGfcMloTLN0JpF
 5n5K0XXJvQS+b/Kv6bB1vdbiqpGPOj7y9VVMWkARC2hGs490n6/58oEzdx7FYYsz
 vG+I4l3Ym1mBdVhlWnU0a0jYwWtUWBQ4d/enX1/aQziz8=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 10/28] net/hinic3: add SP230 Rx queue interrupt handling
Date: Fri, 30 Oct 2026 22:47:14 +0800
Message-ID: <20261030144733.2120-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1UAr45Jw1fAFWrurWxZwb_yoW5GrWDpF
 W5GF95ArWkXF47XanxGw43u3W3W397W348ur93Ka4jvr15Xr1rZryUJFyUZr13KrWUG3W3
 Zr4FkayDW3Wjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_-UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBmFj2rkrhlZOwAA38
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

On SP230 the Rx MSI-X vector is asserted during packet aggregation. When
Rx interrupts are disabled, skip the per-queue MSI-X enable and instead
configure the vectors' coalescing and auto-mask state at init, so those
assertions are masked instead of preempting a core.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 34 +++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 2400adfb81..978e1b0a22 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1509,6 +1509,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
 		return 0;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
 	msix_intr = (uint16_t)intr_handle->intr_vec[queue_id];
 	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,
 					HINIC3_SET_MSIX_AUTO_MASK);
@@ -1789,6 +1792,23 @@ hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)
 	}
 }
 
+static int
+hinic3_sp230_mask_rxq_msix(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t i;
+	int err;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		err = hinic3_init_rxq_msix_attr(nic_dev->hwdev,
+						(uint16_t)(i + HINIC3_RX_VEC_START));
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * Initialize RX queue interrupts by enabling MSI-X, allocate interrupt vectors,
  * and configure interrupt attributes for each RX queue.
@@ -1813,8 +1833,20 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 
 	intr_handle = dev->intr_handle;
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	if (!dev->data->dev_conf.intr_conf.rxq)
+
+	if (!dev->data->dev_conf.intr_conf.rxq) {
+		/*
+		 * SP230 asserts the Rx MSI-X vector during aggregation; mask
+		 * those assertions so they don't preempt a core. Only the
+		 * coalescing/auto-mask programming is needed here, without
+		 * eventfds, intr_vec or dp_intr_en, so dev_start keeps working
+		 * on igb_uio/uio_pci_generic when Rx interrupts are disabled.
+		 */
+		if (HINIC3_IS_SP230_NIC(nic_dev))
+			return hinic3_sp230_mask_rxq_msix(dev);
+
 		return 0;
+	}
 
 	if (!rte_intr_cap_multiple(intr_handle)) {
 		PMD_DRV_LOG(ERR, "Rx queue interrupts require MSI-X interrupts (vfio-pci driver)");
-- 
2.33.0

