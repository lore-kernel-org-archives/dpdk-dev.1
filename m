Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07457C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A612C40E42;
	Mon, 26 May 2025 19:00:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A2A00406B6
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:31 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QEwWNV006239
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 7sJG73rjq++P6jmeIFkx6p8EmfztlRqsmpca59CjDI=; b=XxpMF3GSz9miF5INV
 YqG+M2ScB1bA7AMSVdiUt4OWsBVtpx6DVTOPZqrx9kcARZZkjL0JjLSwPM4n8e/v
 6ZyEC3Gy0XTH11dGJyTv6+QGTWbzNe8JsrXYl1JRgAaBH6XJfdc2gqorP5pOJLkg
 ICETG8z/+1X3M2+l3cTX7SDhJJd2EJrnyOdcvPdYk3HngACw2iRRATgnNrYy6xU/
 Zaiigu8M2GtZAoLIvtDjbvHtViYvaC3mE7dAwZ9xlbh95E0BXxpMHb8Sq+UMYLJo
 BJHnuBhKCf52Y5frARvnpvMegKGIbtAwTxBdvT+nuUhrDHhypCvFHAIfmzXBkqaP
 xlH7A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vthfr72c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:30 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 6E3A73F7063;
 Mon, 26 May 2025 10:00:27 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 39/40] common/cnxk: update qsize in CPT iq enable
Date: Mon, 26 May 2025 22:28:18 +0530
Message-ID: <20250526165819.2197892-40-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX2Vi1tnwSdd7E
 NUIgi/pceilkIlJyCEDd3xy/KYRoJpr/bNLt31I0AJdYWxQ0FNWD+piQBMw7mhOS799brqL+OqQ
 iwRrLRD5GI8tOvNClMnEIgs5CMW11rWizokFuV7+Cf6VqWo1Hi/bj8eusPuElbbPhqwvmundckU
 GY49oBz+qWfeWB0BOZFFjoza+22ktaExfYUzRjg1JupzyQE0yYi5KRHJs0hU3V2hbgKIpq0ZL30
 eSfhCwRFCbA9Own3TyiuYgW++50OIj/qd8fESY1Iaf9D8P/vNV8JvUEVTxGZEef2puAikXjE9s0
 OUdwSD/gMvlneLmjujT4Dxv1yI/LffL75YZZi8A9UWBZ22RfLJNsANsv2scXFlp6tRFT2ypGbmA
 MTyJAzi9gE+nqtCrKom3xaL0Ab8jS3YCtAAHFKTKFMYcwJxlPK0jVUnjIhrDy2GI7rNrrJdA
X-Proofpoint-ORIG-GUID: PGdMHYy97YINDKLIwQij8euLt5IYFYhq
X-Proofpoint-GUID: PGdMHYy97YINDKLIwQij8euLt5IYFYhq
X-Authority-Analysis: v=2.4 cv=FfA3xI+6 c=1 sm=1 tr=0 ts=68349e2e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=gGeKaNl8JbtvcH-T73IA:9
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Reconfigure qsize in each CPT iq enable call.

Fixes: 3bf87839559 ("common/cnxk: move instruction queue enable to ROC")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index b4bf0ccd64..d1ba2b8858 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -1125,9 +1125,14 @@ roc_cpt_iq_disable(struct roc_cpt_lf *lf)
 void
 roc_cpt_iq_enable(struct roc_cpt_lf *lf)
 {
+	union cpt_lf_q_size lf_q_size;
 	union cpt_lf_inprog lf_inprog;
 	union cpt_lf_ctl lf_ctl;
 
+	/* Reconfigure the QSIZE register to ensure NQ_PTR and DQ_PTR are reset */
+	lf_q_size.u = plt_read64(lf->rbase + CPT_LF_Q_SIZE);
+	plt_write64(lf_q_size.u, lf->rbase + CPT_LF_Q_SIZE);
+
 	/* Disable command queue */
 	roc_cpt_iq_disable(lf);
 
-- 
2.25.1

