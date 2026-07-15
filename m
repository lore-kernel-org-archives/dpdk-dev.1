Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA79C4451B
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 09:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D635E4064A;
	Sat, 18 Jul 2026 11:18:14 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 63C494028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 10:43:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F7s4Vw999567 for <dev@dpdk.org>; Wed, 15 Jul 2026 01:43:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vh9G58Dchl4dGQf5+3Z/8D1
 JgnOiuWpZAQeYqfx5ZHg=; b=Cr68IEkW+QpMbATrKjKVEhzrvt+jq5GTlajSqaO
 dV4I4VKQ5dHZZDaXe1b91W5zwZyaU5uzk20jQdA66TlEqkA4xwFAkGJBl4HfFDKN
 RuiaDJp9pZqUbf2YmLqXoyidpdNUDURzXXuVhba2M0rrG60WT+cJoGntaiXiG/Hh
 zXccywA/b1+5OxlrBs5Nk+1frHQ8n3RiZsnZ/BLJyaI8GL32UFArczp2/hKqUxer
 lhmBhVgeXzfVU2iGjZk2Y/LyaJWsgC9xuhlE2fvpswd6GfJbWNmHrrlmbQ/AGoSI
 Luly/SA1BxOFIfJ3fUkTJmYmTXttItx9uw3X+pGk+LgI1JQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fdxve1eex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 15 Jul 2026 01:43:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Jul 2026 01:43:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Jul 2026 01:43:44 -0700
Received: from cavium-ThinkCentre-E73.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 7069C626762;
 Wed, 15 Jul 2026 01:43:42 -0700 (PDT)
From: <ykanaujia@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>
Subject: [PATCH 1/2] common/cnxk: support aggregator enqueue profiles
Date: Wed, 15 Jul 2026 14:13:39 +0530
Message-ID: <20260715084340.300442-1-ykanaujia@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4NCBTYWx0ZWRfX7tscYhNOS+oG
 gtyg40N9mIyY9gHC3CG6ha6/ZwXgKIG1Bs0BRj7MKRBl/9afYlRPLzzTabOcnadb8KosKXjRVtK
 /sUYbKt/bI/mGnZMBS7bkZScYLDxUIQJ1yYkLqVqnUyinA3WL2fGlST9U32B4XuIKthCYAdqrC7
 lhNeVv/wAmvzNfPIaypUTvxkP2Prb6YOvRGI1IudubZG/p5rzxrFsXELPbflqX2EH9zOQHgbNxA
 TiP41gJy9un6q6S9RWDfoCIKEpBEJBbdNvYWLKMo4b1djoHOLfioGfv2XDNclfBKqeo1dNJL83C
 lz+UyegvhUXbcbaMfb/bXjOwUCHoP9nIW+o0Xfy4FWzCdrt41tUUZOGMrPuLbdW/OXe9EAB7141
 cN0zuR4wFWBLxo38rKDQb8U0nhR+KB1J/ltxzMl1uvqL3XPfdulLNn9e8NJSFkz5uZArqhsfOJ+
 7cbY9rjIn34A7sw7MVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4NCBTYWx0ZWRfX6oN+3i36zI6D
 YFKrpbTqrzIG3RMnAAtR4pBpkR6dxnl+cSxFbFebHdmwicfHts2keC+Dw8odnAugXGWZzsQ6tDp
 Oeebdl5791aHiDrRG8blTY531gvLJ1U=
X-Proofpoint-GUID: 4LamkdDJdur2GrvqNn3q9hlKOuIpQO9W
X-Proofpoint-ORIG-GUID: 4LamkdDJdur2GrvqNn3q9hlKOuIpQO9W
X-Authority-Analysis: v=2.4 cv=dfCwG3Xe c=1 sm=1 tr=0 ts=6a574841 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=cWVyRTKpSsE5GqL0wdYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Mailman-Approved-At: Sat, 18 Jul 2026 11:18:11 +0200
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

From: Satheesh Paul <psatheesh@marvell.com>

