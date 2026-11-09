Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43224606A330
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=TQ6FDrvj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D086410D2;
	Mon,  9 Nov 2026 17:21:09 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTPS id F141E40E0C
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=63T5Y+VFzWvPh+IZPEml5fQKK4usB1RwUaNTXT8EVnc=;
 b=TQ6FDrvj/uko0/4rTMfiQI8/96W3oMcgVESMMMb94kJxsTt5GHV50oDKhwT9Db
 9mkF+oZAbydNBURwyKzNUOKLXex7GL6SWYUVENDVvQOv7ABdS9qfyz3FyyRbdCzt
 9Tx36soBCW4AJJ35/nwEb3or9o36BGHC64k0+le6kK1Jk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 10/28] net/hinic3: add SP230 Rx queue interrupt handling
Date: Tue, 10 Nov 2026 00:20:14 +0800
Message-ID: <20261109162033.1144-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4kAry8Gw4xJrWfZFW5KFg_yoW5ZFWkpF
 W5GF93ArWkJF4xXwsxJa17u3W3uws3WFyUG3s2ka4jvryfJrn5ZFyUtFy7ZFn3KrZxAF13
 ZrsYya1DWa4Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_-UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQYNF2rx8uYOPQAA3V
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

On SP230 the Rx MSI-X vector is asserted on every aggregation, even when
the application did not ask for Rx queue interrupts. With no eventfd to
acknowledge it, an unarmed vector keeps interrupting a core at the
aggregation rate.

Set up the per-queue vectors on SP230 even when Rx interrupts are
disabled, provided the interrupt backend supports multiple vectors: vfio
masks a vector after it fires and only user space can re-arm it, which
keeps the assertions off the CPUs. On igb_uio and uio_pci_generic the
vectors cannot be armed this way, so only the coalescing and resend
parameters are programmed and dev_start keeps working there.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 43 ++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 391967dbe4..2eb5909fff 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1508,6 +1508,9 @@ hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
 		return 0;
 
+	if (HINIC3_IS_SP230_NIC(nic_dev) && !dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
 	msix_intr = (uint16_t)intr_handle->intr_vec[queue_id];
 	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,
 					HINIC3_SET_MSIX_AUTO_MASK);
@@ -1788,6 +1791,25 @@ hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)
 	}
 }
 
+static int
+hinic3_sp230_init_rxq_coalesce(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t msix_intr;
+	uint32_t i;
+	int err;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		msix_intr = (uint16_t)(i + HINIC3_RX_VEC_START);
+
+		err = hinic3_init_rxq_msix_attr(nic_dev->hwdev, msix_intr);
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
@@ -1812,8 +1834,25 @@ hinic3_init_rxq_intr(struct rte_eth_dev *dev)
 
 	intr_handle = dev->intr_handle;
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
-	if (!dev->data->dev_conf.intr_conf.rxq)
-		return 0;
+
+	if (!dev->data->dev_conf.intr_conf.rxq) {
+		/*
+		 * SP230 asserts the Rx MSI-X vector on every aggregation and
+		 * nothing acknowledges it when Rx interrupts are disabled. On
+		 * MSI-X capable setups set the per-queue vectors up anyway:
+		 * vfio masks a vector after it fires and only user space can
+		 * re-arm it, which keeps the assertions off the CPUs. Other
+		 * interrupt backends (igb_uio, uio_pci_generic) cannot do
+		 * that, so only program the coalescing parameters there.
+		 */
+		if (!HINIC3_IS_SP230_NIC(nic_dev))
+			return 0;
+
+		if (!rte_intr_cap_multiple(intr_handle))
+			return hinic3_sp230_init_rxq_coalesce(dev);
+
+		/* Fall through to the per-queue MSI-X setup. */
+	}
 
 	if (!rte_intr_cap_multiple(intr_handle)) {
 		PMD_DRV_LOG(ERR, "Rx queue interrupts require MSI-X interrupts (vfio-pci driver)");
-- 
2.33.0

