Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA3C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9966040E5E;
	Fri, 23 May 2025 15:52:43 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 975E340A89
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:38 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9TDq029869
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 63qWbtdB9MckUVq6S0EPouXrmC3egKhlmK1BKruOoA=; b=X8ogomlV1L3tG+o+U
 m2RCvdBnaxefrsDAO91cBUX5uskeHFODWTj+QpLe/KwhJH+NKeVQuDHdrd25CDSk
 qtfbJglFENEYehEH3s6bMmd82kT7VshU/8MXll6p6RNgZZWuX1p5/1W7/QMLgBJV
 LzvuJ3jNv9YkzCOEEDVc38AACL/LrughYa9xXR0xKYp2YyCFKL9XOO8IDV+/sh2j
 1itYCcXwDKBLsbfUGxgyWkZ4U/5v9rB5vFEIAuRaKuyJoVeyjVCpIyHbl0F4m45R
 1LZwK90pq7iq5J2W51f9//xgGlA3t3vWPbL3ALBjNV5A/nEx2OGnRvMas41LKXew
 VgSmA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:36 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 41DE53F7041;
 Fri, 23 May 2025 06:52:33 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 25/40] crypto/cnxk: add tls session destroy
Date: Fri, 23 May 2025 19:20:56 +0530
Message-ID: <20250523135111.2178408-26-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307da5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=YxzK5bxhEJpzRz2Y-cgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX7962CHO/HFu6
 +hRq1pxtj/UBu2ZkkEOV+jQ7RnuMuVxzeXrOkwmPgQhvlHbO0HslF3OJrVgDE2isLcvVrXAGowA
 uBlf77XmJJF3NVVx0Fujfa8JyhHEuhj4+Y86xV5gys9DpvTNqYbAO1H1Mlywc/7hs60+eFK3MWm
 RXSHKbdSBUZbLFVmM0oEc0UkTHSFGK9W2FBGoxMwLowVD7h8nr1G0JZ4407/yYC/FAbPlRe6bPs
 ldukfCNVr5zLeeH3Exr6rn952qfgI71rYELxUKZYf8RzX0Smo4u3gB+ovGTl6qQrh8kSFNomF7P
 6nhbTx2niPbgYZI2S+LRAfXPgk0nIGywaei5TgVZJ51xfgoAlaPEjkTbpeh+vTLr931T95so6GF
 xAb755VHmx2eoj+dnxt9mPcvm0qYWhvnf3D24LfBur9mDArXFC3UrtLSmIn46i3NQS9gnuxi
X-Proofpoint-GUID: IqlVq9CWDBLiYWb7uiWEh8uXpUAtMYjU
X-Proofpoint-ORIG-GUID: IqlVq9CWDBLiYWb7uiWEh8uXpUAtMYjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add tls session destroy for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c |  3 +
 drivers/crypto/cnxk/cn20k_tls.c           | 84 ++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index e5158af595..ab676cc6cf 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -58,6 +58,9 @@ cn20k_sec_session_destroy(void *dev, struct rte_security_session *sec_sess)
 	if (cn20k_sec_sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
 		return cn20k_sec_ipsec_session_destroy(qp, cn20k_sec_sess);
 
+	if (cn20k_sec_sess->proto == RTE_SECURITY_PROTOCOL_TLS_RECORD)
+		return cn20k_sec_tls_session_destroy(qp, cn20k_sec_sess);
+
 	return -EINVAL;
 }
 
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index 4a68edf731..e0cd1b1b34 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -785,6 +785,36 @@ cn20k_tls_write_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	return ret;
 }
 
+static void
+tls_write_sa_init(struct roc_ie_ow_tls_write_sa *sa)
+{
+	size_t offset;
+
+	memset(sa, 0, sizeof(struct roc_ie_ow_tls_write_sa));
+
+	offset = offsetof(struct roc_ie_ow_tls_write_sa, tls_12.w26_rsvd7);
+	sa->w0.s.hw_ctx_off = offset / ROC_CTX_UNIT_8B;
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off;
+	sa->w0.s.ctx_size = ROC_IE_OW_TLS_CTX_ILEN;
+	sa->w0.s.ctx_hdr_size = ROC_IE_OW_TLS_CTX_HDR_SIZE;
+	sa->w0.s.aop_valid = 1;
+}
+
+static void
+tls_read_sa_init(struct roc_ie_ow_tls_read_sa *sa)
+{
+	size_t offset;
+
+	memset(sa, 0, sizeof(struct roc_ie_ow_tls_read_sa));
+
+	offset = offsetof(struct roc_ie_ow_tls_read_sa, tls_12.ctx);
+	sa->w0.s.hw_ctx_off = offset / ROC_CTX_UNIT_8B;
+	sa->w0.s.ctx_push_size = sa->w0.s.hw_ctx_off;
+	sa->w0.s.ctx_size = ROC_IE_OW_TLS_CTX_ILEN;
+	sa->w0.s.ctx_hdr_size = ROC_IE_OW_TLS_CTX_HDR_SIZE;
+	sa->w0.s.aop_valid = 1;
+}
+
 int
 cn20k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 				struct cn20k_sec_session *sess,
@@ -824,9 +854,59 @@ cn20k_tls_record_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 int
 cn20k_sec_tls_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess)
 {
+	struct cn20k_tls_record *tls;
+	struct roc_cpt_lf *lf;
+	void *sa_dptr = NULL;
+	int ret = -ENOMEM;
 
-	RTE_SET_USED(qp);
-	RTE_SET_USED(sess);
+	lf = &qp->lf;
+
+	tls = &sess->tls_rec;
+
+	/* Trigger CTX flush to write dirty data back to DRAM */
+	roc_cpt_lf_ctx_flush(lf, &tls->read_sa, false);
+
+	if (sess->tls_opt.is_write) {
+		sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_write_sa), 8);
+		if (sa_dptr != NULL) {
+			tls_write_sa_init(sa_dptr);
+
+			ret = roc_cpt_ctx_write(lf, sa_dptr, &tls->write_sa,
+						sizeof(struct roc_ie_ow_tls_write_sa));
+			plt_free(sa_dptr);
+		}
+		if (ret) {
+			/* MC write_ctx failed. Attempt reload of CTX */
+
+			/* Wait for 1 ms so that flush is complete */
+			rte_delay_ms(1);
+
+			rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+			/* Trigger CTX reload to fetch new data from DRAM */
+			roc_cpt_lf_ctx_reload(lf, &tls->write_sa);
+		}
+	} else {
+		sa_dptr = plt_zmalloc(sizeof(struct roc_ie_ow_tls_read_sa), 8);
+		if (sa_dptr != NULL) {
+			tls_read_sa_init(sa_dptr);
+
+			ret = roc_cpt_ctx_write(lf, sa_dptr, &tls->read_sa,
+						sizeof(struct roc_ie_ow_tls_read_sa));
+			plt_free(sa_dptr);
+		}
+		if (ret) {
+			/* MC write_ctx failed. Attempt reload of CTX */
+
+			/* Wait for 1 ms so that flush is complete */
+			rte_delay_ms(1);
+
+			rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+			/* Trigger CTX reload to fetch new data from DRAM */
+			roc_cpt_lf_ctx_reload(lf, &tls->read_sa);
+		}
+	}
 
 	return 0;
 }
-- 
2.25.1

