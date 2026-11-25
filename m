Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85270606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=i+oXWtQt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5FBE40E16;
	Wed, 25 Nov 2026 18:06:09 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTPS id C60E4406BC
 for <dev@dpdk.org>; Wed, 25 Nov 2026 18:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=bt8fqXiwVyATEI4cSo9BujRE8NBByHJyFHtQwc9EjrE=;
 b=i+oXWtQtQ0KHkoiWA8zW3IysPbXGes05tYncIxWbkhXKyqmP9nnvrEgJjgf5M4
 /q20kteiVFq62f1cJg8TfyVqNclHjDQ6iIZyPZ6c4D/PQeI/+xNlTLH6uyHSzJEv
 xu2TXQsrCfq+RRYVAXr1Krlm8z+ZVgKJkmgqxcVr3c2h0=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 18/30] net/hinic3: add VF link state and promiscuous support
Date: Thu, 26 Nov 2026 01:04:12 +0800
Message-ID: <20261125170425.5430-19-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.56.0.windows.2
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDn77FiFQdrEdNeBQ--.6538S20
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFykAr1UGFWUtr4xCF18uFg_yoWfCr1xpa
 4UGa9ayF9rJF47X3Z8Gw47u3W5Xa1Iy3yUKas3Ca4rZ3Z8XrZ8Z347JrW2vr15trZrXa17
 uF409F4qyF1jgrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwF4_UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMw-8B2sHFW8akwAA3Y
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

VF link state followed the PF, so a VF could not be brought down while
the PF stayed up. Track vf_valid_status and combine it with the physical
link when computing the VF link status.

Keep a separate admin_down flag, set only by dev_set_link_up/down, and
check it in hinic3_set_vport_state(), dev_start() and the VF link status
so a PF link-up event cannot re-enable a vport the application brought
down.

Register the promiscuous callback in the VF ethdev_ops.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst     |  1 +
 drivers/net/hinic3/base/hinic3_hwdev.h     |  3 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.c   |  2 +
 drivers/net/hinic3/base/hinic3_nic_event.c |  9 ++-
 drivers/net/hinic3/hinic3_ethdev.c         | 71 +++++++++++++++++++---
 drivers/net/hinic3/hinic3_ethdev.h         |  2 +
 6 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4ccc9ad5a7..13c62f71ac 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -134,6 +134,7 @@ New Features
     aggregation (LAG) support.
   * Added FEC mode get and set support.
   * Added Class of Service (COS) mask and map support.
+  * Added VF link up/down and promiscuous mode support.
   * Added mailbox message counter reporting through the device private dump API.
 
 * **Updated Intel iavf driver.**
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/base/hinic3_hwdev.h
index c6661aa1a6..87ca18e571 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.h
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h
@@ -157,7 +157,8 @@ struct hinic3_hwdev {
 	char mgmt_ver[MGMT_VERSION_MAX_LEN];
 
 	uint16_t max_vfs;
-	uint16_t link_status;
+	uint8_t link_status;
+	uint8_t vf_valid_status; /* vport_enable: 1, vport_disable: 0 */
 	uint64_t features[HINIC3_MAX_FEATURE_QWORD];
 };
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 531ac0ecf9..f65b071258 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -468,6 +468,8 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 		return -EIO;
 	}
 
