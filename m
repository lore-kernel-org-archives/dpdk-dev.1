Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E174CCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37E2340693;
	Sat, 10 Oct 2026 16:45:24 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 72C2F4027F;
 Sat, 10 Oct 2026 16:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Z/WLgEhAdqT8ka8pTZ7ZOc3BTk3wSKgASbeVDGHJtKo=;
 b=Iw79+OemDwO1oR0ybxpl1XDNhcLEKOtkGIA020aP5ToRulCbgAqsV4kWkr32Ty
 2DguYnjWmd1OKVtkDURJbnHOGZX0mcgPeLhVX5U+LkKK0UrVLAZZuBOPU7ceHO1a
 WyKM0GKxJpMB5sqd6IV9NOQLSCncBis9VBAEWmH+z+Vi8=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v1 01/17] net/hinic3: fix offload and cmdq/compact CQE config
Date: Sat, 10 Oct 2026 22:44:52 +0800
Message-ID: <20261010144509.2731-2-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF4fWrWfXw17AFWxZryfCrg_yoWxGry5pF
 WUGayxJrZ8trW0q3WDuan7ua45Xw1rG3yjk3W3Aas0vFy5ZF47Z39xKFWxZr1avryxX3WS
 vr1q934qk3W0qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7vtZUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMho-SWrKT3onwAAA3s
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

Some offload capabilities are reported based on the wrong conditions: QINQ=
=0D
strip/insert and VXLAN TNL TSO are never advertised, and GENEVE/IPIP TSO is=
=0D
gated by the HTN cmdq flag instead of those features' own flags. The cmdq=0D
mode/depth are also set in the wrong helper and the compact CQE flag is not=
=0D
written to firmware at vport enable.=0D
=0D
Advertise the missing offloads, add QINQ to the TX offload mask so the QINQ=
=0D
insert flag is honoured, gate tunnel TSO by the correct flags, set cmdq=0D
mode/depth in hinic3_set_cmdq_depth(), and forward the compact CQE flag.=0D
=0D
Fixes: aa31be38544e ("net/hinic3: enhance command queue for new SPx series =
NIC")=0D
Cc: stable@dpdk.org=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 .mailmap                                 |  1 +=0D
 drivers/net/hinic3/base/hinic3_hw_comm.c |  9 +++---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c |  1 +=0D
 drivers/net/hinic3/hinic3_ethdev.c       | 36 +++++++++++++++---------=0D
 drivers/net/hinic3/hinic3_tx.c           |  3 +-=0D
 5 files changed, 31 insertions(+), 19 deletions(-)=0D
=0D
diff --git a/.mailmap b/.mailmap=0D
index 2e348c3bce..53df9d44ff 100644=0D
--- a/.mailmap=0D
+++ b/.mailmap=0D
@@ -749,6 +749,7 @@ Jesse Brandeburg <jesse.brandeburg@intel.com>=0D
 Jesse Bruni <jesse.bruni@intel.com>=0D
 Jia He <justin.he@arm.com> <jia.he@hxt-semitech.com>=0D
 Jia Yu <jyu@vmware.com>=0D
+Jiacheng Ye <yejiacheng4@h-partners.com>=0D
 Jian Wang <jianwang@trustnetic.com>=0D
 Jianbo Liu <jianbo.liu@arm.com> <jianbo.liu@linaro.org>=0D
 Jianfeng Tan <jianfeng.tan@intel.com>=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.c b/drivers/net/hinic3/=
base/hinic3_hw_comm.c=0D
index 6541bc0428..2749faeba1 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hw_comm.c=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.c=0D
@@ -276,10 +276,6 @@ hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, uint3=
2_t rq_depth,=0D
 	root_ctxt.rq_depth =3D (uint16_t)rte_log2_u32(rq_depth);=0D
 	root_ctxt.rx_buf_sz =3D get_hw_rx_buf_size(hwdev, rx_buf_sz);=0D
 	root_ctxt.sq_depth =3D (uint16_t)rte_log2_u32(sq_depth);=0D
-	root_ctxt.cmdq_mode =3D hwdev->cmdqs->cmdq_mode;=0D
-=0D
-	if (hwdev->cmdqs->cmdq_mode =3D=3D HINIC3_ENHANCE_CMDQ)=0D
-		root_ctxt.cmdq_depth--;=0D
 =0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
 				      HINIC3_MGMT_CMD_SET_VAT,=0D
@@ -334,6 +330,11 @@ hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, uint=
16_t cmdq_depth)=0D
 	root_ctxt.set_cmdq_depth =3D 1;=0D
 	root_ctxt.cmdq_depth =3D (uint8_t)rte_log2_u32(cmdq_depth);=0D
 =0D
