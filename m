Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B1DD2CE1C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 05:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195E0402C6;
	Fri,  5 Dec 2025 06:52:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D9FFC40144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 06:51:58 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B4JKSnZ1157842 for <dev@dpdk.org>; Thu, 4 Dec 2025 21:51:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 kSzOAurdy6BPnksZsgpG31HcwYsG3J3kIdcExB/CMs=; b=XRX8lRjgCncpC0E5w
 fFohzBCLN/ljWyjNKJsI7P/OhuZuUtYKKJxnv0shDSsGmrRBkpmnVp7B5VKHNPmB
 0O21qbBIgBA3DpY+FlkEAwZlK5y2dakxv5nxIJ7g44dvH2o48NPOoNf+y/AYXbky
 fUoZyqZpnDwwAZ97BL1xa2Yo6lRMTEPJoF8YL0ynwKsHibie+BvTf2TgVOJC+HH1
 Btfz1aLG3eeTs85BsiQMAUy8ueICPA5j/LMUY7jHrE9kttuMDI4y/BPTQFrEpLaK
 9f2GIA0pyR5FgojVy05a7tUW/m8sirG7h3srCjJ+lJrPbVdz2wjiPa1CVs5cbYmp
 vaZmw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4au6n1at53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 04 Dec 2025 21:51:58 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 4 Dec 2025 21:52:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 4 Dec 2025 21:52:08 -0800
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 84F263F70CA;
 Thu,  4 Dec 2025 21:51:53 -0800 (PST)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH v2 1/2] common/cnxk: add support for halos
Date: Fri, 5 Dec 2025 11:21:33 +0530
Message-ID: <20251205055140.2395369-2-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251205055140.2395369-1-nkishor@marvell.com>
References: <20251204065203.1866809-2-nkishor@marvell.com>
 <20251205055140.2395369-1-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j5OTsBOefosRzfu8mRwuqCB7LgAZ0YKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAzOSBTYWx0ZWRfX0f4qt3Il6SgF
 xGHPpaTzpOua6udI5dZrLutd/loq5FqTqNOu1l0u0yaucjg1/ju6w5dCkszLHMxPlwQOQIK46Yp
 kDx3v+CjogrIQjxmHhrkuJhOBA67ISUhodhsc91j02AZvjJdNnvnXMe26kM7h0W2q4FO88k0sX9
 XXkA1mwy6XqB/i5brTB41Uz8IBzkQcN7wBF/x/GN28zju9z5jRzOkjsEqw5I3UTIK1y2n7C6Y5P
 ih/mvWANQQCzuobWCg7S4KKpW5W7Czss/m3/OQFwsDaBOThUsttovDOYRFCfTBAhzaHuTCYIN7o
 n1iJvuyM2PH7J11sSLz3j4Ev4XzksuByj9vMx20Yrk7765JGqoZpspaMF03FqUob2q9hGz+TNTC
 cmBEzmA7+lnAespSAET2r42UtEKKvQ==
X-Authority-Analysis: v=2.4 cv=b/O/I9Gx c=1 sm=1 tr=0 ts=693272fe cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=x2AnUC3qDfRRiqzikAAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: j5OTsBOefosRzfu8mRwuqCB7LgAZ0YKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_02,2025-12-04_04,2025-10-01_01
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

In cn9k/cn10k NPA mempool creation required the creation of at least
one aura and pool context. Even, if the mapping between aura and pool
was 1:1 (i.e, one aura mapped to one pool), separate contexts were
required for aura and pool. This wasted the context space and most of
common use case for NPA mempool is 1:1 mapping between aura and pool.

In cn20k, 1:1 aura pool mapping can now be replaced by using halos.
Halos allow the creation of only one context which contains the
information required for both aura and pool.

This patch adds the support for creation of Halos in ROC.

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
v2:
 * Fixed compilation warnings.

 drivers/common/cnxk/hw/npa.h                  |  81 ++++++
 drivers/common/cnxk/roc_idev.c                |  25 ++
 drivers/common/cnxk/roc_idev.h                |   3 +
 drivers/common/cnxk/roc_idev_priv.h           |   1 +
 drivers/common/cnxk/roc_mbox.h                |   6 +
 drivers/common/cnxk/roc_nix.h                 |   1 +
 drivers/common/cnxk/roc_nix_queue.c           |  46 ++-
 drivers/common/cnxk/roc_npa.c                 | 268 ++++++++++++++++--
 drivers/common/cnxk/roc_npa.h                 |  20 +-
 drivers/common/cnxk/roc_npa_debug.c           | 201 ++++++++++++-
 drivers/common/cnxk/roc_npa_priv.h            |   3 +
 .../common/cnxk/roc_platform_base_symbols.c   |   2 +
 drivers/common/cnxk/roc_sso.c                 |  35 ++-
 drivers/common/cnxk/roc_sso.h                 |   1 +
 14 files changed, 630 insertions(+), 63 deletions(-)

diff --git a/drivers/common/cnxk/hw/npa.h b/drivers/common/cnxk/hw/npa.h
index 4fd1f9a64b..e421c70e01 100644
--- a/drivers/common/cnxk/hw/npa.h
+++ b/drivers/common/cnxk/hw/npa.h
@@ -118,6 +118,7 @@
 
 #define NPA_AQ_CTYPE_AURA (0x0ull)
 #define NPA_AQ_CTYPE_POOL (0x1ull)
+#define NPA_AQ_CTYPE_HALO (0x2ull)
 
 #define NPA_BPINTF_NIX0_RX (0x0ull)
 #define NPA_BPINTF_NIX1_RX (0x1ull)
@@ -456,6 +457,86 @@ struct npa_cn20k_pool_s {
 	uint64_t rsvd_1023_960 : 64; /* W15 */
 };
 
