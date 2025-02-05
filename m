Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD68C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 05:42:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B2F40289;
	Wed,  5 Feb 2025 06:42:57 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF8A040270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 06:42:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5154dO4Z011030
 for <dev@dpdk.org>; Tue, 4 Feb 2025 21:42:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 TuNeGRMT1p4RFZop8L/nqkdTzzS4icQdqefbEKprro=; b=J4h+8XyboJuZumtJO
 Tlo8bEuylZGUnjwTelYsmoFxkKX/juwJXL2OB2gKrDMJYPOTXz133kWxVerGrD6S
 xRyC50Jm5sxWNyIE4AwC4Dcsd5eoo4d4O0rlQDqAXi5Xt7vsCfxHboDQo0TrIcDj
 eNnG2A51EQ7z5ORo/zCUS9QjBGLwLEpAW45ZcjvJLn51C6xYz63YEO3tgTK7ORxm
 3oBZESSQ6zciOBApKdBWisQTzmexVVVVvgVuX52zCcNklPe4/udqv7T6Nzvddfnk
 3NJX5kSkGk2o30F6vTq7RQy+D74pZe94v1Mh4oKgpjZilQc/Ai82yQw6BNPOVnqe
 frmVA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44m14w02xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Feb 2025 21:42:54 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 4 Feb 2025 21:42:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 4 Feb 2025 21:42:53 -0800
Received: from cavium-OptiPlex-3070-BM17.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id CC1FD3F7078;
 Tue,  4 Feb 2025 21:42:50 -0800 (PST)
From: <psatheesh@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Satheesh Paul <psatheesh@marvell.com>
Subject: [dpdk-dev] [PATCH v5 1/2] common/cnxk: support NPC flow on cn20k
Date: Wed, 5 Feb 2025 11:12:46 +0530
Message-ID: <20250205054247.1214565-1-psatheesh@marvell.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241021040144.974453-1-psatheesh@marvell.com>
References: <20241021040144.974453-1-psatheesh@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: I-6h12KrQPYCROqMeMOGD1OvgDYrMwFU
X-Proofpoint-ORIG-GUID: I-6h12KrQPYCROqMeMOGD1OvgDYrMwFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_02,2025-02-05_01,2024-11-22_01
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

