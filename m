Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC9BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 11:51:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B673C40DFB;
	Wed, 28 May 2025 13:51:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C191640279
 for <dev@dpdk.org>; Wed, 28 May 2025 13:51:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5qtbq006078
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=g
 ei4AR9eYk0Y2Oe8Sk+O7pJ69aig906tFsaQELtwXo8=; b=XGOFWoJ8+5hgeCCr8
 V2qMo6Zamse43bgfUWbKu5P81S7AlMT/YbDYj7Fa27597SNUocytUyR4oKgg+Nfg
 rI3T2wVfxKQ9kjer0uI5cPqiCPh/1xz38gXiMrWO/v13PtZ2t0wlGhUgBY/Vdkrj
 Z5/cY6m8Lbg24GOV3bFH+6j0Q8yfupCLjSHOPzxXwRoDVRaM0hPoeCGojgeNjfKH
 upHy2amQ+M6girURZmJ4nAzqzCjyjtDZhPnjWgJZLDQE+1l3iOXtlZI2v2Xuz9BD
 waEdMfDIQ0+gZwqtSSNzPelPUnCUxgts6m2WtLydVQ3tQTHSu3hhCneS+quixdq5
 m1D4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46wu5agr77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 28 May 2025 04:51:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 May 2025 04:51:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 28 May 2025 04:51:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.158])
 by maili.marvell.com (Postfix) with ESMTP id 3015D3F7060;
 Wed, 28 May 2025 04:51:40 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 3/7] net/cnxk: devarg to set force tail drop
Date: Wed, 28 May 2025 17:21:18 +0530
Message-ID: <20250528115122.24052-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528115122.24052-1-rbhansali@marvell.com>
References: <20250528115122.24052-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEwNCBTYWx0ZWRfX76FKlf4FDMxl
 9glnbNQ14pk7AeYzFtP4Umv0Oa3mPpwGBSPWj8d8bmQHEyA66RnK0+mMNMHd1rKFBjIRQcTuflE
 +wQtZZzGnbe1E5082Mo0T/ppN615THr/Qra6D/tw+9Be6Gg5tteGn9Dfqwtvp2GSw43gnkqRwaR
 ZyXs6oAbBAl51pDIOrhdaJ90r6NmkY20zz5C9OQAntKSNMI1SiKFpVCFUTu/Awd0oKEPN/rd3jC
 NpUyHOYgBTBQ/yZ24hIaLlTCgRI4uHweJM3h1LjP/eiljpxc6OWAoF3Ud9OLBGNbe1aJervwHJo
 GijzPDVlpnrbKPw6n1VodLihYwl/N55CPFpLXYP+w0rvbx0183szviq6UG13XAuhbSTx7hhiegS
 CcanXqizGNGi5VOXpubZZRv/jN1Dl9W9zOp2dVV3QLNgq5EBHrYw9pzDpYrOwQpTN1x74+F2
X-Proofpoint-GUID: 3Dea14P3r47CgO7ujbRz9KngMqS91SEr
X-Proofpoint-ORIG-GUID: 3Dea14P3r47CgO7ujbRz9KngMqS91SEr
X-Authority-Analysis: v=2.4 cv=UahRSLSN c=1 sm=1 tr=0 ts=6836f8d2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=UQ_tuG2nzi5MP-4U3P0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
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

A new devarg is added to configure force tail drop.
Also, CQ descriptors are doubled under this option.

To enable this devarg, it needs to be pass as
force_tail_drop=1 for nix device.
e.g.: 0002:02:00.0,force_tail_drop=1

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c         | 4 ++++
 drivers/net/cnxk/cnxk_ethdev_devargs.c | 7 ++++++-
 drivers/net/cnxk/cnxk_ethdev_ops.c     | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index b9a0b37425..1ba09c068b 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -708,6 +708,10 @@ cnxk_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid,
 	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY)
 		nb_desc = nix_inl_cq_sz_clamp_up(nix, lpb_pool, nb_desc);
 
+	/* Double the CQ descriptors */
+	if (nix->force_tail_drop)
+		nb_desc = 2 * RTE_MAX(nb_desc, (uint32_t)4096);
+
 	/* Setup ROC CQ */
 	cq = &dev->cqs[qid];
 	cq->qid = qid;
