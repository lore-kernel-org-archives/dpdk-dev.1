Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79943EFCBB6
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 06:27:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE674025E;
	Mon, 16 Mar 2026 07:27:29 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3377B400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 07:27:28 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FNqbhu3172801 for <dev@dpdk.org>; Sun, 15 Mar 2026 23:27:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 9W/4XjtewM1RalYzpScMwzbMmxOQGt4HoSYkyTIgQw=; b=hVfnPbYVZMpha8pEv
 EfvSpXqqTBXiGlW+xi3UmY3viPSMAlgVTlMrg6M8bHRYauZM6VnmpOY76gOK2gQs
 dnOF5S15n4lxLQ4eXxM+AqMzsb4s5YLQ8LnrZeDVUAgZ69jWevqEGp+JycTEkNRs
 TMLaO23iqFeQNllbiSJKQX3rjh2YJGGTCc3wiU8KQBKNmHuOJAD5yKSlEBXJH8Cz
 jeQm6AjsUgp5KxyAGCoeIphftpHFJ0LLkcgmxuVcoZM5wWreYyum0oS82hoP8j57
 TxPb2s1qFP+Y93XSm89sleKFjhTusKhiW6xgBk2RDYbtmPBYUBe/JTuBYJ1HbsPe
 5YeJg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cwre8hrkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 15 Mar 2026 23:27:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Mar 2026 23:27:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 15 Mar 2026 23:27:25 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 3B87F3F7091;
 Sun, 15 Mar 2026 23:27:23 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH v2] common/cnxk: add NPA diagnostic and performance counter
 apis
Date: Mon, 16 Mar 2026 11:57:17 +0530
Message-ID: <20260316062720.4181631-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260316055057.4174060-1-nkishor@marvell.com>
References: <20260316055057.4174060-1-nkishor@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69b7a2cf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=d2PnNnB2ApeaiuTy4fkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0NyBTYWx0ZWRfX9Iq55FUH+e7O
 E6lcEn9YOCMYCvU0x9xefe6H/lyYhVyEnnXUpH1/9HCHJh2weLD/PqF3Iqx2UvrcQMC6rCuWG8H
 rI+OhHIc+jFHjR7DlrotNSWTqTo5fJNeEf4/dcETxI+7J1fJABpswRmhhcM2dUuNdPxtnItDspW
 9vtRBNFCquzMhaiT0Z2TOMMrfM0fPmHgyigmVVbSoi7nRdCz5UDyO297s5qFNlGOt+tuXTs4aLM
 Z/TvBbhE8J9kRFo39CnfIjEJvsVOPZK+r9ddugvcsvVtGnFgwhqzMtlvztMTKIHdWLdPxrcLhHF
 oOYf9mKUzXZnBckYH1Vk6YWLLG6dUUqL/TaVhEDkLJAUlvklNAGVBEE53bX9X8vNqc47e0yoKmZ
 pW14m0GF3uXWd6QXbdE3wInDoakecvRnRCiloJeGuGCahaJ6zoyx2Z2fhzchVEDtLVLNO7CWRB+
 ATRxDuIQQ7puNatoRUg==
X-Proofpoint-GUID: usxNxG6QuV6aL2y8uToCkKz8pbVgT7t1
X-Proofpoint-ORIG-GUID: usxNxG6QuV6aL2y8uToCkKz8pbVgT7t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
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

Add DPC (Diagnostic and Performance Counter) support for NPA pool
operations on CN20K. This allows allocating and attaching hardware
counters to pool/aura for monitoring alloc/free, outstanding buffers,
and high-watermark.

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
v2:
 * Fixed commit message.

 drivers/common/cnxk/hw/npa.h                  |  10 +
 drivers/common/cnxk/roc_features.h            |   6 +
 drivers/common/cnxk/roc_mbox.h                |  19 ++
 drivers/common/cnxk/roc_npa.c                 | 235 ++++++++++++++++++
 drivers/common/cnxk/roc_npa.h                 |  45 ++++
 drivers/common/cnxk/roc_npa_priv.h            |   2 +
 .../common/cnxk/roc_platform_base_symbols.c   |   4 +
 7 files changed, 321 insertions(+)

