Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EEBFCE077
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB516402CE;
	Thu, 26 Feb 2026 14:17:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 445D64021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:17:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QDBdut096637 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:17:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 2yrAgLi3t51tub4Vs9kVtZeZQbwfzD/ogu9+jWYqbk=; b=czMvN2p/wzup/1s7q
 ddxaquS9EViqJkOY3wOZhwzleFpO2lHbhIDXmGNMVd34BAT8GUoFisp92wm7oDE3
 rwg7j0uvc5zdH4ABSgDH+gBsLmkze2qxeSVUocTPbOaOSJJ1xqTRJF/C4L8uBJUI
 F1REKDRrIN57yN0AKyS8fuUnd7FBc6K8Q2Ueq5+C65n+1F9lwJcmkj/5qcYW9PDL
 hayfZ4DoPvIQuHo3VmF3c2tjeqmX3E6cHU70MZuA5CDfui/BpISyrc1O0eKVRc1F
 kjTB2M76SNnGutbF3HhXJDW6U6vTlgKuSQ2bN0p99FuA8KdhhtQW9ioNaQHlk7l+
 eL66Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cjpuhg0gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 26 Feb 2026 05:17:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Feb 2026 05:17:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 26 Feb 2026 05:17:48 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 2F2893F70D5;
 Thu, 26 Feb 2026 05:17:45 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 1/8] net/cnxk: support of plain packet reassembly
Date: Thu, 26 Feb 2026 18:47:08 +0530
Message-ID: <20260226131715.2851091-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219090847.3257753-1-rbhansali@marvell.com>
References: <20260219090847.3257753-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iEvVUmhe_BsJEtgjgoOb1OowXc7i1ae8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExOSBTYWx0ZWRfX8h/JrSD6rlmF
 Z92p9EVTXgQKvpIlwQwHzbr7N0IUW2zOZS4iEb1wBe7tgCU2VnGrJNNAQ2URpyUC+LecIWpJpwg
 EvrRwymZnro/SytPIw+yHuFMExnDijkbhXSXd+DiaSU1ome1w/wxGuXf9xnalRhB/h3m1VEv6sT
 jMpuRKn0zxra2VfUN4154RntwDYD8Ul3p0vH/Zi+27QoUfmvHgDA54VAErWgBnslX6M1v1ElXlT
 V8TYSfE8CtzP1vI6QShweFhDM3m3MNizDgk81IsJYN+xLXacoZuHzMYiwVafvRz7foBpgoEfHzA
 v60M9J7qhBW/BXvZmiTbkSsfBbGCTmwxYcBQUgVZihAGshX5bFp4C/kyjaC6MP6s+ysxGKZSSpM
 wMgLX0ryIAgN1V7zY0oQxbn9ThOAkSGgSxryLb71DhQwiyu2zAvv6iW9mg6/NGyQPaPb1kjDsCh
 GgHebFKUF20mb9zRoAg==
X-Proofpoint-GUID: iEvVUmhe_BsJEtgjgoOb1OowXc7i1ae8
X-Authority-Analysis: v=2.4 cv=f7JFxeyM c=1 sm=1 tr=0 ts=69a047fd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=hX8HcxYqf5zOYwlZYC0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Adds support of plain packet reassembly by configuring
UCAST_CPT rule.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
Changes in v2: Updated doc, fix cleanup on configuration failure cases.

 doc/guides/nics/cnxk.rst                      |   1 +
 doc/guides/rel_notes/release_26_03.rst        |   1 +
 drivers/common/cnxk/roc_nix_inl.h             |   2 +-
 .../common/cnxk/roc_platform_base_symbols.c   |   1 +
 drivers/net/cnxk/cn20k_ethdev.c               |  94 +++++--
 drivers/net/cnxk/cn20k_rx.h                   |   6 +-
 drivers/net/cnxk/cnxk_ethdev.c                | 233 ++++++++++++++----
 drivers/net/cnxk/cnxk_ethdev.h                |   8 +
 8 files changed, 287 insertions(+), 59 deletions(-)

diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 4105b101b2..9e758a1b5e 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -40,6 +40,7 @@ Features of the CNXK Ethdev PMD are:
 - Port representors
 - Represented port pattern matching and action
 - Port representor pattern matching and action
+- Plain packet reassembly on CN20K SoC family

 Prerequisites
 -------------
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..b1f9b3c82b 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -80,6 +80,7 @@ New Features
 * **Updated Marvell cnxk net driver.**

   * Added out-of-place support for CN20K SoC.
