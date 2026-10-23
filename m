Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754E606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=PZ2Hi516
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C4BB40DDD;
	Fri, 23 Oct 2026 17:58:31 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 23F5F4067A
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=bVugVN1DSdQhSEDsW6XdrU55mVOC7NEL0wO/JjYfL2o=;
 b=PZ2Hi516DrFCQVMMmPjlqc9iP5DWCjSa5CrBBQznarACuZFncOpGX9RI+jvK/i
 T+GMHAheKBJPEhVZLyozbxYdLVCBc0kXfz8KgRZcndCnZb2+TkV55/35CEC13Jw9
 zOpwQ1smHyPHS2rrBulUiNp2p94WLMCcj3b/gzglgZtW8=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 15/27] net/hinic3: add VF link state and promiscuous support
Date: Fri, 23 Oct 2026 23:57:56 +0800
Message-ID: <20261023155809.855-16-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S17
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWUtw45WrW7trWUuw13CFg_yoW7CF1rpa
 yUGa9ayFyDWF47X3Z8Gw47uF15X3WxG347K3s3C3WYv3W5Zr98Z348JrW2vr13t3srJa12
 vF48ur4q9F18KrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uio7tUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxq4wmrbhBoDJgAA3d
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

Every VF link previously followed the PF, so a VF could not be brought down
while the PF stayed up. Track vf_valid_status and combine it with the
physical link so the VF link can be set down independently.

Register the promiscuous callbacks in the VF eth_dev_ops so a VF can enter
promiscuous mode independently as well.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/base/hinic3_hwdev.h     |  3 +-
 drivers/net/hinic3/base/hinic3_nic_cfg.c   |  2 ++
 drivers/net/hinic3/base/hinic3_nic_event.c |  6 ++++
 drivers/net/hinic3/hinic3_ethdev.c         | 32 ++++++++++++++++++++--
 4 files changed, 40 insertions(+), 3 deletions(-)

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
index 34f4384ee9..60175c72ce 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -470,6 +470,8 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 		return -EIO;
 	}
 
+	hwdev->vf_valid_status = enable;
+
 	return 0;
 }
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic3/base/hinic3_nic_event.c
index 981a5f5083..787b4b0739 100644
--- a/drivers/net/hinic3/base/hinic3_nic_event.c
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c
@@ -111,6 +111,12 @@ link_status_event_handler(struct hinic3_hwdev *hwdev, struct hinic3_handler_info
 
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
index 912d330504..9117293ff7 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -832,6 +832,7 @@ static int
 hinic3_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_link link = { 0 };
 	int err;
 
 	/*
@@ -856,6 +857,14 @@ hinic3_dev_set_link_up(struct rte_eth_dev *dev)
 		return err;
 	}
 
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {
+		link = dev->data->dev_link;
+		link.link_status = nic_dev->hwdev->link_status &
+					nic_dev->hwdev->vf_valid_status;
+
+		(void)rte_eth_linkstatus_set(dev, &link);
+	}
+
 	return 0;
 }
 
@@ -872,6 +881,7 @@ static int
 hinic3_dev_set_link_down(struct rte_eth_dev *dev)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_link link = { 0 };
 	int err;
 
 	err = hinic3_set_vport_enable(nic_dev->hwdev, false);
@@ -885,11 +895,19 @@ hinic3_dev_set_link_down(struct rte_eth_dev *dev)
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
+		link.link_status = nic_dev->hwdev->link_status &
+					nic_dev->hwdev->vf_valid_status;
+
+		(void)rte_eth_linkstatus_set(dev, &link);
+	}
+
 	return 0;
 }
 
@@ -937,6 +955,12 @@ hinic3_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	} while (rep_cnt--);
 
 out:
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {
+		nic_dev->hwdev->link_status = link.link_status;
+		link.link_status = nic_dev->hwdev->link_status &
+					nic_dev->hwdev->vf_valid_status;
+	}
+
 	return rte_eth_linkstatus_set(dev, &link);
 }
 
@@ -3620,6 +3644,8 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
 	.fw_version_get                = hinic3_fw_version_get,
+	.dev_set_link_up               = hinic3_dev_set_link_up,
+	.dev_set_link_down             = hinic3_dev_set_link_down,
 	.rx_queue_setup                = hinic3_rx_queue_setup,
 	.tx_queue_setup                = hinic3_tx_queue_setup,
 	.rx_queue_intr_enable          = hinic3_dev_rx_queue_intr_enable,
@@ -3641,6 +3667,8 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.vlan_offload_set              = hinic3_vlan_offload_set,
 	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
 	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
+	.promiscuous_enable            = hinic3_dev_promiscuous_enable,
+	.promiscuous_disable           = hinic3_dev_promiscuous_disable,
 	.rss_hash_update               = hinic3_rss_hash_update,
 	.rss_hash_conf_get             = hinic3_rss_conf_get,
 	.reta_update                   = hinic3_rss_reta_update,
-- 
2.33.0

