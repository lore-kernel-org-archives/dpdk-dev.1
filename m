Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60EC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A17F140A70;
	Tue,  3 Jun 2025 13:51:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A962540BA5
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:51:00 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKnvN010615
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:51:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=H
 mMQif9Lhyze7Y13guUrNPRIRuIIi3K9mAR0rSrrrC4=; b=ZhXeb8LNlxuT8DI1c
 8JNEfSWvac2t3x4LYXaSKMO4TKvyan47S4KsxmH9jXlRTr9W0wGpFB0YS2ddjcX/
 1nWNuDYnSHGiX7gStKabesfSGDp5BpKNeSlNLpmnPwgGYcS+Op0MHZI4LKkJ7FQq
 eLLwoQsFPvABApfXoLgtMnkF7JimJqQeRUCtSdp8vH3ZhTuIByzF00syjkllT6ap
 CPFVFxSIWDgCi5ZS3lxGXENB/uRV399cMj7NP+NFmYJMoovmLz3qfYUKkBFPZ0o6
 NMKedNFQnnscEwPilz0tdrXwadeVExB2kuZowjjbOEs8IaRqAmtlOpq46bBe27NK
 +uwsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98hw7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:59 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 338555B6921;
 Tue,  3 Jun 2025 04:50:56 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 13/25] crypto/cnxk: add IPsec session update
Date: Tue, 3 Jun 2025 17:20:14 +0530
Message-ID: <20250603115026.2664706-14-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX8PiqCqhRIRkx
 VvoGPlrLKiXpcDzRlJB3FDqPjzqQnu9pnKc4sdbsAx9wGNJjtCeA9OEyBiNnbIIorw/6raSwklC
 JmGgBTRfbRrAMPfBZCigc0UtGcoi/EB/Qn3o4Hj68FG/STz3mCbKfSgUEnbtTDuilWviT/UV9Zi
 2eAHnG+KOZD0SFU1zKmShutU4yIQ3Ck8nQu7G9CErhWJkP1IAFROtO6NxtIswkFF+eiD3j444s2
 HIJsf6bAxxfT14CEYEaSGgcoa66lAarVugA/UT97Vq/SGHbFhFY1HLIOMmC0o3lgjhmi2v0ETEA
 1GEYrBIO2PNJIoVnq9r3BdOe4GOAxChLXtLDvMvqQxIs0X/wgMpkILu7CgAPZrivepPU3Zg8JTW
 nJExPxEAeXcZxpAMOmUWBy4dHzAe5LvivLXdinoU2w+r5MORzvkJlShc2Op+hE0V5Z9vYZQb
X-Proofpoint-ORIG-GUID: lw6xtmMcg_AD-H5ap6MmlAmDBYLHCNqK
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683ee1a3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=VW7-YQa8A1tPSy2DlCwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: lw6xtmMcg_AD-H5ap6MmlAmDBYLHCNqK
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

Add support for IPsec session update and IPsec stats get for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c | 41 +++++++++++++++++++----
 drivers/crypto/cnxk/cn20k_ipsec.c         | 39 +++++++++++++++++----
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index 2a39338556..7374a83795 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -60,16 +60,28 @@ cn20k_sec_session_destroy(void *dev, struct rte_security_session *sec_sess)
 static unsigned int
 cn20k_sec_session_get_size(void *dev __rte_unused)
 {
-	return 0;
+	return sizeof(struct cn20k_sec_session) - sizeof(struct rte_security_session);
 }
 
 static int
 cn20k_sec_session_stats_get(void *dev, struct rte_security_session *sec_sess,
 			    struct rte_security_stats *stats)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(sec_sess);
-	RTE_SET_USED(stats);
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
+		return cn20k_ipsec_stats_get(qp, cn20k_sec_sess, stats);
 
 	return -ENOTSUP;
 }
@@ -78,9 +90,24 @@ static int
 cn20k_sec_session_update(void *dev, struct rte_security_session *sec_sess,
 			 struct rte_security_session_conf *conf)
 {
-	RTE_SET_USED(dev);
-	RTE_SET_USED(sec_sess);
-	RTE_SET_USED(conf);
+	struct cn20k_sec_session *cn20k_sec_sess;
+	struct rte_cryptodev *crypto_dev = dev;
+	struct cnxk_cpt_qp *qp;
+	struct cnxk_cpt_vf *vf;
+
+	if (sec_sess == NULL)
+		return -EINVAL;
+
+	qp = crypto_dev->data->queue_pairs[0];
+	if (qp == NULL)
+		return -EINVAL;
+
+	vf = crypto_dev->data->dev_private;
+
+	cn20k_sec_sess = (struct cn20k_sec_session *)sec_sess;
+
+	if (cn20k_sec_sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
+		return cn20k_ipsec_session_update(vf, qp, cn20k_sec_sess, conf);
 
 	return -ENOTSUP;
 }
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index edb3462630..1a65438646 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -333,9 +333,24 @@ int
 cn20k_ipsec_stats_get(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess,
 		      struct rte_security_stats *stats)
 {
-	RTE_SET_USED(qp);
-	RTE_SET_USED(sess);
-	RTE_SET_USED(stats);
+	struct roc_ow_ipsec_outb_sa *out_sa;
+	struct roc_ow_ipsec_inb_sa *in_sa;
+	struct cn20k_ipsec_sa *sa;
+
+	stats->protocol = RTE_SECURITY_PROTOCOL_IPSEC;
+	sa = &sess->sa;
+
+	if (sess->ipsec.is_outbound) {
+		out_sa = &sa->out_sa;
+		roc_cpt_lf_ctx_flush(&qp->lf, out_sa, false);
+		stats->ipsec.opackets = out_sa->ctx.mib_pkts;
+		stats->ipsec.obytes = out_sa->ctx.mib_octs;
+	} else {
+		in_sa = &sa->in_sa;
+		roc_cpt_lf_ctx_flush(&qp->lf, in_sa, false);
+		stats->ipsec.ipackets = in_sa->ctx.mib_pkts;
+		stats->ipsec.ibytes = in_sa->ctx.mib_octs;
+	}
 
 	return 0;
 }
@@ -344,10 +359,20 @@ int
 cn20k_ipsec_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 			   struct cn20k_sec_session *sess, struct rte_security_session_conf *conf)
 {
-	RTE_SET_USED(vf);
-	RTE_SET_USED(qp);
-	RTE_SET_USED(sess);
-	RTE_SET_USED(conf);
+	struct roc_cpt *roc_cpt;
+	int ret;
+
+	if (conf->ipsec.direction == RTE_SECURITY_IPSEC_SA_DIR_INGRESS)
+		return -ENOTSUP;
+
+	ret = cnxk_ipsec_xform_verify(&conf->ipsec, conf->crypto_xform);
+	if (ret)
+		return ret;
+
+	roc_cpt = &vf->cpt;
+
+	return cn20k_ipsec_outb_sa_create(roc_cpt, &qp->lf, &conf->ipsec, conf->crypto_xform,
+					  (struct cn20k_sec_session *)sess);
 
 	return 0;
 }
-- 
2.25.1