+	hwdev->vf_valid_status = enable;
+
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic3/base/hinic3_nic_event.c
index 981a5f5083..0fe7b54981 100644
--- a/drivers/net/hinic3/base/hinic3_nic_event.c
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c
@@ -82,7 +82,8 @@ hinic3_set_vport_state(struct hinic3_hwdev *hwdev,
 	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(hwdev->eth_dev);
 
 	if (link_state->state) {
-		if (hinic3_get_bit(HINIC3_DEV_START, &nic_dev->dev_status))
+		if (hinic3_get_bit(HINIC3_DEV_START, &nic_dev->dev_status) &&
+		    !nic_dev->admin_down)
 			err = hinic3_set_vport_enable(hwdev, true);
 	} else {
 		err = hinic3_set_vport_enable(hwdev, false);
@@ -111,6 +112,12 @@ link_status_event_handler(struct hinic3_hwdev *hwdev, struct hinic3_handler_info
 
 	/* Link event reported only after set vport enable. */
 	hinic3_get_link_port_info(hwdev, link_status->state, &link);
+
+	if (HINIC3_IS_VF(hwdev)) {
+		hwdev->link_status = link.link_status;
+		link.link_status = hwdev->link_status & hwdev->vf_valid_status;
+	}
+
 	err = rte_eth_linkstatus_set(hwdev->eth_dev, &link);
 	if (!err && hwdev->eth_dev->data->dev_conf.intr_conf.lsc != 0)
 		rte_eth_dev_callback_process(hwdev->eth_dev,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 325764dee4..5c10bd3c47 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -821,6 +821,26 @@ hinic3_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 	return 0;
 }
 
+/**
+ * Get the VF link status reported to the application.
+ *
+ * @param[in] nic_dev
+ * Pointer to the hinic3 NIC device.
+ *
+ * @return
+ * Link status of the VF, RTE_ETH_LINK_UP or RTE_ETH_LINK_DOWN.
+ */
+static uint8_t
+hinic3_vf_link_status(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (nic_dev->admin_down)
+		return RTE_ETH_LINK_DOWN;
+
+	return hwdev->link_status & hwdev->vf_valid_status;
+}
+
 /**
  * Set ethernet device link state up.
  *
@@ -834,8 +854,11 @@ static int
 hinic3_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_link link = { 0 };
 	int err;
 
+	nic_dev->admin_down = 0;
+
 	/*
 	 * Vport enable will set function valid in mpu.
 	 * So dev start status need to be checked before vport enable.
@@ -845,6 +868,7 @@ hinic3_dev_set_link_up(struct rte_eth_dev *dev)
 		if (err) {
 			PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",
 				    nic_dev->dev_name);
+			nic_dev->admin_down = 1;
 			return err;
 		}
 	}
@@ -855,9 +879,17 @@ hinic3_dev_set_link_up(struct rte_eth_dev *dev)
 		PMD_DRV_LOG(ERR,
 			    "Set MAC link up failed, dev_name: %s, port_id: %d",
 			    nic_dev->dev_name, dev->data->port_id);
+		nic_dev->admin_down = 1;
 		return err;
 	}
 
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {
+		link = dev->data->dev_link;
+		link.link_status = hinic3_vf_link_status(nic_dev);
+
+		(void)rte_eth_linkstatus_set(dev, &link);
+	}
+
 	return 0;
 }
 
@@ -874,10 +906,14 @@ static int
 hinic3_dev_set_link_down(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_link link = { 0 };
 	int err;
 
+	nic_dev->admin_down = 1;
+
 	err = hinic3_set_vport_enable(nic_dev->hwdev, false);
 	if (err) {
+		nic_dev->admin_down = 0;
 		PMD_DRV_LOG(ERR, "Disable vport failed, dev_name: %s",
 			    nic_dev->dev_name);
 		return err;
@@ -887,11 +923,18 @@ hinic3_dev_set_link_down(struct rte_eth_dev *dev)
 	err = hinic3_set_port_enable(nic_dev->hwdev, false);
 	if (err) {
 		PMD_DRV_LOG(ERR,
-			"Set MAC link down failed, dev_name: %s, port_id: %d",
-			nic_dev->dev_name, dev->data->port_id);
+			    "Set MAC link down failed, dev_name: %s, port_id: %d",
+			    nic_dev->dev_name, dev->data->port_id);
 		return err;
 	}
 
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {
+		link = dev->data->dev_link;
+		link.link_status = hinic3_vf_link_status(nic_dev);
+
+		(void)rte_eth_linkstatus_set(dev, &link);
+	}
+
 	return 0;
 }
 
@@ -939,6 +982,13 @@ hinic3_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	} while (rep_cnt--);
 
 out:
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {
+		if (ret == 0)
+			nic_dev->hwdev->link_status = link.link_status;
+		link.link_status = (ret == 0) ?
+			hinic3_vf_link_status(nic_dev) : RTE_ETH_LINK_DOWN;
+	}
+
 	return rte_eth_linkstatus_set(dev, &link);
 }
 
@@ -2125,12 +2175,13 @@ hinic3_dev_start(struct rte_eth_dev *eth_dev)
 
 	hinic3_start_all_sqs(eth_dev);
 
-	/* Open virtual port and ready to start packet receiving. */
-	err = hinic3_set_vport_enable(nic_dev->hwdev, true);
-	if (err) {
-		PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",
-			    eth_dev->data->name);
-		goto en_vport_fail;
+	if (!nic_dev->admin_down) {
+		err = hinic3_set_vport_enable(nic_dev->hwdev, true);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",
+				    eth_dev->data->name);
+			goto en_vport_fail;
+		}
 	}
 
 	/* Open physical port and start packet receiving. */
@@ -3699,6 +3750,8 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
 	.fw_version_get                = hinic3_fw_version_get,
+	.dev_set_link_up               = hinic3_dev_set_link_up,
+	.dev_set_link_down             = hinic3_dev_set_link_down,
 	.rx_queue_setup                = hinic3_rx_queue_setup,
 	.tx_queue_setup                = hinic3_tx_queue_setup,
 	.rx_queue_intr_enable          = hinic3_dev_rx_queue_intr_enable,
@@ -3720,6 +3773,8 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.vlan_offload_set              = hinic3_vlan_offload_set,
 	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
 	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
+	.promiscuous_enable            = hinic3_dev_promiscuous_enable,
+	.promiscuous_disable           = hinic3_dev_promiscuous_disable,
 	.rss_hash_update               = hinic3_rss_hash_update,
 	.rss_hash_conf_get             = hinic3_rss_conf_get,
 	.reta_update                   = hinic3_rss_reta_update,
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 935b7719ca..a078120794 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -141,6 +141,8 @@ struct hinic3_nic_dev {
 
 	RTE_ATOMIC(uint64_t)dev_status;
 
+	uint8_t admin_down; /**< Link down requested by dev_set_link_down(). */
+
 	uint8_t pause_set; /**< Flag of PAUSE frame setting. */
 	struct nic_pause_config nic_pause;
 
-- 
2.33.0

