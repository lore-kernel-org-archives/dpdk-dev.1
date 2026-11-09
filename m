Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67166606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=djzprCYN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B108D40EE7;
	Mon,  9 Nov 2026 17:21:07 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTPS id 8FED740A8B
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=QP+Eq/xu/tFBXh8pH1JyJD1R5lVv4HK0SDl2zXRfw6o=;
 b=djzprCYNGwYJWZYpB/ho+3sKIEmuQ9Pg33doa4hndvPvLbXR6HSH0hwsGBtCAC
 sOYb8+FnupOlFkazez+LebTSFiK3knkEN+HDD+4f9t/ejGdpvhUEZUWc6rhOzmNh
 xX5ux4ny+pHgC2uOGIF1Ofa2E1QnPMXyWge7+jhidmVLE=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 11/28] net/hinic3: fix offload and cmdq/compact CQE config
Date: Tue, 10 Nov 2026 00:20:15 +0800
Message-ID: <20261109162033.1144-12-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S13
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF43Cw15Ar4UKFW3WFW3Wrg_yoW7ZrW8pF
 4DGayxJrWDtFWjvw1kua1xCa45Xw1fG3yjk3Z0ya4Y9Fy5ZF47Za43GFWxZry3t39rJ3W2
 vr1q939Fgr10q3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uio7tUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwYNF2rx8uYPQgAA3p
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

Some offload capabilities are reported based on the wrong conditions:
VXLAN TNL TSO is never advertised, GENEVE/IPIP TSO is gated by the HTN
cmdq flag instead of those features' own flags, and outer UDP checksum
offload is not advertised although the Tx path handles it. The cmdq
mode/depth are also set in the wrong helper and the compact CQE flag is
not written to firmware at vport enable.

Advertise the missing offloads, gate tunnel TSO by the correct flags, set
cmdq mode/depth in hinic3_set_cmdq_depth(), and forward the compact CQE
flag.

Fixes: aa31be38544e ("net/hinic3: enhance command queue for new SPx series NIC")
Fixes: c1537bf6c033 ("net/hinic3: support Compact CQE in init")

The stale "QinQ offload" entry is dropped from features/hinic3.ini since
the PMD does not advertise those offloads. No outer L3/L4 checksum entry
is added either: default.ini has no such feature and adding it only to
hinic3.ini breaks the documentation build.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/nics/features/hinic3.ini      | 1 -
 drivers/net/hinic3/base/hinic3_hw_comm.c | 9 +++++----
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 1 +
 drivers/net/hinic3/hinic3_ethdev.c       | 7 +++++--
 drivers/net/hinic3/hinic3_ethdev.h       | 1 -
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index 6cdd240a82..3405a837bf 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -25,7 +25,6 @@ VLAN filter          = Y
 Flow control         = Y
 CRC offload          = Y
 VLAN offload         = Y
-QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Inner L3 checksum    = P
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.c b/drivers/net/hinic3/base/hinic3_hw_comm.c
index 6541bc0428..2749faeba1 100644
--- a/drivers/net/hinic3/base/hinic3_hw_comm.c
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.c
@@ -276,10 +276,6 @@ hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, uint32_t rq_depth,
 	root_ctxt.rq_depth = (uint16_t)rte_log2_u32(rq_depth);
 	root_ctxt.rx_buf_sz = get_hw_rx_buf_size(hwdev, rx_buf_sz);
 	root_ctxt.sq_depth = (uint16_t)rte_log2_u32(sq_depth);
-	root_ctxt.cmdq_mode = hwdev->cmdqs->cmdq_mode;
-
-	if (hwdev->cmdqs->cmdq_mode == HINIC3_ENHANCE_CMDQ)
-		root_ctxt.cmdq_depth--;
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
 				      HINIC3_MGMT_CMD_SET_VAT,
@@ -334,6 +330,11 @@ hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, uint16_t cmdq_depth)
 	root_ctxt.set_cmdq_depth = 1;
 	root_ctxt.cmdq_depth = (uint8_t)rte_log2_u32(cmdq_depth);
 
+	root_ctxt.cmdq_mode = hwdev->cmdqs->cmdq_mode;
+
+	if (root_ctxt.cmdq_mode == HINIC3_ENHANCE_CMDQ)
+		root_ctxt.cmdq_depth--;
+
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
 				      HINIC3_MGMT_CMD_SET_VAT,
 				      &root_ctxt, sizeof(root_ctxt),
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 1520f88a1b..fb9b6d4d19 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -455,6 +455,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 	en_state.func_id = hinic3_global_func_id(hwdev);
 	en_state.state = enable ? 1 : 0;
 	en_state.num_qps = nic_dev->num_rqs;
+	en_state.rx_compact_wqe_en = HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev);
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 2eb5909fff..61ea3172fc 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -672,6 +672,8 @@ hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_nic_dev
 		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
 	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))
 		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO;
+	if (HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev))
+		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO;
 }
 
 /**
@@ -713,9 +715,10 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
-		hinic3_dev_tnl_tso_support(info, nic_dev);
+
+	hinic3_dev_tnl_tso_support(info, nic_dev);
 
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
 	info->reta_size = HINIC3_RSS_INDIR_SIZE;
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 8bbab2ad53..f4d8c16640 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -24,7 +24,6 @@
 #define HINIC3_PKT_TX_TCP_CKSUM		RTE_MBUF_F_TX_TCP_CKSUM
 #define HINIC3_PKT_TX_IP_CKSUM		RTE_MBUF_F_TX_IP_CKSUM
 #define HINIC3_PKT_TX_VLAN_PKT		RTE_MBUF_F_TX_VLAN
-#define HINIC3_PKT_TX_QINQ_PKT		RTE_MBUF_F_TX_QINQ
 #define HINIC3_PKT_TX_L4_MASK		RTE_MBUF_F_TX_L4_MASK
 #define HINIC3_PKT_TX_SCTP_CKSUM	RTE_MBUF_F_TX_SCTP_CKSUM
 #define HINIC3_PKT_TX_IPV6		RTE_MBUF_F_TX_IPV6
-- 
2.33.0