+  * Added plain packet reassembly support for CN20K SoC.

 * **Updated ZTE zxdh ethernet driver.**

diff --git a/drivers/common/cnxk/roc_nix_inl.h b/drivers/common/cnxk/roc_nix_inl.h
index 68f395438c..596f12d1c7 100644
--- a/drivers/common/cnxk/roc_nix_inl.h
+++ b/drivers/common/cnxk/roc_nix_inl.h
@@ -160,7 +160,7 @@ bool __roc_api roc_nix_inl_inb_is_enabled(struct roc_nix *roc_nix);
 uintptr_t __roc_api roc_nix_inl_inb_sa_base_get(struct roc_nix *roc_nix,
 						bool inl_dev_sa);
 uint16_t roc_nix_inl_inb_ipsec_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
-uint16_t roc_nix_inl_inb_reass_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
+uint16_t __roc_api roc_nix_inl_inb_reass_profile_id_get(struct roc_nix *roc_nix, bool inb_inl_dev);
 bool __roc_api roc_nix_inl_inb_rx_inject_enable(struct roc_nix *roc_nix, bool inl_dev_sa);
 uint32_t __roc_api roc_nix_inl_inb_spi_range(struct roc_nix *roc_nix,
 					     bool inl_dev_sa, uint32_t *min,
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 79dd18fbd7..2c73efd877 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -228,6 +228,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sdp_prepare_tree)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_reass_profile_id_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_cpt_lfs_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_desc_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_get)
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 7e9e32f80b..4a3d163c75 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -616,22 +616,17 @@ static int
 cn20k_nix_reassembly_capability_get(struct rte_eth_dev *eth_dev,
 				    struct rte_eth_ip_reassembly_params *reassembly_capa)
 {
-	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
-	int rc = -ENOTSUP;
 	RTE_SET_USED(eth_dev);

 	if (!roc_feature_nix_has_reass())
 		return -ENOTSUP;

-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
-		reassembly_capa->timeout_ms = 60 * 1000;
-		reassembly_capa->max_frags = 4;
-		reassembly_capa->flags =
-			RTE_ETH_DEV_REASSEMBLY_F_IPV4 | RTE_ETH_DEV_REASSEMBLY_F_IPV6;
-		rc = 0;
-	}
+	reassembly_capa->timeout_ms = 60 * 1000;
+	reassembly_capa->max_frags = 8;
+	reassembly_capa->flags =
+		RTE_ETH_DEV_REASSEMBLY_F_IPV4 | RTE_ETH_DEV_REASSEMBLY_F_IPV6;

-	return rc;
+	return 0;
 }

 static int
@@ -649,7 +644,10 @@ cn20k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_cpt_rxc_time_cfg rxc_time_cfg = {0};
-	int rc = 0;
+	uint16_t nb_rxq = dev->nb_rxq;
+	int rc = 0, i, rxq_cnt = 0;
+	struct cn20k_eth_rxq *rxq;
+	struct roc_nix_rq *rq;

 	if (!roc_feature_nix_has_reass())
 		return -ENOTSUP;
@@ -659,15 +657,83 @@ cn20k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 		if (!dev->inb.nb_oop)
 			dev->rx_offload_flags &= ~NIX_RX_REAS_F;
 		dev->inb.reass_en = false;
+		if (dev->ip_reass_en) {
+			cnxk_nix_ip_reass_rule_clr(eth_dev);
+			dev->ip_reass_en = false;
+		}
 		return 0;
 	}

+	if (!(dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY)) {
+		rc = cnxk_nix_inline_inbound_setup(dev);
+		if (rc) {
+			plt_err("Nix inline inbound setup failed rc=%d", rc);
+			goto done;
+		}
+
+		rc = cnxk_nix_inline_inbound_mode_setup(dev);
+		if (rc) {
+			plt_err("Nix inline inbound mode setup failed rc=%d", rc);
+			goto cleanup;
+		}
+
+		for (i = 0; i < nb_rxq; i++) {
+			rq = &dev->rqs[i];
+			rxq = eth_dev->data->rx_queues[i];
+
+			if (!rxq) {
+				plt_err("Receive queue = %d not enabled", i);
+				rc = -EINVAL;
+				goto cleanup;
+			}
+
+			roc_nix_inl_dev_xaq_realloc(rq->aura_handle);
+
+			rq->tag_mask = 0x0FF00000 | ((uint32_t)RTE_EVENT_TYPE_ETHDEV << 28);
+			rc = roc_nix_inl_dev_rq_get(rq, !!eth_dev->data->dev_started);
+			if (rc)
+				goto cleanup;
+
+			rxq->lmt_base = dev->nix.lmt_base;
+			rxq->sa_base = roc_nix_inl_inb_sa_base_get(&dev->nix, dev->inb.inl_dev);
+			rc = roc_npa_buf_type_update(rq->aura_handle,
+						     ROC_NPA_BUF_TYPE_PACKET_IPSEC, 1);
+			if (rc)
+				goto cleanup;
+
+			rxq_cnt = i + 1;
+		}
+	}
+
 	rc = roc_nix_reassembly_configure(&rxc_time_cfg, conf->timeout_ms);
