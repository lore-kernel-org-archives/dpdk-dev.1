Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F9C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16DE340663;
	Mon, 26 May 2025 18:59:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 21ADF40BA2
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGeWE5000522
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 uLh6eORZoNd3Wji//Fmn+WEJ8oj89vcetVNdf0WT18=; b=Asfu14hRR1fc6cytz
 zQ2kNYypkd/VS/IZkNaOJKFeU5bExRD+FfsDhLmiXG4M5Iy5hpZRnSN0fVEZYPP8
 c0jWPLTtJFTtwBtmyzpwjKn83Ip+klHzxiVMODBJVLNfhHoQKsagkVeTaw715IYO
 DuTunVxqoSec6wvNTQcYi9rTVUPc6X0nhGBRd6L2wppCpuBDS7bHS6pH37a+fV3n
 3CbGnlJRWWkFHdm+0av3WmVJohdDQFSDYGLKxS1gRTNA1zasnUQ0VMsziAaMWAD+
 xPqMHbRvJ6QmvLoPY+hDoxxj8t+iYkTfR7MsJbqJ/NidipfKRsgdufe9UckoBbOm
 RfZAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebhjqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:25 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 7C71A3F7048;
 Mon, 26 May 2025 09:59:22 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 19/40] crypto/cnxk: add rte sec session update
Date: Mon, 26 May 2025 22:27:58 +0530
Message-ID: <20250526165819.2197892-20-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 34gt-sH7mMkkHpQWQChCTxNq8F5q46eT
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68349dee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VW7-YQa8A1tPSy2DlCwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfXzPaewr7O6UXP
 NTUJPwnWew9nO17+JxnflqxKchzZCi9mSJAordF4IEFOXyAEOozUKQFnYTTBWRtFYgV7Oj6Q0LT
 Q09iPaZ7peTIDP/Ts8fnsBXJrQdDVN1n6MfNCQBApUDtwme4UryVUttyocjv6ax18JLGeh6YbgU
 K3tmrOhE/tLwe2h4R/I2RpIZKSZbpn0DxsiEYXMlOf//n6y0AdWbVkn/2QcnbnH46CO6fdYd7xI
 NWN+rAGvvKtt4N3ZqWqZP7skntL9zpvUydgaV0BrDuPsUpRh2HRwocvOYMSvTlZRCnj+PDEJ1ir
 xb0PMEeD9LbRz9Xp7llDigJJsjj9tJKHqnONFF9ryflTgWCTWSreEqqrk1F/nzZI8X/9e0yYB2L
 OEPgymigF8hw0OeU6FNKuwm1/4m2xVjwaAVM/S7E06GxYnUupiEGD6BY6IOgw0m6LhyutSmd
X-Proofpoint-GUID: 34gt-sH7mMkkHpQWQChCTxNq8F5q46eT
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

Add support for IPsec session update and IPsec stats get for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c | 41 +++++++++++++++++++----
 drivers/crypto/cnxk/cn20k_ipsec.c         | 39 +++++++++++++++++----
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index 1b18398250..ba7f1baf86 100644
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

