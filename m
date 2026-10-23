Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D5606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=Nyc4/7jY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A7940DCA;
	Fri, 23 Oct 2026 17:58:29 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 99729406FF
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:58:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=soWDoss4gr8Hd5PgyljdHcejwdRwx6uz0m1DVla8hlY=;
 b=Nyc4/7jYvYzB71eyf7fL/vaiYpGZP+rPXE9rA8l65ej63zFnNJPMmCO7lRpxJg
 j+pVuGU+KMq7PV3uj5Ey4JUWilqbeau0BHqNcPmfHdpv3QosP4j0aOqCpl289Gw2
 hckwqHRIa+++mRq4IHAqos6qtooXpjVi2XVOY/cRtJZUY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 10/27] net/hinic3: fix offload and cmdq/compact CQE config
Date: Fri, 23 Oct 2026 23:57:51 +0800
Message-ID: <20261023155809.855-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAnQEEUhNtqKyfqAw--.15103S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry3AFyfXrW7trWUWryxuFg_yoWrXF1rpF
 WDGFWxJryDJF4jq3Wkua1xua45Xw1fK3yjka4rAa4Y9Fy5ZF17Z343KFZ7ZryagryxJF12
 vr4qvrZF93W0q3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_-UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhm4wmrbhBkC4gAA3Z
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
VXLAN TNL TSO is never advertised, and GENEVE/IPIP TSO is gated by the
HTN cmdq flag instead of those features' own flags. The cmdq mode/depth
are also set in the wrong helper and the compact CQE flag is not written
to firmware at vport enable.

Advertise the missing offloads, gate tunnel TSO by the correct flags, set
cmdq mode/depth in hinic3_set_cmdq_depth(), and forward the compact CQE
flag.

Fixes: aa31be38544e ("net/hinic3: enhance command queue for new SPx series NIC")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/base/hinic3_hw_comm.c | 9 +++++----
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 1 +
 drivers/net/hinic3/hinic3_ethdev.c       | 6 ++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

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
index d64a123c56..1057d4e777 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -457,6 +457,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, bool enable)
 	en_state.func_id = hinic3_global_func_id(hwdev);
 	en_state.state = enable ? 1 : 0;
 	en_state.num_qps = nic_dev->num_rqs;
+	en_state.rx_compact_wqe_en = HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev);
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index b6f6b73ac2..6d2619b9ef 100644
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
@@ -715,8 +717,8 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
-		hinic3_dev_tnl_tso_support(info, nic_dev);
+
+	hinic3_dev_tnl_tso_support(info, nic_dev);
 
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
 	info->reta_size = HINIC3_RSS_INDIR_SIZE;
-- 
2.33.0