Support for flow aggregator enqueue profiles.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
---
 drivers/common/cnxk/roc_mbox.h                | 57 +++++++++++
 drivers/common/cnxk/roc_nix.c                 | 41 ++++++++
 drivers/common/cnxk/roc_nix.h                 |  2 +
 drivers/common/cnxk/roc_nix_flow_vec.h        | 99 +++++++++++++++++++
 drivers/common/cnxk/roc_npc_priv.h            |  3 +
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 6 files changed, 203 insertions(+)
 create mode 100644 drivers/common/cnxk/roc_nix_flow_vec.h

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 52ecde6563..814999722f 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -359,6 +359,8 @@ struct mbox_msghdr {
 				msg_rsp)					\
 	M(NIX_RX_INL_QUEUE_CFG,	0x8033, nix_rx_inl_queue_cfg,				\
 			      nix_rx_inline_qcfg_req, msg_rsp)		\
+	M(NIX_AF_RX_FLOW_VEC_CTRL_SET, 0x8034, nix_af_rx_flow_vec_ctrl_set,                        \
+	  nix_af_rx_flow_vec_ctrl_write_req, msg_rsp)                                              \
 	/* MCS mbox IDs (range 0xa000 - 0xbFFF) */                                                 \
 	M(MCS_ALLOC_RESOURCES, 0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,                    \
 	  mcs_alloc_rsrc_rsp)                                                                      \
@@ -2773,6 +2775,61 @@ struct npc_cn20k_mcam_write_entry_req {
 	uint64_t __io reserved;	   /* reserved for future use */
 };
 
+union nix_af_rx_flow_vec_ctrl0x {
+	struct nix_af_rx_flow_vec_ctrl0x_s {
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		uint64_t __io reserved : 14;
+		uint64_t __io sov_offset : 8;
+		uint64_t __io sov_mask : 16;
+		uint64_t __io sov_inv : 1;
+		uint64_t __io eov_offset : 8;
+		uint64_t __io eov_mask : 16;
+		uint64_t __io eov_inv : 1;
+#else
+		uint64_t __io eov_inv : 1;
+		uint64_t __io eov_mask : 16;
+		uint64_t __io eov_offset : 8;
+		uint64_t __io sov_inv : 1;
+		uint64_t __io sov_mask : 16;
+		uint64_t __io sov_offset : 8;
+		uint64_t __io reserved : 14;
+#endif
+	} __attribute__((__packed__)) s;
+	uint64_t __io val;
+};
+
+union nix_af_rx_flow_vec_ctrl1x {
+	struct nix_af_rx_flow_vec_ctrl1x_s {
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		uint64_t __io reserved : 35;
+		uint64_t __io valid : 1;
+		uint64_t __io lid : 3;
+		uint64_t __io ltype_match : 4;
+		uint64_t __io ltype_mask : 4;
+		uint64_t __io ver_offset : 9;
+		uint64_t __io ver_match : 4;
+		uint64_t __io ver_mask : 4;
+#else
+		uint64_t __io ver_mask : 4;
+		uint64_t __io ver_match : 4;
+		uint64_t __io ver_offset : 9;
+		uint64_t __io ltype_mask : 4;
+		uint64_t __io ltype_match : 4;
+		uint64_t __io lid : 3;
+		uint64_t __io valid : 1;
+		uint64_t __io reserved : 35;
+#endif
+	} __attribute__((__packed__)) s;
+	uint64_t __io val;
+};
+
+#define NIX_AF_RX_FLOW_VEC_CTRL_MAX 4
+struct nix_af_rx_flow_vec_ctrl_write_req {
+	struct mbox_msghdr hdr;
+	union nix_af_rx_flow_vec_ctrl0x ctrl0x[NIX_AF_RX_FLOW_VEC_CTRL_MAX];
+	union nix_af_rx_flow_vec_ctrl1x ctrl1x[NIX_AF_RX_FLOW_VEC_CTRL_MAX];
+};
+
 /* Enable/Disable a given entry */
 struct npc_mcam_ena_dis_entry_req {
 	struct mbox_msghdr hdr;
diff --git a/drivers/common/cnxk/roc_nix.c b/drivers/common/cnxk/roc_nix.c
index 477c7d5ca0..8e3903051d 100644
--- a/drivers/common/cnxk/roc_nix.c
+++ b/drivers/common/cnxk/roc_nix.c
@@ -3,6 +3,7 @@
  */
 
 #include "roc_api.h"
+#include "roc_nix_flow_vec.h"
 #include "roc_priv.h"
 
 bool
@@ -524,7 +525,15 @@ roc_nix_dev_init(struct roc_nix *roc_nix)
 	roc_nix_get_hw_info(roc_nix);
 	nix->dev.drv_inited = true;
 
+	if (roc_model_is_cn20k()) {
+		rc = roc_nix_af_rx_flow_vec_ctrl_set(roc_nix);
+		if (rc)
+			goto tm_conf_fini;
+	}
+
 	return 0;
+tm_conf_fini:
+	nix_tm_conf_fini(roc_nix);
 unregister_irqs:
 	nix_unregister_irqs(nix);
 lf_detach:
@@ -588,3 +597,35 @@ roc_nix_max_rep_count(struct roc_nix *roc_nix)
 	mbox_put(mbox);
 	return rc;
 }
