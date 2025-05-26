Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0591C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69E9740B8D;
	Mon, 26 May 2025 19:00:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 76D974069D
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:58 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QExskM008460
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 iqjKG9jRh318FsE2HDng9v1QH1J1vn+Q2zXqjOcDN4=; b=h4QKVuUg9erDHhRxQ
 rSdl9tdayROJGK/2xZbg2Xtz2yZImPg232OEP0hEr269wofayUHyEokI6jsb1lOh
 yXuQSmlEG/rB5fAhlBAC0IP8WuZHlOLrZrmyyNUN6kouRgzs+UpaommhUOG9wGnb
 JTnY/DFtGHYp911Dm8gD95QtUsqY0GFsgUCjU2BTmtoTUKWRyyDmszBgmauYP0y0
 Z0CmourJnM/W7iwve5jp9AOxc5wt76qonE3TChuTH29oPnJn/GXTFyIgZBLR3gT8
 rwydI9tZGgaJ+220c6WabfgAEwKei5tIyM4g0wIPYYPvAB2gVz7hDDgyeqZYcbaQ
 nuEhg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vthfr6y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:54 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id BC7463F7048;
 Mon, 26 May 2025 09:59:51 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 28/40] crypto/cnxk: add tls session update
Date: Mon, 26 May 2025 22:28:07 +0530
Message-ID: <20250526165819.2197892-29-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfXzj6R7gvY/UrU
 5SlckeyJbr5xz4sNjHHbWekDHt0EvNFc7iqgU9j8TnGCEJtH1i6cQwMFs6BaF2OFP6eGyU8X039
 oighFIZfKHanH+TjRJTjaqt7lLFPY1zz/ZElyYS2Q39S8ILdaIZcBV7AzBzJvcqpgYvxfPzmXlv
 Rral7EV828r48ujOJuOWaVnCZvM/l64uhhLDlbd5/qyzCxxv0AsRMXNuaHtZ3mK1mce3OmzBIyF
 eExPG+ll12nSHgCgS2QsahCUjlghBgiZvzkg69AMzet0i6w1VoWxVnuncAw4WvGQYtwEzdxGg/a
 1KJDVDTRK+NrCBUpCmPx4ZwyPK8ozHzQ52lSMbeDxlYOhum5nRmNmX6efw6N7ZfsfwSWa3xZYKr
 dj8weYFeamSLku07oTIB6wqAtA7u1aEUK5OLEQuqRcqweeWurAOxyeJeYn1AwwxBeH1GaZg8
X-Proofpoint-ORIG-GUID: 43IG1se_a1Mqmc_KAlQql7ZBBjaHIRRG
X-Proofpoint-GUID: 43IG1se_a1Mqmc_KAlQql7ZBBjaHIRRG
X-Authority-Analysis: v=2.4 cv=FfA3xI+6 c=1 sm=1 tr=0 ts=68349e0d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=64np0t8wK4iXYbfUXPkA:9
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add support for TLS session update for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c |  3 +++
 drivers/crypto/cnxk/cn20k_tls.c           | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
index ab676cc6cf..ae1e31e7e1 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -116,6 +116,9 @@ cn20k_sec_session_update(void *dev, struct rte_security_session *sec_sess,
 	if (cn20k_sec_sess->proto == RTE_SECURITY_PROTOCOL_IPSEC)
 		return cn20k_ipsec_session_update(vf, qp, cn20k_sec_sess, conf);
 
+	if (conf->protocol == RTE_SECURITY_PROTOCOL_TLS_RECORD)
+		return cn20k_tls_record_session_update(vf, qp, cn20k_sec_sess, conf);
+
 	return -ENOTSUP;
 }
 
diff --git a/drivers/crypto/cnxk/cn20k_tls.c b/drivers/crypto/cnxk/cn20k_tls.c
index b6f444baf4..9f7acefc19 100644
--- a/drivers/crypto/cnxk/cn20k_tls.c
+++ b/drivers/crypto/cnxk/cn20k_tls.c
@@ -820,12 +820,17 @@ cn20k_tls_record_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
 				struct cn20k_sec_session *sess,
 				struct rte_security_session_conf *conf)
 {
-	RTE_SET_USED(vf);
-	RTE_SET_USED(qp);
-	RTE_SET_USED(sess);
-	RTE_SET_USED(conf);
+	struct roc_cpt *roc_cpt;
+	int ret;
 
-	return 0;
+	if (conf->tls_record.type == RTE_SECURITY_TLS_SESS_TYPE_READ)
+		return -ENOTSUP;
+
+	roc_cpt = &vf->cpt;
+	ret = cn20k_tls_write_sa_create(roc_cpt, &qp->lf, &conf->tls_record, conf->crypto_xform,
+					(struct cn20k_sec_session *)sess);
+
+	return ret;
 }
 
 int
-- 
2.25.1