diff --git a/drivers/common/cnxk/hw/npa.h b/drivers/common/cnxk/hw/npa.h
index e421c70e01..8d6b6bbe8b 100644
--- a/drivers/common/cnxk/hw/npa.h
+++ b/drivers/common/cnxk/hw/npa.h
@@ -48,6 +48,8 @@
 #define NPA_AF_BATCH_ACCEPT_CTL	     (0x6a8ull) /* [CN10K, .) */
 #define NPA_AF_BATCH_ERR_DATA0	     (0x6c0ull) /* [CN10K, .) */
 #define NPA_AF_BATCH_ERR_DATA1	     (0x6c8ull) /* [CN10K, .) */
+#define NPA_AF_DPCX_CFG(a)           (0x800ull | (uint64_t)(a) << 6)  /* [CN20K, .) */
+#define NPA_AF_DPC_PERMITX(a)        (0x1000ull | (uint64_t)(a) << 3) /* [CN20K, .) */
 #define NPA_AF_LFX_AURAS_CFG(a)	     (0x4000ull | (uint64_t)(a) << 18)
 #define NPA_AF_LFX_LOC_AURAS_BASE(a) (0x4010ull | (uint64_t)(a) << 18)
 #define NPA_AF_LFX_QINTS_CFG(a)	     (0x4100ull | (uint64_t)(a) << 18)
@@ -89,6 +91,14 @@
 #define NPA_LF_AURA_BATCH_FREE0	  (0x400ull) /* [CN10K, .) */
 #define NPA_LF_AURA_BATCH_FREEX(a)                                             \
 	(0x400ull | (uint64_t)(a) << 3) /* [CN10K, .) */
+#define NPA_LF_DPCX_ALLOC_CNT(a)                                               \
+	(0x808ull | (uint64_t)(a) << 6) /* [CN20K, .) */
+#define NPA_LF_DPCX_FREE_CNT(a)                                                \
+	(0x810ull | (uint64_t)(a) << 6) /* [CN20K, .) */
+#define NPA_LF_DPCX_OUTST_BUF_CNT(a)                                           \
+	(0x818ull | (uint64_t)(a) << 6) /* [CN20K, .) */
+#define NPA_LF_DPCX_CNT_HI_WM(a)                                               \
+	(0x820ull | (uint64_t)(a) << 6) /* [CN20K, .) */
 
 /* Enum offsets */
 
diff --git a/drivers/common/cnxk/roc_features.h b/drivers/common/cnxk/roc_features.h
index 3c34041d76..2d8bad5b0c 100644
--- a/drivers/common/cnxk/roc_features.h
+++ b/drivers/common/cnxk/roc_features.h
@@ -132,6 +132,12 @@ roc_feature_nix_has_sq_cnt_update(void)
 	return roc_model_is_cn20k();
 }
 
+static inline bool
+roc_feature_npa_has_dpc(void)
+{
+	return roc_model_is_cn20k();
+}
+
 static inline bool
 roc_feature_nix_has_16b_align(void)
 {
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 3176c87382..e86446c339 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -123,6 +123,10 @@ struct mbox_msghdr {
 	  msg_rsp)                                                             \
 	M(NPA_CN20K_AQ_ENQ, 0x404, npa_cn20k_aq_enq, npa_cn20k_aq_enq_req,     \
 	  npa_cn20k_aq_enq_rsp)                                                \
+	M(NPA_CN20K_DPC_ALLOC, 0x405, npa_cn20k_dpc_alloc,                     \
+	  npa_cn20k_dpc_alloc_req, npa_cn20k_dpc_alloc_rsp)                    \
+	M(NPA_CN20K_DPC_FREE,  0x406, npa_cn20k_dpc_free,                      \
+	  npa_cn20k_dpc_free_req, msg_rsp)                                     \
 	/* SSO/SSOW mbox IDs (range 0x600 - 0x7FF) */                          \
 	M(SSO_LF_ALLOC, 0x600, sso_lf_alloc, sso_lf_alloc_req,                 \
 	  sso_lf_alloc_rsp)                                                    \
@@ -1423,6 +1427,21 @@ struct npa_cn20k_aq_enq_rsp {
 	};
 };
 
