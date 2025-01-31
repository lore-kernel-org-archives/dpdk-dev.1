Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB1C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03D5E427E7;
	Fri, 31 Jan 2025 09:06:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 51CAE410D2
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:51 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V70SKu004964
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 Xh9uYtIY6pEwmXxWGpTTPNFnrMNvOLUNNzWqKdXmJs=; b=N/jVG4HfZb1vOB7Tc
 d+Bbhl1fzwvUjQ+lKwdflPw3GzOyDGrVIw3x+vOfFoC3yxRygDJpL8FZhgiejs/Z
 1kLOTsmtRR++O6CKXwMyEQO+FXGpdtJ76qgs9/OSO/pOn52XhesyROLnL/mNbC+n
 UI1OVw92wuAU8nUBrYiH+pJudTzw8HrIazCUf2dO5BKZf1tYjAOZM3KTQO9Bs9/c
 XcBP4tDgd5lp3X5bEFmWV7hEc+Aq6IH82KO+F9/RbLh1Ia8pcvsGYyqUCr+XaeX9
 PA6vcjmm6EO7R387wAw3lB1etf+FkqVImRhn3MWd9Xqi/xOzTyN/wyWWtS9OvQsE
 8T9Mg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gsr3g362-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:50 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:49 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id AA5423F7066;
 Fri, 31 Jan 2025 00:06:46 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 24/34] common/cnxk: update CPT RXC time config mbox for cn20k
Date: Fri, 31 Jan 2025 13:35:19 +0530
Message-ID: <20250131080530.3224977-24-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zhIg7M_ecVgWLrXdO3O7SEnXD2KssS6j
X-Proofpoint-GUID: zhIg7M_ecVgWLrXdO3O7SEnXD2KssS6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Sync in CPT_RXC_TIME_CFG mbox as per new fields added for
cn20k and restructure to support it.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h    |  2 ++
 drivers/common/cnxk/roc_nix_inl.c | 55 +++++++++++++++++++++++++------
 drivers/common/cnxk/roc_nix_inl.h |  3 +-
 drivers/net/cnxk/cn10k_ethdev.c   |  5 +--
 drivers/net/cnxk/cn20k_ethdev.c   |  3 +-
 5 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a4212a59ed..df9a629403 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -2468,6 +2468,8 @@ struct cpt_rxc_time_cfg_req {
 	uint16_t __io zombie_limit;
 	uint16_t __io active_thres;
 	uint16_t __io active_limit;
+	uint16_t __io queue_id;
+	uint64_t __io cpt_af_rxc_que_cfg;
 };
 
 /* Mailbox message format to request for CPT faulted engines */
diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index 6927de6505..8ade58e1a2 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -930,30 +930,65 @@ roc_nix_inl_inb_sa_get(struct roc_nix *roc_nix, bool inb_inl_dev, uint32_t spi)
 }
 
 int
