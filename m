Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66E7C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:55:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3151F40E72;
	Fri, 23 May 2025 15:52:50 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C473140E7C
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:48 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9TDw029869
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 4o3RHRN6bxsAM5KML5inuuLiZeDZBBfWADdsujDWvE=; b=Hu47dZ3iiZYpOsGYx
 veEfd2Dok4YP5MNqVGGWE6PatDxp/9S75HejMDBEHoCCbjt12wAVsVzCRAHFDrk3
 KfDMJyxOtFLa/TsKDOYtTbFF2GKQL213UPV0SuLS1i9kvFNk5v2cwRi83/3gXoaz
 +YEw3kEnahWwSVUfd3kq0QUmtyk+cMQ6oKVGKKkNmP5cdMGWQrgKMq8O2+nrWc1o
 Udik+3Iif/qAYHLW0zSgvywo3mA+J4mpvmMGFKS5l/WYIsrCfIcdgqj9ahuog/n8
 LCniAKBSlnwbeqC+uf2RWYgBgxPZJ6YjdfuGU2ayXlRpoorAEkysO34YYByl/GOr
 yJI/g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:46 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id CE7A13F7041;
 Fri, 23 May 2025 06:52:43 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 28/40] crypto/cnxk: add tls session update
Date: Fri, 23 May 2025 19:20:59 +0530
Message-ID: <20250523135111.2178408-29-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307daf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=64np0t8wK4iXYbfUXPkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX7U2T4JadTEiw
 u/KQtYqUIcHwx/b4S1iOtu9QK7Mq5VRKdyl9xC0FHIUfmeSUKitwF8FyXXh+/IiPWtRCkBGqlsl
 PD6g9627NYqDjqxY59bHBB9VH3vNA75uLTQmA05ejk6AMhiBOPZbhWM3O9aL+KJNT0kc1D4l5TW
 gi364eQ7VId8N7RaGF9cA/bhBlUCf0fsLYNjrtWlK4kq5dk+ufZnBbXB7BKoxyN9L8TDm9anCsd
 y+/pqFRm8GT88AFYhMHa2wSDV7bCGGQFw2R041YwyhMkdVCYx363HOJUtKK7KvdO5R01mlk39Vl
 p7Wi5OAwfzJYupc8zpTd7VIAvOEwfNjfeuCU01NzDvHXki0DMyj+lEfszHbsILEtcqcOmeKc620
 3pRwGMYc3GgyY+5N0WurzpEXYgDAsgq94J2hHpn93AvOtpA0oD2nD76KU01XXco3KyZkLhmR
X-Proofpoint-GUID: NDPH0meyQFDFOy-sb2ExEkJcFtnYHiOl
X-Proofpoint-ORIG-GUID: NDPH0meyQFDFOy-sb2ExEkJcFtnYHiOl
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
index e0cd1b1b34..cdf885b997 100644
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