+struct npa_cn20k_dpc_alloc_req {
+	struct mbox_msghdr hdr;
+	uint16_t __io dpc_conf;
+};
+
+struct npa_cn20k_dpc_alloc_rsp {
+	struct mbox_msghdr hdr;
+	uint8_t __io cntr_id;
+};
+
+struct npa_cn20k_dpc_free_req {
+	struct mbox_msghdr hdr;
+	uint8_t __io cntr_id;
+};
+
 /* Disable all contexts of type 'ctype' */
 struct hwctx_disable_req {
 	struct mbox_msghdr hdr;
diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 10087e19ef..88e328105a 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -1803,3 +1803,238 @@ roc_npa_dev_unlock(void)
 	if (idev != NULL)
 		plt_spinlock_unlock(&idev->npa_dev_lock);
 }
+
+int
+roc_npa_dpc_alloc(uint8_t *counter_id, uint16_t conf)
+{
+	struct npa_cn20k_dpc_alloc_req *req;
+	struct npa_cn20k_dpc_alloc_rsp *rsp;
+	int rc = NPA_ERR_DPC_ALLOC, off;
+	struct mbox_dev *mdev;
+	struct mbox *mbox;
+	struct npa_lf *lf;
+
+	lf = idev_npa_obj_get();
+	if (lf == NULL) {
+		rc = NPA_ERR_DEVICE_NOT_BOUNDED;
+		return rc;
+	}
+	mdev = &lf->mbox->dev[0];
+
+	mbox = mbox_get(lf->mbox);
+	req = mbox_alloc_msg_npa_cn20k_dpc_alloc(mbox);
+	if (req == NULL)
+		goto exit;
+
+	req->dpc_conf = conf;
+	rc = mbox_process(mbox);
+	if (rc < 0)
+		goto exit;
+
+	off = mbox->rx_start +
+	      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	rsp = (struct npa_cn20k_dpc_alloc_rsp *)((uintptr_t)mdev->mbase + off);
+
+	if (rsp->hdr.rc != 0)
+		goto exit;
+
+	*counter_id = rsp->cntr_id;
+	rc = 0;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_npa_dpc_free(uint8_t counter_id)
+{
+	struct npa_cn20k_dpc_free_req *free_req;
+	int rc = NPA_ERR_DPC_FREE, off;
+	struct mbox_dev *mdev;
+	struct msg_rsp *rsp;
+	struct mbox *mbox;
+	struct npa_lf *lf;
+
+	lf = idev_npa_obj_get();
+	if (lf == NULL) {
+		rc = NPA_ERR_DEVICE_NOT_BOUNDED;
+		return rc;
+	}
+	mdev = &lf->mbox->dev[0];
+	mbox = mbox_get(lf->mbox);
+	free_req = mbox_alloc_msg_npa_cn20k_dpc_free(mbox);
+	if (free_req == NULL)
+		goto exit;
+
+	free_req->cntr_id = counter_id;
+	rc = mbox_process(mbox);
+	if (rc < 0)
+		goto exit;
+
+	off = mbox->rx_start +
+	      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	rsp = (struct msg_rsp *)((uintptr_t)mdev->mbase + off);
+	if (rsp->hdr.rc != 0)
+		goto exit;
+
+	rc = 0;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_npa_pool_dpc_enable(uint64_t aura_handle, uint8_t counter_id, uint32_t flags)
+{
+	struct npa_cn20k_aq_enq_req *req;
+	struct npa_cn20k_aq_enq_rsp *rsp;
+	int rc = -ENOSPC, off;
+	struct mbox_dev *mdev;
+	struct mbox *mbox;
+	struct npa_lf *lf;
+
+	lf = idev_npa_obj_get();
+	if (lf == NULL) {
+		rc = NPA_ERR_DEVICE_NOT_BOUNDED;
+		return rc;
+	}
+	mdev = &lf->mbox->dev[0];
+	mbox = mbox_get(lf->mbox);
+	req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+	if (req == NULL)
+		goto exit;
+
+	req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+	req->op = NPA_AQ_INSTOP_WRITE;
+	if (!(flags & ROC_NPA_HALO_F)) {
+		/* Enable DPC in Pool */
+		req->ctype = NPA_AQ_CTYPE_POOL;
+		req->pool.op_dpc_ena = 1;
+		req->pool.op_dpc_set = counter_id;
+		req->pool_mask.op_dpc_ena = 1;
+		req->pool_mask.op_dpc_set = 0;
+		req->pool_mask.op_dpc_set = ~req->pool_mask.op_dpc_set;
+	} else {
+		/* Enable DPC in Halo */
+		req->ctype = NPA_AQ_CTYPE_HALO;
+		req->halo.op_dpc_ena = 1;
+		req->halo.op_dpc_set = counter_id;
+		req->halo_mask.op_dpc_ena = 1;
+		req->halo_mask.op_dpc_set = 0;
+		req->halo_mask.op_dpc_set = ~req->halo_mask.op_dpc_set;
+	}
+
+	rc = mbox_process(mbox);
+	if (rc < 0)
+		goto exit;
+
+	off = mbox->rx_start +
+	      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	rsp = (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
+	if (rsp->hdr.rc != 0)
+		goto exit;
+
+	if (!(flags & ROC_NPA_HALO_F)) {
+		req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+		if (req == NULL)
+			goto disable;
+
+		/* Enable DPC in Aura */
+		req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+		req->op = NPA_AQ_INSTOP_WRITE;
+		req->ctype = NPA_AQ_CTYPE_AURA;
+		req->aura.op_dpc_ena = 1;
+		req->aura.op_dpc_set = counter_id;
+		req->aura_mask.op_dpc_ena = 1;
+		req->aura_mask.op_dpc_set = 0;
+		req->aura_mask.op_dpc_set = ~req->aura_mask.op_dpc_set;
+
+		rc = mbox_process(mbox);
+		if (rc < 0)
+			goto disable;
+
+		off = mbox->rx_start +
+		      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+		rsp = (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
+		if (rsp->hdr.rc != 0)
+			goto disable;
+	}
+	rc = 0;
+	goto exit;
+
+disable:
+	roc_npa_pool_dpc_disable(aura_handle, flags);
+exit:
+	mbox_put(mbox);
+	return rc;
+}
+
+int
+roc_npa_pool_dpc_disable(uint64_t aura_handle, uint32_t flags)
+{
+	struct npa_cn20k_aq_enq_req *req;
+	struct npa_cn20k_aq_enq_rsp *rsp;
+	int rc = -ENOSPC, off;
+	struct mbox_dev *mdev;
+	struct mbox *mbox;
+	struct npa_lf *lf;
+
+	lf = idev_npa_obj_get();
+	if (lf == NULL) {
+		rc = NPA_ERR_DEVICE_NOT_BOUNDED;
+		return rc;
+	}
+	mdev = &lf->mbox->dev[0];
+	mbox = mbox_get(lf->mbox);
+	req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+	if (req == NULL)
+		goto exit;
+
+	req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+	req->op = NPA_AQ_INSTOP_WRITE;
+	if (!(flags & ROC_NPA_HALO_F)) {
+		req->ctype = NPA_AQ_CTYPE_POOL;
+		req->pool.op_dpc_ena = 0;
+		req->pool_mask.op_dpc_ena = 1;
+	} else {
+		req->ctype = NPA_AQ_CTYPE_HALO;
+		req->halo.op_dpc_ena = 0;
+		req->halo_mask.op_dpc_ena = 1;
+	}
+
+	rc = mbox_process(mbox);
+	if (rc < 0)
+		goto exit;
+
+	off = mbox->rx_start +
+	      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	rsp = (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
+	if (rsp->hdr.rc != 0)
+		goto exit;
+
+	if (!(flags & ROC_NPA_HALO_F)) {
+		req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
+		if (req == NULL)
+			goto exit;
+
+		req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
+		req->op = NPA_AQ_INSTOP_WRITE;
+		req->ctype = NPA_AQ_CTYPE_AURA;
+		req->aura.op_dpc_ena = 0;
+		req->aura_mask.op_dpc_ena = 1;
+		rc = mbox_process(mbox);
+		if (rc < 0)
+			goto exit;
+
+		off = mbox->rx_start + PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+		rsp = (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
+		if (rsp->hdr.rc != 0)
+			goto exit;
+	}
+
+	rc = 0;
+
+exit:
+	mbox_put(mbox);
+	return rc;
+}
diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index 18808e5873..db610cbd2c 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -191,6 +191,47 @@ roc_npa_aura_op_available_wait(uint64_t aura_handle, uint32_t count,
 	return op_avail;
 }
 
+static inline void
+roc_npa_pool_op_dpc_reset(uint64_t aura_handle, uint8_t counter_id)
+{
+	plt_write64(0, roc_npa_aura_handle_to_base(aura_handle) +
+		       NPA_LF_DPCX_ALLOC_CNT(counter_id));
+	plt_write64(0, roc_npa_aura_handle_to_base(aura_handle) +
+		       NPA_LF_DPCX_FREE_CNT(counter_id));
+	plt_write64(0, roc_npa_aura_handle_to_base(aura_handle) +
+		       NPA_LF_DPCX_OUTST_BUF_CNT(counter_id));
+	plt_write64(0, roc_npa_aura_handle_to_base(aura_handle) +
+		       NPA_LF_DPCX_CNT_HI_WM(counter_id));
+}
+
+static inline uint64_t
+roc_npa_pool_op_dpc_alloc_count(uint64_t aura_handle, uint8_t counter_id)
+{
+	return plt_read64(roc_npa_aura_handle_to_base(aura_handle) +
+			  NPA_LF_DPCX_ALLOC_CNT(counter_id));
+}
+
+static inline uint64_t
+roc_npa_pool_op_dpc_free_count(uint64_t aura_handle, uint8_t counter_id)
+{
+	return plt_read64(roc_npa_aura_handle_to_base(aura_handle) +
+			  NPA_LF_DPCX_FREE_CNT(counter_id));
+}
+
+static inline uint64_t
+roc_npa_pool_op_dpc_outst_buf_count(uint64_t aura_handle, uint8_t counter_id)
+{
+	return plt_read64(roc_npa_aura_handle_to_base(aura_handle) +
+			  NPA_LF_DPCX_OUTST_BUF_CNT(counter_id));
+}
+
+static inline uint64_t
+roc_npa_pool_op_dpc_high_wm_count(uint64_t aura_handle, uint8_t counter_id)
+{
+	return plt_read64(roc_npa_aura_handle_to_base(aura_handle) +
+			  NPA_LF_DPCX_CNT_HI_WM(counter_id));
+}
+
 static inline uint64_t
 roc_npa_pool_op_performance_counter(uint64_t aura_handle, const int drop)
 {
@@ -852,5 +893,9 @@ int __roc_api roc_npa_aura_drop_set(uint64_t aura_handle, uint64_t limit,
 
 void __roc_api roc_npa_dev_lock(void);
 void __roc_api roc_npa_dev_unlock(void);
+int __roc_api roc_npa_dpc_alloc(uint8_t *counter_id, uint16_t conf);
+int __roc_api roc_npa_dpc_free(uint8_t counter_id);
+int __roc_api roc_npa_pool_dpc_enable(uint64_t aura_handle, uint8_t counter_id, uint32_t flags);
+int __roc_api roc_npa_pool_dpc_disable(uint64_t aura_handle, uint32_t flags);
 
 #endif /* _ROC_NPA_H_ */
diff --git a/drivers/common/cnxk/roc_npa_priv.h b/drivers/common/cnxk/roc_npa_priv.h
index e437fe831a..a3bda39f73 100644
--- a/drivers/common/cnxk/roc_npa_priv.h
+++ b/drivers/common/cnxk/roc_npa_priv.h
@@ -16,6 +16,8 @@ enum npa_error_status {
 	NPA_ERR_DEVICE_NOT_BOUNDED = -519,
 	NPA_ERR_HALO_INIT = -520,
 	NPA_ERR_HALO_FINI = -521,
+	NPA_ERR_DPC_ALLOC = -522,
+	NPA_ERR_DPC_FREE = -523,
 };
 
 struct npa_lf {
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 79dd18fbd7..65db0c77bd 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -452,6 +452,10 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dump)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_update)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_mask)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_limit_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dpc_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dpc_free)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_dpc_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_dpc_disable)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_sub_return)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_get)
-- 
2.48.1