diff --git a/drivers/net/cnxk/cnxk_ethdev_devargs.c b/drivers/net/cnxk/cnxk_ethdev_devargs.c
index aa2fe7dfe1..7013849ad3 100644
--- a/drivers/net/cnxk/cnxk_ethdev_devargs.c
+++ b/drivers/net/cnxk/cnxk_ethdev_devargs.c
@@ -281,6 +281,7 @@ parse_val_u16(const char *key, const char *value, void *extra_args)
 #define CNXK_NIX_RX_INJ_ENABLE	"rx_inj_ena"
 #define CNXK_CUSTOM_META_AURA_DIS "custom_meta_aura_dis"
 #define CNXK_CUSTOM_INB_SA	  "custom_inb_sa"
+#define CNXK_FORCE_TAIL_DROP	  "force_tail_drop"
 
 int
 cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
@@ -301,6 +302,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	uint16_t outb_nb_desc = 8200;
 	struct sdp_channel sdp_chan;
 	uint16_t rss_tag_as_xor = 0;
+	uint8_t force_tail_drop = 0;
 	uint16_t scalar_enable = 0;
 	uint16_t tx_compl_ena = 0;
 	uint16_t custom_sa_act = 0;
@@ -364,6 +366,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	rte_kvargs_process(kvlist, CNXK_CUSTOM_META_AURA_DIS, &parse_flag,
 			   &custom_meta_aura_dis);
 	rte_kvargs_process(kvlist, CNXK_CUSTOM_INB_SA, &parse_flag, &custom_inb_sa);
+	rte_kvargs_process(kvlist, CNXK_FORCE_TAIL_DROP, &parse_flag, &force_tail_drop);
 	rte_kvargs_free(kvlist);
 
 null_devargs:
@@ -405,6 +408,7 @@ cnxk_ethdev_parse_devargs(struct rte_devargs *devargs, struct cnxk_eth_dev *dev)
 	dev->npc.flow_age.aging_poll_freq = aging_thread_poll_freq;
 	if (roc_feature_nix_has_rx_inject())
 		dev->nix.rx_inj_ena = rx_inj_ena;
+	dev->nix.force_tail_drop = force_tail_drop;
 	return 0;
 exit:
 	return -EINVAL;
@@ -429,4 +433,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_cnxk,
 			      CNXK_SQB_SLACK "=<12-512>"
 			      CNXK_FLOW_AGING_POLL_FREQ "=<10-65535>"
 			      CNXK_NIX_RX_INJ_ENABLE "=1"
-			      CNXK_CUSTOM_META_AURA_DIS "=1");
+			      CNXK_CUSTOM_META_AURA_DIS "=1"
+			      CNXK_FORCE_TAIL_DROP "=1");
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 9970c5ff5c..7c8a4d8416 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -313,6 +313,7 @@ cnxk_nix_flow_ctrl_set(struct rte_eth_dev *eth_dev,
 		fc_cfg.rq_cfg.pool = rq->aura_handle;
 		fc_cfg.rq_cfg.spb_pool = rq->spb_aura_handle;
 		fc_cfg.rq_cfg.cq_drop = cq->drop_thresh;
+		fc_cfg.rq_cfg.cq_bp = cq->bp_thresh;
 		fc_cfg.rq_cfg.pool_drop_pct = ROC_NIX_AURA_THRESH;
 
 		rc = roc_nix_fc_config_set(nix, &fc_cfg);
@@ -1239,6 +1240,7 @@ nix_priority_flow_ctrl_rq_conf(struct rte_eth_dev *eth_dev, uint16_t qid,
 	fc_cfg.rq_cfg.pool = rxq->qconf.mp->pool_id;
 	fc_cfg.rq_cfg.spb_pool = rq->spb_aura_handle;
 	fc_cfg.rq_cfg.cq_drop = cq->drop_thresh;
+	fc_cfg.rq_cfg.cq_bp = cq->bp_thresh;
 	fc_cfg.rq_cfg.pool_drop_pct = ROC_NIX_AURA_THRESH;
 	rc = roc_nix_fc_config_set(nix, &fc_cfg);
 	if (rc)
-- 
2.25.1

