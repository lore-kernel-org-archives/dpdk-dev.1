Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA2C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E029B40DDA;
	Mon, 26 May 2025 18:59:50 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DB09940B9F
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QA8RXm022843
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 KaT0Z2F6Yv4MB6dvxQqq8GOjwJJbjJatG27ie7+zv8=; b=EU53mcwQ3L1Y/xTcv
 7xLWJ6anJq78waJfXJt8F06qjgp++SM6+ZI9WW8no8uOCR7XTlG0vC39Mmbz6chb
 /fra+f2fusyH+ZZ06Dt1nMC4lCtFy6umq3rGmV+oiB36sRqvH2gt9kS3UJaJ+zcH
 ++U6Pd4ARNpl4NP2XUNlpNoyobLxK7qdeFXWghGpUx3obzyrZCRVvjqo3XZvyImx
 7zttCYL9cRnU5qqO/VDjFRt2RLBaCDfktI0ZinbslIqlo4mt+Fz6EQqXmBq/Ts+6
 KQ7cLyB8XQCVAcxSUljUh2tTykQPvCF+Jzg6/qfQEQKkHED2wSoKoGnYDV9Vv8zq
 g00eA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vp9krpbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:44 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 1D36D3F7048;
 Mon, 26 May 2025 09:59:41 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 25/40] crypto/cnxk: add tls session destroy
Date: Mon, 26 May 2025 22:28:04 +0530
Message-ID: <20250526165819.2197892-26-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=68349e02 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=YxzK5bxhEJpzRz2Y-cgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfXxHiTgi1MRzsI
 ibIbTcEDWUWwyF99ya9TJ1tPtCVLKZwWYv9heZPlMM7RyWGeIGzAIBH1OXU0m3Ih+zfPYNVf5zE
 MhDEcSDHEQujYP51bMMn4pmYuYrgc8dCu7+R9WTclKZ9zkx6CptIKa5Ij2Lag6cPR6Np56AtVeN
 tvKFeKM3gZW9lCB2kwGITlpy5tpw7EgXlk67Ssmex2CEFJm/45dP6s+YgJRiUK2MHGI2owfS+8J
 JZcph5b4w5ndEL+CF/hJfOtzN2fNY91K82boPA6BETqWdcy9UpXlFbfl7dZsv8mqRp8IJM/M2Pf
 e1zO+wakfUia5mXT0EEJ1BMxgDkhXdGvXCMIrBHHwcEIlyLadDYzSUm0DD1xoyywYYtrtS3yY21
 dqg0TXdv54UINtCSG6aAxdWd3KOxbEN5HaV0dnXMJzS0WRZ17xkWK+NdU3nXRjwB9yoz52KT
X-Proofpoint-ORIG-GUID: 7He4kIhrBJiRvf-RyqcvKQyFDQGWgNH5
X-Proofpoint-GUID: 7He4kIhrBJiRvf-RyqcvKQyFDQGWgNH5
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
index 27d08c49fa..b6f444baf4 100644
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