ROC changes to support NPC flow on cn20k.

Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>
---
v2:
* Fixed generic platform compiler error.
v3:
* Removed compile time macros.
v4:
* Rebased the patches.
v5:
* Updated release notes.
* Fixed '__io' label for mbox field.

 drivers/common/cnxk/roc_mbox.h          | 144 +++++-
 drivers/common/cnxk/roc_nix.h           |  18 +-
 drivers/common/cnxk/roc_nix_mcast.c     |  40 +-
 drivers/common/cnxk/roc_nix_vlan.c      |  66 ++-
 drivers/common/cnxk/roc_npc.c           |  58 ++-
 drivers/common/cnxk/roc_npc.h           |  59 ++-
 drivers/common/cnxk/roc_npc_mcam.c      | 602 +++++++++++++++++++-----
 drivers/common/cnxk/roc_npc_mcam_dump.c | 279 +++++++++--
 drivers/common/cnxk/roc_npc_priv.h      |  91 ++--
 drivers/common/cnxk/roc_npc_utils.c     | 340 ++++++++++---
 drivers/common/cnxk/version.map         |   1 +
 11 files changed, 1325 insertions(+), 373 deletions(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 989f33b0d2..f3024057b5 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -244,6 +244,22 @@ struct mbox_msghdr {
 	  npc_get_field_hash_info_req, npc_get_field_hash_info_rsp)            \
 	M(NPC_MCAM_GET_HIT_STATUS, 0x6015, npc_mcam_get_hit_status,            \
 	  npc_mcam_get_hit_status_req, npc_mcam_get_hit_status_rsp)            \
+	M(NPC_MCAM_DEFRAG, 0x6016, npc_defrag, msg_req,	msg_rsp)               \
+	M(NPC_CN20K_GET_KEX_CFG, 0x6017, npc_cn20k_get_kex_cfg, msg_req,       \
+	  npc_cn20k_get_kex_cfg_rsp)                                           \
+	M(NPC_CN20K_MCAM_GET_FREE_COUNT, 0x6018, npc_cn20k_get_free_count,     \
+	  msg_req, npc_cn20k_get_free_count_rsp)                               \
+	M(NPC_CN20K_MCAM_WRITE_ENTRY,	0x6019, npc_cn20k_mcam_write_entry,    \
+	  npc_cn20k_mcam_write_entry_req, msg_rsp)	                       \
+	M(NPC_CN20K_MCAM_ALLOC_AND_WRITE_ENTRY, 0x601a,			       \
+	  npc_cn20k_mcam_alloc_and_write_entry,				       \
+	  npc_cn20k_mcam_alloc_and_write_entry_req,			       \
+	  npc_mcam_alloc_and_write_entry_rsp)				       \
+	M(NPC_CN20K_MCAM_READ_ENTRY,	0x601b, npc_cn20k_mcam_read_entry,     \
+	  npc_mcam_read_entry_req, npc_cn20k_mcam_read_entry_rsp)	       \
+	M(NPC_CN20K_MCAM_READ_BASE_RULE, 0x601c,                               \
+	  npc_cn20k_read_base_steer_rule, msg_req,                             \
+	  npc_cn20k_mcam_read_base_rule_rsp)                                   \
 	/* NIX mbox IDs (range 0x8000 - 0xFFFF) */                             \
 	M(NIX_LF_ALLOC, 0x8000, nix_lf_alloc, nix_lf_alloc_req,                \
 	  nix_lf_alloc_rsp)                                                    \
@@ -645,7 +661,7 @@ struct cgx_mac_addr_add_req {
  */
 struct cgx_mac_addr_add_rsp {
 	struct mbox_msghdr hdr;
-	uint8_t __io index;
+	uint32_t __io index;
 };
 
 /* Structure for requesting the operation to
@@ -653,7 +669,7 @@ struct cgx_mac_addr_add_rsp {
  */
 struct cgx_mac_addr_del_req {
 	struct mbox_msghdr hdr;
-	uint8_t __io index;
+	uint32_t __io index;
 };
 
 /* Structure for response against the operation to
@@ -661,7 +677,7 @@ struct cgx_mac_addr_del_req {
  */
 struct cgx_max_dmac_entries_get_rsp {
 	struct mbox_msghdr hdr;
-	uint8_t __io max_dmac_filters;
+	uint32_t __io max_dmac_filters;
 };
 
 struct cgx_link_user_info {
@@ -2485,6 +2501,14 @@ enum npc_af_status {
 	NPC_MCAM_ALLOC_FAILED = -703,
 	NPC_MCAM_PERM_DENIED = -704,
 	NPC_AF_ERR_HIGIG_CONFIG_FAIL = -705,
+	NPC_AF_ERR_HIGIG_NOT_SUPPORTED = -706,
+	NPC_FLOW_INTF_INVALID = -707,
+	NPC_FLOW_CHAN_INVALID = -708,
+	NPC_FLOW_NO_NIXLF = -709,
+	NPC_FLOW_NOT_SUPPORTED = -710,
+	NPC_FLOW_VF_PERM_DENIED = -711,
+	NPC_FLOW_VF_NOT_INIT = -712,
+	NPC_FLOW_VF_OVERLAP = -713,
 };
 
 struct npc_mcam_alloc_entry_req {
@@ -2494,9 +2518,12 @@ struct npc_mcam_alloc_entry_req {
 #define NPC_MCAM_ANY_PRIO    0
 #define NPC_MCAM_LOWER_PRIO  1
 #define NPC_MCAM_HIGHER_PRIO 2
-	uint8_t __io priority; /* Lower or higher w.r.t ref_entry */
+	uint8_t __io ref_priority; /* Lower or higher w.r.t ref_entry */
 	uint16_t __io ref_entry;
 	uint16_t __io count; /* Number of entries requested */
+	uint8_t __io kw_type; /* Key type */
+	uint8_t __io virt;    /* Request virtual index */
+	uint16_t __io rsvd[16];	/* Reserved */
 };
 
 struct npc_mcam_alloc_entry_rsp {
@@ -2508,6 +2535,7 @@ struct npc_mcam_alloc_entry_rsp {
 	uint16_t __io count;	  /* Number of entries allocated */
 	uint16_t __io free_count; /* Number of entries available */
 	uint16_t __io entry_list[NPC_MAX_NONCONTIG_ENTRIES];
+	uint16_t __io rsvd[16];	/* Reserved */
 };
 
 struct npc_mcam_free_entry_req {
@@ -2534,6 +2562,26 @@ struct npc_mcam_write_entry_req {
 	uint8_t __io set_cntr;	   /* Set counter for this entry ? */
 };
 
+struct cn20k_mcam_entry {
+#define NPC_CN20K_MAX_KWS_IN_KEY 8 /* Number of keywords in max keywidth */
+	uint64_t __io kw[NPC_CN20K_MAX_KWS_IN_KEY];
+	uint64_t __io kw_mask[NPC_CN20K_MAX_KWS_IN_KEY];
+	uint64_t __io action;
+	uint64_t __io vtag_action;
+};
+
+struct npc_cn20k_mcam_write_entry_req {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry_data;
+	uint16_t __io entry;	   /* MCAM entry to write this match key */
+	uint16_t __io cntr;	   /* Counter for this MCAM entry */
+	uint8_t __io intf;	   /* Rx or Tx interface */
+	uint8_t __io enable_entry; /* Enable this MCAM entry ? */
+	uint8_t __io hw_prio;	   /* hardware priority, valid for cn20k */
+	uint8_t __io req_kw_type;  /* Type of kw which should be written */
+	uint64_t __io reserved;	   /* reserved for future use */
+};
+
 /* Enable/Disable a given entry */
 struct npc_mcam_ena_dis_entry_req {
 	struct mbox_msghdr hdr;
@@ -2593,12 +2641,25 @@ struct npc_mcam_alloc_and_write_entry_req {
 	struct mbox_msghdr hdr;
 	struct mcam_entry entry_data;
 	uint16_t __io ref_entry;
-	uint8_t __io priority;	   /* Lower or higher w.r.t ref_entry */
+	uint8_t __io ref_priority; /* Lower or higher w.r.t ref_entry */
 	uint8_t __io intf;	   /* Rx or Tx interface */
 	uint8_t __io enable_entry; /* Enable this MCAM entry ? */
 	uint8_t __io alloc_cntr;   /* Allocate counter and map ? */
 };
 
+struct npc_cn20k_mcam_alloc_and_write_entry_req {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry_data;
+	uint16_t __io ref_entry;
+	uint8_t __io ref_prio;	   /* Lower or higher w.r.t ref_entry */
+	uint8_t __io intf;	   /* Rx or Tx interface */
+	uint8_t __io enable_entry; /* Enable this MCAM entry ? */
+	uint8_t __io hw_prio;	   /* hardware priority, valid for cn20k */
+	uint8_t __io virt;	   /* Allocate virtual index */
+	uint8_t __io req_kw_type;  /* Key type to be written */
+	uint16_t __io reserved[4]; /* reserved for future use */
+};
+
 struct npc_mcam_alloc_and_write_entry_rsp {
 	struct mbox_msghdr hdr;
 	uint16_t __io entry;
@@ -2625,6 +2686,48 @@ struct npc_get_kex_cfg_rsp {
 	uint8_t __io mkex_pfl_name[MKEX_NAME_LEN];
 };
 
+struct npc_delete_flow_rsp {
+	struct mbox_msghdr hdr;
+	uint16_t __io cntr_val;
+};
+
+/* Available entries to use */
+struct npc_cn20k_get_free_count_rsp {
+	struct mbox_msghdr hdr;
+	int __io free_x2;
+	int __io free_x4;
+	int __io free_subbanks;
+};
+
+struct npc_cn20k_get_kex_cfg_rsp {
+	struct mbox_msghdr hdr;
+	uint64_t __io rx_keyx_cfg; /* NPC_AF_INTF(0)_KEX_CFG */
+	uint64_t __io tx_keyx_cfg; /* NPC_AF_INTF(1)_KEX_CFG */
+#define NPC_MAX_EXTRACTOR 24
+	/* MKEX Extractor data */
+	uint64_t __io intf_extr[NPC_MAX_INTF][NPC_MAX_EXTRACTOR];
+	/* KEX configuration per extractor */
+	uint64_t __io intf_extr_lt[NPC_MAX_INTF][NPC_MAX_EXTRACTOR][NPC_MAX_LT];
+#define MKEX_NAME_LEN 128
+	uint8_t __io mkex_pfl_name[MKEX_NAME_LEN];
+};
+
+struct npc_get_field_hash_info_req {
+	struct mbox_msghdr hdr;
+	uint8_t __io intf;
+};
+
+struct npc_get_field_hash_info_rsp {
+	struct mbox_msghdr hdr;
+	uint64_t __io secret_key[3];
+#define NPC_MAX_HASH	  2
+#define NPC_MAX_HASH_MASK 2
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_MASK(0..1) */
+	uint64_t __io hash_mask[NPC_MAX_INTF][NPC_MAX_HASH][NPC_MAX_HASH_MASK];
+	/* NPC_AF_INTF(0..1)_HASH(0..1)_RESULT_CTRL */
+	uint64_t __io hash_ctrl[NPC_MAX_INTF][NPC_MAX_HASH];
+};
+
 enum header_fields {
 	NPC_DMAC,
 	NPC_SMAC,
@@ -2714,6 +2817,8 @@ struct npc_install_flow_req {
 	uint8_t __io vtag1_op;
 	/* old counter value */
 	uint16_t __io cntr_val;
+	/* hardware priority, supported for cn20k */
+	uint8_t __io hw_prio;
 };
 
 struct npc_install_flow_rsp {
@@ -2744,11 +2849,24 @@ struct npc_mcam_read_entry_rsp {
 	uint8_t __io enable;
 };
 
+struct npc_cn20k_mcam_read_entry_rsp {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry_data;
+	uint8_t __io intf;
+	uint8_t __io enable;
+	uint8_t __io hw_prio; /* valid for cn20k */
+};
+
 struct npc_mcam_read_base_rule_rsp {
 	struct mbox_msghdr hdr;
 	struct mcam_entry entry_data;
 };
 
+struct npc_cn20k_mcam_read_base_rule_rsp {
+	struct mbox_msghdr hdr;
+	struct cn20k_mcam_entry entry;
+};
+
 struct npc_mcam_get_stats_req {
 	struct mbox_msghdr hdr;
 	uint16_t __io entry; /* mcam entry */
@@ -2829,22 +2947,6 @@ enum tim_gpio_edge {
 	TIM_GPIO_INVALID,
 };
 
-struct npc_get_field_hash_info_req {
-	struct mbox_msghdr hdr;
-	uint8_t intf;
-};
-
-struct npc_get_field_hash_info_rsp {
-	struct mbox_msghdr hdr;
-	uint64_t __io secret_key[3];
-#define NPC_MAX_HASH	  2
-#define NPC_MAX_HASH_MASK 2
-	/* NPC_AF_INTF(0..1)_HASH(0..1)_MASK(0..1) */
-	uint64_t __io hash_mask[NPC_MAX_INTF][NPC_MAX_HASH][NPC_MAX_HASH_MASK];
-	/* NPC_AF_INTF(0..1)_HASH(0..1)_RESULT_CTRL */
-	uint64_t __io hash_ctrl[NPC_MAX_INTF][NPC_MAX_HASH];
-};
-
 enum ptp_op {
 	PTP_OP_ADJFINE = 0,   /* adjfine(req.scaled_ppm); */
 	PTP_OP_GET_CLOCK = 1, /* rsp.clk = get_clock() */
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index f213823b9b..15823ab16c 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -983,15 +983,11 @@ bool __roc_api roc_nix_ptp_is_enable(struct roc_nix *roc_nix);
 /* VLAN */
 int __roc_api
 roc_nix_vlan_mcam_entry_read(struct roc_nix *roc_nix, uint32_t index,
-			     struct npc_mcam_read_entry_rsp **rsp);
-int __roc_api roc_nix_vlan_mcam_entry_write(struct roc_nix *roc_nix,
-					    uint32_t index,
-					    struct mcam_entry *entry,
+			     void **rsp);
+int __roc_api roc_nix_vlan_mcam_entry_write(struct roc_nix *roc_nix, uint32_t index, void *entry,
 					    uint8_t intf, uint8_t enable);
-int __roc_api roc_nix_vlan_mcam_entry_alloc_and_write(struct roc_nix *roc_nix,
-						      struct mcam_entry *entry,
-						      uint8_t intf,
-						      uint8_t priority,
+int __roc_api roc_nix_vlan_mcam_entry_alloc_and_write(struct roc_nix *roc_nix, void *entry,
+						      uint8_t intf, uint8_t priority,
 						      uint8_t ref_entry);
 int __roc_api roc_nix_vlan_mcam_entry_free(struct roc_nix *roc_nix,
 					   uint32_t index);
@@ -1012,10 +1008,8 @@ int __roc_api roc_nix_mcast_mcam_entry_alloc(struct roc_nix *roc_nix,
 					     uint16_t index[]);
 int __roc_api roc_nix_mcast_mcam_entry_free(struct roc_nix *roc_nix,
 					    uint32_t index);
-int __roc_api roc_nix_mcast_mcam_entry_write(struct roc_nix *roc_nix,
-					     struct mcam_entry *entry,
-					     uint32_t index, uint8_t intf,
-					     uint64_t action);
+int __roc_api roc_nix_mcast_mcam_entry_write(struct roc_nix *roc_nix, void *entry, uint32_t index,
+					     uint8_t intf, uint64_t action);
 int __roc_api roc_nix_mcast_mcam_entry_ena_dis(struct roc_nix *roc_nix, uint32_t index,
 					       bool enable);
 int __roc_api roc_nix_mcast_list_setup(struct mbox *mbox, uint8_t intf, int nb_entries,
diff --git a/drivers/common/cnxk/roc_nix_mcast.c b/drivers/common/cnxk/roc_nix_mcast.c
index 615014e820..eab4bde743 100644
--- a/drivers/common/cnxk/roc_nix_mcast.c
+++ b/drivers/common/cnxk/roc_nix_mcast.c
@@ -19,7 +19,7 @@ roc_nix_mcast_mcam_entry_alloc(struct roc_nix *roc_nix, uint16_t nb_entries,
 	req = mbox_alloc_msg_npc_mcam_alloc_entry(mbox);
 	if (req == NULL)
 		goto exit;
-	req->priority = priority;
+	req->ref_priority = priority;
 	req->count = nb_entries;
 
 	rc = mbox_process_msg(mbox, (void *)&rsp);
@@ -56,24 +56,38 @@ roc_nix_mcast_mcam_entry_free(struct roc_nix *roc_nix, uint32_t index)
 }
 
 int
-roc_nix_mcast_mcam_entry_write(struct roc_nix *roc_nix,
-			       struct mcam_entry *entry, uint32_t index,
-			       uint8_t intf, uint64_t action)
+roc_nix_mcast_mcam_entry_write(struct roc_nix *roc_nix, void *entry, uint32_t index, uint8_t intf,
+			       uint64_t action)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct dev *dev = &nix->dev;
 	struct mbox *mbox = mbox_get(dev->mbox);
-	struct npc_mcam_write_entry_req *req;
 	int rc = -ENOSPC;
 
-	req = mbox_alloc_msg_npc_mcam_write_entry(mbox);
-	if (req == NULL)
-		goto exit;
-	req->entry = index;
-	req->intf = intf;
-	req->enable_entry = true;
-	mbox_memcpy(&req->entry_data, entry, sizeof(struct mcam_entry));
-	req->entry_data.action = action;
+	if (roc_model_is_cn20k()) {
+		struct npc_cn20k_mcam_write_entry_req *req;
+
+		req = mbox_alloc_msg_npc_cn20k_mcam_write_entry(mbox);
+		if (req == NULL)
+			goto exit;
+		req->entry = index;
+		req->intf = intf;
+		req->enable_entry = true;
+		mbox_memcpy(&req->entry_data, entry, sizeof(struct cn20k_mcam_entry));
+		req->entry_data.action = action;
+
+	} else {
+		struct npc_mcam_write_entry_req *req;
+
+		req = mbox_alloc_msg_npc_mcam_write_entry(mbox);
+		if (req == NULL)
+			goto exit;
+		req->entry = index;
+		req->intf = intf;
+		req->enable_entry = true;
+		mbox_memcpy(&req->entry_data, entry, sizeof(struct mcam_entry));
+		req->entry_data.action = action;
+	}
 
 	rc = mbox_process(mbox);
 exit:
diff --git a/drivers/common/cnxk/roc_nix_vlan.c b/drivers/common/cnxk/roc_nix_vlan.c
index db218593ad..16100eb5d6 100644
--- a/drivers/common/cnxk/roc_nix_vlan.c
+++ b/drivers/common/cnxk/roc_nix_vlan.c
@@ -7,7 +7,7 @@
 
 int
 roc_nix_vlan_mcam_entry_read(struct roc_nix *roc_nix, uint32_t index,
-			     struct npc_mcam_read_entry_rsp **rsp)
+			     void **rsp)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct dev *dev = &nix->dev;
@@ -27,24 +27,34 @@ roc_nix_vlan_mcam_entry_read(struct roc_nix *roc_nix, uint32_t index,
 }
 
 int
-roc_nix_vlan_mcam_entry_write(struct roc_nix *roc_nix, uint32_t index,
-			      struct mcam_entry *entry, uint8_t intf,
+roc_nix_vlan_mcam_entry_write(struct roc_nix *roc_nix, uint32_t index, void *entry, uint8_t intf,
 			      uint8_t enable)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct dev *dev = &nix->dev;
 	struct mbox *mbox = mbox_get(dev->mbox);
 	struct npc_mcam_write_entry_req *req;
+	struct npc_cn20k_mcam_write_entry_req *cn20k_req;
 	struct msghdr *rsp;
 	int rc = -ENOSPC;
 
-	req = mbox_alloc_msg_npc_mcam_write_entry(mbox);
-	if (req == NULL)
-		goto exit;
-	req->entry = index;
-	req->intf = intf;
-	req->enable_entry = enable;
-	mbox_memcpy(&req->entry_data, entry, sizeof(struct mcam_entry));
+	if (roc_model_is_cn20k()) {
+		cn20k_req = mbox_alloc_msg_npc_cn20k_mcam_write_entry(mbox);
+		if (cn20k_req == NULL)
+			goto exit;
+		cn20k_req->entry = index;
+		cn20k_req->intf = intf;
+		cn20k_req->enable_entry = enable;
+		mbox_memcpy(&cn20k_req->entry_data, entry, sizeof(struct cn20k_mcam_entry));
+	} else {
+		req = mbox_alloc_msg_npc_mcam_write_entry(mbox);
+		if (req == NULL)
+			goto exit;
+		req->entry = index;
+		req->intf = intf;
+		req->enable_entry = enable;
+		mbox_memcpy(&req->entry_data, entry, sizeof(struct mcam_entry));
+	}
 
 	rc = mbox_process_msg(mbox, (void *)&rsp);
 exit:
@@ -53,25 +63,39 @@ roc_nix_vlan_mcam_entry_write(struct roc_nix *roc_nix, uint32_t index,
 }
 
 int
-roc_nix_vlan_mcam_entry_alloc_and_write(struct roc_nix *roc_nix,
-					struct mcam_entry *entry, uint8_t intf,
+roc_nix_vlan_mcam_entry_alloc_and_write(struct roc_nix *roc_nix, void *entry, uint8_t intf,
 					uint8_t priority, uint8_t ref_entry)
 {
-	struct npc_mcam_alloc_and_write_entry_req *req;
 	struct npc_mcam_alloc_and_write_entry_rsp *rsp;
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	struct dev *dev = &nix->dev;
 	struct mbox *mbox = mbox_get(dev->mbox);
 	int rc = -ENOSPC;
 
-	req = mbox_alloc_msg_npc_mcam_alloc_and_write_entry(mbox);
-	if (req == NULL)
-		goto exit;
-	req->priority = priority;
-	req->ref_entry = ref_entry;
-	req->intf = intf;
-	req->enable_entry = true;
-	mbox_memcpy(&req->entry_data, entry, sizeof(struct mcam_entry));
+	if (roc_model_is_cn20k()) {
+		struct npc_cn20k_mcam_alloc_and_write_entry_req *req;
+
+		req = mbox_alloc_msg_npc_cn20k_mcam_alloc_and_write_entry(mbox);
+		if (req == NULL)
+			goto exit;
+		req->ref_prio = priority;
+		req->ref_entry = ref_entry;
+		req->intf = intf;
+		req->enable_entry = true;
+		mbox_memcpy(&req->entry_data, entry, sizeof(struct cn20k_mcam_entry));
+
+	} else {
+		struct npc_mcam_alloc_and_write_entry_req *req;
+
+		req = mbox_alloc_msg_npc_mcam_alloc_and_write_entry(mbox);
+		if (req == NULL)
+			goto exit;
+		req->ref_priority = priority;
+		req->ref_entry = ref_entry;
+		req->intf = intf;
+		req->enable_entry = true;
+		mbox_memcpy(&req->entry_data, entry, sizeof(struct mcam_entry));
+	}
 
 	rc = mbox_process_msg(mbox, (void *)&rsp);
 	if (rc)
diff --git a/drivers/common/cnxk/roc_npc.c b/drivers/common/cnxk/roc_npc.c
index 53f278c764..138f12f6d8 100644
--- a/drivers/common/cnxk/roc_npc.c
+++ b/drivers/common/cnxk/roc_npc.c
@@ -100,6 +100,14 @@ roc_npc_mcam_read_counter(struct roc_npc *roc_npc, uint32_t ctr_id, uint64_t *co
 	return npc_mcam_read_counter(npc->mbox, ctr_id, count);
 }
 
+int
+roc_npc_mcam_get_stats(struct roc_npc *roc_npc, struct roc_npc_flow *flow, uint64_t *count)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+
+	return npc_mcam_get_stats(npc->mbox, flow, count);
+}
+
 int
 roc_npc_mcam_clear_counter(struct roc_npc *roc_npc, uint32_t ctr_id)
 {
@@ -221,7 +229,9 @@ roc_npc_get_low_priority_mcam(struct roc_npc *roc_npc)
 {
 	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
 
-	if (roc_model_is_cn10k())
+	if (roc_model_is_cn20k())
+		return (npc->mcam_entries - NPC_MCAME_RESVD_10XX - 1);
+	else if (roc_model_is_cn10k())
 		return (npc->mcam_entries - NPC_MCAME_RESVD_10XX - 1);
 	else if (roc_model_is_cn98xx())
 		return (npc->mcam_entries - NPC_MCAME_RESVD_98XX - 1);
@@ -235,7 +245,9 @@ npc_mcam_tot_entries(void)
 	/* FIXME: change to reading in AF from NPC_AF_CONST1/2
 	 * MCAM_BANK_DEPTH(_EXT) * MCAM_BANKS
 	 */
-	if (roc_model_is_cn10k() || roc_model_is_cn98xx())
+	if (roc_model_is_cn20k())
+		return 2 * 8192; /* MCAM_BANKS = 2, BANK_DEPTH_EXT = 8192 */
+	else if (roc_model_is_cn10k() || roc_model_is_cn98xx())
 		return 16 * 1024; /* MCAM_BANKS = 4, BANK_DEPTH_EXT = 4096 */
 	else
 		return 4 * 1024; /* MCAM_BANKS = 4, BANK_DEPTH_EXT = 1024 */
@@ -311,6 +323,7 @@ roc_npc_init(struct roc_npc *roc_npc)
 
 	npc->mcam_entries = npc_mcam_tot_entries() >> npc->keyw[NPC_MCAM_RX];
 	nix->exact_match_ena = npc->exact_match_ena;
+	roc_npc->max_entries = npc->mcam_entries;
 
 	/* Free, free_rev, live and live_rev entries */
 	bmap_sz = plt_bitmap_get_memory_footprint(npc->mcam_entries);
@@ -1856,9 +1869,7 @@ roc_npc_flow_dump(FILE *file, struct roc_npc *roc_npc, int rep_port_id)
 int
 roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_flow *flow)
 {
-	struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
 	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
-	struct mcam_entry *base_entry;
 	struct mbox *mbox = mbox_get(npc->mbox);
 	int idx, rc;
 
@@ -1868,17 +1879,36 @@ roc_npc_mcam_merge_base_steering_rule(struct roc_npc *roc_npc, struct roc_npc_fl
 	}
 
 	(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
-	rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
-	if (rc) {
-		plt_err("Failed to fetch VF's base MCAM entry");
-		goto exit;
-	}
-	base_entry = &base_rule_rsp->entry_data;
-	for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
-		flow->mcam_data[idx] |= base_entry->kw[idx];
-		flow->mcam_mask[idx] |= base_entry->kw_mask[idx];
-	}
+	if (roc_model_is_cn20k()) {
+		struct npc_cn20k_mcam_read_base_rule_rsp *base_rule_rsp;
+		struct cn20k_mcam_entry *base_entry;
 
+		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
+		if (rc) {
+			plt_err("Failed to fetch VF's base MCAM entry");
+			goto exit;
+		}
+		base_entry = &base_rule_rsp->entry;
+		for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
+			flow->mcam_data[idx] |= base_entry->kw[idx];
+			flow->mcam_mask[idx] |= base_entry->kw_mask[idx];
+		}
+
+	} else {
+		struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
+		struct mcam_entry *base_entry;
+
+		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
+		if (rc) {
+			plt_err("Failed to fetch VF's base MCAM entry");
+			goto exit;
+		}
+		base_entry = &base_rule_rsp->entry_data;
+		for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
+			flow->mcam_data[idx] |= base_entry->kw[idx];
+			flow->mcam_mask[idx] |= base_entry->kw_mask[idx];
+		}
+	}
 	rc = 0;
 exit:
 	mbox_put(mbox);
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index f7a1e5d810..4da21a8eb3 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -305,52 +305,58 @@ struct roc_npc_spi_to_sa_action_info {
 };
 
 struct mbox;
-
 struct roc_npc_flow {
 	uint8_t nix_intf;
 	uint8_t enable;
-	uint32_t mcam_id;
 	uint8_t use_ctr;
+	bool is_validate;
+	uint32_t mcam_id;
+	uint16_t tx_pf_func;
+	bool has_age_action;
+	bool rep_act_rep;
 	int32_t ctr_id;
 	uint32_t priority;
 	uint32_t mtr_id;
+#if defined(ROC_PLATFORM_CN20K)
+#define ROC_NPC_MAX_MCAM_WIDTH_DWORDS 8
+#define ROC_NPC_MAX_MCAM_PRIORITY     123
+#else
 #define ROC_NPC_MAX_MCAM_WIDTH_DWORDS 7
+#define ROC_NPC_MAX_MCAM_PRIORITY     32
+#endif
 	/* Contiguous match string */
 	uint64_t mcam_data[ROC_NPC_MAX_MCAM_WIDTH_DWORDS];
 	uint64_t mcam_mask[ROC_NPC_MAX_MCAM_WIDTH_DWORDS];
 	uint64_t npc_action;
 	uint64_t vtag_action;
 	bool vtag_insert_enabled;
-	uint8_t vtag_insert_count;
+	int8_t vtag_insert_count;
 #define ROC_NPC_MAX_FLOW_PATTERNS 32
 	struct roc_npc_flow_dump_data dump_data[ROC_NPC_MAX_FLOW_PATTERNS];
 	uint16_t num_patterns;
 	struct roc_npc_spi_to_sa_action_info spi_to_sa_info;
-	uint16_t tx_pf_func;
-	bool is_validate;
 	uint16_t match_id;
 	uint8_t is_inline_dev;
 	bool use_pre_alloc;
 	uint64_t timeout_cycles;
 	void *age_context;
-	uint32_t timeout;
-	bool has_age_action;
-	uint16_t rep_pf_func;
 	uint16_t rep_act_pf_func;
-	bool rep_act_rep;
+	bool is_rep_vf;
+	bool has_rep;
+	bool is_sampling_rule;
+	uint16_t rep_pf_func;
+#define ROC_NPC_MIRROR_LIST_SIZE 2
+	uint16_t mcast_pf_funcs[ROC_NPC_MIRROR_LIST_SIZE];
 	uint16_t rep_channel;
 	struct mbox *rep_mbox;
-	bool has_rep;
-	bool is_rep_vf;
 	struct npc *rep_npc;
 	int port_id;
-	bool is_sampling_rule;
+	uint16_t mcast_channels[ROC_NPC_MIRROR_LIST_SIZE];
 	uint32_t recv_queue;
 	uint32_t mcast_grp_index;
 	uint32_t mce_start_index;
-#define ROC_NPC_MIRROR_LIST_SIZE 2
-	uint16_t mcast_pf_funcs[ROC_NPC_MIRROR_LIST_SIZE];
-	uint16_t mcast_channels[ROC_NPC_MIRROR_LIST_SIZE];
+	uint8_t key_type;
+	uint32_t timeout;
 
 	TAILQ_ENTRY(roc_npc_flow) next;
 };
@@ -400,33 +406,34 @@ struct roc_npc {
 	struct roc_nix *roc_nix;
 	uint8_t switch_header_type;
 	uint8_t pre_l2_size_offset;	 /**< Offset with in header that holds
-					   * size of custom header
-					   */
+					  * size of custom header
+					  */
 	uint8_t pre_l2_size_offset_mask; /**< Offset mask with in header
-					   * that holds size of custom header
-					   */
+					  * that holds size of custom header
+					  */
 	uint8_t pre_l2_size_shift_dir;	 /**< Shift direction to calculate size
-					   */
+					  */
 	uint16_t flow_prealloc_size;
 	uint16_t flow_max_priority;
 	uint16_t channel;
 	uint16_t pf_func;
+	bool is_sdp_mask_set;
+	bool rep_act_rep;
+	uint16_t sdp_channel_mask;
 	uint64_t kex_capability;
 	uint64_t rx_parse_nibble;
 	/* Parsed RSS Flowkey cfg for current flow being created */
 	uint32_t flowkey_cfg_state;
-	bool is_sdp_mask_set;
+	uint32_t max_entries;
+	uint16_t rep_act_pf_func;
 	uint16_t sdp_channel;
-	uint16_t sdp_channel_mask;
 	struct roc_npc_flow_age flow_age;
 	struct roc_npc *rep_npc;
 	uint16_t rep_pf_func;
 	uint16_t rep_rx_channel;
-	uint16_t rep_act_pf_func;
-	bool rep_act_rep;
 	int rep_port_id;
 
-#define ROC_NPC_MEM_SZ (6 * 1024)
+#define ROC_NPC_MEM_SZ (20 * 1024)
 	uint8_t reserved[ROC_NPC_MEM_SZ];
 } __plt_cache_aligned;
 
@@ -482,4 +489,6 @@ int __roc_api roc_npc_mcam_move(struct roc_npc *roc_npc, uint16_t old_ent, uint1
 void *__roc_api roc_npc_aged_flow_ctx_get(struct roc_npc *roc_npc, uint32_t mcam_id);
 void __roc_api roc_npc_sdp_channel_get(struct roc_npc *roc_npc, uint16_t *chan_base,
 				       uint16_t *chan_mask);
+int __roc_api roc_npc_mcam_get_stats(struct roc_npc *roc_npc, struct roc_npc_flow *flow,
+				     uint64_t *count);
 #endif /* _ROC_NPC_H_ */
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index cdb9db1383..412b2611b7 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -11,6 +11,10 @@ npc_mcam_alloc_counter(struct mbox *mbox, uint16_t *ctr)
 	struct npc_mcam_alloc_counter_rsp *rsp;
 	int rc = -ENOSPC;
 
+	/* For CN20K, counters are enabled by default */
+	if (roc_model_is_cn20k())
+		return 0;
+
 	req = mbox_alloc_msg_npc_mcam_alloc_counter(mbox_get(mbox));
 	if (req == NULL)
 		goto exit;
@@ -30,6 +34,9 @@ npc_mcam_free_counter(struct mbox *mbox, uint16_t ctr_id)
 	struct npc_mcam_oper_counter_req *req;
 	int rc = -ENOSPC;
 
+	if (roc_model_is_cn20k())
+		return 0;
+
 	req = mbox_alloc_msg_npc_mcam_free_counter(mbox_get(mbox));
 	if (req == NULL)
 		goto exit;
@@ -40,6 +47,30 @@ npc_mcam_free_counter(struct mbox *mbox, uint16_t ctr_id)
 	return rc;
 }
 
+int
+npc_mcam_get_stats(struct mbox *mbox, struct roc_npc_flow *flow, uint64_t *count)
+{
+	struct npc_mcam_get_stats_req *req;
+	struct npc_mcam_get_stats_rsp *rsp;
+	int rc = -ENOSPC;
+
+	/* valid only for cn20k */
+	if (!roc_model_is_cn20k())
+		return 0;
+
+	req = mbox_alloc_msg_npc_mcam_entry_stats(mbox_get(mbox));
+	if (req == NULL)
+		goto exit;
+	req->entry = flow->mcam_id;
+	rc = mbox_process_msg(mbox, (void *)&rsp);
+	if (rc)
+		goto exit;
+	*count = rsp->stat;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 int
 npc_mcam_read_counter(struct mbox *mbox, uint32_t ctr_id, uint64_t *count)
 {
@@ -47,6 +78,9 @@ npc_mcam_read_counter(struct mbox *mbox, uint32_t ctr_id, uint64_t *count)
 	struct npc_mcam_oper_counter_rsp *rsp;
 	int rc = -ENOSPC;
 
+	if (roc_model_is_cn20k())
+		return 0;
+
 	req = mbox_alloc_msg_npc_mcam_counter_stats(mbox_get(mbox));
 	if (req == NULL)
 		goto exit;
@@ -66,6 +100,9 @@ npc_mcam_clear_counter(struct mbox *mbox, uint32_t ctr_id)
 	struct npc_mcam_oper_counter_req *req;
 	int rc = -ENOSPC;
 
+	if (roc_model_is_cn20k())
+		return 0;
+
 	req = mbox_alloc_msg_npc_mcam_clear_counter(mbox_get(mbox));
 	if (req == NULL)
 		goto exit;
@@ -132,16 +169,53 @@ npc_lid_lt_in_kex(struct npc *npc, uint8_t lid, uint8_t lt)
 	struct npc_xtract_info *x_info;
 	int i;
 
-	for (i = 0; i < NPC_MAX_LD; i++) {
-		x_info = &npc->prx_dxcfg[NIX_INTF_RX][lid][lt].xtract[i];
-		/* Check for LDATA */
-		if (x_info->enable && x_info->len > 0)
-			return true;
+	if (!roc_model_is_cn20k()) {
+		for (i = 0; i < NPC_MAX_LD; i++) {
+			x_info = &npc->prx_dxcfg[NIX_INTF_RX][lid][lt].xtract[i];
+			/* Check for LDATA */
+			if (x_info->enable && x_info->len > 0)
+				return true;
+		}
+	} else {
+		for (i = 0; i < NPC_MAX_EXTRACTOR; i++) {
+			union npc_kex_ldata_flags_cfg *lid_info = &npc->lid_cfg[NIX_INTF_RX][i];
+
+			if (lid_info->s.lid != lid)
+				continue;
+			x_info = &npc->prx_dxcfg_cn20k[NIX_INTF_RX][i][lt].xtract;
+			/* Check for LDATA */
+			if (x_info->enable && x_info->len > 0)
+				return true;
+		}
 	}
 
 	return false;
 }
 
+static void
+npc_construct_ldata_mask_cn20k(struct npc *npc, struct plt_bitmap *bmap, uint8_t lid, uint8_t lt)
+{
+	struct npc_xtract_info *x_info;
+	int hdr_off, keylen;
+	int i, j;
+
+	for (i = 0; i < NPC_MAX_EXTRACTOR; i++) {
+		union npc_kex_ldata_flags_cfg *lid_conf = &npc->lid_cfg[NIX_INTF_RX][i];
+
+		if (lid_conf->s.lid != lid)
+			continue;
+
+		x_info = &npc->prx_dxcfg_cn20k[NIX_INTF_RX][i][lt].xtract;
+		if (x_info->enable == 0)
+			continue;
+
+		hdr_off = x_info->hdr_off * 8;
+		keylen = x_info->len * 8;
+		for (j = hdr_off; j < (hdr_off + keylen); j++)
+			plt_bitmap_set(bmap, j);
+	}
+}
+
 static void
 npc_construct_ldata_mask(struct npc *npc, struct plt_bitmap *bmap, uint8_t lid, uint8_t lt,
 			 uint8_t ld)
@@ -220,8 +294,12 @@ npc_is_kex_enabled(struct npc *npc, uint8_t lid, uint8_t lt, int offset, int len
 		return false;
 	}
 
-	npc_construct_ldata_mask(npc, bmap, lid, lt, 0);
-	npc_construct_ldata_mask(npc, bmap, lid, lt, 1);
+	if (!roc_model_is_cn20k()) {
+		npc_construct_ldata_mask(npc, bmap, lid, lt, 0);
+		npc_construct_ldata_mask(npc, bmap, lid, lt, 1);
+	} else {
+		npc_construct_ldata_mask_cn20k(npc, bmap, lid, lt);
+	}
 
 	for (i = offset; i < (offset + len); i++) {
 		if (plt_bitmap_get(bmap, i) != 0x1) {
@@ -330,7 +408,7 @@ npc_mcam_alloc_entries(struct mbox *mbox, int ref_mcam, int *alloc_entry, int re
 		goto exit;
 	req->contig = is_conti;
 	req->count = req_count;
-	req->priority = prio;
+	req->ref_priority = prio;
 	req->ref_entry = ref_mcam;
 
 	rc = mbox_process_msg(mbox, (void *)&rsp);
@@ -349,11 +427,11 @@ npc_mcam_alloc_entries(struct mbox *mbox, int ref_mcam, int *alloc_entry, int re
 
 int
 npc_mcam_alloc_entry(struct npc *npc, struct roc_npc_flow *mcam, struct roc_npc_flow *ref_mcam,
-		     int prio, int *resp_count)
+		     uint8_t prio, int *resp_count)
 {
+	struct mbox *mbox = mbox_get(npc->mbox);
 	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
-	struct mbox *mbox = mbox_get(npc->mbox);
 	int rc = -ENOSPC;
 
 	req = mbox_alloc_msg_npc_mcam_alloc_entry(mbox);
@@ -361,16 +439,16 @@ npc_mcam_alloc_entry(struct npc *npc, struct roc_npc_flow *mcam, struct roc_npc_
 		goto exit;
 	req->contig = 1;
 	req->count = 1;
-	req->priority = prio;
-	req->ref_entry = ref_mcam->mcam_id;
-
+	req->ref_priority = prio;
+	req->ref_entry = ref_mcam ? ref_mcam->mcam_id : 0;
+	req->kw_type = mcam->key_type;
 	rc = mbox_process_msg(mbox, (void *)&rsp);
 	if (rc)
 		goto exit;
-	memset(mcam, 0, sizeof(struct roc_npc_flow));
 	mcam->mcam_id = rsp->entry;
-	mcam->nix_intf = ref_mcam->nix_intf;
+	mcam->nix_intf = ref_mcam ? ref_mcam->nix_intf : 0;
 	*resp_count = rsp->count;
+
 	rc = 0;
 exit:
 	mbox_put(mbox);
@@ -403,6 +481,7 @@ int
 npc_mcam_write_entry(struct mbox *mbox, struct roc_npc_flow *mcam)
 {
 	struct npc_mcam_write_entry_req *req;
+	struct npc_cn20k_mcam_write_entry_req *cn20k_req;
 	struct mbox_msghdr *rsp;
 	int rc = -ENOSPC;
 	uint16_t ctr = 0;
@@ -419,33 +498,121 @@ npc_mcam_write_entry(struct mbox *mbox, struct roc_npc_flow *mcam)
 			return rc;
 	}
 
-	req = mbox_alloc_msg_npc_mcam_write_entry(mbox_get(mbox));
-	if (req == NULL) {
-		mbox_put(mbox);
+	if (roc_model_is_cn20k()) {
+		cn20k_req = mbox_alloc_msg_npc_cn20k_mcam_write_entry(mbox_get(mbox));
+		if (cn20k_req == NULL) {
+			mbox_put(mbox);
+			if (mcam->use_ctr)
+				npc_mcam_free_counter(mbox, ctr);
+
+			return rc;
+		}
+		cn20k_req->entry = mcam->mcam_id;
+		cn20k_req->intf = mcam->nix_intf;
+		cn20k_req->enable_entry = mcam->enable;
+		cn20k_req->entry_data.action = mcam->npc_action;
+		cn20k_req->entry_data.vtag_action = mcam->vtag_action;
+		cn20k_req->hw_prio = mcam->priority;
 		if (mcam->use_ctr)
-			npc_mcam_free_counter(mbox, ctr);
+			cn20k_req->cntr = mcam->ctr_id;
 
-		return rc;
-	}
-	req->entry = mcam->mcam_id;
-	req->intf = mcam->nix_intf;
-	req->enable_entry = mcam->enable;
-	req->entry_data.action = mcam->npc_action;
-	req->entry_data.vtag_action = mcam->vtag_action;
-	if (mcam->use_ctr) {
-		req->set_cntr = 1;
-		req->cntr = mcam->ctr_id;
-	}
+		for (i = 0; i < NPC_MCAM_KEY_X4_WORDS; i++) {
+			cn20k_req->entry_data.kw[i] = mcam->mcam_data[i];
+			cn20k_req->entry_data.kw_mask[i] = mcam->mcam_mask[i];
+		}
+	} else {
+		req = mbox_alloc_msg_npc_mcam_write_entry(mbox_get(mbox));
+		if (req == NULL) {
+			mbox_put(mbox);
+			if (mcam->use_ctr)
+				npc_mcam_free_counter(mbox, ctr);
 
-	for (i = 0; i < NPC_MCAM_KEY_X4_WORDS; i++) {
-		req->entry_data.kw[i] = mcam->mcam_data[i];
-		req->entry_data.kw_mask[i] = mcam->mcam_mask[i];
+			return rc;
+		}
+		req->entry = mcam->mcam_id;
+		req->intf = mcam->nix_intf;
+		req->enable_entry = mcam->enable;
+		req->entry_data.action = mcam->npc_action;
+		req->entry_data.vtag_action = mcam->vtag_action;
+		if (mcam->use_ctr) {
+			req->set_cntr = 1;
+			req->cntr = mcam->ctr_id;
+		}
+
+		for (i = 0; i < NPC_MCAM_KEY_X4_WORDS; i++) {
+			req->entry_data.kw[i] = mcam->mcam_data[i];
+			req->entry_data.kw_mask[i] = mcam->mcam_mask[i];
+		}
 	}
 	rc = mbox_process_msg(mbox, (void *)&rsp);
 	mbox_put(mbox);
 	return rc;
 }
 
+static void
+npc_mcam_kex_cfg_dump(struct npc_cn20k_get_kex_cfg_rsp *kex_rsp)
+{
+	for (int i = 0; i < NPC_MAX_INTF; i++) {
+		for (int j = 0; j < NPC_MAX_EXTRACTOR; j++) {
+			if (kex_rsp->intf_extr[i][j] == 0)
+				continue;
+			plt_info("Intf %d, Extr %d: 0x%" PRIx64, i, j, kex_rsp->intf_extr[i][j]);
+		}
+	}
+
+	for (int i = 0; i < NPC_MAX_INTF; i++) {
+		for (int j = 0; j < NPC_MAX_EXTRACTOR; j++) {
+			for (int k = 0; k < NPC_MAX_LT; k++) {
+				if (kex_rsp->intf_extr_lt[i][j][k] == 0)
+					continue;
+				plt_info("Intf %d, Extr %d, LT %d: 0x%" PRIx64, i, j, k,
+					 kex_rsp->intf_extr_lt[i][j][k]);
+			}
+		}
+	}
+}
+
+static void
+npc_mcam_process_mkex_cfg_cn20k(struct npc *npc, struct npc_cn20k_get_kex_cfg_rsp *kex_rsp)
+{
+	volatile uint64_t(*q)[NPC_MAX_INTF][NPC_MAX_EXTRACTOR][NPC_MAX_LT];
+	volatile uint64_t(*d)[NPC_MAX_INTF][NPC_MAX_EXTRACTOR];
+	struct npc_xtract_info *x_info = NULL;
+	union npc_kex_ldata_flags_cfg *ld_info = NULL;
+	int ex, lt, ix;
+	npc_dxcfg_cn20k_t *p;
+	npc_lid_cn20k_t *l;
+	uint64_t keyw;
+	uint64_t val;
+
+	npc->keyx_supp_nmask[NPC_MCAM_RX] = kex_rsp->rx_keyx_cfg & 0x7fffffffULL;
+	npc->keyx_supp_nmask[NPC_MCAM_TX] = kex_rsp->tx_keyx_cfg & 0x7fffffffULL;
+	npc->keyx_len[NPC_MCAM_RX] = npc_supp_key_len(npc->keyx_supp_nmask[NPC_MCAM_RX]);
+	npc->keyx_len[NPC_MCAM_TX] = npc_supp_key_len(npc->keyx_supp_nmask[NPC_MCAM_TX]);
+
+	keyw = (kex_rsp->rx_keyx_cfg >> 32) & 0x7ULL;
+	npc->keyw[NPC_MCAM_RX] = keyw;
+	keyw = (kex_rsp->tx_keyx_cfg >> 32) & 0x7ULL;
+	npc->keyw[NPC_MCAM_TX] = keyw;
+
+	p = &npc->prx_dxcfg_cn20k;
+	l = &npc->lid_cfg;
+	q = (volatile uint64_t(*)[][NPC_MAX_EXTRACTOR][NPC_MAX_LT])(&kex_rsp->intf_extr_lt);
+	d = (volatile uint64_t(*)[][NPC_MAX_EXTRACTOR])(&kex_rsp->intf_extr);
+	for (ix = 0; ix < NPC_MAX_INTF; ix++) {
+		for (ex = 0; ex < NPC_MAX_EXTRACTOR; ex++) {
+			val = (*d)[ix][ex];
+			ld_info = &(*l)[ix][ex];
+			ld_info->s.lid = (val & 0x7);
+			for (lt = 0; lt < NPC_MAX_LT; lt++) {
+				x_info = &(*p)[ix][ex][lt].xtract;
+				val = (*q)[ix][ex][lt];
+				npc_update_kex_info(x_info, val);
+			}
+		}
+	}
+}
+
 static void
 npc_mcam_process_mkex_cfg(struct npc *npc, struct npc_get_kex_cfg_rsp *kex_rsp)
 {
@@ -522,20 +689,38 @@ int
 npc_mcam_fetch_kex_cfg(struct npc *npc)
 {
 	struct npc_get_kex_cfg_rsp *kex_rsp;
+	struct npc_cn20k_get_kex_cfg_rsp *kex_rsp_20k;
 	struct mbox *mbox = mbox_get(npc->mbox);
 	int rc = 0;
 
-	mbox_alloc_msg_npc_get_kex_cfg(mbox);
-	rc = mbox_process_msg(mbox, (void *)&kex_rsp);
-	if (rc) {
-		plt_err("Failed to fetch NPC KEX config");
-		goto done;
-	}
 
-	mbox_memcpy((char *)npc->profile_name, kex_rsp->mkex_pfl_name, MKEX_NAME_LEN);
+	if (!roc_model_is_cn20k()) {
+		mbox_alloc_msg_npc_get_kex_cfg(mbox);
+		rc = mbox_process_msg(mbox, (void *)&kex_rsp);
+		if (rc) {
+			plt_err("Failed to fetch NPC KEX config");
+			goto done;
+		}
 
-	npc->exact_match_ena = (kex_rsp->rx_keyx_cfg >> 40) & 0xF;
-	npc_mcam_process_mkex_cfg(npc, kex_rsp);
+		mbox_memcpy((char *)npc->profile_name, kex_rsp->mkex_pfl_name, MKEX_NAME_LEN);
+
+		npc->exact_match_ena = (kex_rsp->rx_keyx_cfg >> 40) & 0xF;
+		npc_mcam_process_mkex_cfg(npc, kex_rsp);
+	} else {
+		mbox_alloc_msg_npc_cn20k_get_kex_cfg(mbox);
+		rc = mbox_process_msg(mbox, (void *)&kex_rsp_20k);
+		if (rc) {
+			plt_err("Failed to fetch NPC KEX config");
+			goto done;
+		}
+
+		mbox_memcpy((char *)npc->profile_name, kex_rsp_20k->mkex_pfl_name, MKEX_NAME_LEN);
+
+		npc->exact_match_ena = (kex_rsp_20k->rx_keyx_cfg >> 40) & 0xF;
+		npc_mcam_process_mkex_cfg_cn20k(npc, kex_rsp_20k);
+		if (npc->enable_debug)
+			npc_mcam_kex_cfg_dump(kex_rsp_20k);
+	}
 
 done:
 	mbox_put(mbox);
@@ -543,7 +728,7 @@ npc_mcam_fetch_kex_cfg(struct npc *npc)
 }
 
 static void
-npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_mcam_write_entry_req *req,
+npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_cn20k_mcam_write_entry_req *req,
 		     uint16_t channel, uint16_t chan_mask, bool is_second_pass)
 {
 	uint16_t chan = 0, mask = 0;
@@ -552,6 +737,7 @@ npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_mcam_write_entry_req
 	req->entry_data.kw_mask[0] &= ~(GENMASK(11, 0));
 	flow->mcam_data[0] &= ~(GENMASK(11, 0));
 	flow->mcam_mask[0] &= ~(GENMASK(11, 0));
+
 	chan = channel;
 	mask = chan_mask;
 
@@ -579,11 +765,12 @@ npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_mcam_write_entry_req
 	flow->mcam_mask[0] |= (uint64_t)mask;
 }
 
+#define NPC_PF_FUNC_WIDTH    2
+#define NPC_KEX_PF_FUNC_MASK 0xFFFF
+
 static int
 npc_mcam_set_pf_func(struct npc *npc, struct roc_npc_flow *flow, uint16_t pf_func)
 {
-#define NPC_PF_FUNC_WIDTH    2
-#define NPC_KEX_PF_FUNC_MASK 0xFFFF
 	uint16_t nr_bytes, hdr_offset, key_offset, pf_func_offset;
 	uint8_t *flow_mcam_data, *flow_mcam_mask;
 	struct npc_lid_lt_xtract_info *xinfo;
@@ -618,10 +805,48 @@ npc_mcam_set_pf_func(struct npc *npc, struct roc_npc_flow *flow, uint16_t pf_fun
 	return 0;
 }
 
+static int
+npc_mcam_set_pf_func_cn20k(struct npc *npc, struct roc_npc_flow *flow, uint16_t pf_func)
+{
+	uint16_t nr_bytes, hdr_offset, key_offset, pf_func_offset;
+	struct npc_lid_lt_xtract_info_cn20k *xinfo;
+	uint8_t *flow_mcam_data, *flow_mcam_mask;
+	bool pffunc_found = false;
+	uint16_t mask = 0xFFFF;
+	int i;
+
+	flow_mcam_data = (uint8_t *)flow->mcam_data;
+	flow_mcam_mask = (uint8_t *)flow->mcam_mask;
+
+	xinfo = npc->prx_dxcfg_cn20k[NIX_INTF_TX][NPC_LID_LA];
+
+	for (i = 0; i < NPC_MAX_LT; i++) {
+		nr_bytes = xinfo[i].xtract.len;
+		hdr_offset = xinfo[i].xtract.hdr_off;
+		key_offset = xinfo[i].xtract.key_off;
+
+		if (hdr_offset > 0 || nr_bytes < NPC_PF_FUNC_WIDTH)
+			continue;
+		else
+			pffunc_found = true;
+
+		pf_func_offset = key_offset + nr_bytes - NPC_PF_FUNC_WIDTH;
+		memcpy((void *)&flow_mcam_data[pf_func_offset], (uint8_t *)&pf_func,
+		       NPC_PF_FUNC_WIDTH);
+		memcpy((void *)&flow_mcam_mask[pf_func_offset], (uint8_t *)&mask,
+		       NPC_PF_FUNC_WIDTH);
+	}
+	if (!pffunc_found)
+		return -EINVAL;
+
+	return 0;
+}
+
 int
 npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_parse_state *pst)
 {
-	struct npc_mcam_write_entry_req *req;
+	struct npc_cn20k_mcam_write_entry_req *cn20k_req;
+	struct npc_cn20k_mcam_write_entry_req req;
 	struct nix_inl_dev *inl_dev = NULL;
 	struct mbox *mbox = npc->mbox;
 	struct mbox_msghdr *rsp;
@@ -655,6 +880,12 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 			return rc;
 	}
 
+	if (roc_model_is_cn20k()) {
+		req.hw_prio = flow->priority;
+		flow->key_type = npc_get_key_type(npc, flow);
+		req.req_kw_type = flow->key_type;
+	}
+
 	if (flow->nix_intf == NIX_INTF_RX && flow->is_inline_dev && inl_dev &&
 	    inl_dev->ipsec_index && inl_dev->is_multi_channel) {
 		if (inl_dev->curr_ipsec_idx >= inl_dev->alloc_ipsec_rules)
@@ -672,14 +903,17 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 	}
 
 	if (flow->nix_intf == NIX_INTF_TX) {
-		uint16_t pf_func = flow->tx_pf_func;
+		uint16_t pffunc = flow->tx_pf_func;
 
 		if (flow->has_rep)
-			pf_func = flow->rep_pf_func;
+			pffunc = flow->rep_pf_func;
 
-		pf_func = plt_cpu_to_be_16(pf_func);
+		pffunc = plt_cpu_to_be_16(pffunc);
 
-		rc = npc_mcam_set_pf_func(npc, flow, pf_func);
+		if (roc_model_is_cn20k())
+			rc = npc_mcam_set_pf_func_cn20k(npc, flow, pffunc);
+		else
+			rc = npc_mcam_set_pf_func(npc, flow, pffunc);
 		if (rc)
 			return rc;
 	}
@@ -708,20 +942,14 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 		}
 	}
 
-	req = mbox_alloc_msg_npc_mcam_write_entry(mbox_get(mbox));
-	if (req == NULL) {
-		rc = -ENOSPC;
-		goto exit;
-	}
-	req->set_cntr = flow->use_ctr;
-	req->cntr = flow->ctr_id;
-	req->entry = entry;
+	req.cntr = flow->ctr_id;
+	req.entry = entry;
 
-	req->intf = (flow->nix_intf == NIX_INTF_RX) ? NPC_MCAM_RX : NPC_MCAM_TX;
-	req->enable_entry = 1;
+	req.intf = (flow->nix_intf == NIX_INTF_RX) ? NPC_MCAM_RX : NPC_MCAM_TX;
+	req.enable_entry = 1;
 	if (flow->nix_intf == NIX_INTF_RX)
 		flow->npc_action |= (uint64_t)flow->recv_queue << 20;
-	req->entry_data.action = flow->npc_action;
+	req.entry_data.action = flow->npc_action;
 
 	/*
 	 * Driver sets vtag action on per interface basis, not
@@ -735,38 +963,38 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 	 *
 	 * Second approach is used now.
 	 */
-	req->entry_data.vtag_action = flow->vtag_action;
+	req.entry_data.vtag_action = flow->vtag_action;
 
 	for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
-		req->entry_data.kw[idx] = flow->mcam_data[idx];
-		req->entry_data.kw_mask[idx] = flow->mcam_mask[idx];
+		req.entry_data.kw[idx] = flow->mcam_data[idx];
+		req.entry_data.kw_mask[idx] = flow->mcam_mask[idx];
 	}
 
 	if (flow->nix_intf == NIX_INTF_RX) {
 		if (inl_dev && inl_dev->is_multi_channel &&
 		    (flow->npc_action & NIX_RX_ACTIONOP_UCAST_IPSEC)) {
 			pf_func = nix_inl_dev_pffunc_get();
-			req->entry_data.action &= ~(GENMASK(19, 4));
-			req->entry_data.action |= (uint64_t)pf_func << 4;
+			req.entry_data.action &= ~(GENMASK(19, 4));
+			req.entry_data.action |= (uint64_t)pf_func << 4;
 			flow->npc_action &= ~(GENMASK(19, 4));
 			flow->npc_action |= (uint64_t)pf_func << 4;
 
-			npc_mcam_set_channel(flow, req, inl_dev->channel, inl_dev->chan_mask,
+			npc_mcam_set_channel(flow, &req, inl_dev->channel, inl_dev->chan_mask,
 					     false);
 		} else if (flow->has_rep) {
 			pf_func = (flow->rep_act_pf_func == 0) ? flow->rep_pf_func :
 								 flow->rep_act_pf_func;
-			req->entry_data.action &= ~(GENMASK(19, 4));
-			req->entry_data.action |= (uint64_t)pf_func << 4;
+			req.entry_data.action &= ~(GENMASK(19, 4));
+			req.entry_data.action |= (uint64_t)pf_func << 4;
 			flow->npc_action &= ~(GENMASK(19, 4));
 			flow->npc_action |= (uint64_t)pf_func << 4;
-			npc_mcam_set_channel(flow, req, flow->rep_channel, (BIT_ULL(12) - 1),
+			npc_mcam_set_channel(flow, &req, flow->rep_channel, (BIT_ULL(12) - 1),
 					     false);
 		} else if (npc->is_sdp_link) {
-			npc_mcam_set_channel(flow, req, npc->sdp_channel, npc->sdp_channel_mask,
+			npc_mcam_set_channel(flow, &req, npc->sdp_channel, npc->sdp_channel_mask,
 					     pst->is_second_pass_rule);
 		} else {
-			npc_mcam_set_channel(flow, req, npc->channel, (BIT_ULL(12) - 1),
+			npc_mcam_set_channel(flow, &req, npc->channel, (BIT_ULL(12) - 1),
 					     pst->is_second_pass_rule);
 		}
 		/*
@@ -779,25 +1007,66 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 			la_offset *= 4;
 
 			mask = ~((0xfULL << la_offset));
-			req->entry_data.kw[0] &= mask;
-			req->entry_data.kw_mask[0] &= mask;
+			req.entry_data.kw[0] &= mask;
+			req.entry_data.kw_mask[0] &= mask;
 			flow->mcam_data[0] &= mask;
 			flow->mcam_mask[0] &= mask;
 			if (pst->is_second_pass_rule) {
-				req->entry_data.kw[0] |= ((uint64_t)NPC_LT_LA_CPT_HDR) << la_offset;
-				req->entry_data.kw_mask[0] |= (0xFULL << la_offset);
+				req.entry_data.kw[0] |= ((uint64_t)NPC_LT_LA_CPT_HDR) << la_offset;
+				req.entry_data.kw_mask[0] |= (0xFULL << la_offset);
 				flow->mcam_data[0] |= ((uint64_t)NPC_LT_LA_CPT_HDR) << la_offset;
 				flow->mcam_mask[0] |= (0xFULL << la_offset);
 			} else {
 				/* Mask ltype ETHER (0x2) and CPT_HDR (0xa)  */
-				req->entry_data.kw[0] |= (0x2ULL << la_offset);
-				req->entry_data.kw_mask[0] |= (0x7ULL << la_offset);
+				req.entry_data.kw[0] |= (0x2ULL << la_offset);
+				req.entry_data.kw_mask[0] |= (0x7ULL << la_offset);
 				flow->mcam_data[0] |= (0x2ULL << la_offset);
 				flow->mcam_mask[0] |= (0x7ULL << la_offset);
 			}
 		}
 	}
 
+	if (roc_model_is_cn20k()) {
+		cn20k_req = mbox_alloc_msg_npc_cn20k_mcam_write_entry(mbox_get(mbox));
+		if (cn20k_req == NULL) {
+			mbox_put(mbox);
+			if (flow->use_ctr)
+				npc_mcam_free_counter(mbox, ctr);
+
+			return rc;
+		}
+		cn20k_req->entry = req.entry;
+		cn20k_req->intf = req.intf;
+		cn20k_req->enable_entry = req.enable_entry;
+		cn20k_req->entry_data.action = req.entry_data.action;
+		cn20k_req->entry_data.vtag_action = req.entry_data.vtag_action;
+		cn20k_req->hw_prio = req.hw_prio;
+		cn20k_req->req_kw_type = req.req_kw_type;
+		if (flow->use_ctr)
+			cn20k_req->cntr = req.cntr;
+
+		mbox_memcpy(&cn20k_req->entry_data, &req.entry_data,
+			    sizeof(struct cn20k_mcam_entry));
+	} else {
+		struct npc_mcam_write_entry_req *req_leg;
+
+		req_leg = mbox_alloc_msg_npc_mcam_write_entry(mbox_get(mbox));
+		if (req_leg == NULL) {
+			rc = -ENOSPC;
+			goto exit;
+		}
+		for (idx = 0; idx < NPC_MAX_KWS_IN_KEY; idx++) {
+			req_leg->entry_data.kw[idx] = req.entry_data.kw[idx];
+			req_leg->entry_data.kw_mask[idx] = req.entry_data.kw_mask[idx];
+		}
+		req_leg->entry = req.entry;
+		req_leg->intf = req.intf;
+		req_leg->enable_entry = req.enable_entry;
+		req_leg->cntr = req.cntr;
+		req_leg->entry_data.action = req.entry_data.action;
+		req_leg->entry_data.vtag_action = req.entry_data.vtag_action;
+		req_leg->set_cntr = flow->use_ctr;
+	}
 	rc = mbox_process_msg(mbox, (void *)&rsp);
 	if (rc != 0)
 		goto exit;
@@ -810,7 +1079,7 @@ npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow, struct npc_
 
 exit:
 	mbox_put(mbox);
-	if (rc)
+	if (rc && flow->is_sampling_rule)
 		roc_nix_mcast_list_free(npc->mbox, flow->mcast_grp_index);
 	return rc;
 }
@@ -821,9 +1090,14 @@ npc_set_vlan_ltype(struct npc_parse_state *pst)
 	uint64_t val, mask;
 	uint8_t lb_offset;
 
-	lb_offset =
-		plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
-				   ((1ULL << NPC_LTYPE_LB_OFFSET) - 1));
+	if (roc_model_is_cn20k()) {
+		lb_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
+					   ((1ULL << NPC_CN20K_LTYPE_LB_OFFSET) - 1));
+
+	} else {
+		lb_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
+					   ((1ULL << NPC_LTYPE_LB_OFFSET) - 1));
+	}
 	lb_offset *= 4;
 
 	mask = ~((0xfULL << lb_offset));
@@ -843,9 +1117,14 @@ npc_set_ipv6ext_ltype_mask(struct npc_parse_state *pst)
 	uint8_t lc_offset, lcflag_offset;
 	uint64_t val, mask;
 
-	lc_offset =
-		plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
-				   ((1ULL << NPC_LTYPE_LC_OFFSET) - 1));
+	if (roc_model_is_cn20k()) {
+		lc_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
+					   ((1ULL << NPC_CN20K_LTYPE_LC_OFFSET) - 1));
+
+	} else {
+		lc_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
+					   ((1ULL << NPC_LTYPE_LC_OFFSET) - 1));
+	}
 	lc_offset *= 4;
 
 	mask = ~((0xfULL << lc_offset));
@@ -867,8 +1146,14 @@ npc_set_ipv6ext_ltype_mask(struct npc_parse_state *pst)
 	 * zero in LFLAG.
 	 */
 	if (pst->npc->keyx_supp_nmask[pst->nix_intf] & (1ULL << NPC_LFLAG_LC_OFFSET)) {
-		lcflag_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
-					       ((1ULL << NPC_LFLAG_LC_OFFSET) - 1));
+		if (roc_model_is_cn20k()) {
+			lcflag_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
+						       ((1ULL << NPC_CN20K_LFLAG_LC_OFFSET) - 1));
+
+		} else {
+			lcflag_offset = plt_popcount32(pst->npc->keyx_supp_nmask[pst->nix_intf] &
+						       ((1ULL << NPC_LFLAG_LC_OFFSET) - 1));
+		}
 		lcflag_offset *= 4;
 
 		mask = (0xfULL << lcflag_offset);
@@ -881,14 +1166,12 @@ npc_set_ipv6ext_ltype_mask(struct npc_parse_state *pst)
 int
 npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 {
-	struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
 	/* This is non-LDATA part in search key */
 	uint64_t key_data[2] = {0ULL, 0ULL};
 	uint64_t key_mask[2] = {0ULL, 0ULL};
 	int key_len, bit = 0, index, rc = 0;
 	struct nix_inl_dev *inl_dev = NULL;
 	int intf = pst->flow->nix_intf;
-	struct mcam_entry *base_entry;
 	bool skip_base_rule = false;
 	int off, idx, data_off = 0;
 	uint8_t lid, mask, data;
@@ -908,40 +1191,79 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 	data_off *= 4;
 
 	index = 0;
-	for (lid = 0; lid < NPC_MAX_LID; lid++) {
-		/* Offset in key */
-		off = NPC_PARSE_KEX_S_LID_OFFSET(lid);
-		lt = pst->lt[lid] & 0xf;
-		flags = pst->flags[lid] & 0xff;
+	if (!roc_model_is_cn20k()) {
+		for (lid = 0; lid < NPC_MAX_LID; lid++) {
+			/* Offset in key */
+			off = NPC_PARSE_KEX_S_LID_OFFSET(lid);
+			lt = pst->lt[lid] & 0xf;
+			flags = pst->flags[lid] & 0xff;
 
-		/* NPC_LAYER_KEX_S */
-		layer_info = ((npc->keyx_supp_nmask[intf] >> off) & 0x7);
+			/* NPC_LAYER_KEX_S */
+			layer_info = ((npc->keyx_supp_nmask[intf] >> off) & 0x7);
+			if (!layer_info)
+				continue;
 
-		if (layer_info) {
 			for (idx = 0; idx <= 2; idx++) {
-				if (layer_info & (1 << idx)) {
-					if (idx == 2) {
-						data = lt;
-						mask = 0xf;
-					} else if (idx == 1) {
-						data = ((flags >> 4) & 0xf);
-						mask = ((flags >> 4) & 0xf);
-					} else {
-						data = (flags & 0xf);
-						mask = (flags & 0xf);
-					}
-
-					if (data_off >= 64) {
-						data_off = 0;
-						index++;
-					}
-					key_data[index] |= ((uint64_t)data << data_off);
-
-					if (lt == 0)
-						mask = 0;
-					key_mask[index] |= ((uint64_t)mask << data_off);
-					data_off += 4;
+				if (!(layer_info & (1 << idx)))
+					continue;
+
+				if (idx == 2) {
+					data = lt;
+					mask = 0xf;
+				} else if (idx == 1) {
+					data = ((flags >> 4) & 0xf);
+					mask = ((flags >> 4) & 0xf);
+				} else {
+					data = (flags & 0xf);
+					mask = (flags & 0xf);
+				}
+
+				if (data_off >= 64) {
+					data_off = 0;
+					index++;
 				}
+				key_data[index] |= ((uint64_t)data << data_off);
+
+				if (lt == 0)
+					mask = 0;
+				key_mask[index] |= ((uint64_t)mask << data_off);
+				data_off += 4;
+			}
+		}
+	} else {
+		for (lid = 0; lid < NPC_MAX_LID; lid++) {
+			/* Offset in key */
+			off = NPC_PARSE_KEX_S_LID_OFFSET_CN20K(lid);
+			lt = pst->lt[lid] & 0xf;
+			flags = pst->flags[lid] & 0xf;
+
+			/* NPC_LAYER_KEX_S */
+			layer_info = ((npc->keyx_supp_nmask[intf] >> off) & 0x3);
+			if (!layer_info)
+				continue;
+
+			for (idx = 0; idx <= 1; idx++) {
+				if (!(layer_info & (1 << idx)))
+					continue;
+
+				if (idx == 1) {
+					data = lt;
+					mask = 0xf;
+				} else {
+					data = (flags & 0xf);
+					mask = (flags & 0xf);
+				}
+
+				if (data_off >= 64) {
+					data_off = 0;
+					index++;
+				}
+				key_data[index] |= ((uint64_t)data << data_off);
+
+				if (lt == 0)
+					mask = 0;
+				key_mask[index] |= ((uint64_t)mask << data_off);
+				data_off += 4;
 			}
 		}
 	}
@@ -971,17 +1293,39 @@ npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc)
 		else
 			mbox = mbox_get(npc->mbox);
 		(void)mbox_alloc_msg_npc_read_base_steer_rule(mbox);
-		rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
-		if (rc) {
+		if (roc_model_is_cn20k()) {
+			struct npc_cn20k_mcam_read_base_rule_rsp *base_rule_rsp;
+			struct cn20k_mcam_entry *base_entry;
+
+			rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
+			if (rc) {
+				mbox_put(mbox);
+				plt_err("Failed to fetch VF's base MCAM entry");
+				return rc;
+			}
 			mbox_put(mbox);
-			plt_err("Failed to fetch VF's base MCAM entry");
-			return rc;
-		}
-		mbox_put(mbox);
-		base_entry = &base_rule_rsp->entry_data;
-		for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
-			pst->flow->mcam_data[idx] |= base_entry->kw[idx];
-			pst->flow->mcam_mask[idx] |= base_entry->kw_mask[idx];
+			base_entry = &base_rule_rsp->entry;
+			for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
+				pst->flow->mcam_data[idx] |= base_entry->kw[idx];
+				pst->flow->mcam_mask[idx] |= base_entry->kw_mask[idx];
+			}
+
+		} else {
+			struct npc_mcam_read_base_rule_rsp *base_rule_rsp;
+			struct mcam_entry *base_entry;
+
+			rc = mbox_process_msg(mbox, (void *)&base_rule_rsp);
+			if (rc) {
+				mbox_put(mbox);
+				plt_err("Failed to fetch VF's base MCAM entry");
+				return rc;
+			}
+			mbox_put(mbox);
+			base_entry = &base_rule_rsp->entry_data;
+			for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
+				pst->flow->mcam_data[idx] |= base_entry->kw[idx];
+				pst->flow->mcam_mask[idx] |= base_entry->kw_mask[idx];
+			}
 		}
 	}
 
diff --git a/drivers/common/cnxk/roc_npc_mcam_dump.c b/drivers/common/cnxk/roc_npc_mcam_dump.c
index 27a63cc92d..fa2fd0d344 100644
--- a/drivers/common/cnxk/roc_npc_mcam_dump.c
+++ b/drivers/common/cnxk/roc_npc_mcam_dump.c
@@ -35,6 +35,33 @@
 #define NIX_TX_VTAGACT_VTAG1_OP_MASK	 GENMASK(45, 44)
 #define NIX_TX_VTAGACT_VTAG1_DEF_MASK	 GENMASK(57, 48)
 
+union npc_rx_parse_nibble_cn20k_u {
+	struct __plt_packed_begin {
+		uint64_t chan : 3;
+		uint64_t errlev : 1;
+		uint64_t errcode : 2;
+		uint64_t l2l3bm : 1;
+		uint64_t laflags : 1;
+		uint64_t latype : 1;
+		uint64_t lbflags : 1;
+		uint64_t lbtype : 1;
+		uint64_t lcflags : 1;
+		uint64_t lctype : 1;
+		uint64_t ldflags : 1;
+		uint64_t ldtype : 1;
+		uint64_t leflags : 1;
+		uint64_t letype : 1;
+		uint64_t lfflags : 1;
+		uint64_t lftype : 1;
+		uint64_t lgflags : 1;
+		uint64_t lgtype : 1;
+		uint64_t lhflags : 1;
+		uint64_t lhtype : 1;
+		uint64_t reserved : 41;
+	} s __plt_packed_end;
+	uint64_t u;
+};
+
 struct __plt_packed_begin npc_rx_parse_nibble_s {
 	uint16_t chan : 3;
 	uint16_t errlev : 1;
@@ -181,8 +208,135 @@ npc_get_nibbles(struct roc_npc_flow *flow, uint16_t size, uint32_t bit_offset)
 }
 
 static void
-npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
-			     uint64_t parse_nibbles)
+npc_flow_print_parse_nibbles_cn20k(FILE *file, struct roc_npc_flow *flow, uint64_t parse_nibbles)
+{
+	union npc_rx_parse_nibble_cn20k_u rx_parse;
+	uint32_t data, offset = 0;
+
+	rx_parse.u = parse_nibbles;
+
+	if (rx_parse.s.chan) {
+		data = npc_get_nibbles(flow, 3, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_CHAN:%#03X\n", data);
+		offset += 12;
+	}
+
+	if (rx_parse.s.errlev) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_ERRLEV:%#X\n", data);
+		offset += 4;
+	}
+
+	if (rx_parse.s.errcode) {
+		data = npc_get_nibbles(flow, 2, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_ERRCODE:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.l2l3bm) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_L2L3_BCAST:%#X\n", data);
+		offset += 4;
+	}
+
+	if (rx_parse.s.laflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LA_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.latype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LA_LTYPE:%s\n", ltype_str[NPC_LID_LA][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.lbflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LB_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.lbtype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LB_LTYPE:%s\n", ltype_str[NPC_LID_LB][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.lcflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LC_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.lctype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LC_LTYPE:%s\n", ltype_str[NPC_LID_LC][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.ldflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LD_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.ldtype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LD_LTYPE:%s\n", ltype_str[NPC_LID_LD][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.leflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LE_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.letype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LE_LTYPE:%s\n", ltype_str[NPC_LID_LE][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.lfflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LF_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.lftype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LF_LTYPE:%s\n", ltype_str[NPC_LID_LF][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.lgflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LG_FLAGS:%#02X\n", data);
+		offset += 8;
+	}
+
+	if (rx_parse.s.lgtype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LG_LTYPE:%s\n", ltype_str[NPC_LID_LG][data]);
+		offset += 4;
+	}
+
+	if (rx_parse.s.lhflags) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LH_FLAGS:%#02X\n", data);
+	}
+
+	if (rx_parse.s.lhtype) {
+		data = npc_get_nibbles(flow, 1, offset);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LH_LTYPE:%s\n", ltype_str[NPC_LID_LH][data]);
+		offset += 4;
+	}
+}
+
+static void
+npc_flow_print_parse_nibbles_legacy(FILE *file, struct roc_npc_flow *flow, uint64_t parse_nibbles)
 {
 	struct npc_rx_parse_nibble_s *rx_parse;
 	uint32_t data, offset = 0;
@@ -221,8 +375,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->latype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LA_LTYPE:%s\n",
-			ltype_str[NPC_LID_LA][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LA_LTYPE:%s\n", ltype_str[NPC_LID_LA][data]);
 		offset += 4;
 	}
 
@@ -234,8 +387,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->lbtype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LB_LTYPE:%s\n",
-			ltype_str[NPC_LID_LB][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LB_LTYPE:%s\n", ltype_str[NPC_LID_LB][data]);
 		offset += 4;
 	}
 
@@ -247,8 +399,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->lctype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LC_LTYPE:%s\n",
-			ltype_str[NPC_LID_LC][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LC_LTYPE:%s\n", ltype_str[NPC_LID_LC][data]);
 		offset += 4;
 	}
 
@@ -260,8 +411,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->ldtype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LD_LTYPE:%s\n",
-			ltype_str[NPC_LID_LD][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LD_LTYPE:%s\n", ltype_str[NPC_LID_LD][data]);
 		offset += 4;
 	}
 
@@ -273,8 +423,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->letype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LE_LTYPE:%s\n",
-			ltype_str[NPC_LID_LE][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LE_LTYPE:%s\n", ltype_str[NPC_LID_LE][data]);
 		offset += 4;
 	}
 
@@ -286,8 +435,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->lftype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LF_LTYPE:%s\n",
-			ltype_str[NPC_LID_LF][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LF_LTYPE:%s\n", ltype_str[NPC_LID_LF][data]);
 		offset += 4;
 	}
 
@@ -299,8 +447,7 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->lgtype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LG_LTYPE:%s\n",
-			ltype_str[NPC_LID_LG][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LG_LTYPE:%s\n", ltype_str[NPC_LID_LG][data]);
 		offset += 4;
 	}
 
@@ -311,15 +458,14 @@ npc_flow_print_parse_nibbles(FILE *file, struct roc_npc_flow *flow,
 
 	if (rx_parse->lhtype) {
 		data = npc_get_nibbles(flow, 1, offset);
-		fprintf(file, "\tNPC_PARSE_NIBBLE_LH_LTYPE:%s\n",
-			ltype_str[NPC_LID_LH][data]);
+		fprintf(file, "\tNPC_PARSE_NIBBLE_LH_LTYPE:%s\n", ltype_str[NPC_LID_LH][data]);
 		offset += 4;
 	}
 }
 
 static void
-npc_flow_print_xtractinfo(FILE *file, struct npc_xtract_info *lfinfo,
-			  struct roc_npc_flow *flow, int lid, int lt)
+npc_flow_print_xtractinfo(FILE *file, struct npc_xtract_info *lfinfo, struct roc_npc_flow *flow,
+			  int lid, int lt)
 {
 	uint8_t *datastart, *maskstart;
 	int i;
@@ -374,6 +520,7 @@ static void
 npc_flow_dump_patterns(FILE *file, struct npc *npc, struct roc_npc_flow *flow)
 {
 	struct npc_lid_lt_xtract_info *lt_xinfo;
+	struct npc_lid_lt_xtract_info_cn20k *lt_xinfo_cn20k;
 	struct npc_xtract_info *xinfo;
 	uint32_t intf, lid, ld, i;
 	uint64_t parse_nibbles;
@@ -381,19 +528,37 @@ npc_flow_dump_patterns(FILE *file, struct npc *npc, struct roc_npc_flow *flow)
 
 	intf = flow->nix_intf;
 	parse_nibbles = npc->keyx_supp_nmask[intf];
-	npc_flow_print_parse_nibbles(file, flow, parse_nibbles);
-
-	for (i = 0; i < flow->num_patterns; i++) {
-		lid = flow->dump_data[i].lid;
-		ltype = flow->dump_data[i].ltype;
-		lt_xinfo = &npc->prx_dxcfg[intf][lid][ltype];
-
-		for (ld = 0; ld < NPC_MAX_LD; ld++) {
-			xinfo = &lt_xinfo->xtract[ld];
-			if (!xinfo->enable)
-				continue;
-			npc_flow_print_item(file, npc, xinfo, flow, intf, lid,
-					    ltype, ld);
+	if (roc_model_is_cn20k()) {
+		npc_flow_print_parse_nibbles_cn20k(file, flow, parse_nibbles);
+		for (i = 0; i < flow->num_patterns; i++) {
+			lid = flow->dump_data[i].lid;
+			ltype = flow->dump_data[i].ltype;
+			for (int j = 0; j < NPC_MAX_EXTRACTOR; j++) {
+				union npc_kex_ldata_flags_cfg *lid_info =
+					&npc->lid_cfg[NIX_INTF_RX][j];
+				if (lid_info->s.lid != lid)
+					continue;
+				lt_xinfo_cn20k = &npc->prx_dxcfg_cn20k[intf][j][ltype];
+				xinfo = &lt_xinfo_cn20k->xtract;
+				if (!xinfo->enable)
+					continue;
+				npc_flow_print_item(file, npc, xinfo, flow, intf, lid, ltype, j);
+			}
+		}
+	} else {
+		npc_flow_print_parse_nibbles_legacy(file, flow, parse_nibbles);
+
+		for (i = 0; i < flow->num_patterns; i++) {
+			lid = flow->dump_data[i].lid;
+			ltype = flow->dump_data[i].ltype;
+			lt_xinfo = &npc->prx_dxcfg[intf][lid][ltype];
+
+			for (ld = 0; ld < NPC_MAX_LD; ld++) {
+				xinfo = &lt_xinfo->xtract[ld];
+				if (!xinfo->enable)
+					continue;
+				npc_flow_print_item(file, npc, xinfo, flow, intf, lid, ltype, ld);
+			}
 		}
 	}
 }
@@ -645,7 +810,6 @@ npc_flow_hw_mcam_entry_dump(FILE *file, struct npc *npc, struct roc_npc_flow *fl
 	uint64_t mcam_data[ROC_NPC_MAX_MCAM_WIDTH_DWORDS];
 	uint64_t mcam_mask[ROC_NPC_MAX_MCAM_WIDTH_DWORDS];
 	struct npc_mcam_read_entry_req *mcam_read_req;
-	struct npc_mcam_read_entry_rsp *mcam_read_rsp;
 	struct nix_inl_dev *inl_dev = NULL;
 	struct idev_cfg *idev;
 	struct mbox *mbox;
@@ -669,17 +833,34 @@ npc_flow_hw_mcam_entry_dump(FILE *file, struct npc *npc, struct roc_npc_flow *fl
 	}
 
 	mcam_read_req->entry = flow->mcam_id;
-	rc = mbox_process_msg(mbox, (void *)&mcam_read_rsp);
-	if (rc) {
-		mbox_put(mbox);
-		plt_err("Failed to fetch MCAM entry:%d", flow->mcam_id);
-		return;
-	}
 
-	mbox_memcpy(mcam_data, mcam_read_rsp->entry_data.kw, sizeof(mcam_data));
-	mbox_memcpy(mcam_mask, mcam_read_rsp->entry_data.kw_mask, sizeof(mcam_data));
-	enabled = mcam_read_rsp->enable;
+	if (roc_model_is_cn20k()) {
+		struct npc_cn20k_mcam_read_entry_rsp *mcam_read_rsp;
+
+		rc = mbox_process_msg(mbox, (void *)&mcam_read_rsp);
+		if (rc) {
+			mbox_put(mbox);
+			plt_err("Failed to fetch MCAM entry:%d", flow->mcam_id);
+			return;
+		}
+
+		mbox_memcpy(mcam_data, mcam_read_rsp->entry_data.kw, sizeof(mcam_data));
+		mbox_memcpy(mcam_mask, mcam_read_rsp->entry_data.kw_mask, sizeof(mcam_data));
+		enabled = mcam_read_rsp->enable;
+	} else {
+		struct npc_mcam_read_entry_rsp *mcam_read_rsp;
 
+		rc = mbox_process_msg(mbox, (void *)&mcam_read_rsp);
+		if (rc) {
+			mbox_put(mbox);
+			plt_err("Failed to fetch MCAM entry:%d", flow->mcam_id);
+			return;
+		}
+
+		mbox_memcpy(mcam_data, mcam_read_rsp->entry_data.kw, sizeof(mcam_data));
+		mbox_memcpy(mcam_mask, mcam_read_rsp->entry_data.kw_mask, sizeof(mcam_data));
+		enabled = mcam_read_rsp->enable;
+	}
 	fprintf(file, "HW MCAM Data :\n");
 
 	for (i = 0; i < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; i++) {
@@ -702,14 +883,18 @@ roc_npc_flow_mcam_dump(FILE *file, struct roc_npc *roc_npc, struct roc_npc_flow
 
 	fprintf(file, "MCAM Index:%d\n", flow->mcam_id);
 	if (flow->ctr_id != NPC_COUNTER_NONE && flow->use_ctr) {
-		if (flow->use_pre_alloc)
+		if (flow->use_pre_alloc) {
 			rc = roc_npc_inl_mcam_read_counter(flow->ctr_id, &count);
-		else
-			rc = roc_npc_mcam_read_counter(roc_npc, flow->ctr_id, &count);
+		} else {
+			if (roc_model_is_cn20k())
+				rc = roc_npc_mcam_get_stats(roc_npc, flow, &count);
+			else
+				rc = roc_npc_mcam_read_counter(roc_npc, flow->ctr_id, &count);
+		}
 
 		if (rc)
 			return;
-		fprintf(file, "Hit count: %" PRIu64 "\n", count);
+		fprintf(file, "Counter_id = 0x%x, Hit count: %" PRIu64 "\n", flow->ctr_id, count);
 	}
 
 	fprintf(file, "Interface :%s (%d)\n", intf_str[flow->nix_intf], flow->nix_intf);
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index e08a34d146..b7d726caa1 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -30,6 +30,10 @@
 	((((lid) - (NPC_LID_LA)) * NPC_LAYER_KEYX_SZ) +                        \
 	 NPC_PARSE_KEX_S_LA_OFFSET)
 
+#define NPC_LAYER_KEYX_SZ_CN20K (2)
+#define NPC_PARSE_KEX_S_LID_OFFSET_CN20K(lid)                                                      \
+	((((lid) - (NPC_LID_LA)) * NPC_LAYER_KEYX_SZ_CN20K) + NPC_PARSE_KEX_S_LA_OFFSET)
+
 /* This mark value indicates flag action */
 #define NPC_FLOW_FLAG_VAL (0xffff)
 
@@ -43,7 +47,11 @@
 
 #define NPC_MCAM_KEX_FIELD_MAX	  23
 #define NPC_MCAM_MAX_PROTO_FIELDS (NPC_MCAM_KEX_FIELD_MAX + 1)
-#define NPC_MCAM_KEY_X4_WORDS	  7 /* Number of 64-bit words */
+#if defined(ROC_PLATFORM_CN20K)
+#define NPC_MCAM_KEY_X4_WORDS 8 /* Number of 64-bit words */
+#else
+#define NPC_MCAM_KEY_X4_WORDS 7 /* Number of 64-bit words */
+#endif
 
 #define NPC_RVUPF_MAX_9XXX 0x10 /* HRM: RVU_PRIV_CONST */
 #define NPC_RVUPF_MAX_98XX 0x18 /* HRM: RVU_PRIV_CONST */
@@ -77,6 +85,16 @@
 #define NPC_LFLAG_LC_OFFSET (NPC_LTYPE_OFFSET_START + 6)
 #define NPC_LTYPE_LC_OFFSET (NPC_LTYPE_OFFSET_START + 8)
 
+/* LB OFFSET : START + LA (1b flags + 1b ltype) + LB (1b flags) */
+#define NPC_CN20K_LTYPE_LB_OFFSET (NPC_LTYPE_OFFSET_START + 3)
+#define NPC_CN20K_LFLAG_LB_OFFSET (NPC_LTYPE_OFFSET_START + 2)
+
+/* LC OFFSET : START + LA (1b flags + 1b ltype) + LB (1b flags + 1b ltype) + LC
+ * (1b flags)
+ */
+#define NPC_CN20K_LFLAG_LC_OFFSET (NPC_LTYPE_OFFSET_START + 4)
+#define NPC_CN20K_LTYPE_LC_OFFSET (NPC_LTYPE_OFFSET_START + 5)
+
 #define CN10K_SDP_CH_START 0x80
 #define CN10K_SDP_CH_MASK  0xF80
 
@@ -176,9 +194,9 @@ struct npc_parse_item_info {
 	const void *def_mask; /* default mask */
 	void *hw_mask;	      /* hardware supported mask */
 	int len;	      /* length of item */
+	uint8_t hw_hdr_len;   /* Extra data len at each layer*/
 	const void *spec;     /* spec to use, NULL implies match any */
 	const void *mask;     /* mask to use */
-	uint8_t hw_hdr_len;   /* Extra data len at each layer*/
 };
 
 struct npc_parse_state {
@@ -192,16 +210,16 @@ struct npc_parse_state {
 	uint8_t layer_mask;
 	uint8_t lt[NPC_MAX_LID];
 	uint8_t flags[NPC_MAX_LID];
+	bool has_eth_type;
+	bool is_second_pass_rule;
+	bool set_ipv6ext_ltype_mask;
+	/* adjust ltype in MCAM to match at least one vlan */
+	bool set_vlan_ltype_mask;
 	uint8_t *mcam_data; /* point to flow->mcam_data + key_len */
 	uint8_t *mcam_mask; /* point to flow->mcam_mask + key_len */
 	bool is_vf;
-	/* adjust ltype in MCAM to match at least one vlan */
-	bool set_vlan_ltype_mask;
-	bool set_ipv6ext_ltype_mask;
-	bool is_second_pass_rule;
-	bool has_eth_type;
-	uint16_t nb_tx_queues;
 	uint16_t dst_pf_func;
+	uint16_t nb_tx_queues;
 };
 
 enum npc_kpu_parser_flag {
@@ -340,6 +358,14 @@ struct npc_lid_lt_xtract_info {
 	struct npc_xtract_info xtract[NPC_MAX_LD];
 };
 
+struct npc_lid_lt_xtract_info_cn20k {
+	/* Info derived from parser configuration */
+	uint16_t npc_proto;	    /* Network protocol identified */
+	uint8_t valid_flags_mask;   /* Flags applicable */
+	uint8_t is_terminating : 1; /* No more parsing */
+	struct npc_xtract_info xtract;
+};
+
 union npc_kex_ldata_flags_cfg {
 	struct {
 		uint64_t lid : 3;
@@ -349,6 +375,11 @@ union npc_kex_ldata_flags_cfg {
 	uint64_t i;
 };
 
+#define NPC_MAX_EXTRACTTORS 24
+typedef struct npc_lid_lt_xtract_info_cn20k npc_dxcfg_cn20k_t[NPC_MAX_INTF][NPC_MAX_EXTRACTTORS]
+							     [NPC_MAX_LT];
+typedef union npc_kex_ldata_flags_cfg npc_lid_cn20k_t[NPC_MAX_INTF][NPC_MAX_EXTRACTTORS];
+
 typedef struct npc_lid_lt_xtract_info npc_dxcfg_t[NPC_MAX_INTF][NPC_MAX_LID]
 						 [NPC_MAX_LT];
 typedef struct npc_lid_lt_xtract_info npc_fxcfg_t[NPC_MAX_INTF][NPC_MAX_LD]
@@ -387,33 +418,36 @@ TAILQ_HEAD(npc_age_flow_list_head, npc_age_flow_entry);
 
 struct npc {
 	struct mbox *mbox;			/* Mbox */
-	uint32_t keyx_supp_nmask[NPC_MAX_INTF]; /* nibble mask */
+	uint64_t keyx_supp_nmask[NPC_MAX_INTF]; /* nibble mask */
 	uint8_t hash_extract_cap;		/* hash extract support */
 	uint8_t profile_name[MKEX_NAME_LEN];	/* KEX profile name */
-	uint32_t keyx_len[NPC_MAX_INTF];	/* per intf key len in bits */
-	uint32_t datax_len[NPC_MAX_INTF];	/* per intf data len in bits */
-	uint32_t keyw[NPC_MAX_INTF];		/* max key + data len bits */
-	uint32_t mcam_entries;			/* mcam entries supported */
-	uint16_t channel;			/* RX Channel number */
 	bool is_sdp_link;
+	uint16_t channel;		  /* RX Channel number */
+	uint32_t keyx_len[NPC_MAX_INTF];  /* per intf key len in bits */
+	uint32_t datax_len[NPC_MAX_INTF]; /* per intf data len in bits */
+	uint32_t keyw[NPC_MAX_INTF];	  /* max key + data len bits */
+	uint32_t mcam_entries;		  /* mcam entries supported */
+	uint16_t switch_header_type;	  /* Supported switch header type */
+	uint16_t flow_max_priority;	  /* Max priority for flow */
 	uint16_t sdp_channel;
 	uint16_t sdp_channel_mask;
-	uint32_t rss_grps;			/* rss groups supported */
-	uint16_t flow_prealloc_size;		/* Pre allocated mcam size */
-	uint16_t flow_max_priority;		/* Max priority for flow */
-	uint16_t switch_header_type; /* Supported switch header type */
+	uint32_t rss_grps;	     /* rss groups supported */
+	uint16_t flow_prealloc_size; /* Pre allocated mcam size */
+	uint8_t exact_match_ena;
+	uint16_t pf_func; /* pf_func of device */
 	uint32_t mark_actions;
-	uint32_t vtag_strip_actions; /* vtag insert/strip actions */
-	uint16_t pf_func;	     /* pf_func of device */
-	npc_dxcfg_t prx_dxcfg;	     /* intf, lid, lt, extract */
-	npc_fxcfg_t prx_fxcfg;	     /* Flag extract */
-	npc_ld_flags_t prx_lfcfg;    /* KEX LD_Flags CFG */
+	uint32_t vtag_strip_actions;	   /* vtag insert/strip actions */
+	npc_dxcfg_t prx_dxcfg;		   /* intf, lid, lt, extract */
+	npc_dxcfg_cn20k_t prx_dxcfg_cn20k; /* intf, ext, lt, extract */
+	npc_lid_cn20k_t lid_cfg;	   /* KEX LD_Flags CFG */
+	npc_fxcfg_t prx_fxcfg;		   /* Flag extract */
+	npc_ld_flags_t prx_lfcfg;	   /* KEX LD_Flags CFG */
 	struct npc_flow_list *flow_list;
 	struct npc_prio_flow_list_head *prio_flow_list;
 	struct npc_age_flow_list_head age_flow_list;
 	struct plt_bitmap *rss_grp_entries;
 	struct npc_flow_list ipsec_list;
-	uint8_t exact_match_ena;
+	uint8_t enable_debug;
 };
 
 #define NPC_HASH_FIELD_LEN 16
@@ -432,6 +466,7 @@ roc_npc_to_npc_priv(struct roc_npc *npc)
 	return (struct npc *)npc->reserved;
 }
 
+int npc_mcam_get_stats(struct mbox *mbox, struct roc_npc_flow *flow, uint64_t *count);
 int npc_mcam_alloc_counter(struct mbox *mbox, uint16_t *ctr);
 int npc_mcam_free_counter(struct mbox *mbox, uint16_t ctr_id);
 int npc_mcam_read_counter(struct mbox *mbox, uint32_t ctr_id, uint64_t *count);
@@ -440,9 +475,10 @@ int npc_mcam_free_entry(struct mbox *mbox, uint32_t entry);
 int npc_mcam_free_all_entries(struct npc *npc);
 int npc_mcam_alloc_and_write(struct npc *npc, struct roc_npc_flow *flow,
 			     struct npc_parse_state *pst);
-int npc_mcam_alloc_entry(struct npc *npc, struct roc_npc_flow *mcam,
-			 struct roc_npc_flow *ref_mcam, int prio,
-			 int *resp_count);
+int npc_mcam_alloc_entry(struct npc *npc, struct roc_npc_flow *mcam, struct roc_npc_flow *ref_mcam,
+			 uint8_t prio, int *resp_count);
+int npc_mcam_alloc_entry_cn20k(struct npc *npc, struct roc_npc_flow *mcam, int *resp_count);
+
 int npc_mcam_alloc_entries(struct mbox *mbox, int ref_mcam, int *alloc_entry, int req_count,
 			   int prio, int *resp_count, bool is_conti);
 
@@ -453,6 +489,7 @@ int npc_update_parse_state(struct npc_parse_state *pst, struct npc_parse_item_in
 			   int lt, uint8_t flags);
 void npc_get_hw_supp_mask(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
 			  int lt);
+uint8_t npc_get_key_type(struct npc *npc, struct roc_npc_flow *flow);
 int npc_mask_is_supported(const char *mask, const char *hw_mask, int len);
 int npc_parse_item_basic(const struct roc_npc_item_info *item, struct npc_parse_item_info *info);
 int npc_parse_meta_items(struct npc_parse_state *pst);
diff --git a/drivers/common/cnxk/roc_npc_utils.c b/drivers/common/cnxk/roc_npc_utils.c
index a507df994f..75d3b0702c 100644
--- a/drivers/common/cnxk/roc_npc_utils.c
+++ b/drivers/common/cnxk/roc_npc_utils.c
@@ -4,6 +4,36 @@
 #include "roc_api.h"
 #include "roc_priv.h"
 
+enum npc_mcam_cn20k_key_width {
+	NPC_CN20K_MCAM_KEY_X1 = 0,
+	NPC_CN20K_MCAM_KEY_DYN = NPC_CN20K_MCAM_KEY_X1,
+	NPC_CN20K_MCAM_KEY_X2,
+	NPC_CN20K_MCAM_KEY_X4,
+	NPC_CN20K_MCAM_KEY_MAX,
+};
+
+uint8_t
+npc_get_key_type(struct npc *npc, struct roc_npc_flow *flow)
+{
+	int i;
+
+	/* KEX is configured just for X2 */
+	if (npc->keyw[ROC_NPC_INTF_RX] == 1)
+		return NPC_CN20K_MCAM_KEY_X2;
+
+	/* KEX is configured just for X4 */
+	if (npc->keyw[ROC_NPC_INTF_RX] == 2)
+		return NPC_CN20K_MCAM_KEY_X4;
+
+	/* KEX is configured for both X2 and X4 */
+	/* Check mask for upper 256 bits. if mask is set, then it is X4 entry */
+	for (i = 4; i < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; i++) {
+		if (flow->mcam_mask[i] != 0)
+			return NPC_CN20K_MCAM_KEY_X4;
+	}
+	return NPC_CN20K_MCAM_KEY_X2;
+}
+
 static void
 npc_prep_mcam_ldata(uint8_t *ptr, const uint8_t *data, int len)
 {
@@ -67,8 +97,9 @@ npc_ipv6_hash_mask_get(struct npc_xtract_info *xinfo, struct npc_parse_item_info
 	memset(&hw_mask[offset], 0xFF, NPC_HASH_FIELD_LEN);
 }
 
-void
-npc_get_hw_supp_mask(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid, int lt)
+static void
+npc_get_hw_supp_mask_legacy(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
+			    int lt)
 {
 	struct npc_xtract_info *xinfo, *lfinfo;
 	char *hw_mask = info->hw_mask;
@@ -101,6 +132,40 @@ npc_get_hw_supp_mask(struct npc_parse_state *pst, struct npc_parse_item_info *in
 	}
 }
 
+static void
+npc_get_hw_supp_mask_o20k(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
+			  int lt)
+{
+	struct npc_xtract_info *xinfo;
+	union npc_kex_ldata_flags_cfg *lid_info;
+	char *hw_mask = info->hw_mask;
+	int ex;
+	int intf;
+
+	intf = pst->nix_intf;
+	memset(hw_mask, 0, info->len);
+	for (ex = 0; ex < NPC_MAX_EXTRACTTORS; ex++) {
+		lid_info = &pst->npc->lid_cfg[intf][ex];
+		if (lid_info->s.lid != lid)
+			continue;
+		xinfo = &pst->npc->prx_dxcfg_cn20k[intf][ex][lt].xtract;
+
+		if (pst->npc->hash_extract_cap && xinfo->use_hash)
+			npc_ipv6_hash_mask_get(xinfo, info);
+		else
+			npc_set_hw_mask(info, xinfo, hw_mask);
+	}
+}
+
+void
+npc_get_hw_supp_mask(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid, int lt)
+{
+	if (!roc_model_is_cn20k())
+		return npc_get_hw_supp_mask_legacy(pst, info, lid, lt);
+	else
+		return npc_get_hw_supp_mask_o20k(pst, info, lid, lt);
+}
+
 inline int
 npc_mask_is_supported(const char *mask, const char *hw_mask, int len)
 {
@@ -381,10 +446,10 @@ npc_hash_field_get(struct npc_xtract_info *xinfo, const struct roc_npc_flow_item
 	return 1;
 }
 
-int
-npc_process_ipv6_field_hash(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
-			    const struct roc_npc_flow_item_ipv6 *ipv6_mask,
-			    struct npc_parse_state *pst, uint8_t ltype)
+static int
+npc_process_ipv6_field_hash_legacy(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
+				   const struct roc_npc_flow_item_ipv6 *ipv6_mask,
+				   struct npc_parse_state *pst, uint8_t ltype)
 {
 	struct npc_lid_lt_xtract_info *lid_lt_xinfo;
 	uint8_t hash_field[ROC_IPV6_ADDR_LEN];
@@ -421,9 +486,64 @@ npc_process_ipv6_field_hash(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
 	return 0;
 }
 
+static int
+npc_process_ipv6_field_hash_o20k(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
+				 const struct roc_npc_flow_item_ipv6 *ipv6_mask,
+				 struct npc_parse_state *pst, uint8_t ltype)
+{
+	struct npc_lid_lt_xtract_info_cn20k *lid_lt_xinfo;
+	union npc_kex_ldata_flags_cfg *lid_cfg;
+	uint8_t hash_field[ROC_IPV6_ADDR_LEN];
+	struct npc_xtract_info *xinfo;
+	struct roc_ipv6_hdr ipv6_buf;
+	uint32_t hash = 0, mask;
+	int intf, i, rc = 0;
+
+	memset(&ipv6_buf, 0, sizeof(ipv6_buf));
+	memset(hash_field, 0, sizeof(hash_field));
+
+	intf = pst->nix_intf;
+	for (i = 0; i < NPC_MAX_EXTRACTTORS; i++) {
+		lid_cfg = &pst->npc->lid_cfg[intf][i];
+		if (lid_cfg->s.lid != NPC_LID_LC)
+			continue;
+		lid_lt_xinfo = &pst->npc->prx_dxcfg_cn20k[intf][NPC_LID_LC][ltype];
+
+		xinfo = &lid_lt_xinfo->xtract;
+		if (!xinfo->use_hash)
+			continue;
+
+		rc = npc_hash_field_get(xinfo, ipv6_spec, ipv6_mask, hash_field);
+		if (rc == 0)
+			continue;
+
+		rc = npc_ipv6_field_hash_get(pst->npc, (const uint32_t *)hash_field, intf, i,
+					     &hash);
+		if (rc)
+			return rc;
+
+		mask = GENMASK(31, 0);
+		memcpy(pst->mcam_mask + xinfo->key_off, (uint8_t *)&mask, 4);
+		memcpy(pst->mcam_data + xinfo->key_off, (uint8_t *)&hash, 4);
+	}
+
+	return 0;
+}
+
 int
-npc_update_parse_state(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
-		       int lt, uint8_t flags)
+npc_process_ipv6_field_hash(const struct roc_npc_flow_item_ipv6 *ipv6_spec,
+			    const struct roc_npc_flow_item_ipv6 *ipv6_mask,
+			    struct npc_parse_state *pst, uint8_t ltype)
+{
+	if (!roc_model_is_cn20k())
+		return npc_process_ipv6_field_hash_legacy(ipv6_spec, ipv6_mask, pst, ltype);
+	else
+		return npc_process_ipv6_field_hash_o20k(ipv6_spec, ipv6_mask, pst, ltype);
+}
+
+static int
+npc_update_parse_state_legacy(struct npc_parse_state *pst, struct npc_parse_item_info *info,
+			      int lid, int lt, uint8_t flags)
 {
 	struct npc_lid_lt_xtract_info *xinfo;
 	struct roc_npc_flow_dump_data *dump;
@@ -461,8 +581,7 @@ npc_update_parse_state(struct npc_parse_state *pst, struct npc_parse_item_info *
 		if (lf_cfg == lid) {
 			for (j = 0; j < NPC_MAX_LFL; j++) {
 				lfinfo = pst->npc->prx_fxcfg[intf][i][j].xtract;
-				rc = npc_update_extraction_data(pst, info,
-								&lfinfo[0]);
+				rc = npc_update_extraction_data(pst, info, &lfinfo[0]);
 				if (rc != 0)
 					return rc;
 
@@ -480,42 +599,127 @@ npc_update_parse_state(struct npc_parse_state *pst, struct npc_parse_item_info *
 	return 0;
 }
 
+static int
+npc_update_parse_state_o20(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
+			   int lt, uint8_t flags)
+{
+	struct npc_lid_lt_xtract_info_cn20k *xinfo;
+	union npc_kex_ldata_flags_cfg *lid_cfg;
+	struct roc_npc_flow_dump_data *dump;
+	int intf;
+	int i, rc = 0;
+
+	pst->layer_mask |= lid;
+	pst->lt[lid] = lt;
+	pst->flags[lid] = flags;
+
+	intf = pst->nix_intf;
+	if (info->spec == NULL)
+		goto done;
+
+	for (i = 0; i < NPC_MAX_EXTRACTTORS; i++) {
+		lid_cfg = &pst->npc->lid_cfg[intf][i];
+		if (lid_cfg->s.lid != lid)
+			continue;
+		xinfo = &pst->npc->prx_dxcfg_cn20k[intf][i][lt];
+		if (xinfo->is_terminating)
+			pst->terminate = 1;
+
+		if (xinfo->xtract.use_hash)
+			continue;
+		rc = npc_update_extraction_data(pst, info, &xinfo->xtract);
+		if (rc != 0)
+			return rc;
+	}
+
+done:
+	dump = &pst->flow->dump_data[pst->flow->num_patterns++];
+	dump->lid = lid;
+	dump->ltype = lt;
+	pst->pattern++;
+	return 0;
+}
+
+int
+npc_update_parse_state(struct npc_parse_state *pst, struct npc_parse_item_info *info, int lid,
+		       int lt, uint8_t flags)
+{
+	if (roc_model_is_cn20k())
+		return npc_update_parse_state_o20(pst, info, lid, lt, flags);
+	else
+		return npc_update_parse_state_legacy(pst, info, lid, lt, flags);
+}
+
 int
 npc_mcam_init(struct npc *npc, struct roc_npc_flow *flow, int mcam_id)
 {
-	struct npc_mcam_write_entry_req *req;
-	struct npc_mcam_write_entry_rsq *rsp;
+	struct msg_rsp *rsp;
 	struct mbox *mbox = mbox_get(npc->mbox);
 	int rc = 0, idx;
 
-	req = mbox_alloc_msg_npc_mcam_write_entry(mbox);
-	if (req == NULL) {
-		rc = -ENOSPC;
-		goto exit;
-	}
-	req->set_cntr = 0;
-	req->cntr = 0;
-	req->entry = mcam_id;
-
-	req->intf = (flow->nix_intf == NIX_INTF_RX) ? NPC_MCAM_RX : NPC_MCAM_TX;
-	req->enable_entry = 1;
-	req->entry_data.action = flow->npc_action;
-	req->entry_data.vtag_action = flow->vtag_action;
-
-	for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
-		req->entry_data.kw[idx] = 0x0;
-		req->entry_data.kw_mask[idx] = 0x0;
-	}
+	if (roc_model_is_cn20k()) {
+		struct npc_cn20k_mcam_write_entry_req *req;
+
+		req = mbox_alloc_msg_npc_cn20k_mcam_write_entry(mbox);
+		if (req == NULL) {
+			rc = -ENOSPC;
+			goto exit;
+		}
+		req->cntr = 0;
+		req->entry = mcam_id;
+
+		req->intf = (flow->nix_intf == NIX_INTF_RX) ? NPC_MCAM_RX : NPC_MCAM_TX;
+		req->enable_entry = 1;
+		req->entry_data.action = flow->npc_action;
+		req->entry_data.vtag_action = flow->vtag_action;
+
+		for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
+			req->entry_data.kw[idx] = 0x0;
+			req->entry_data.kw_mask[idx] = 0x0;
+		}
+
+		if (flow->nix_intf == NIX_INTF_RX) {
+			req->entry_data.kw[0] |= (uint64_t)npc->channel;
+			req->entry_data.kw_mask[0] |= (BIT_ULL(12) - 1);
+		} else {
+			uint16_t pf_func = (flow->npc_action >> 4) & 0xffff;
 
-	if (flow->nix_intf == NIX_INTF_RX) {
-		req->entry_data.kw[0] |= (uint64_t)npc->channel;
-		req->entry_data.kw_mask[0] |= (BIT_ULL(12) - 1);
+			pf_func = plt_cpu_to_be_16(pf_func);
+			req->entry_data.kw[0] |= ((uint64_t)pf_func << 32);
+			req->entry_data.kw_mask[0] |= ((uint64_t)0xffff << 32);
+		}
 	} else {
-		uint16_t pf_func = (flow->npc_action >> 4) & 0xffff;
+		struct npc_mcam_write_entry_req *req;
+
+		req = mbox_alloc_msg_npc_mcam_write_entry(mbox);
+		if (req == NULL) {
+			rc = -ENOSPC;
+			goto exit;
+		}
+		req->set_cntr = 0;
+		req->cntr = 0;
+		req->entry = mcam_id;
+
+		req->intf = (flow->nix_intf == NIX_INTF_RX) ? NPC_MCAM_RX : NPC_MCAM_TX;
+		req->enable_entry = 1;
+		req->entry_data.action = flow->npc_action;
+		req->entry_data.vtag_action = flow->vtag_action;
+
+		for (idx = 0; idx < ROC_NPC_MAX_MCAM_WIDTH_DWORDS; idx++) {
+			req->entry_data.kw[idx] = 0x0;
+			req->entry_data.kw_mask[idx] = 0x0;
+		}
+
+		if (flow->nix_intf == NIX_INTF_RX) {
+			req->entry_data.kw[0] |= (uint64_t)npc->channel;
+			req->entry_data.kw_mask[0] |= (BIT_ULL(12) - 1);
+		} else {
+			uint16_t pf_func = (flow->npc_action >> 4) & 0xffff;
 
-		pf_func = plt_cpu_to_be_16(pf_func);
-		req->entry_data.kw[0] |= ((uint64_t)pf_func << 32);
-		req->entry_data.kw_mask[0] |= ((uint64_t)0xffff << 32);
+			pf_func = plt_cpu_to_be_16(pf_func);
+			req->entry_data.kw[0] |= ((uint64_t)pf_func << 32);
+			req->entry_data.kw_mask[0] |= ((uint64_t)0xffff << 32);
+		}
 	}
 
 	rc = mbox_process_msg(mbox, (void *)&rsp);
@@ -783,13 +987,12 @@ npc_insert_into_flow_list(struct npc *npc, struct npc_prio_flow_entry *entry)
 }
 
 static int
-npc_allocate_mcam_entry(struct mbox *mbox, int prio,
-			struct npc_mcam_alloc_entry_rsp *rsp_local,
-			int ref_entry)
+npc_allocate_mcam_entry(struct mbox *mbox, int prio, struct npc_mcam_alloc_entry_rsp *rsp_local,
+			int ref_entry, uint8_t kw_type)
 {
-	struct npc_mcam_alloc_entry_rsp *rsp_cmd;
-	struct npc_mcam_alloc_entry_req *req;
 	struct npc_mcam_alloc_entry_rsp *rsp;
+	struct npc_mcam_alloc_entry_req *req;
+
 	int rc = -ENOSPC;
 
 	req = mbox_alloc_msg_npc_mcam_alloc_entry(mbox_get(mbox));
@@ -797,20 +1000,20 @@ npc_allocate_mcam_entry(struct mbox *mbox, int prio,
 		goto exit;
 	req->contig = 1;
 	req->count = 1;
-	req->priority = prio;
+	req->ref_priority = prio;
 	req->ref_entry = ref_entry;
+	req->kw_type = kw_type;
 
-	rc = mbox_process_msg(mbox, (void *)&rsp_cmd);
+	rc = mbox_process_msg(mbox, (void *)&rsp);
 	if (rc)
 		goto exit;
 
-	if (!rsp_cmd->count) {
+	if (!rsp->count) {
 		rc = -ENOSPC;
 		goto exit;
 	}
 
-	mbox_memcpy(rsp_local, rsp_cmd, sizeof(*rsp));
-
+	mbox_memcpy(rsp_local, rsp, sizeof(*rsp));
 	rc = 0;
 exit:
 	mbox_put(mbox);
@@ -854,8 +1057,7 @@ npc_find_mcam_ref_entry(struct roc_npc_flow *flow, struct npc *npc, int *prio,
 }
 
 static int
-npc_alloc_mcam_by_ref_entry(struct mbox *mbox, struct roc_npc_flow *flow,
-			    struct npc *npc,
+npc_alloc_mcam_by_ref_entry(struct mbox *mbox, struct roc_npc_flow *flow, struct npc *npc,
 			    struct npc_mcam_alloc_entry_rsp *rsp_local)
 {
 	int prio, ref_entry = 0, rc = 0, dir = NPC_MCAM_LOWER_PRIO;
@@ -863,7 +1065,7 @@ npc_alloc_mcam_by_ref_entry(struct mbox *mbox, struct roc_npc_flow *flow,
 
 retry:
 	npc_find_mcam_ref_entry(flow, npc, &prio, &ref_entry, dir);
-	rc = npc_allocate_mcam_entry(mbox, prio, rsp_local, ref_entry);
+	rc = npc_allocate_mcam_entry(mbox, prio, rsp_local, ref_entry, flow->key_type);
 	if (rc && !retry_done) {
 		plt_npc_dbg(
 			"npc: Failed to allocate lower priority entry. Retrying for higher priority");
@@ -879,32 +1081,42 @@ npc_alloc_mcam_by_ref_entry(struct mbox *mbox, struct roc_npc_flow *flow,
 }
 
 int
-npc_get_free_mcam_entry(struct mbox *mbox, struct roc_npc_flow *flow,
-			struct npc *npc)
+npc_get_free_mcam_entry(struct mbox *mbox, struct roc_npc_flow *flow, struct npc *npc)
 {
 	struct npc_mcam_alloc_entry_rsp rsp_local;
 	struct npc_prio_flow_entry *new_entry;
 	int rc = 0;
 
-	rc = npc_alloc_mcam_by_ref_entry(mbox, flow, npc, &rsp_local);
-
-	if (rc)
-		return rc;
-
 	new_entry = plt_zmalloc(sizeof(*new_entry), 0);
 	if (!new_entry)
 		return -ENOSPC;
 
-	new_entry->flow = flow;
+	if (roc_model_is_cn20k()) {
+		rc = npc_allocate_mcam_entry(mbox, NPC_MCAM_ANY_PRIO, &rsp_local, 0,
+					     flow->key_type);
+		if (rc) {
+			plt_npc_dbg("npc: failed to allocate MCAM entry.");
+			return rc;
+		}
+
+		new_entry->flow = flow;
+	} else {
+		rc = npc_alloc_mcam_by_ref_entry(mbox, flow, npc, &rsp_local);
 
-	plt_npc_dbg("kernel allocated MCAM entry %d", rsp_local.entry);
+		if (rc)
+			return rc;
 
-	rc = npc_sort_mcams_by_user_prio_level(mbox, new_entry, npc,
-					       &rsp_local);
-	if (rc)
-		goto err;
+		new_entry->flow = flow;
+
+		plt_npc_dbg("kernel allocated MCAM entry %d", rsp_local.entry);
+
+		rc = npc_sort_mcams_by_user_prio_level(mbox, new_entry, npc, &rsp_local);
+		if (rc)
+			goto err;
+
+		plt_npc_dbg("allocated MCAM entry after sorting %d", rsp_local.entry);
+	}
 
-	plt_npc_dbg("allocated MCAM entry after sorting %d", rsp_local.entry);
 	flow->mcam_id = rsp_local.entry;
 	npc_insert_into_flow_list(npc, new_entry);
 
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index 97562b1663..dc8fb1b29f 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -487,6 +487,7 @@ INTERNAL {
 	roc_npc_mcam_free_counter;
 	roc_npc_mcam_free;
 	roc_npc_mcam_free_entry;
+	roc_npc_mcam_get_stats;
 	roc_npc_mcam_init;
 	roc_npc_mcam_move;
 	roc_npc_mcam_merge_base_steering_rule;
-- 
2.39.2