-roc_nix_reassembly_configure(uint32_t max_wait_time, uint16_t max_frags)
+roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg, uint32_t max_wait_time)
 {
 	struct idev_cfg *idev = idev_get_cfg();
-	struct roc_cpt *roc_cpt;
+	struct nix_inl_dev *inl_dev = NULL;
+	struct cpt_rxc_time_cfg_req *req;
 	struct roc_cpt_rxc_time_cfg cfg;
+	struct roc_cpt *roc_cpt;
+	struct mbox *mbox;
+	int rc;
 
 	if (!idev)
 		return -EFAULT;
 
-	PLT_SET_USED(max_frags);
-
 	roc_cpt = idev->cpt;
 	if (!roc_cpt) {
 		plt_err("Cannot support inline inbound, cryptodev not probed");
 		return -ENOTSUP;
 	}
 
-	cfg.step = (max_wait_time * 1000 / ROC_NIX_INL_REAS_ACTIVE_LIMIT);
-	cfg.zombie_limit = ROC_NIX_INL_REAS_ZOMBIE_LIMIT;
-	cfg.zombie_thres = ROC_NIX_INL_REAS_ZOMBIE_THRESHOLD;
-	cfg.active_limit = ROC_NIX_INL_REAS_ACTIVE_LIMIT;
-	cfg.active_thres = ROC_NIX_INL_REAS_ACTIVE_THRESHOLD;
+	cfg.step = req_cfg->step ? req_cfg->step :
+				   (max_wait_time * 1000 / ROC_NIX_INL_REAS_ACTIVE_LIMIT);
+	cfg.zombie_limit =
+		req_cfg->zombie_limit ? req_cfg->zombie_limit : ROC_NIX_INL_REAS_ZOMBIE_LIMIT;
+	cfg.zombie_thres =
+		req_cfg->zombie_thres ? req_cfg->zombie_thres : ROC_NIX_INL_REAS_ZOMBIE_THRESHOLD;
+	cfg.active_limit =
+		req_cfg->active_limit ? req_cfg->active_limit : ROC_NIX_INL_REAS_ACTIVE_LIMIT;
+	cfg.active_thres =
+		req_cfg->active_thres ? req_cfg->active_thres : ROC_NIX_INL_REAS_ACTIVE_THRESHOLD;
 
-	return roc_cpt_rxc_time_cfg(roc_cpt, &cfg);
+	if (roc_model_is_cn10k())
+		return roc_cpt_rxc_time_cfg(roc_cpt, &cfg);
+
+	inl_dev = idev->nix_inl_dev;
+	if (!inl_dev) {
+		plt_err("Cannot support RXC config, inlinedev is not probed");
+		return -ENOTSUP;
+	}
+
+	mbox = mbox_get((&inl_dev->dev)->mbox);
+
+	req = mbox_alloc_msg_cpt_rxc_time_cfg(mbox);
+	if (req == NULL) {
+		rc = -ENOSPC;
+		goto exit;
+	}
+
+	req->blkaddr = 0;
+	req->queue_id = inl_dev->nix_inb_qids[inl_dev->inb_cpt_lf_id];
+	req->step = cfg.step;
+	req->zombie_limit = cfg.zombie_limit;
+	req->zombie_thres = cfg.zombie_thres;
+	req->active_limit = cfg.active_limit;
+	req->active_thres = cfg.active_thres;
+
+	rc = mbox_process(mbox);
+exit:
+	mbox_put(mbox);
+	return rc;
 }
 
 static void
diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 10bf7d5c25..2db3a0d0f2 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -157,7 +157,8 @@ int __roc_api roc_nix_inl_dev_rq_put(struct roc_nix_rq *rq);
 bool __roc_api roc_nix_inb_is_with_inl_dev(struct roc_nix *roc_nix);
 struct roc_nix_rq *__roc_api roc_nix_inl_dev_rq(struct roc_nix *roc_nix);
 int __roc_api roc_nix_inl_inb_tag_update(struct roc_nix *roc_nix, uint32_t tag_const, uint8_t tt);
-int __roc_api roc_nix_reassembly_configure(uint32_t max_wait_time, uint16_t max_frags);
+int __roc_api roc_nix_reassembly_configure(struct roc_cpt_rxc_time_cfg *req_cfg,
+					   uint32_t max_wait_time);
 int __roc_api roc_nix_inl_ts_pkind_set(struct roc_nix *roc_nix, bool ts_ena, bool inb_inl_dev,
 				       uint8_t profile_id);
 int __roc_api roc_nix_inl_rq_ena_dis(struct roc_nix *roc_nix, bool ena);
diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index 3f8c66615d..e491854cb2 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -655,9 +655,10 @@ cn10k_nix_reassembly_conf_get(struct rte_eth_dev *eth_dev,
 
 static int
 cn10k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
-		const struct rte_eth_ip_reassembly_params *conf)
+			      const struct rte_eth_ip_reassembly_params *conf)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_cpt_rxc_time_cfg rxc_time_cfg = {0};
 	int rc = 0;
 
 	if (!roc_feature_nix_has_reass())
@@ -671,7 +672,7 @@ cn10k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 		return 0;
 	}
 
-	rc = roc_nix_reassembly_configure(conf->timeout_ms, conf->max_frags);
+	rc = roc_nix_reassembly_configure(&rxc_time_cfg, conf->timeout_ms);
 	if (!rc && dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
 		dev->rx_offload_flags |= NIX_RX_REAS_F;
 		dev->inb.reass_en = true;
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index ea22112f69..db8d08cb2a 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -631,6 +631,7 @@ cn20k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 			      const struct rte_eth_ip_reassembly_params *conf)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_cpt_rxc_time_cfg rxc_time_cfg = {0};
 	int rc = 0;
 
 	if (!roc_feature_nix_has_reass())
@@ -644,7 +645,7 @@ cn20k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 		return 0;
 	}
 
-	rc = roc_nix_reassembly_configure(conf->timeout_ms, conf->max_frags);
+	rc = roc_nix_reassembly_configure(&rxc_time_cfg, conf->timeout_ms);
 	if (!rc && dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
 		dev->rx_offload_flags |= NIX_RX_REAS_F;
 		dev->inb.reass_en = true;
-- 
2.34.1