+/* NPA halo context structure [CN20K] */
+struct npa_cn20k_halo_s {
+	uint64_t stack_base : 64; /* W0 */
+	uint64_t ena : 1; /* W1 */
+	uint64_t nat_align : 1;
+	uint64_t reserved_67_66 : 2;
+	uint64_t stack_caching : 1;
+	uint64_t reserved_71_69 : 3;
+	uint64_t aura_drop_ena : 1;
+	uint64_t reserved_79_73 : 7;
+	uint64_t aura_drop : 8;
+	uint64_t buf_offset : 12;
+	uint64_t reserved_103_100 : 4;
+	uint64_t buf_size : 12;
+	uint64_t reserved_119_116 : 4;
+	uint64_t ref_cnt_prof : 3;
+	uint64_t reserved_127_123 : 5;
+	uint64_t stack_max_pages : 32; /* W2 */
+	uint64_t stack_pages : 32;
+	uint64_t bp_0 : 7; /* W3 */
+	uint64_t bp_1 : 7;
+	uint64_t bp_2 : 7;
+	uint64_t bp_3 : 7;
+	uint64_t bp_4 : 7;
+	uint64_t bp_5 : 7;
+	uint64_t bp_6 : 7;
+	uint64_t bp_7 : 7;
+	uint64_t bp_ena_0 : 1;
+	uint64_t bp_ena_1 : 1;
+	uint64_t bp_ena_2 : 1;
+	uint64_t bp_ena_3 : 1;
+	uint64_t bp_ena_4 : 1;
+	uint64_t bp_ena_5 : 1;
+	uint64_t bp_ena_6 : 1;
+	uint64_t bp_ena_7 : 1;
+	uint64_t stack_offset : 4; /* W4 */
+	uint64_t reserved_263_260 : 4;
+	uint64_t shift : 6;
+	uint64_t reserved_271_270 : 2;
+	uint64_t avg_level : 8;
+	uint64_t avg_con : 9;
+	uint64_t fc_ena : 1;
+	uint64_t fc_stype : 2;
+	uint64_t fc_hyst_bits : 4;
+	uint64_t fc_up_crossing : 1;
+	uint64_t reserved_299_297 : 3;
+	uint64_t update_time : 16;
+	uint64_t reserved_319_316 : 4;
+	uint64_t fc_addr : 64;   /* W5 */
+	uint64_t ptr_start : 64; /* W6 */
+	uint64_t ptr_end : 64;   /* W7 */
+	uint64_t bpid_0 : 12; /* W8 */
+	uint64_t reserved_535_524 : 12;
+	uint64_t err_int : 8;
+	uint64_t err_int_ena : 8;
+	uint64_t thresh_int : 1;
+	uint64_t thresh_int_ena : 1;
+	uint64_t thresh_up : 1;
+	uint64_t reserved_555_555 : 1;
+	uint64_t thresh_qint_idx : 7;
+	uint64_t reserved_563_563 : 1;
+	uint64_t err_qint_idx : 7;
+	uint64_t reserved_575_571 : 5;
+	uint64_t thresh : 36; /* W9 */
+	uint64_t reserved_615_612 : 4;
+	uint64_t fc_msh_dst : 11;
+	uint64_t reserved_630_627 : 4;
+	uint64_t op_dpc_ena : 1;
+	uint64_t op_dpc_set : 5;
+	uint64_t reserved_637_637 : 1;
+	uint64_t stream_ctx : 1;
+	uint64_t unified_ctx : 1;
+	uint64_t reserved_703_640 : 64; /* W10 */
+	uint64_t reserved_767_704 : 64; /* W11 */
+	uint64_t reserved_831_768 : 64; /* W12 */
+	uint64_t reserved_895_832 : 64; /* W13 */
+	uint64_t reserved_959_896 : 64; /* W14 */
+	uint64_t reserved_1023_960 : 64; /* W15 */
+};
+
 /* NPA queue interrupt context hardware structure */
 struct npa_qint_hw_s {
 	uint32_t count : 22;
diff --git a/drivers/common/cnxk/roc_idev.c b/drivers/common/cnxk/roc_idev.c
index 84812f73e0..6aa5b10ee9 100644
--- a/drivers/common/cnxk/roc_idev.c
+++ b/drivers/common/cnxk/roc_idev.c
@@ -33,6 +33,7 @@ idev_set_defaults(struct idev_cfg *idev)
 	idev->npa = NULL;
 	idev->npa_pf_func = 0;
 	idev->max_pools = 128;
+	idev->halo_ena = 0;
 	idev->lmt_pf_func = 0;
 	idev->lmt_base_addr = 0;
 	idev->num_lmtlines = 0;
@@ -123,6 +124,30 @@ roc_idev_npa_maxpools_set(uint32_t max_pools)
 		__atomic_store_n(&idev->max_pools, max_pools, __ATOMIC_RELEASE);
 }
 
