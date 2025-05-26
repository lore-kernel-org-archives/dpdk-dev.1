Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E38C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6081740E31;
	Mon, 26 May 2025 19:00:19 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C9A9F40E2B
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:16 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QExT6c007455
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 pmvACWTT7vInAStpxwdQZvgsWD5E7hsf/x0RpLul28=; b=CktyzQXQoihwK/JV6
 PL9ZJeJkSEwV+ZLEMfy7NjtwSMNq5I82bQMM7m200dIm0xslpPVoRzQr62HTTRkd
 tsMPVl92tAZHouzcuBSsxjtl4zSvijnxRrpB5mYyG1mOxeTJ39kX9M3V2cI72VM5
 VxJOtFCyxD47AXOAEXcgGboUFfClYjJmm4CQTWtkE8ApAwTMXgBjWd3g0SRxvtTl
 TrGpXkdqzX0xoM2/HWbVUqgkzPZTX/BulkFynMpHqZsqH2qSKHSnctfGd0Zec0ki
 k3swFi1pfbR/vslRuiUWWkYNPAsKs1F7caBUkVp4nq8raw1c11wm7LfZXjEE6Gmc
 G5D8Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vthfr71k-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:15 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:14 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 453A03F7048;
 Mon, 26 May 2025 10:00:10 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Aakash Sasidharan <asasidharan@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 34/40] crypto/cnxk: extend check for max supported gather
 entries
Date: Mon, 26 May 2025 22:28:13 +0530
Message-ID: <20250526165819.2197892-35-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX5qleRFmMpF0k
 ZJRjqPwi+LKOrsYtcRPU18700xJUtCG3xY5Vp/aUZLFu+VjAKMDjDEYi0wFCtWzlVTSEDDqNglY
 vkXpHUAb+qVf4YSMP0wJ/lWHIsdCRJ94pX5goCMXLlPnfasdDGBmCC7R3tGp5RyHMiBJDfM2U4B
 4oItu059eRzQiJqz+LJJqd2ftONiJw1LCWV6uPGQOwDscGCQBnvC8PPos5/fxSWspnl7MCOVVxv
 eIbM5q1lsmqGAN/ri8R1bwDvs81b/k6H2UOXgYdBLicI3a1uNA3oluXroe8oDsdOhRzgauxarPl
 Dgwpogjx3+OMlMUs+UdwA/bL070bGfbr1pKFaVGi3PKUf781XRiM8dy8gymWNZ9CH0ri1hzZsMi
 5ofB5cojswtIqltaPw9LIJZJ8bJrGKkQ9mb5wy67oBsRGdZ82WB7+PVY1CHaHtPZcLXkh+C0
X-Proofpoint-ORIG-GUID: 83V5hNaPJupylkX881FjJH1B-5bmdFYm
X-Proofpoint-GUID: 83V5hNaPJupylkX881FjJH1B-5bmdFYm
X-Authority-Analysis: v=2.4 cv=FfA3xI+6 c=1 sm=1 tr=0 ts=68349e1f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=eJjrCEJGAj4jR_m2buIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

Extend check for max supported gather entries in CNXK
CPT PMD.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/common/cnxk/roc_cpt_sg.h         |  1 +
 drivers/crypto/cnxk/cn10k_ipsec_la_ops.h | 10 ++++++++++
 drivers/crypto/cnxk/cn10k_tls_ops.h      | 10 ++++++++++
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h | 10 ++++++++++
 drivers/crypto/cnxk/cn20k_tls_ops.h      | 10 ++++++++++
 drivers/crypto/cnxk/cn9k_ipsec_la_ops.h  | 10 ++++++++++
 6 files changed, 51 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt_sg.h b/drivers/common/cnxk/roc_cpt_sg.h
index e7e01cd29a..7c3caf94d7 100644
--- a/drivers/common/cnxk/roc_cpt_sg.h
+++ b/drivers/common/cnxk/roc_cpt_sg.h
@@ -15,6 +15,7 @@
 #define ROC_SG_MAX_COMP	     25
 #define ROC_SG_MAX_DLEN_SIZE (ROC_SG_LIST_HDR_SIZE + (ROC_SG_MAX_COMP * ROC_SG_ENTRY_SIZE))
 #define ROC_SG2_MAX_PTRS 48
+#define ROC_SG1_MAX_PTRS 32
 
 struct roc_sglist_comp {
 	union {
diff --git a/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
index 87442c2a1f..0cc6283c7e 100644
--- a/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn10k_ipsec_la_ops.h
@@ -105,6 +105,11 @@ process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k_s
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -224,6 +229,11 @@ process_inb_sa(struct rte_crypto_op *cop, struct cn10k_sec_session *sess, struct
 		void *m_data;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
diff --git a/drivers/crypto/cnxk/cn10k_tls_ops.h b/drivers/crypto/cnxk/cn10k_tls_ops.h
index 427c31425c..90600bd850 100644
--- a/drivers/crypto/cnxk/cn10k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn10k_tls_ops.h
@@ -117,6 +117,11 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -255,6 +260,11 @@ process_tls_read(struct rte_crypto_op *cop, struct cn10k_sec_session *sess,
 		uint32_t dlen;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
diff --git a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
index eff51bd794..505fddb517 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
@@ -104,6 +104,11 @@ process_outb_sa(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k_s
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -163,6 +168,11 @@ process_inb_sa(struct rte_crypto_op *cop, struct cn20k_sec_session *sess, struct
 		void *m_data;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
diff --git a/drivers/crypto/cnxk/cn20k_tls_ops.h b/drivers/crypto/cnxk/cn20k_tls_ops.h
index 14f879f2a9..9f70a1d42d 100644
--- a/drivers/crypto/cnxk/cn20k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn20k_tls_ops.h
@@ -118,6 +118,11 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn20k
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -194,6 +199,11 @@ process_tls_read(struct rte_crypto_op *cop, struct cn20k_sec_session *sess,
 		uint32_t g_size_bytes;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
diff --git a/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h b/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h
index befd5b0c05..79e00e3c57 100644
--- a/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h
+++ b/drivers/crypto/cnxk/cn9k_ipsec_la_ops.h
@@ -111,6 +111,11 @@ process_outb_sa(struct cpt_qp_meta_info *m_info, struct rte_crypto_op *cop,
 			return -ENOMEM;
 		}
 
+		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
@@ -206,6 +211,11 @@ process_inb_sa(struct cpt_qp_meta_info *m_info, struct rte_crypto_op *cop,
 		void *m_data;
 		int i;
 
+		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
+			plt_dp_err("Exceeds max supported components. Reduce segments");
+			return -1;
+		}
+
 		m_data = alloc_op_meta(NULL, m_info->mlen, m_info->pool, infl_req);
 		if (unlikely(m_data == NULL)) {
 			plt_dp_err("Error allocating meta buffer for request");
-- 
2.25.1