+
+static int
+nix_af_rx_flow_vec_ctrl_set(struct mbox *mbox)
+{
+	struct nix_af_rx_flow_vec_ctrl_write_req *req;
+	struct nix_af_rx_flow_vec_ctrl_write_rsp *rsp;
+	int rc = -ENOSPC;
+
+	req = mbox_alloc_msg_nix_af_rx_flow_vec_ctrl_set(mbox_get(mbox));
+	if (req == NULL)
+		goto exit;
+
+	memcpy(&req->ctrl0x, nix_flow_ctrl0, sizeof(nix_flow_ctrl0));
+	memcpy(&req->ctrl1x, nix_flow_ctrl1, sizeof(nix_flow_ctrl1));
+
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		goto exit;
+
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_nix_af_rx_flow_vec_ctrl_set(struct roc_nix *roc_nix)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct dev *dev = &nix->dev;
+
+	return nix_af_rx_flow_vec_ctrl_set(dev->mbox);
+}
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 0b1e501b16..35a90f982b 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -1052,6 +1052,8 @@ int __roc_api roc_nix_npc_rx_ena_dis(struct roc_nix *roc_nix, bool enable);
 int __roc_api roc_nix_npc_mcast_config(struct roc_nix *roc_nix,
 				       bool mcast_enable, bool prom_enable);
 
+int __roc_api roc_nix_af_rx_flow_vec_ctrl_set(struct roc_nix *roc_nix);
+
 /* RSS */
 void __roc_api roc_nix_rss_key_default_fill(struct roc_nix *roc_nix,
 					    uint8_t key[ROC_NIX_RSS_KEY_LEN]);