+	root_ctxt.cmdq_mode =3D hwdev->cmdqs->cmdq_mode;=0D
+=0D
+	if (root_ctxt.cmdq_mode =3D=3D HINIC3_ENHANCE_CMDQ)=0D
+		root_ctxt.cmdq_depth--;=0D
+=0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
 				      HINIC3_MGMT_CMD_SET_VAT,=0D
 				      &root_ctxt, sizeof(root_ctxt),=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index 5387626b98..bd3c39730f 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -454,6 +454,7 @@ hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, boo=
l enable)=0D
 	en_state.func_id =3D hinic3_global_func_id(hwdev);=0D
 	en_state.state =3D enable ? 1 : 0;=0D
 	en_state.num_qps =3D nic_dev->num_rqs;=0D
+	en_state.rx_compact_wqe_en =3D HINIC3_SUPPORT_RX_HW_COMPACT_CQE(nic_dev);=
=0D
 =0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
 				      HINIC3_NIC_CMD_SET_VPORT_ENABLE,=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index eb5ddd9de6..623c836a3b 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -684,22 +684,30 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct =
rte_eth_dev_info *info)=0D
 	info->max_lro_pkt_size =3D HINIC3_MAX_LRO_SIZE;=0D
 =0D
 	info->rx_queue_offload_capa =3D 0;=0D
-	info->rx_offload_capa =3D=0D
-		RTE_ETH_RX_OFFLOAD_VLAN_STRIP | RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |=0D
-		RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM |=0D
-		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM | RTE_ETH_RX_OFFLOAD_VLAN_FILTER |=0D
-		RTE_ETH_RX_OFFLOAD_SCATTER | RTE_ETH_RX_OFFLOAD_TCP_LRO |=0D
-		RTE_ETH_RX_OFFLOAD_RSS_HASH;=0D
+	info->rx_offload_capa =3D RTE_ETH_RX_OFFLOAD_VLAN_STRIP |=0D
+				RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |=0D
+				RTE_ETH_RX_OFFLOAD_UDP_CKSUM |=0D
+				RTE_ETH_RX_OFFLOAD_TCP_CKSUM |=0D
+				RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |=0D
+				RTE_ETH_RX_OFFLOAD_VLAN_FILTER |=0D
+				RTE_ETH_RX_OFFLOAD_SCATTER |=0D
+				RTE_ETH_RX_OFFLOAD_TCP_LRO |=0D
+				RTE_ETH_RX_OFFLOAD_RSS_HASH |=0D
+				RTE_ETH_RX_OFFLOAD_QINQ_STRIP;=0D
 =0D
 	info->tx_queue_offload_capa =3D 0;=0D
-	info->tx_offload_capa =3D=0D
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |=0D
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |=0D
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |=0D
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |=0D
-		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;=0D
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)=0D
-		hinic3_dev_tnl_tso_support(info, nic_dev);=0D
+	info->tx_offload_capa =3D RTE_ETH_TX_OFFLOAD_VLAN_INSERT |=0D
+				RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_UDP_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_TCP_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |=0D
+				RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |=0D
+				RTE_ETH_TX_OFFLOAD_TCP_TSO |=0D
+				RTE_ETH_TX_OFFLOAD_MULTI_SEGS |=0D
+				RTE_ETH_TX_OFFLOAD_QINQ_INSERT;=0D
+=0D
+	hinic3_dev_tnl_tso_support(info, nic_dev);=0D
 =0D
 	info->hash_key_size =3D HINIC3_RSS_KEY_SIZE;=0D
 	info->reta_size =3D HINIC3_RSS_INDIR_SIZE;=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index 6b2bffb14e..bbe8c1c085 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -24,7 +24,8 @@=0D
 #define MAX_TSO_NUM_FRAG 1024=0D
 =0D
 #define HINIC3_TX_OFFLOAD_MASK \=0D
-	(HINIC3_TX_CKSUM_OFFLOAD_MASK | HINIC3_PKT_TX_VLAN_PKT)=0D
+	(HINIC3_TX_CKSUM_OFFLOAD_MASK | HINIC3_PKT_TX_VLAN_PKT | \=0D
+	 HINIC3_PKT_TX_QINQ_PKT)=0D
 =0D
 #define HINIC3_TX_CKSUM_OFFLOAD_MASK                          \=0D
 	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \=0D
-- =0D
2.33.0=0D
=0D

