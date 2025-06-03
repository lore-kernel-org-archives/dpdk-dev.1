Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65ACC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:52:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FF9E40E1C;
	Tue,  3 Jun 2025 13:51:16 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A1F6740666
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:51:14 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKnHq010604
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:51:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 DGqgjGNm146U/8YucTWK+7Cf6GPh7Uru+bq+FnF9LE=; b=APHoy2gSKEiQOoHLo
 AOzVLJF4ydNpuT+YV+BLcZHEXorIoqXEouWCt9rs+k3j4YsDr7CqH/dEcq4Rzqrn
 SNEK0EzKxzS+elhJLP3CkLBX6f19+CM4RfzIkDRBKa99a7qj3s0xzriiqmhxgoxZ
 fNYIch3xJCTmFnsShmOGJe0mMDC3dc0xVfbUx16Qjp9yuNUIvDkKYodc10+v/cfw
 EajKY6PrY0b+tmFeqnfuQsW2FgURbJ6eb7/MW5hQl185BjUWIsrEYgC/sp4c/WDD
 ePA9J+gokzYqvyGjedPtqzvEAYH7fDfveZRNE3rOVMH88vaPKtXszdF5cfJ5TN4e
 unHew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98hw7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:51:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:51:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:51:13 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 3B4305B692D;
 Tue,  3 Jun 2025 04:51:10 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 19/25] crypto/cnxk: add TLS session destroy
Date: Tue, 3 Jun 2025 17:20:20 +0530
Message-ID: <20250603115026.2664706-20-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX74PtdWoM83hh
 6qoURUiZr376GSVB0ys7UL1wjcD8gRtf8f56UAoazxMbjcgdT7zGiBypKugbWqBjONTOpFlS71q
 BF7dx7Cm4QzZuPCyLc1SccEdIC9rLfP5pXYcWgPyUSWASy8g665MYrU8e+/oNRVk3XrXz+FD/Tt
 F34xoZnehz5mY/KiQeRmqLRTRoJ/oPNb4ZQ6k9qVkSIWkkzFxlQGRYaMo+UL2i7xMgopzEcomg2
 4aUGn05qLFRyG+Ty4h0cGO2+rMQsfqCMHcfYDZjlSBoEkYpp6aBrJ53t4sUJXC6FqQrzko/s2zI
 gn8YMdDMXZ4pEoJw1kgH25SdoQfwPT7EkBuGWPQdDsCRBOTmB4d0NDGw65zNR654sQbY+CCSp6W
 jS7PP/FmGaqN7wcnN6XKN5e4Z9k2k+d2BJwM/Nx4alj0/p/Ypv/nx8vpKjtVUJ2WO3JVPX9U
X-Proofpoint-ORIG-GUID: kMjUkBWEy2ac1ZeHOlKq3brF7zWBi7rG
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683ee1b1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=YxzK5bxhEJpzRz2Y-cgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: kMjUkBWEy2ac1ZeHOlKq3brF7zWBi7rG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Add TLS session destroy for cn20k

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

