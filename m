Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B113CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DA784067C;
	Mon, 19 Oct 2026 15:08:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1D31F4067C
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:21 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OdND110851 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 9W3WiZtvrqAtEcrpc3grGwnWMhWSJnv/Ua4feRIuMY=; b=JbPON68MWgCjKbUyl
 wfZJdnAiK2mXNmPKmWHhq9nD9WIyCFUYUagaJaWh/ffmOxwSJF4uc7xEf6tdNinu
 Gt/kLJVzp5SCm0+KoXK31svi07uISw/v9If9FHIdzxyEH9lPgE0zRn0tOE2S3XvU
 d0wK4JDkFuLIGOnFfN9GszRYYWSZdOXyvUE49ZjwS5LMB6gi65CWVNVTPyioWvEX
 abXrZnrfrtfnVdzRjAzfP4nG/oAre88hpzxdwwCU1XgtgOyK08pNLNDGAu0G4fdZ
 B4yfL6jJ/DJNgdtD9VIO2GTB1d/4Vg8yZpZjRHHmk3An9T64H2Bki7cTdKWTKUKo
 VkEiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4ypc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:19 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 182F53F704D;
 Mon, 19 Oct 2026 06:08:16 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 06/16] crypto/cnxk: fix CN20K CPT error recovery
Date: Mon, 19 Oct 2026 18:37:47 +0530
Message-ID: <20261019130759.2181566-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e3LeLU__8NHaTKw7AyoawrvnT1HC67cL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX95KC1foNF9p3
 8f6jkLu5mAB6vqQp/b+ul9HRf+TPAA5p/XhGWksjfnIpj2LzIt4ResR1rv0KWYtwrb2O5J6td4w
 pxgdTmmbW8OQqOIh5k21BxKoD2nd+7mrRnsr3Hndr/nZoIf4AQe2ThvNOKxePSmxSQhmLeDVOTn
 GxkSgvlL0NRmVKogqTi+cPZgk18e+f2q4w3qCkY/z7CgMqupQeGb7Pv6a2E76Zk/D5bTmqt6YpD
 oPRzKs5Vk/Kt15dKZt2nJk18bCa41BUNLousQfUi4VTN+SnyeMzpY6wvtVEjHO9znCbcVgqReDK
 FTlUpi1YTd0/L984IaP+t9v9CmA4teK0qIQUamo5GQ3Yz3YoHPoEA/zzA6oDpv1mkXqeZCv7HO8
 9eUIpiDzEey3vHjZW6N/QT4Mf7CrytMeEDpEZ3vJpJeZEQo+vlb6r26BjjrJvRl8YfHjwqKesQW
 r/gBBkA/muhBmxSkD3w==
X-Proofpoint-GUID: e3LeLU__8NHaTKw7AyoawrvnT1HC67cL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX9HAbs8kBEx1a
 6ooG5iyrGGJsWXuiKQkU1JgJllAr4zwuW1dvnRddHwx/hK/sM9a0jV1CaVSVUK7jkdqh5g7PtZ3
 ST4enBaIISB9XJpYCgdOO40cVVEW5oM=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad61644 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=yL3dTDLnE6O-cySBhc8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

Reprogram completion queue base and size registers in
roc_cpt_cq_enable as hardware clears them after fatal error.
Also reset pending queue head and tail during queue pair reset so
software completion state stays aligned with the reset hardware
queue.

Fixes: 13ce9121c3c0 ("common/cnxk: add routines to operate CPT CQ")
Fixes: 4e8a41acaffb ("crypto/cnxk: support CPT CQ for CN20K")

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/roc_cpt.c            | 13 +++++++++++++
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.c
index 8c60a28fff..eae3f134e9 100644
--- a/drivers/common/cnxk/roc_cpt.c
+++ b/drivers/common/cnxk/roc_cpt.c
@@ -1147,7 +1147,20 @@ roc_cpt_eng_grp_add(struct roc_cpt *roc_cpt, enum cpt_eng_type eng_type)
 void
 roc_cpt_cq_enable(struct roc_cpt_lf *lf)
 {
+	union cpt_lf_cq_base lf_cq_base = {.u = 0x0};
+	union cpt_lf_cq_size lf_cq_size = {.u = 0x0};
 	union cpt_lf_cq_ctl lf_cq_ctl = {.u = 0x0};
+	uintptr_t addr;
+
+	/* Disable completion queue */
+	roc_cpt_cq_disable(lf);
+
+	/* Reconfigure CQ base and size, same as cpt_lf_cq_init() */
+	addr = (uintptr_t)lf->cq_vaddr;
+	lf_cq_base.s.addr = addr >> 7;
+	plt_write64(lf_cq_base.u, lf->rbase + CPT_LF_CQ_BASE);
+	lf_cq_size.s.size = lf->cq_size;
+	plt_write64(lf_cq_size.u, lf->rbase + CPT_LF_CQ_SIZE);
 
 	lf_cq_ctl.s.ena = 1;
 	lf_cq_ctl.s.dq_ack_ena = lf->dq_ack_ena;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 1e0ea9d358..95f64a79ae 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -596,6 +596,7 @@ cnxk_cpt_queue_pair_reset(struct rte_cryptodev *dev, uint16_t qp_id,
 {
 	if (conf == NULL) {
 		struct cnxk_cpt_vf *vf = dev->data->dev_private;
+		struct cnxk_cpt_qp *qp;
 		struct roc_cpt_lf *lf;
 
 		if (vf == NULL)
@@ -603,6 +604,11 @@ cnxk_cpt_queue_pair_reset(struct rte_cryptodev *dev, uint16_t qp_id,
 
 		lf = vf->cpt.lf[qp_id];
 		roc_cpt_lf_reset(lf);
+
+		qp = dev->data->queue_pairs[qp_id];
+		qp->pend_q.head = 0;
+		qp->pend_q.tail = 0;
+
 		roc_cpt_iq_enable(lf);
 
 		if (lf->cpt_cq_ena)
-- 
2.43.0