-	if (!rc && dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
-		dev->rx_offload_flags |= NIX_RX_REAS_F;
-		dev->inb.reass_en = true;
+	if (rc) {
+		plt_err("Nix reassembly_configure failed rc=%d", rc);
+		goto cleanup;
 	}

+	dev->rx_offload_flags |= NIX_RX_REAS_F | NIX_RX_OFFLOAD_SECURITY_F;
+	dev->inb.reass_en = !!((dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY));
+
+	if (!dev->ip_reass_en) {
+		rc = cnxk_nix_ip_reass_rule_set(eth_dev, 0);
+		if (rc) {
+			plt_err("Nix reassembly rule setup failed rc=%d", rc);
+			goto cleanup;
+		}
+	}
+
+	return 0;
+cleanup:
+	dev->inb.reass_en = false;
+	if (!(dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY)) {
+		rc |= cnxk_nix_inl_inb_fini(dev);
+		for (i = 0; i < rxq_cnt; i++) {
+			struct roc_nix_rq *rq = &dev->rqs[i];
+
+			roc_nix_inl_dev_rq_put(rq);
+		}
+	}
+done:
 	return rc;
 }

diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index 83c222c53c..d6c217cdf5 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -258,7 +258,8 @@ nix_sec_meta_to_mbuf_sc(uint64_t cq_w5, uint64_t cpth, const uint64_t sa_base,
 			*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
 	} else {
 		/* Update dynamic field with userdata */
-		*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
+		if (flags & NIX_RX_REAS_F && inb_priv->userdata)
+			*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
 	}

 	*len = ((w3 >> 48) & 0xFFFF) + ((cq_w5 >> 16) & 0xFF) - (cq_w5 & 0xFF);
@@ -917,7 +918,8 @@ nix_sec_meta_to_mbuf(uintptr_t inb_sa, uintptr_t cpth, struct rte_mbuf **inner,
 		/* Get SPI from CPT_PARSE_S's cookie(already swapped) */
 		inb_priv = roc_nix_inl_ot_ipsec_inb_sa_sw_rsvd((void *)inb_sa);
 		/* Update dynamic field with userdata */
-		*rte_security_dynfield(inner_m) = (uint64_t)inb_priv->userdata;
+		if (flags & NIX_RX_REAS_F && inb_priv->userdata)
+			*rte_security_dynfield(inner_m) = (uint64_t)inb_priv->userdata;
 	}

 	/* Clear and update original lower 16 bit of data offset */
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index ff78622b58..ba8ac52b46 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -7,6 +7,11 @@
 #include <eal_export.h>
 #include <rte_eventdev.h>
 #include <rte_pmd_cnxk.h>
+#include "roc_priv.h"
+
+#define REASS_PRIORITY             0
+#define CLS_LTYPE_OFFSET_START     7
+#define CLS_LFLAGS_LC_OFFSET (CLS_LTYPE_OFFSET_START + 4)

 static const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
 	[CGX_MODE_SGMII] = RTE_ETH_LINK_SPEED_1G,
@@ -203,46 +208,160 @@ cnxk_nix_inb_mode_set(struct cnxk_eth_dev *dev, bool use_inl_dev)
 	return cnxk_nix_lookup_mem_sa_base_set(dev);
 }

