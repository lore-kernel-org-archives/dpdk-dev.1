Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29B5CD8CA7
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3038740672;
	Tue,  9 Jun 2026 09:52:10 +0200 (CEST)
Received: from out28-91.mail.aliyun.com (out28-91.mail.aliyun.com
 [115.124.28.91])
 by mails.dpdk.org (Postfix) with ESMTP id ED933402BE;
 Tue,  9 Jun 2026 09:52:06 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1;
 BR=01201311R211S07rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00739376-0.00049684-0.992109;
 FP=16606177112690819234|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033032062159; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.htFolaz_1780991522; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.htFolaz_1780991522 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 09 Jun 2026 15:52:02 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: fix multicast reception in promiscuous mode
Date: Tue,  9 Jun 2026 00:51:43 -0700
Message-Id: <20260609075143.32695-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609075143.32695-1-dimon.zhao@nebula-matrix.com>
References: <20260609075143.32695-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When promiscuous mode is enabled on NBL PMD,
the hardware does not forward multicast frames to the host,
causing the driver to fail receiving multicast packets.
This patch fixes the issue.

Fixes: 80bd3cad22c8 ("net/nbl: support promiscuous mode")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  5 +++
 drivers/net/nbl/nbl_dispatch.c                | 45 +++++++++++++++++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  5 +++
 .../net/nbl/nbl_include/nbl_def_resource.h    |  2 +
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 35485ea691..3c0e98d687 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -784,6 +784,8 @@ int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev)
 	struct nbl_common_info *common = &adapter->common;
 
 	if (!common->is_vf) {
+		disp_ops->cfg_multi_mcast(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					  dev_mgt->net_dev->vsi_id, 1);
 		disp_ops->set_promisc_mode(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
 					   dev_mgt->net_dev->vsi_id, 1);
 		dev_mgt->net_dev->promisc = 1;
@@ -802,6 +804,8 @@ int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
 	struct nbl_common_info *common = &adapter->common;
 
 	if (!common->is_vf) {
+		disp_ops->cfg_multi_mcast(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					  dev_mgt->net_dev->vsi_id, 0);
 		disp_ops->set_promisc_mode(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
 					   dev_mgt->net_dev->vsi_id, 0);
 		dev_mgt->net_dev->promisc = 0;
@@ -1012,6 +1016,7 @@ static void nbl_dev_leonis_stop(void *p)
 		disp_ops->del_multi_rule(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
 		disp_ops->del_macvlan(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), mac, 0, net_dev->vsi_id);
 	}
+	disp_ops->cfg_multi_mcast(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id, 0);
 }
 
 static void nbl_dev_remove_ops(struct nbl_dev_ops_tbl **dev_ops_tbl)
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index 52d37ba7fe..f4f1ee4842 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -698,6 +698,47 @@ static void nbl_disp_chan_del_multi_rule_req(void *priv, u16 vsi)
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
+static int nbl_disp_cfg_multi_mcast(void *priv, u16 vsi, u16 enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	int ret = 0;
+
+	if (enable)
+		ret = NBL_OPS_CALL(res_ops->add_multi_mcast,
+				   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi));
+	else
+		NBL_OPS_CALL(res_ops->del_multi_mcast, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi));
+
+	return ret;
+}
+
+static int nbl_disp_chan_cfg_multi_mcast_req(void *priv, u16 vsi, u16 enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_param_cfg_multi_mcast param = {0};
+	struct nbl_chan_send_info chan_send;
+	int ret = 0;
+
+	if (NBL_IS_COEXISTENCE(common)) {
+		ret = ioctl(common->devfd, NBL_DEV_USER_SET_MCAST_MODE, &enable);
+		if (ret) {
+			NBL_LOG(ERR, "userspace send cfg_multi_mcast ioctl msg failed ret %d",
+				ret);
+			return ret;
+		}
+		return 0;
+	}
+
+	param.vsi = vsi;
+	param.enable = enable;
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
 static int nbl_disp_cfg_dsch(void *priv, u16 vsi_id, bool vld)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
@@ -1145,6 +1186,10 @@ do {									\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_DEL_MULTI_RULE,			\
 			 nbl_disp_chan_del_multi_rule_req, NULL);	\
+	NBL_DISP_SET_OPS(cfg_multi_mcast, nbl_disp_cfg_multi_mcast,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,		\
+			 nbl_disp_chan_cfg_multi_mcast_req, NULL);	\
 	NBL_DISP_SET_OPS(cfg_dsch, nbl_disp_cfg_dsch,			\
 			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_CFG_DSCH,	\
 			 nbl_disp_chan_cfg_dsch_req, NULL);		\
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 55880737f1..257c81e01e 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -371,6 +371,11 @@ struct nbl_chan_param_del_multi_rule {
 	u16 vsi;
 };
 
+struct nbl_chan_param_cfg_multi_mcast {
+	u16 vsi;
+	u16 enable;
+};
+
 struct nbl_chan_param_cfg_dsch {
 	u16 vsi_id;
 	bool vld;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index 6935598789..a803c59dc0 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -77,6 +77,8 @@ struct nbl_resource_ops {
 	int (*add_multi_rule)(void *priv, u16 vsi_id);
 	void (*del_multi_rule)(void *priv, u16 vsi_id);
 	int (*cfg_multi_mcast)(void *priv, u16 vsi_id, u16 enable);
+	int (*add_multi_mcast)(void *priv, u16 vsi);
+	void (*del_multi_mcast)(void *priv, u16 vsi);
 	void (*clear_flow)(void *priv, u16 vsi_id);
 	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
 	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set);
-- 
2.34.1