diff --git a/drivers/common/cnxk/roc_nix_flow_vec.h b/drivers/common/cnxk/roc_nix_flow_vec.h
new file mode 100644
index 0000000000..72dbf44292
--- /dev/null
+++ b/drivers/common/cnxk/roc_nix_flow_vec.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2021 Marvell.
+ */
+
+#ifndef _ROC_NIX_FLOW_VEC_H_
+#define _ROC_NIX_FLOW_VEC_H_
+
+#define IPV4_SOV_OFFSET 6
+#define IPV4_SOV_MASK	0x1FFF
+#define IPV4_EOV_OFFSET 6
+#define IPV4_EOV_MASK	0x2000
+
+#define IPV6_SOV_OFFSET 0x2A
+#define IPV6_SOV_MASK	0xFFF8
+#define IPV6_EOV_OFFSET 0x2A
+#define IPV6_EOV_MASK	0x1
+
+#define CUSTOM_SOV_OFFSET 4
+#define CUSTOM_SOV_MASK	  0x7F
+#define CUSTOM_EOV_OFFSET 5
+#define CUSTOM_EOV_MASK	  0x80
+
+#define IPV4_VER_OFFSET	  0
+#define IPV4_VER_MATCH	  0x4
+#define IPV4_VER_MASK	  0xF
+#define IPV6_VER_OFFSET	  0
+#define IPV6_VER_MATCH	  0x6
+#define IPV6_VER_MASK	  0xF
+#define CUSTOM_VER_OFFSET 0
+#define CUSTOM_VER_MATCH  0x2
+#define CUSTOM_VER_MASK	  0xF
+
+static union nix_af_rx_flow_vec_ctrl0x nix_flow_ctrl0[NIX_AF_RX_FLOW_VEC_CTRL_MAX] = {
+	{.s.eov_inv = 0,
+	 .s.eov_mask = 0,
+	 .s.eov_offset = 0,
+	 .s.sov_inv = 0,
+	 .s.sov_mask = 0,
+	 .s.sov_offset = 0,
+	 .s.reserved = 0},
+	{.s.eov_inv = 1,
+	 .s.eov_mask = IPV4_EOV_MASK,
+	 .s.eov_offset = IPV4_EOV_OFFSET,
+	 .s.sov_inv = 1,
+	 .s.sov_mask = IPV4_SOV_MASK,
+	 .s.sov_offset = IPV4_SOV_OFFSET,
+	 .s.reserved = 0},
+	{.s.eov_inv = 1,
+	 .s.eov_mask = IPV6_EOV_MASK,
+	 .s.eov_offset = IPV6_EOV_OFFSET,
+	 .s.sov_inv = 1,
+	 .s.sov_mask = IPV6_SOV_MASK,
+	 .s.sov_offset = IPV6_SOV_OFFSET,
+	 .s.reserved = 0},
+	{.s.eov_inv = 1,
+	 .s.eov_mask = CUSTOM_EOV_MASK,
+	 .s.eov_offset = CUSTOM_EOV_OFFSET,
+	 .s.sov_inv = 1,
+	 .s.sov_mask = CUSTOM_SOV_MASK,
+	 .s.sov_offset = CUSTOM_SOV_OFFSET,
+	 .s.reserved = 0},
+};
+
+static union nix_af_rx_flow_vec_ctrl1x nix_flow_ctrl1[NIX_AF_RX_FLOW_VEC_CTRL_MAX] = {
+	{.s.ver_mask = 0,
+	 .s.ver_match = 0,
+	 .s.ver_offset = 0,
+	 .s.ltype_mask = 0,
+	 .s.ltype_match = 0,
+	 .s.lid = 0,
+	 .s.valid = 0,
+	 .s.reserved = 0},
+	{.s.ver_mask = IPV4_VER_MASK,
+	 .s.ver_match = IPV4_VER_MATCH,
+	 .s.ver_offset = IPV4_VER_OFFSET,
+	 .s.ltype_mask = 0x3,
+	 .s.ltype_match = NPC_LT_LC_IP,
+	 .s.lid = NPC_LID_LC,
+	 .s.valid = 1,
+	 .s.reserved = 0},
+	{.s.ver_mask = IPV6_VER_MASK,
+	 .s.ver_match = IPV6_VER_MATCH,
+	 .s.ver_offset = IPV6_VER_OFFSET,
+	 .s.ltype_mask = 0x7,
+	 .s.ltype_match = NPC_LT_LC_IP6,
+	 .s.lid = NPC_LID_LC,
+	 .s.valid = 1,
+	 .s.reserved = 0},
+	{.s.ver_mask = CUSTOM_VER_MASK,
+	 .s.ver_match = CUSTOM_VER_MATCH,
+	 .s.ver_offset = CUSTOM_VER_OFFSET,
+	 .s.ltype_mask = 0xF,
+	 .s.ltype_match = NPC_LT_LC_CUSTOM0,
+	 .s.lid = NPC_LID_LC,
+	 .s.valid = 1,
+	 .s.reserved = 0},
+};
+
+#endif /* _ROC_NIX_FLOW_VEC_H_ */
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index 6a27f0e0fa..c7e7d2d8f6 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -95,6 +95,9 @@
 #define NPC_CN20K_LFLAG_LC_OFFSET (NPC_LTYPE_OFFSET_START + 4)
 #define NPC_CN20K_LTYPE_LC_OFFSET (NPC_LTYPE_OFFSET_START + 5)
 
+#define NPC_ACTION2_FLOW_VEC_VLD_FIELD 0xE
+#define NPC_ACTION2_FLOW_VEC_FIELD     0xC
+
 #define CN10K_SDP_CH_START 0x80
 #define CN10K_SDP_CH_MASK  0xF80
 
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 063cb21aae..00746abc06 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -96,6 +96,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_free)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_af_rx_flow_vec_ctrl_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_ring_base_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_list_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_set)
-- 
2.43.0