-static int
-nix_security_setup(struct cnxk_eth_dev *dev)
+int
+cnxk_nix_inline_inbound_mode_setup(struct cnxk_eth_dev *dev)
+{
+	int rc = 0;
+
+	/* By default pick using inline device for poll mode.
+	 * Will be overridden when event mode rq's are setup.
+	 */
+	cnxk_nix_inb_mode_set(dev, !dev->inb.no_inl_dev);
+
+	/* Allocate memory to be used as dptr for CPT ucode
+	 * WRITE_SA op.
+	 */
+	dev->inb.sa_dptr =
+		plt_zmalloc(ROC_NIX_INL_OT_IPSEC_INB_HW_SZ, 0);
+	if (!dev->inb.sa_dptr) {
+		plt_err("Couldn't allocate memory for SA dptr");
+		rc = -ENOMEM;
+		goto cleanup;
+	}
+	dev->inb.inl_dev_q = roc_nix_inl_dev_qptr_get(0);
+cleanup:
+	return rc;
+}
+
+static void
+cnxk_flow_ipfrag_set(struct roc_npc_flow *flow, struct roc_npc *npc)
+{
+	uint8_t lc_offset;
+	uint64_t mask;
+
+	lc_offset = rte_popcount64(npc->rx_parse_nibble & ((1ULL << CLS_LFLAGS_LC_OFFSET) - 1));
+
+	lc_offset *= 4;
+
+	mask = (~(0xffULL << lc_offset));
+	flow->mcam_data[0] &= mask;
+	flow->mcam_mask[0] &= mask;
+	flow->mcam_data[0] |= (0x02ULL << lc_offset);
+	flow->mcam_mask[0] |= (0x82ULL << lc_offset);
+}
+
+int
+cnxk_nix_ip_reass_rule_set(struct rte_eth_dev *eth_dev, uint32_t rq)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct nix_rx_action2_s *action2;
+	struct nix_rx_action_s *action;
+	struct roc_npc_flow mcam;
+	int prio = 0, rc = 0;
+	struct roc_npc *npc;
+	int resp_count = 0;
+	bool inl_dev;
+
+	npc = &dev->npc;
+	inl_dev = roc_nix_inb_is_with_inl_dev(&dev->nix);
+
+	prio = REASS_PRIORITY;
+	memset(&mcam, 0, sizeof(struct roc_npc_flow));
+
+	action = (struct nix_rx_action_s *)&mcam.npc_action;
+	action2 = (struct nix_rx_action2_s *)&mcam.npc_action2;
+
+	if (inl_dev) {
+		struct roc_nix_rq *inl_rq;
+
+		inl_rq = roc_nix_inl_dev_rq(&dev->nix);
+		if (!inl_rq) {
+			plt_err("Failed to get inline dev rq for %d", dev->nix.port_id);
+			goto mcam_alloc_failed;
+		}
+		action->pf_func = roc_idev_nix_inl_dev_pffunc_get();
+		action->index = inl_rq->qid;
+	} else {
+		action->pf_func = npc->pf_func;
+		action->index = rq;
+	}
+	action->op = NIX_RX_ACTIONOP_UCAST_CPT;
+
+	action2->inline_profile_id = roc_nix_inl_inb_reass_profile_id_get(npc->roc_nix, inl_dev);
+
+	rc = roc_npc_mcam_merge_base_steering_rule(npc, &mcam);
+	if (rc < 0)
+		goto mcam_alloc_failed;
+
+	/* Channel[11] should be 'b0 */
+	mcam.mcam_data[0] &= (~0xfffULL);
+	mcam.mcam_mask[0] &= (~0xfffULL);
+	mcam.mcam_data[0] |= (uint64_t)(npc->channel & 0x7ff);
+	mcam.mcam_mask[0] |= (BIT_ULL(12) - 1);
+	cnxk_flow_ipfrag_set(&mcam, npc);
+
+	mcam.priority = prio;
+	mcam.key_type = roc_npc_get_key_type(npc, &mcam);
+	rc = roc_npc_mcam_alloc_entry(npc, &mcam, NULL, prio, &resp_count);
+	if (rc || resp_count == 0)
+		goto mcam_alloc_failed;
+
+	mcam.enable = true;
+	rc = roc_npc_mcam_write_entry(npc, &mcam);
+	if (rc < 0)
+		goto mcam_write_failed;
+
+	dev->ip_reass_rule_id = mcam.mcam_id;
+	dev->ip_reass_en = true;
+	return 0;
+
+mcam_write_failed:
+	rc |= roc_npc_mcam_free(npc, &mcam);
+	if (rc)
+		return rc;
+mcam_alloc_failed:
+	return -EIO;
+}
+
+int
+cnxk_nix_inline_inbound_setup(struct cnxk_eth_dev *dev)
 {
 	struct roc_nix *nix = &dev->nix;
-	int i, rc = 0;
+	int rc = 0;

-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
-		/* Setup minimum SA table when inline device is used */
-		nix->ipsec_in_min_spi = dev->inb.no_inl_dev ? dev->inb.min_spi : 0;
-		nix->ipsec_in_max_spi = dev->inb.no_inl_dev ? dev->inb.max_spi : 1;
+	/* Setup minimum SA table when inline device is used */
+	nix->ipsec_in_min_spi = dev->inb.no_inl_dev ? dev->inb.min_spi : 0;
+	nix->ipsec_in_max_spi = dev->inb.no_inl_dev ? dev->inb.max_spi : 1;

-		/* Enable custom meta aura when multi-chan is used */
-		if (nix->local_meta_aura_ena && roc_nix_inl_dev_is_multi_channel() &&
-		    !dev->inb.custom_meta_aura_dis)
-			nix->custom_meta_aura_ena = true;
+	/* Enable custom meta aura when multi-chan is used */
+	if (nix->local_meta_aura_ena && roc_nix_inl_dev_is_multi_channel() &&
+	    !dev->inb.custom_meta_aura_dis)
+		nix->custom_meta_aura_ena = true;

-		/* Setup Inline Inbound */
-		rc = roc_nix_inl_inb_init(nix);
-		if (rc) {
-			plt_err("Failed to initialize nix inline inb, rc=%d",
+	/* Setup Inline Inbound */
+	rc = roc_nix_inl_inb_init(nix);
+	if (rc) {
+		plt_err("Failed to initialize nix inline inb, rc=%d",
 				rc);
-			return rc;
-		}
+		return rc;
+	}

-		/* By default pick using inline device for poll mode.
-		 * Will be overridden when event mode rq's are setup.
-		 */
-		cnxk_nix_inb_mode_set(dev, !dev->inb.no_inl_dev);
+	return 0;
+}

-		/* Allocate memory to be used as dptr for CPT ucode
-		 * WRITE_SA op.
-		 */
-		dev->inb.sa_dptr =
-			plt_zmalloc(ROC_NIX_INL_OT_IPSEC_INB_HW_SZ, 0);
-		if (!dev->inb.sa_dptr) {
-			plt_err("Couldn't allocate memory for SA dptr");
-			rc = -ENOMEM;
+static int
+nix_security_setup(struct cnxk_eth_dev *dev)
+{
+	struct roc_nix *nix = &dev->nix;
+	int i, rc = 0;
+
+	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
+		rc = cnxk_nix_inline_inbound_setup(dev);
+		if (rc)
+			return rc;
+		rc = cnxk_nix_inline_inbound_mode_setup(dev);
+		if (rc)
 			goto cleanup;
-		}
-		dev->inb.inl_dev_q = roc_nix_inl_dev_qptr_get(0);
 	}

 	if (dev->tx_offloads & RTE_ETH_TX_OFFLOAD_SECURITY ||
@@ -365,6 +484,22 @@ nix_meter_fini(struct cnxk_eth_dev *dev)
 	return 0;
 }

+int
+cnxk_nix_inl_inb_fini(struct cnxk_eth_dev *dev)
+{
+	struct roc_nix *nix = &dev->nix;
+	int rc;
+
+	if (dev->inb.sa_dptr) {
+		plt_free(dev->inb.sa_dptr);
+		dev->inb.sa_dptr = NULL;
+	}
+	rc = roc_nix_inl_inb_fini(nix);
+	if (rc)
+		plt_err("Failed to cleanup nix inline inb, rc=%d", rc);
+	return rc;
+}
+
 static int
 nix_security_release(struct cnxk_eth_dev *dev)
 {
@@ -374,7 +509,7 @@ nix_security_release(struct cnxk_eth_dev *dev)
 	int rc, ret = 0;

 	/* Cleanup Inline inbound */
-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
+	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY || dev->ip_reass_en) {
 		/* Destroy inbound sessions */
 		tvar = NULL;
 		RTE_TAILQ_FOREACH_SAFE(eth_sec, &dev->inb.list, entry, tvar)
@@ -384,17 +519,14 @@ nix_security_release(struct cnxk_eth_dev *dev)
 		/* Clear lookup mem */
 		cnxk_nix_lookup_mem_sa_base_clear(dev);

-		rc = roc_nix_inl_inb_fini(nix);
-		if (rc)
-			plt_err("Failed to cleanup nix inline inb, rc=%d", rc);
-		ret |= rc;
+		ret |= cnxk_nix_inl_inb_fini(dev);

 		cnxk_nix_lookup_mem_metapool_clear(dev);
+	}

-		if (dev->inb.sa_dptr) {
-			plt_free(dev->inb.sa_dptr);
-			dev->inb.sa_dptr = NULL;
-		}
+	if (dev->ip_reass_en) {
+		cnxk_nix_ip_reass_rule_clr(eth_dev);
+		dev->ip_reass_en = false;
 	}

 	/* Cleanup Inline outbound */
@@ -946,7 +1078,7 @@ cnxk_nix_rx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
 	plt_nix_dbg("Releasing rxq %u", qid);

 	/* Release rq reference for inline dev if present */
-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY)
+	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY || dev->ip_reass_en)
 		roc_nix_inl_dev_rq_put(rq);

 	/* Cleanup ROC RQ */
