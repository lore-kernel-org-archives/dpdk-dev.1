Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0310C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E030340A7A;
	Fri, 23 May 2025 15:52:13 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7E8AE4028C
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:12 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9TDd029869
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 51ZwVx2KlWYLQCKo9LX27tw0Gz9LjRtagYfSoLTgRU=; b=Gz6vR5zIT7Bs3u/kn
 IO3rST6FE8/+CI/r0S/5F5D0T8XHe4/ZD6Y/9TD/q6ZfSD+tFvxEiG8twxzA0/QW
 qW6D+/wmPRj8lUjykQ4qyweAi8kS8qPcBKcxHNENoHqqYXRaRk8mdLRXIkZLoeAC
 6a9zdp9PvNhSKHyPDejR2pQMH/sMvvss5F0wsc7997nb3Cg4VKYKjykSRNLSs8Qh
 Vc8uFuf5qY2ZrFK24XWq9zkqQX7OJybs8gNv3yBluvifmpHxdJ3bwNXyYjIIlS3O
 x/uKDFml2L6ML109hvgjO8yF/vKvqhR3BmlOs7cpF/TWMkk3eYTmowKDvKUwnshP
 JjjgQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:10 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 76F503F707B;
 Fri, 23 May 2025 06:52:07 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 17/40] crypto/cnxk: add security session destroy
Date: Fri, 23 May 2025 19:20:48 +0530
Message-ID: <20250523135111.2178408-18-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307d8b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=RdC8Ne2aqbW4Nz29PYYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXyJgOLZ56zTmE
 zZFXk3FJo4onN1JsyFv4ARYBbIEj/w3G4etR/65hjlFSIb030BpanNQcPiaBvR4y/JUEpgkfA8x
 fSzW86M49KsFFnS+yZAG5xNikzXxNVGbCDYCupxMjoR8/xjRsmVFwIg+i8StXcJt/Pjc2ttGKH7
 W5a5iD596G29nPNa4S6+XiMeXF+S8EGMc42BzJqK+QujXHedwBwH3Lm5ZnUnZ2KPe8EGZ/3HDSa
 xH3+GWNPGfU7wSzio1ywG9A6VZ/9J/oc4BsgA/7cjKJRQt0m1rWMjNuaFbc3DgeFG55JyKgjgBX
 FHuVMfQCGdVpDVLCXQBqf2Tke/F0nFA7rLrjnKQH5zajOaNyw0njrYtIeiMOBkbmcnpdRbukd8M
 o4axILxFWm/I/JdclsLubfgvuOrzmOYbkEVagioTxLOnqLe0i7Ulk0lU4JO+9AWmQVz+LiU5
X-Proofpoint-GUID: wuyS0CG1tabptv2jyrq1L_q01kvqZFE8
X-Proofpoint-ORIG-GUID: wuyS0CG1tabptv2jyrq1L_q01kvqZFE8
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

Add support for rte security session destroy for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c | 17 +++++++-
 drivers/crypto/cnxk/cn20k_ipsec.c         | 51 ++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index 0bb4b7db63..1b18398250 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -38,8 +38,21 @@ cn20k_sec_session_create(void *dev, struct rte_security_session_conf *conf,
 static int
 cn20k_sec_session_destroy(void *dev, struct rte_security_session *sec_sess)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(sec_sess);
+	struct cn20k_sec_session *cn20k_sec_sess;
+	struct rte_cryptodev *crypto_dev = dev;
+	struct cnxk_cpt_qp *qp;
+
+	if (unlikely(sec_sess == NULL))
+		return -EINVAL;
+
+	qp = crypto_dev->data->queue_pairs[0];
+	if (unlikely(qp == NULL))
+		return -ENOTSUP;
+
+	cn20k_sec_sess = (struct cn20k_sec_session *)sec_sess;
+
+	if (cn20k_sec_sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
+		return cn20k_sec_ipsec_session_destroy(qp, cn20k_sec_sess);
 
 	return -EINVAL;
 }
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index b6ecc4fb1a..f898461523 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -276,8 +276,55 @@ cn20k_ipsec_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 int
 cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess)
 {
-	RTE_SET_USED(qp);
-	RTE_SET_USED(sess);
+	union roc_ow_ipsec_sa_word2 *w2;
+	struct cn20k_ipsec_sa *sa;
+	struct roc_cpt_lf *lf;
+	void *sa_dptr = NULL;
+	int ret;
+
+	lf = &qp->lf;
+
+	sa = &sess->sa;
+
+	/* Trigger CTX flush to write dirty data back to DRAM */
+	roc_cpt_lf_ctx_flush(lf, &sa->in_sa, false);
+
+	ret = -1;
+
+	if (sess->ipsec.is_outbound) {
+		sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_outb_sa), 8);
+		if (sa_dptr != NULL) {
+			roc_ow_ipsec_outb_sa_init(sa_dptr);
+
+			ret = roc_cpt_ctx_write(lf, sa_dptr, &sa->out_sa,
+						sizeof(struct roc_ow_ipsec_outb_sa));
+		}
+	} else {
+		sa_dptr = plt_zmalloc(sizeof(struct roc_ow_ipsec_inb_sa), 8);
+		if (sa_dptr != NULL) {
+			roc_ow_ipsec_inb_sa_init(sa_dptr);
+
+			ret = roc_cpt_ctx_write(lf, sa_dptr, &sa->in_sa,
+						sizeof(struct roc_ow_ipsec_inb_sa));
+		}
+	}
+
+	plt_free(sa_dptr);
+
+	if (ret) {
+		/* MC write_ctx failed. Attempt reload of CTX */
+
+		/* Wait for 1 ms so that flush is complete */
+		rte_delay_ms(1);
+
+		w2 = (union roc_ow_ipsec_sa_word2 *)&sa->in_sa.w2;
+		w2->s.valid = 0;
+
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+		/* Trigger CTX reload to fetch new data from DRAM */
+		roc_cpt_lf_ctx_reload(lf, &sa->in_sa);
+	}
 
 	return 0;
 }
-- 
2.25.1