+int
+roc_idev_npa_halo_ena_get(void)
+{
+	struct idev_cfg *idev;
+	int halo_ena;
+
+	idev = idev_get_cfg();
+	halo_ena = 0;
+	if (idev != NULL)
+		halo_ena = __atomic_load_n(&idev->halo_ena, __ATOMIC_ACQUIRE);
+
+	return halo_ena;
+}
+
+void
+roc_idev_npa_halo_ena_set(int halo_ena)
+{
+	struct idev_cfg *idev;
+
+	idev = idev_get_cfg();
+	if (idev != NULL)
+		__atomic_store_n(&idev->halo_ena, halo_ena, __ATOMIC_RELEASE);
+}
+
 uint16_t
 idev_npa_lf_active(struct dev *dev)
 {
diff --git a/drivers/common/cnxk/roc_idev.h b/drivers/common/cnxk/roc_idev.h
index 6edb5f83b2..3803963b07 100644
--- a/drivers/common/cnxk/roc_idev.h
+++ b/drivers/common/cnxk/roc_idev.h
@@ -8,6 +8,9 @@
 uint32_t __roc_api roc_idev_npa_maxpools_get(void);
 void __roc_api roc_idev_npa_maxpools_set(uint32_t max_pools);
 
+int __roc_api roc_idev_npa_halo_ena_get(void);
+void __roc_api roc_idev_npa_halo_ena_set(int halo_ena);
+
 /* LMT */
 uint64_t __roc_api roc_idev_lmt_base_addr_get(void);
 uint16_t __roc_api roc_idev_num_lmtlines_get(void);
diff --git a/drivers/common/cnxk/roc_idev_priv.h b/drivers/common/cnxk/roc_idev_priv.h
index 98b6286bfe..dde555535b 100644
--- a/drivers/common/cnxk/roc_idev_priv.h
+++ b/drivers/common/cnxk/roc_idev_priv.h
@@ -30,6 +30,7 @@ struct idev_cfg {
 	struct npa_lf *npa;
 	uint16_t npa_refcnt;
 	uint32_t max_pools;
+	int halo_ena;
 	uint16_t lmt_pf_func;
 	uint16_t num_lmtlines;
 	uint64_t lmt_base_addr;
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 3e913fa13c..3176c87382 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1397,6 +1397,8 @@ struct npa_cn20k_aq_enq_req {
 		__io struct npa_cn20k_aura_s aura;
 		/* Valid when op == WRITE/INIT and ctype == POOL */
 		__io struct npa_cn20k_pool_s pool;
+		/* Valid when op == WRITE/INIT and ctype == HALO */
+		__io struct npa_cn20k_halo_s halo;
 	};
 	/* Mask data when op == WRITE (1=write, 0=don't write) */
 	union {
@@ -1404,6 +1406,8 @@ struct npa_cn20k_aq_enq_req {
 		__io struct npa_cn20k_aura_s aura_mask;
 		/* Valid when op == WRITE and ctype == POOL */
 		__io struct npa_cn20k_pool_s pool_mask;
+		/* Valid when op == WRITE/INIT and ctype == HALO */
+		__io struct npa_cn20k_halo_s halo_mask;
 	};
 };
 
@@ -1414,6 +1418,8 @@ struct npa_cn20k_aq_enq_rsp {
 		__io struct npa_cn20k_aura_s aura;
 		/* Valid when op == READ and ctype == POOL */
 		__io struct npa_cn20k_pool_s pool;
+		/* Valid when op == READ and ctype == HALO */
+		__io struct npa_cn20k_halo_s halo;
 	};
 };
 
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index 326decde2b..aa197eb95e 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -595,6 +595,7 @@ struct roc_nix {
 	uintptr_t lmt_base;
 	bool io_enabled;
 	bool rx_ptp_ena;
+	bool sqb_halo_ena;
 	uint16_t cints;
 	uint32_t buf_sz;
 	uint64_t meta_aura_handle;
diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/roc_nix_queue.c
index c7e37abf32..a6f487fe08 100644
--- a/drivers/common/cnxk/roc_nix_queue.c
+++ b/drivers/common/cnxk/roc_nix_queue.c
@@ -1486,8 +1486,6 @@ sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 {
 	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
 	uint16_t sqes_per_sqb, count, nb_sqb_bufs;
-	struct npa_pool_s pool;
-	struct npa_aura_s aura;
 	uint64_t blk_sz;
 	uint64_t iova;
 	int rc;
@@ -1509,20 +1507,38 @@ sqb_pool_populate(struct roc_nix *roc_nix, struct roc_nix_sq *sq)
 	/* Explicitly set nat_align alone as by default pool is with both
 	 * nat_align and buf_offset = 1 which we don't want for SQB.
 	 */
-	memset(&pool, 0, sizeof(struct npa_pool_s));
-	pool.nat_align = 1;
+	if (roc_model_is_cn20k() && roc_nix->sqb_halo_ena) {
+		struct npa_cn20k_halo_s halo;
+
+		memset(&halo, 0, sizeof(struct npa_cn20k_halo_s));
+		halo.nat_align = 1;
+		halo.fc_ena = 1;
+		halo.fc_stype = 0x3; /* STSTP */
+		halo.fc_addr = (uint64_t)sq->fc;
+		halo.fc_hyst_bits = 0; /* Store count on all updates */
+		halo.unified_ctx = 1;
+		rc = roc_npa_pool_create(&sq->aura_handle, blk_sz, nb_sqb_bufs, NULL,
+					 (struct npa_pool_s *)&halo, ROC_NPA_HALO_F);
+	} else {
+		struct npa_pool_s pool;
+		struct npa_aura_s aura;
+
+		memset(&pool, 0, sizeof(struct npa_pool_s));
+		pool.nat_align = 1;
+
+		memset(&aura, 0, sizeof(aura));
+		/* Disable SQ pool FC updates when SQ count updates are used */
+		if (!sq->sq_cnt_ptr)
+			aura.fc_ena = 1;
+		if (roc_model_is_cn9k() || roc_errata_npa_has_no_fc_stype_ststp())
+			aura.fc_stype = 0x0; /* STF */
+		else
+			aura.fc_stype = 0x3; /* STSTP */
+		aura.fc_addr = (uint64_t)sq->fc;
+		aura.fc_hyst_bits = sq->fc_hyst_bits & 0xF;
+		rc = roc_npa_pool_create(&sq->aura_handle, blk_sz, nb_sqb_bufs, &aura, &pool, 0);
+	}
 
-	memset(&aura, 0, sizeof(aura));
-	/* Disable SQ pool FC updates when SQ count updates are used */
-	if (!sq->sq_cnt_ptr)
-		aura.fc_ena = 1;
-	if (roc_model_is_cn9k() || roc_errata_npa_has_no_fc_stype_ststp())
-		aura.fc_stype = 0x0; /* STF */
-	else
-		aura.fc_stype = 0x3; /* STSTP */
-	aura.fc_addr = (uint64_t)sq->fc;
-	aura.fc_hyst_bits = sq->fc_hyst_bits & 0xF;
-	rc = roc_npa_pool_create(&sq->aura_handle, blk_sz, nb_sqb_bufs, &aura, &pool, 0);
 	if (rc)
 		goto fail;
 
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index f9824f6656..e8df8ad077 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -82,7 +82,6 @@ static int
 npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura,
 		   struct npa_pool_s *pool)
 {
-	struct npa_cn20k_aq_enq_req *aura_init_req_cn20k, *pool_init_req_cn20k;
 	struct npa_aq_enq_req *aura_init_req, *pool_init_req;
 	struct npa_aq_enq_rsp *aura_init_rsp, *pool_init_rsp;
 	struct mbox_dev *mdev = &m_box->dev[0];
@@ -91,6 +90,7 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura
 
 	mbox = mbox_get(m_box);
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *aura_init_req_cn20k;
 		aura_init_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		aura_init_req = (struct npa_aq_enq_req *)aura_init_req_cn20k;
 	} else {
@@ -104,6 +104,7 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura
 	mbox_memcpy(&aura_init_req->aura, aura, sizeof(*aura));
 
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *pool_init_req_cn20k;
 		pool_init_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		pool_init_req = (struct npa_aq_enq_req *)pool_init_req_cn20k;
 	} else {
@@ -139,7 +140,6 @@ npa_aura_pool_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura
 static int
 npa_aura_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura)
 {
-	struct npa_cn20k_aq_enq_req *aura_init_req_cn20k;
 	struct npa_aq_enq_req *aura_init_req;
 	struct npa_aq_enq_rsp *aura_init_rsp;
 	struct mbox *mbox;
@@ -147,6 +147,7 @@ npa_aura_init(struct mbox *m_box, uint32_t aura_id, struct npa_aura_s *aura)
 
 	mbox = mbox_get(m_box);
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *aura_init_req_cn20k;
 		aura_init_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		aura_init_req = (struct npa_aq_enq_req *)aura_init_req_cn20k;
 	} else {
@@ -209,10 +210,92 @@ npa_pool_multi_bp_reset(struct npa_cn20k_aq_enq_req *pool_req)
 	pool_req->pool_mask.bp_ena_7 = ~(pool_req->pool_mask.bp_ena_7);
 }
 
+static int
+npa_halo_init(struct mbox *m_box, uint32_t aura_id, struct npa_cn20k_halo_s *halo)
+{
+	struct npa_cn20k_aq_enq_req *req;
+	struct npa_aq_enq_rsp *rsp;
+	struct mbox *mbox;
+	int rc = -ENOSPC;
+
+	mbox = mbox_get(m_box);
+	req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+	if (req == NULL)
+		goto exit;
+	req->aura_id = aura_id;
+	req->ctype = NPA_AQ_CTYPE_HALO;
+	req->op = NPA_AQ_INSTOP_INIT;
+	mbox_memcpy(&req->halo, halo, sizeof(*halo));
+
+	rc = mbox_process_msg(mbox, (void **)&rsp);
+	if (rc < 0)
+		goto exit;
+
+	if (rsp->hdr.rc == 0)
+		rc = 0;
+	else
+		rc = NPA_ERR_HALO_INIT;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+static int
+npa_halo_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
+{
+	struct mbox_dev *mdev = &m_box->dev[0];
+	struct npa_cn20k_aq_enq_req *req;
+	struct npa_aq_enq_rsp *rsp;
+	int rc = -ENOSPC, off;
+	struct mbox *mbox;
+	uint64_t ptr;
+
+	/* Procedure for disabling an aura/pool */
+	plt_delay_us(10);
+
+	/* Clear all the pointers from the aura */
+	do {
+		ptr = roc_npa_aura_op_alloc(aura_handle, 0);
+	} while (ptr);
+
+	mbox = mbox_get(m_box);
+	req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+	if (req == NULL)
+		goto exit;
+
+	/* Disable backpressure on halo on CN20K */
+	if (roc_model_is_cn20k())
+		npa_pool_multi_bp_reset(req);
+
+	req->aura_id = aura_id;
+	req->ctype = NPA_AQ_CTYPE_HALO;
+	req->op = NPA_AQ_INSTOP_WRITE;
+	req->halo.ena = 0;
+	req->halo_mask.ena = ~req->halo_mask.ena;
+
+	rc = mbox_process(mbox);
+	if (rc < 0)
+		goto exit;
+
+	off = mbox->rx_start +
+	      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	rsp = (struct npa_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
+
+	if (rsp->hdr.rc != 0) {
+		rc = NPA_ERR_HALO_FINI;
+		goto exit;
+	}
+
+	rc = 0;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
 static int
 npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 {
-	struct npa_cn20k_aq_enq_req *aura_req_cn20k, *pool_req_cn20k = NULL;
+	struct npa_cn20k_aq_enq_req *pool_req_cn20k = NULL;
 	struct npa_aq_enq_req *aura_req, *pool_req;
 	struct npa_aq_enq_rsp *aura_rsp, *pool_rsp;
 	struct mbox_dev *mdev = &m_box->dev[0];
@@ -249,6 +332,7 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 	pool_req->pool_mask.ena = ~pool_req->pool_mask.ena;
 
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 		aura_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		aura_req = (struct npa_aq_enq_req *)aura_req_cn20k;
 	} else {
@@ -318,7 +402,6 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 static int
 npa_aura_fini(struct mbox *m_box, uint32_t aura_id)
 {
-	struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 	struct npa_aq_enq_req *aura_req;
 	struct npa_aq_enq_rsp *aura_rsp;
 	struct ndc_sync_op *ndc_req;
@@ -330,6 +413,7 @@ npa_aura_fini(struct mbox *m_box, uint32_t aura_id)
 
 	mbox = mbox_get(m_box);
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 		aura_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		aura_req = (struct npa_aq_enq_req *)aura_req_cn20k;
 	} else {
@@ -439,10 +523,10 @@ roc_npa_pool_op_pc_reset(uint64_t aura_handle)
 int
 roc_npa_aura_drop_set(uint64_t aura_handle, uint64_t limit, bool ena)
 {
-	struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 	struct npa_aq_enq_req *aura_req;
 	struct npa_lf *lf;
 	struct mbox *mbox;
+	uint64_t aura_id;
 	int rc;
 
 	lf = idev_npa_obj_get();
@@ -450,6 +534,7 @@ roc_npa_aura_drop_set(uint64_t aura_handle, uint64_t limit, bool ena)
 		return NPA_ERR_DEVICE_NOT_BOUNDED;
 	mbox = mbox_get(lf->mbox);
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 		aura_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		aura_req = (struct npa_aq_enq_req *)aura_req_cn20k;
 	} else {
@@ -459,8 +544,12 @@ roc_npa_aura_drop_set(uint64_t aura_handle, uint64_t limit, bool ena)
 		rc = -ENOMEM;
 		goto exit;
 	}
-	aura_req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
-	aura_req->ctype = NPA_AQ_CTYPE_AURA;
+	aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+	aura_req->aura_id = aura_id;
+	if (lf->aura_attr[aura_id].halo)
+		aura_req->ctype = NPA_AQ_CTYPE_HALO;
+	else
+		aura_req->ctype = NPA_AQ_CTYPE_AURA;
 	aura_req->op = NPA_AQ_INSTOP_WRITE;
 
 	aura_req->aura.aura_drop_ena = ena;
@@ -575,7 +664,7 @@ npa_aura_pool_pair_alloc(struct npa_lf *lf, const uint32_t block_size,
 
 	/* Block size should be cache line aligned and in range of 128B-128KB */
 	if (block_size % ROC_ALIGN || block_size < 128 ||
-	    block_size > ROC_NPA_MAX_BLOCK_SZ)
+	    block_size > roc_npa_max_block_size())
 		return NPA_ERR_INVALID_BLOCK_SZ;
 
 	/* Get aura_id from resource bitmap */
@@ -627,11 +716,21 @@ npa_aura_pool_pair_alloc(struct npa_lf *lf, const uint32_t block_size,
 	/* Update pool fields */
 	pool->stack_base = mz->iova;
 	pool->ena = 1;
+
 	/* In opaque mode buffer size must be 0 */
-	if (!pool->nat_align)
+	if (!pool->nat_align) {
 		pool->buf_size = 0;
-	else
-		pool->buf_size = block_size / ROC_ALIGN;
+	} else {
+		uint64_t buf_sz = block_size / ROC_ALIGN;
+		if (roc_model_is_cn20k()) {
+			__io struct npa_cn20k_pool_s *cn20k_pool =
+				(__io struct npa_cn20k_pool_s *)pool;
+			cn20k_pool->buf_size = buf_sz;
+		} else {
+			pool->buf_size = buf_sz;
+		}
+	}
+
 	pool->stack_max_pages = stack_size;
 	pool->shift = plt_log2_u32(block_count);
 	pool->shift = pool->shift < 8 ? 0 : pool->shift - 8;
@@ -653,6 +752,7 @@ npa_aura_pool_pair_alloc(struct npa_lf *lf, const uint32_t block_size,
 
 	lf->aura_attr[aura_id].shift = aura->shift;
 	lf->aura_attr[aura_id].limit = aura->limit;
+	lf->aura_attr[aura_id].halo = 0;
 	*aura_handle = roc_npa_aura_handle_gen(aura_id, lf->base);
 	/* Update aura count */
 	roc_npa_aura_op_cnt_set(*aura_handle, 0, block_count);
@@ -671,6 +771,86 @@ npa_aura_pool_pair_alloc(struct npa_lf *lf, const uint32_t block_size,
 	return rc;
 }
 
+static int
+npa_halo_alloc(struct npa_lf *lf, const uint32_t block_size, const uint32_t block_count,
+	       struct npa_cn20k_halo_s *halo, uint64_t *aura_handle, uint32_t flags)
+{
+	int rc, aura_id, stack_size, alloc_size, pool_id;
+	char name[PLT_MEMZONE_NAMESIZE];
+	const struct plt_memzone *mz;
+
+	/* Sanity check */
+	if (!lf || !halo || !aura_handle)
+		return NPA_ERR_PARAM;
+
+	roc_npa_dev_lock();
+	/* Get aura_id from resource bitmap */
+	aura_id = find_free_aura(lf, flags);
+	if (aura_id < 0) {
+		roc_npa_dev_unlock();
+		return NPA_ERR_AURA_ID_ALLOC;
+	}
+
+	/* Mark aura as reserved */
+	plt_bitmap_clear(lf->npa_bmp, aura_id);
+
+	roc_npa_dev_unlock();
+	rc = (aura_id < 0 || aura_id >= (int)BIT_ULL(6 + lf->aura_sz)) ? NPA_ERR_AURA_ID_ALLOC : 0;
+	if (rc)
+		goto exit;
+
+	/* Allocate stack memory */
+	stack_size = (block_count + lf->stack_pg_ptrs - 1) / lf->stack_pg_ptrs;
+	alloc_size = stack_size * lf->stack_pg_bytes;
+
+	pool_id = aura_id;
+	mz = npa_stack_dma_alloc(lf, name, pool_id, alloc_size);
+	if (mz == NULL) {
+		rc = NPA_ERR_ALLOC;
+		goto aura_res_put;
+	}
+
+	/* Update halo fields */
+	halo->ena = 1;
+	halo->shift = plt_log2_u32(block_count);
+	halo->shift = halo->shift < 8 ? 0 : halo->shift - 8;
+	halo->err_int_ena = BIT(NPA_AURA_ERR_INT_AURA_ADD_OVER);
+	halo->err_int_ena |= BIT(NPA_AURA_ERR_INT_AURA_ADD_UNDER);
+	halo->err_int_ena |= BIT(NPA_AURA_ERR_INT_AURA_FREE_UNDER);
+	halo->err_int_ena |= BIT(NPA_AURA_ERR_INT_POOL_DIS);
+	halo->avg_con = 0;
+	/* Many to one reduction */
+	halo->err_qint_idx = aura_id % lf->qints;
+	halo->stack_base = mz->iova;
+	/* In opaque mode buffer size must be 0 */
+	halo->buf_size = !halo->nat_align ? 0 : block_size / ROC_ALIGN;
+	halo->stack_max_pages = stack_size;
+	halo->ptr_start = 0;
+	halo->ptr_end = ~0;
+	halo->stack_caching = 1;
+	halo->unified_ctx = 1;
+
+	/* Issue HALO_INIT op */
+	rc = npa_halo_init(lf->mbox, aura_id, halo);
+	if (rc)
+		goto stack_mem_free;
+
+	lf->aura_attr[aura_id].shift = halo->shift;
+	lf->aura_attr[aura_id].halo = 1;
+	*aura_handle = roc_npa_aura_handle_gen(aura_id, lf->base);
+
+	return 0;
+
+stack_mem_free:
+	plt_memzone_free(mz);
+aura_res_put:
+	roc_npa_dev_lock();
+	plt_bitmap_set(lf->npa_bmp, aura_id);
+	roc_npa_dev_unlock();
+exit:
+	return rc;
+}
+
 int
 roc_npa_pool_create(uint64_t *aura_handle, uint32_t block_size,
 		    uint32_t block_count, struct npa_aura_s *aura,
@@ -713,10 +893,21 @@ roc_npa_pool_create(uint64_t *aura_handle, uint32_t block_size,
 	if (flags & ROC_NPA_FORCE_OPAQUE_MODE_F)
 		pool->nat_align = 0;
 
-	rc = npa_aura_pool_pair_alloc(lf, block_size, block_count, aura, pool,
-				      aura_handle, flags);
+	/* The pool argument will be a pointer to a npa_cn20k_halo_s structure
+	 * when ROC_NPA_HALO_F flag is set. Note that halo and pool contexts
+	 * are same in size and the fields that are modified here are 1:1
+	 * mapped in these structures.
+	 */
+	if (roc_model_is_cn20k() && (flags & ROC_NPA_HALO_F)) {
+		struct npa_cn20k_halo_s *halo = (struct npa_cn20k_halo_s *)pool;
+		rc = npa_halo_alloc(lf, block_size, block_count, halo, aura_handle, flags);
+	} else {
+		rc = npa_aura_pool_pair_alloc(lf, block_size, block_count, aura, pool,
+					      aura_handle, flags);
+	}
+
 	if (rc) {
-		plt_err("Failed to alloc pool or aura rc=%d", rc);
+		plt_err("Failed to alloc pool/aura/halo rc=%d", rc);
 		goto error;
 	}
 
@@ -773,7 +964,7 @@ npa_aura_alloc(struct npa_lf *lf, const uint32_t block_count, int pool_id,
 	/* Many to one reduction */
 	aura->err_qint_idx = aura_id % lf->qints;
 
-	/* Issue AURA_INIT and POOL_INIT op */
+	/* Issue AURA_INIT op */
 	rc = npa_aura_init(lf->mbox, aura_id, aura);
 	if (rc)
 		return rc;
@@ -836,7 +1027,6 @@ roc_npa_aura_create(uint64_t *aura_handle, uint32_t block_count,
 int
 roc_npa_aura_limit_modify(uint64_t aura_handle, uint16_t aura_limit)
 {
-	struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 	struct npa_aq_enq_req *aura_req;
 	struct npa_lf *lf;
 	struct mbox *mbox;
@@ -848,6 +1038,7 @@ roc_npa_aura_limit_modify(uint64_t aura_handle, uint16_t aura_limit)
 
 	mbox = mbox_get(lf->mbox);
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *aura_req_cn20k;
 		aura_req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		aura_req = (struct npa_aq_enq_req *)aura_req_cn20k;
 	} else {
@@ -872,6 +1063,28 @@ roc_npa_aura_limit_modify(uint64_t aura_handle, uint16_t aura_limit)
 	return rc;
 }
 
+static int
+npa_halo_free(struct npa_lf *lf, uint64_t aura_handle)
+{
+	char name[PLT_MEMZONE_NAMESIZE];
+	int aura_id, pool_id, rc;
+
+	if (!lf || !aura_handle)
+		return NPA_ERR_PARAM;
+
+	aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+	pool_id = aura_id;
+	rc = npa_halo_fini(lf->mbox, aura_id, aura_handle);
+	rc |= npa_stack_dma_free(lf, name, pool_id);
+	memset(&lf->aura_attr[aura_id], 0, sizeof(struct npa_aura_attr));
+
+	roc_npa_dev_lock();
+	plt_bitmap_set(lf->npa_bmp, aura_id);
+	roc_npa_dev_unlock();
+
+	return rc;
+}
+
 static int
 npa_aura_pool_pair_free(struct npa_lf *lf, uint64_t aura_handle)
 {
@@ -898,12 +1111,18 @@ int
 roc_npa_pool_destroy(uint64_t aura_handle)
 {
 	struct npa_lf *lf = idev_npa_obj_get();
-	int rc = 0;
+	int rc = 0, aura_id;
 
 	plt_npa_dbg("lf=%p aura_handle=0x%" PRIx64, lf, aura_handle);
-	rc = npa_aura_pool_pair_free(lf, aura_handle);
+	aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+
+	if (lf->aura_attr[aura_id].halo)
+		rc = npa_halo_free(lf, aura_handle);
+	else
+		rc = npa_aura_pool_pair_free(lf, aura_handle);
+
 	if (rc)
-		plt_err("Failed to destroy pool or aura rc=%d", rc);
+		plt_err("Failed to destroy pool/aura/halo rc=%d", rc);
 
 	/* Release the reference of npa */
 	rc |= npa_lf_fini();
@@ -952,14 +1171,13 @@ roc_npa_aura_destroy(uint64_t aura_handle)
 int
 roc_npa_pool_range_update_check(uint64_t aura_handle)
 {
-	uint64_t aura_id = roc_npa_aura_handle_to_aura(aura_handle);
-	struct npa_cn20k_aq_enq_req *req_cn20k;
 	__io struct npa_pool_s *pool;
 	struct npa_aq_enq_req *req;
 	struct npa_aq_enq_rsp *rsp;
 	struct npa_aura_lim *lim;
 	struct mbox *mbox;
 	struct npa_lf *lf;
+	uint64_t aura_id;
 	int rc;
 
 	lf = idev_npa_obj_get();
@@ -970,6 +1188,7 @@ roc_npa_pool_range_update_check(uint64_t aura_handle)
 
 	mbox = mbox_get(lf->mbox);
 	if (roc_model_is_cn20k()) {
+		struct npa_cn20k_aq_enq_req *req_cn20k;
 		req_cn20k = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
 		req = (struct npa_aq_enq_req *)req_cn20k;
 	} else {
@@ -980,8 +1199,12 @@ roc_npa_pool_range_update_check(uint64_t aura_handle)
 		goto exit;
 	}
 
+	aura_id = roc_npa_aura_handle_to_aura(aura_handle);
 	req->aura_id = aura_id;
-	req->ctype = NPA_AQ_CTYPE_POOL;
+	if (lf->aura_attr[aura_id].halo)
+		req->ctype = NPA_AQ_CTYPE_HALO;
+	else
+		req->ctype = NPA_AQ_CTYPE_POOL;
 	req->op = NPA_AQ_INSTOP_READ;
 
 	rc = mbox_process_msg(mbox, (void *)&rsp);
@@ -1140,7 +1363,6 @@ int
 roc_npa_aura_bp_configure(uint64_t aura_handle, uint16_t bpid, uint8_t bp_intf, uint8_t bp_thresh,
 			  bool enable)
 {
-	/* TODO: Add support for CN20K */
 	uint32_t aura_id = roc_npa_aura_handle_to_aura(aura_handle);
 	struct npa_lf *lf = idev_npa_obj_get();
 	struct npa_aq_enq_req *req;
diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index 336a43f95c..18808e5873 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -21,7 +21,9 @@
 
 #define ROC_AURA_OP_LIMIT_MASK (BIT_ULL(36) - 1)
 
-#define ROC_NPA_MAX_BLOCK_SZ		   (128 * 1024)
+#define ROC_NPA_MAX_BLOCK_SZ_CN9K	   (128 * 1024)
+#define ROC_NPA_MAX_BLOCK_SZ_CN10K	   (128 * 1024)
+#define ROC_NPA_MAX_BLOCK_SZ_CN20K	   (256 * 1024)
 #define ROC_CN10K_NPA_BATCH_ALLOC_MAX_PTRS 512
 #define ROC_CN10K_NPA_BATCH_FREE_MAX_PTRS  15U
 #define ROC_CN10K_NPA_BATCH_FREE_BURST_MAX 16U
@@ -36,6 +38,17 @@
  */
 #define ROC_CN9K_NPA_BULK_ALLOC_MAX_PTRS 30
 
+static inline uint32_t
+roc_npa_max_block_size(void)
+{
+	if (roc_model_is_cn20k())
+		return ROC_NPA_MAX_BLOCK_SZ_CN20K;
+	else if (roc_model_is_cn10k())
+		return ROC_NPA_MAX_BLOCK_SZ_CN10K;
+	else
+		return ROC_NPA_MAX_BLOCK_SZ_CN9K;
+}
+
 /*
  * Generate 64bit handle to have optimized alloc and free aura operation.
  * 0 - ROC_AURA_ID_MASK for storing the aura_id.
@@ -767,8 +780,9 @@ int __roc_api roc_npa_dev_init(struct roc_npa *roc_npa);
 int __roc_api roc_npa_dev_fini(struct roc_npa *roc_npa);
 
 /* Flags to pool create */
-#define ROC_NPA_ZERO_AURA_F	    BIT(0)
-#define ROC_NPA_FORCE_OPAQUE_MODE_F BIT(1)
+#define ROC_NPA_ZERO_AURA_F		BIT(0)
+#define ROC_NPA_FORCE_OPAQUE_MODE_F	BIT(1)
+#define ROC_NPA_HALO_F			BIT(2)
 
 /* Enumerations */
 enum roc_npa_buf_type {
diff --git a/drivers/common/cnxk/roc_npa_debug.c b/drivers/common/cnxk/roc_npa_debug.c
index 9a16f481a8..e64696730f 100644
--- a/drivers/common/cnxk/roc_npa_debug.c
+++ b/drivers/common/cnxk/roc_npa_debug.c
@@ -86,10 +86,171 @@ npa_aura_dump(__io struct npa_aura_s *aura)
 	npa_dump("W6: thresh\t\t%" PRIx64 "\n", (uint64_t)aura->thresh);
 }
 
+static inline void
+npa_cn20k_pool_dump(__io struct npa_cn20k_pool_s *pool)
+{
+	npa_dump("W0: Stack base\t\t0x%" PRIx64 "\n", pool->stack_base);
+	npa_dump("W1: ena \t\t%d\nW1: nat_align \t\t%d\nW1: stack_caching \t%d",
+		 pool->ena, pool->nat_align, pool->stack_caching);
+	npa_dump("W1: buf_offset \t\t%d", pool->buf_offset);
+	npa_dump("W1: buf_size \t\t%d\nW1: ref_cnt_prof \t%d",
+		 pool->buf_size, pool->ref_cnt_prof);
+
+	npa_dump("W2: stack_max_pages \t%d\nW2: stack_pages\t\t%d\n",
+		 pool->stack_max_pages, pool->stack_pages);
+
+	npa_dump("W3: bp_0 \t\t%d\nW3: bp_1 \t\t%d\nW3: bp_2 \t\t%d",
+		 pool->bp_0, pool->bp_1, pool->bp_2);
+	npa_dump("W3: bp_3 \t\t%d\nW3: bp_4 \t\t%d\nW3: bp_5 \t\t%d",
+		 pool->bp_3, pool->bp_4, pool->bp_5);
+	npa_dump("W3: bp_6 \t\t%d\nW3: bp_7 \t\t%d", pool->bp_6, pool->bp_7);
+	npa_dump("W3: bp_ena_0 \t\t%d\nW3: bp_ena_1 \t\t%d", pool->bp_ena_0,
+		 pool->bp_ena_1);
+	npa_dump("W3: bp_ena_2 \t\t%d\nW3: bp_ena_3 \t\t%d", pool->bp_ena_2,
+		 pool->bp_ena_3);
+	npa_dump("W3: bp_ena_4 \t\t%d\nW3: bp_ena_5 \t\t%d", pool->bp_ena_4,
+		 pool->bp_ena_5);
+	npa_dump("W3: bp_ena_6 \t\t%d\nW3: bp_ena_7 \t\t%d\n", pool->bp_6,
+		 pool->bp_7);
+
+	npa_dump("W4: stack_offset\t%d\nW4: shift\t\t%d\nW4: avg_level\t\t%d",
+		 pool->stack_offset, pool->shift, pool->avg_level);
+	npa_dump("W4: avg_con \t\t%d\nW4: fc_ena\t\t%d\nW4: fc_stype\t\t%d",
+		 pool->avg_con, pool->fc_ena, pool->fc_stype);
+	npa_dump("W4: fc_hyst_bits\t%d\nW4: fc_up_crossing\t%d",
+		 pool->fc_hyst_bits, pool->fc_up_crossing);
+	npa_dump("W4: update_time\t\t%d\n", pool->update_time);
+
+	npa_dump("W5: fc_addr\t\t0x%" PRIx64 "\n", pool->fc_addr);
+
+	npa_dump("W6: ptr_start\t\t0x%" PRIx64 "\n", pool->ptr_start);
+
+	npa_dump("W7: ptr_end\t\t0x%" PRIx64 "\n", pool->ptr_end);
+
+	npa_dump("W8: bpid_0 \t\t%d", pool->bpid_0);
+	npa_dump("W8: err_int\t\t%d\nW8: err_int_ena\t\t%d", pool->err_int,
+		 pool->err_int_ena);
+	npa_dump("W8: thresh_int\t\t%d", pool->thresh_int);
+	npa_dump("W8: thresh_int_ena\t%d\nW8: thresh_up\t\t%d",
+		 pool->thresh_int_ena, pool->thresh_up);
+	npa_dump("W8: thresh_qint_idx\t%d\nW8: err_qint_idx\t%d\n",
+		 pool->thresh_qint_idx, pool->err_qint_idx);
+	npa_dump("W9: thresh\t\t%" PRIx64 "", (uint64_t)pool->thresh);
+	npa_dump("W9: fc_msh_dst \t\t%d", pool->fc_msh_dst);
+	npa_dump("W9: op_dpc_ena \t\t%d\nW9: op_dpc_set \t\t%d",
+		 pool->op_dpc_ena, pool->op_dpc_set);
+	npa_dump("W9: stream_ctx \t\t%d", pool->stream_ctx);
+}
+
+static inline void
+npa_halo_dump(__io struct npa_cn20k_halo_s *halo)
+{
+	npa_dump("W0: Stack base\t\t0x%" PRIx64 "\n", halo->stack_base);
+	npa_dump("W1: ena \t\t%d\nW1: nat_align \t\t%d\nW1: stack_caching \t%d",
+		 halo->ena, halo->nat_align, halo->stack_caching);
+	npa_dump("W1: buf_offset\t\t%d\nW1: buf_size\t\t%d",
+		 halo->buf_offset, halo->buf_size);
+	npa_dump("W1: ref_cnt_prof \t%d\n", halo->ref_cnt_prof);
+
+	npa_dump("W2: stack_max_pages \t%d\nW2: stack_pages\t\t%d\n",
+		 halo->stack_max_pages, halo->stack_pages);
+
+	npa_dump("W3: bp_0 \t\t%d\nW3: bp_1 \t\t%d\nW3: bp_2 \t\t%d",
+		 halo->bp_0, halo->bp_1, halo->bp_2);
+	npa_dump("W3: bp_3 \t\t%d\nW3: bp_4 \t\t%d\nW3: bp_5 \t\t%d",
+		 halo->bp_3, halo->bp_4, halo->bp_5);
+	npa_dump("W3: bp_6 \t\t%d\nW3: bp_7 \t\t%d", halo->bp_6, halo->bp_7);
+
+	npa_dump("W3: bp_ena_0 \t\t%d\nW3: bp_ena_1 \t\t%d", halo->bp_ena_0,
+		 halo->bp_ena_1);
+	npa_dump("W3: bp_ena_2 \t\t%d\nW3: bp_ena_3 \t\t%d", halo->bp_ena_2,
+		 halo->bp_ena_3);
+	npa_dump("W3: bp_ena_4 \t\t%d\nW3: bp_ena_5 \t\t%d", halo->bp_ena_4,
+		 halo->bp_ena_5);
+	npa_dump("W3: bp_ena_6 \t\t%d\nW3: bp_ena_7 \t\t%d\n", halo->bp_6,
+		 halo->bp_7);
+
+	npa_dump("W4: stack_offset\t%d\nW4: shift\t\t%d\nW4: avg_level\t\t%d",
+		 halo->stack_offset, halo->shift, halo->avg_level);
+	npa_dump("W4: avg_con \t\t%d\nW4: fc_ena\t\t%d\nW4: fc_stype\t\t%d",
+		 halo->avg_con, halo->fc_ena, halo->fc_stype);
+	npa_dump("W4: fc_hyst_bits\t%d\nW4: fc_up_crossing\t%d",
+		 halo->fc_hyst_bits, halo->fc_up_crossing);
+	npa_dump("W4: update_time\t\t%d\n", halo->update_time);
+
+	npa_dump("W5: fc_addr\t\t0x%" PRIx64 "\n", halo->fc_addr);
+
+	npa_dump("W6: ptr_start\t\t0x%" PRIx64 "\n", halo->ptr_start);
+
+	npa_dump("W7: ptr_end\t\t0x%" PRIx64 "\n", halo->ptr_end);
+	npa_dump("W8: bpid_0 \t\t%d", halo->bpid_0);
+	npa_dump("W8: err_int\t\t%d\nW8: err_int_ena\t\t%d", halo->err_int,
+		 halo->err_int_ena);
+	npa_dump("W8: thresh_int\t\t%d", halo->thresh_int);
+
+	npa_dump("W8: thresh_int_ena\t%d\nW8: thresh_up\t\t%d",
+		 halo->thresh_int_ena, halo->thresh_up);
+	npa_dump("W8: thresh_qint_idx\t%d\nW8: err_qint_idx\t%d\n",
+		 halo->thresh_qint_idx, halo->err_qint_idx);
+	npa_dump("W9: thresh \t\t%" PRIx64 "\nW9: fc_msh_dst \t\t%d",
+		 (unsigned long)halo->thresh, halo->fc_msh_dst);
+	npa_dump("W9: op_dpc_ena \t\t%d\nW9: op_dpc_set \t\t%d",
+		 halo->op_dpc_ena, halo->op_dpc_set);
+	npa_dump("W9: stream_ctx \t\t%d\nW9: unified_ctx \t%d",
+		 halo->stream_ctx, halo->unified_ctx);
+}
+
+static inline void
+npa_cn20k_aura_dump(__io struct npa_cn20k_aura_s *aura)
+{
+	npa_dump("W0: Pool addr\t\t0x%" PRIx64 "\n", aura->pool_addr);
+
+	npa_dump("W1: ena\t\t\t%d\nW1: pool caching\t%d", aura->ena,
+		 aura->pool_caching);
+	npa_dump("W1: avg con\t\t%d\nW1: pool drop ena\t%d", aura->avg_con,
+		 aura->pool_drop_ena);
+	npa_dump("W1: aura drop ena\t%d", aura->aura_drop_ena);
+	npa_dump("W1: bp_ena\t\t%d", aura->bp_ena);
+	npa_dump("W1: aura drop\t\t%d\nW1: aura shift\t\t%d", aura->aura_drop,
+		 aura->shift);
+	npa_dump("W1: avg_level\t\t%d\n", aura->avg_level);
+
+	npa_dump("W2: count\t\t%" PRIx64 "", (uint64_t)aura->count);
+	npa_dump("W2: bpid\t\t%d\n", aura->bpid);
+
+	npa_dump("W3: limit\t\t%" PRIx64 "", (uint64_t)aura->limit);
+	npa_dump("W3: bp\t\t\t%d", aura->bp);
+	npa_dump("W3: fc_ena\t\t%d", aura->fc_ena);
+	npa_dump("W3: fc_up_crossing\t%d\nW3: fc_stype\t\t%d",
+		 aura->fc_up_crossing, aura->fc_stype);
+
+	npa_dump("W3: fc_hyst_bits\t%d\n", aura->fc_hyst_bits);
+
+	npa_dump("W4: fc_addr\t\t0x%" PRIx64 "\n", aura->fc_addr);
+
+	npa_dump("W5: pool_drop\t\t%d\nW5: update_time\t\t%d", aura->pool_drop,
+		 aura->update_time);
+	npa_dump("W5: err_int\t\t%d", aura->err_int);
+	npa_dump("W5: err_int_ena\t\t%d\nW5: thresh_int\t\t%d",
+		 aura->err_int_ena, aura->thresh_int);
+	npa_dump("W5: thresh_int_ena\t%d", aura->thresh_int_ena);
+
+	npa_dump("W5: thresh_up\t\t%d\nW5: thresh_qint_idx\t%d",
+		 aura->thresh_up, aura->thresh_qint_idx);
+	npa_dump("W5: err_qint_idx\t%d\n", aura->err_qint_idx);
+
+	npa_dump("W6: thresh\t\t%" PRIx64 "", (uint64_t)aura->thresh);
+	npa_dump("W6: fc_msh_dst \t\t%d", aura->fc_msh_dst);
+	npa_dump("W6: op_dpc_ena \t\t%d\nW6: op_dpc_set \t\t%d",
+		 aura->op_dpc_ena, aura->op_dpc_set);
+	npa_dump("W6: stream_ctx \t\t%d", aura->stream_ctx);
+}
+
 int
 roc_npa_ctx_dump(void)
 {
 	struct npa_cn20k_aq_enq_req *aq_cn20k;
+	struct npa_cn20k_aq_enq_rsp *rsp_cn20k;
 	struct npa_aq_enq_rsp *rsp;
 	struct npa_aq_enq_req *aq;
 	struct mbox *mbox;
@@ -103,7 +264,7 @@ roc_npa_ctx_dump(void)
 	mbox = mbox_get(lf->mbox);
 
 	for (q = 0; q < lf->nr_pools; q++) {
-		/* Skip disabled POOL */
+		/* Skip disabled AURA */
 		if (plt_bitmap_get(lf->npa_bmp, q))
 			continue;
 
@@ -118,21 +279,34 @@ roc_npa_ctx_dump(void)
 			goto exit;
 		}
 		aq->aura_id = q;
-		aq->ctype = NPA_AQ_CTYPE_POOL;
 		aq->op = NPA_AQ_INSTOP_READ;
+		if (lf->aura_attr[q].halo) {
+			aq->ctype = NPA_AQ_CTYPE_HALO;
+			rc = mbox_process_msg(mbox, (void *)&rsp_cn20k);
+		} else {
+			aq->ctype = NPA_AQ_CTYPE_AURA;
+			rc = mbox_process_msg(mbox, (void *)&rsp);
+		}
 
-		rc = mbox_process_msg(mbox, (void *)&rsp);
 		if (rc) {
-			plt_err("Failed to get pool(%d) context", q);
+			plt_err("Failed to get aura/halo(%d) context", q);
 			goto exit;
 		}
-		npa_dump("============== pool=%d ===============\n", q);
-		npa_pool_dump(&rsp->pool);
+		if (lf->aura_attr[q].halo) {
+			npa_dump("============== halo=%d ===============\n", q);
+			npa_halo_dump(&rsp_cn20k->halo);
+		} else {
+			npa_dump("============== aura=%d ===============\n", q);
+			if (roc_model_is_cn20k())
+				npa_cn20k_aura_dump(&rsp_cn20k->aura);
+			else
+				npa_aura_dump(&rsp->aura);
+		}
 	}
 
 	for (q = 0; q < lf->nr_pools; q++) {
-		/* Skip disabled AURA */
-		if (plt_bitmap_get(lf->npa_bmp, q))
+		/* Skip halo and disabled POOL */
+		if (plt_bitmap_get(lf->npa_bmp, q) || lf->aura_attr[q].halo)
 			continue;
 
 		if (roc_model_is_cn20k()) {
@@ -146,16 +320,19 @@ roc_npa_ctx_dump(void)
 			goto exit;
 		}
 		aq->aura_id = q;
-		aq->ctype = NPA_AQ_CTYPE_AURA;
+		aq->ctype = NPA_AQ_CTYPE_POOL;
 		aq->op = NPA_AQ_INSTOP_READ;
 
 		rc = mbox_process_msg(mbox, (void *)&rsp);
 		if (rc) {
-			plt_err("Failed to get aura(%d) context", q);
+			plt_err("Failed to get pool(%d) context", q);
 			goto exit;
 		}
-		npa_dump("============== aura=%d ===============\n", q);
-		npa_aura_dump(&rsp->aura);
+		npa_dump("============== pool=%d ===============\n", q);
+		if (roc_model_is_cn20k())
+			npa_cn20k_pool_dump(&rsp_cn20k->pool);
+		else
+			npa_pool_dump(&rsp->pool);
 	}
 
 exit:
diff --git a/drivers/common/cnxk/roc_npa_priv.h b/drivers/common/cnxk/roc_npa_priv.h
index 0223e4a438..e437fe831a 100644
--- a/drivers/common/cnxk/roc_npa_priv.h
+++ b/drivers/common/cnxk/roc_npa_priv.h
@@ -14,6 +14,8 @@ enum npa_error_status {
 	NPA_ERR_AURA_POOL_FINI = -517,
 	NPA_ERR_BASE_INVALID = -518,
 	NPA_ERR_DEVICE_NOT_BOUNDED = -519,
+	NPA_ERR_HALO_INIT = -520,
+	NPA_ERR_HALO_FINI = -521,
 };
 
 struct npa_lf {
@@ -55,6 +57,7 @@ struct npa_aura_attr {
 	uint64_t shift;
 	uint64_t limit;
 	uint8_t bp_ena;
+	bool halo;
 	union {
 		uint8_t bp;	      /* CN9K, CN10K */
 		uint8_t bp_thresh[8]; /* CN20K */
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 43095741f5..79dd18fbd7 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -85,6 +85,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha256_gen)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha512_gen)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_set)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_halo_ena_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_halo_ena_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_lmt_base_addr_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_num_lmtlines_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_get)
diff --git a/drivers/common/cnxk/roc_sso.c b/drivers/common/cnxk/roc_sso.c
index 1d82e5b978..b07454a7f0 100644
--- a/drivers/common/cnxk/roc_sso.c
+++ b/drivers/common/cnxk/roc_sso.c
@@ -834,8 +834,6 @@ sso_hwgrp_init_xaq_aura(struct dev *dev, struct roc_sso_xaq_data *xaq,
 			uint32_t nb_xae, uint32_t xae_waes,
 			uint32_t xaq_buf_size, uint16_t nb_hwgrp)
 {
-	struct npa_pool_s pool;
-	struct npa_aura_s aura;
 	plt_iova_t iova;
 	uint32_t i;
 	int rc;
@@ -877,15 +875,32 @@ sso_hwgrp_init_xaq_aura(struct dev *dev, struct roc_sso_xaq_data *xaq,
 		goto free_fc;
 	}
 
-	memset(&pool, 0, sizeof(struct npa_pool_s));
-	pool.nat_align = 1;
+	if (roc_model_is_cn20k() && xaq->halo_ena) {
+		struct npa_cn20k_halo_s halo;
+
+		memset(&halo, 0, sizeof(struct npa_cn20k_halo_s));
+		halo.nat_align = 1;
+		halo.fc_ena = 1;
+		halo.fc_addr = (uint64_t)xaq->fc;
+		halo.fc_hyst_bits = 0; /* Store count on all updates */
+		halo.unified_ctx = 1;
+		rc = roc_npa_pool_create(&xaq->aura_handle, xaq_buf_size, xaq->nb_xaq,
+					 NULL, (struct npa_pool_s *)&halo, ROC_NPA_HALO_F);
+	} else {
+		struct npa_pool_s pool;
+		struct npa_aura_s aura;
+
+		memset(&pool, 0, sizeof(struct npa_pool_s));
+		pool.nat_align = 1;
+
+		memset(&aura, 0, sizeof(aura));
+		aura.fc_ena = 1;
+		aura.fc_addr = (uint64_t)xaq->fc;
+		aura.fc_hyst_bits = 0; /* Store count on all updates */
+		rc = roc_npa_pool_create(&xaq->aura_handle, xaq_buf_size, xaq->nb_xaq,
+					 &aura, &pool, 0);
+	}
 
-	memset(&aura, 0, sizeof(aura));
-	aura.fc_ena = 1;
-	aura.fc_addr = (uint64_t)xaq->fc;
-	aura.fc_hyst_bits = 0; /* Store count on all updates */
-	rc = roc_npa_pool_create(&xaq->aura_handle, xaq_buf_size, xaq->nb_xaq,
-				 &aura, &pool, 0);
 	if (rc) {
 		plt_err("Failed to create XAQ pool");
 		goto npa_fail;
diff --git a/drivers/common/cnxk/roc_sso.h b/drivers/common/cnxk/roc_sso.h
index f1ad34bcc7..9d8356abb1 100644
--- a/drivers/common/cnxk/roc_sso.h
+++ b/drivers/common/cnxk/roc_sso.h
@@ -43,6 +43,7 @@ struct roc_sso_xaq_data {
 	uint32_t nb_xae;
 	uint32_t xaq_lmt;
 	uint64_t aura_handle;
+	int halo_ena;
 	void *fc;
 	void *mem;
 };
-- 
2.48.1