@@ -1760,6 +1892,18 @@ cnxk_nix_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qid)
 	return rc;
 }

+int
+cnxk_nix_ip_reass_rule_clr(struct rte_eth_dev *eth_dev)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+
+	if (dev->ip_reass_en)
+		return roc_npc_mcam_free_entry(npc, dev->ip_reass_rule_id);
+	else
+		return 0;
+}
+
 static int
 cnxk_nix_dev_stop(struct rte_eth_dev *eth_dev)
 {
@@ -1842,7 +1986,7 @@ cnxk_nix_dev_start(struct rte_eth_dev *eth_dev)
 			return rc;
 	}

-	if (dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) {
+	if ((dev->rx_offloads & RTE_ETH_RX_OFFLOAD_SECURITY) || dev->ip_reass_en) {
 		rc = roc_nix_inl_rq_ena_dis(&dev->nix, true);
 		if (rc) {
 			plt_err("Failed to enable Inline device RQ, rc=%d", rc);
@@ -2258,6 +2402,11 @@ cnxk_eth_dev_uninit(struct rte_eth_dev *eth_dev, bool reset)
 	/* Disable and free rte_meter entries */
 	nix_meter_fini(dev);

+	if (dev->ip_reass_en) {
+		cnxk_nix_ip_reass_rule_clr(eth_dev);
+		dev->ip_reass_en = false;
+	}
+
 	/* Disable and free rte_flow entries */
 	roc_npc_fini(&dev->npc);

diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 3d0a587406..1b63b02ad8 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -427,6 +427,8 @@ struct cnxk_eth_dev {
 	/* Reassembly dynfield/flag offsets */
 	int reass_dynfield_off;
 	int reass_dynflag_bit;
+	uint32_t ip_reass_rule_id;
+	bool ip_reass_en;

 	/* MCS device */
 	struct cnxk_mcs_dev *mcs_dev;
@@ -645,6 +647,10 @@ int cnxk_nix_tm_set_queue_rate_limit(struct rte_eth_dev *eth_dev,
 int cnxk_nix_tm_mark_vlan_dei(struct rte_eth_dev *eth_dev, int mark_green,
 			      int mark_yellow, int mark_red,
 			      struct rte_tm_error *error);
+int cnxk_nix_ip_reass_rule_clr(struct rte_eth_dev *eth_dev);
+int cnxk_nix_ip_reass_rule_set(struct rte_eth_dev *eth_dev, uint32_t rq);
+int cnxk_nix_inl_inb_fini(struct cnxk_eth_dev *dev);
+
 int cnxk_nix_tm_mark_ip_ecn(struct rte_eth_dev *eth_dev, int mark_green,
 			    int mark_yellow, int mark_red,
 			    struct rte_tm_error *error);
@@ -736,6 +742,8 @@ __rte_internal
 int cnxk_nix_inb_mode_set(struct cnxk_eth_dev *dev, bool use_inl_dev);
 __rte_internal
 void cnxk_ethdev_rx_offload_cb_register(cnxk_ethdev_rx_offload_cb_t cb);
+int cnxk_nix_inline_inbound_setup(struct cnxk_eth_dev *dev);
+int cnxk_nix_inline_inbound_mode_setup(struct cnxk_eth_dev *dev);

 struct cnxk_eth_sec_sess *cnxk_eth_sec_sess_get_by_sa_idx(struct cnxk_eth_dev *dev,
 							  uint32_t sa_idx, bool inb);
--
2.34.1

