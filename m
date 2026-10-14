Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B8CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8120440A8B;
	Wed, 14 Oct 2026 17:09:53 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id CD0D24064A;
 Wed, 14 Oct 2026 17:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=ioYLKo6msOQn7vj489tX3d8Eko0v5cgCGWXIO4NMFCU=;
 b=QnDY78ArbnG7jqmseNlsn81pIglC+0ciTq1J2FLT3xHjt/XPD5Qm/zSri+Qe+2
 Ll6qk0k79D0FSRC/Kbzncq1ijVAhVMeU6IyqCLFeZ7CILbvXMRyM7mHlscLXAyZU
 VyMg/HVCfRP2k+zJqvYj+f0+E9WrOLlTxZxkfOt13TJAY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v2 07/26] net/hinic3: fix offload and cmdq/compact CQE config
Date: Wed, 14 Oct 2026 23:09:03 +0800
Message-ID: <20261014150923.838-8-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S9
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4fXrW5ury7ZFWfJw18Zrb_yoW7WFWDpF
 WUJayfJrZ8trWvq3WDuan7uas8Ww1rK3yjk3W3Aas0yFyUZr47Z3srKF97Zr1a9ryxX3Z2
 vr1qv34DCF10qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzrWrUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMheCjGrPmzcaBAAA38
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

Some offload capabilities are reported based on the wrong conditions:
VXLAN TNL TSO is never advertised, and GENEVE/IPIP TSO is gated by the
HTN cmdq flag instead of those features' own flags. The cmdq mode/depth
are also set in the wrong helper and the compact CQE flag is not written
to firmware at vport enable.

Advertise the missing offloads, gate tunnel TSO by the correct flags, set
cmdq mode/depth in hinic3_set_cmdq_depth(), and forward the compact CQE
flag.

Fixes: aa31be38544e ("net/hinic3: enhance command queue for new SPx series NIC")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/base/hinic3_hw_comm.c |  9 +++---
 drivers/net/hinic3/base/hinic3_nic_cfg.c |  1 +
 drivers/net/hinic3/hinic3_ethdev.c       | 35 ++++++++++++++----------
 3 files changed, 27 insertions(+), 18 deletions(-)

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
index 678ed46454..789e4a17ee 100644
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
@@ -700,22 +702,27 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->max_lro_pkt_size = HINIC3_MAX_LRO_SIZE;
 
 	info->rx_queue_offload_capa = 0;
-	info->rx_offload_capa =
-		RTE_ETH_RX_OFFLOAD_VLAN_STRIP | RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
-		RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM | RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
-		RTE_ETH_RX_OFFLOAD_SCATTER | RTE_ETH_RX_OFFLOAD_TCP_LRO |
-		RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+				RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+				RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+				RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+				RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
+				RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+				RTE_ETH_RX_OFFLOAD_SCATTER |
+				RTE_ETH_RX_OFFLOAD_TCP_LRO |
+				RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
 	info->tx_queue_offload_capa = 0;
-	info->tx_offload_capa =
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
-		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
-		hinic3_dev_tnl_tso_support(info, nic_dev);
+	info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
+				RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+				RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+				RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+				RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+				RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+				RTE_ETH_TX_OFFLOAD_TCP_TSO |
+				RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
+	hinic3_dev_tnl_tso_support(info, nic_dev);
 
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
 	info->reta_size = HINIC3_RSS_INDIR_SIZE;
-- 
2.33.0

