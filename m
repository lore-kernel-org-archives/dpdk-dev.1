Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EEDE8384C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29FD040648;
	Tue, 17 Feb 2026 06:40:14 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CCE71402EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:40:12 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1uqgu860882 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:40:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 A8dn9ctdryEcs1KnI4eFkvnS6KSa1ztvDLkemFfiyw=; b=YH4C2e/uzLTWkm6di
 f0Wcn/8h3pEQ4kIvdU6DyfPEZcpEmTAV7fMqbhbWrEL1lGqlwQ/EZlbsFs3YGGe1
 qydp/g3dbbP32GuWpBSTFpeJr40i8yX3Q9yz6PCGgydHajogioi+pJRrjMM4xCdX
 X1iIgn3uYBGHUfaHwScYoIbRyIkJubKxuXxTkpPY3gRw+KlhEPBbrTnWe3R3wDRL
 K1+t1bZB774ZNroscKjsV5da/rWMDKyYvFkyRCNPnFWZ3h6beZLEGfpltgmH7F67
 VBfIVZZJ98vdAiovVMm5K552hQM9o3ta9WHh+mzfgPwIiFvJYMoTr/j9IZ7uw/1I
 Wu0DQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8cqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:40:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:40:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:40:28 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7919A5B6972;
 Mon, 16 Feb 2026 21:40:08 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 03/18] common/cnxk: support inbound pdb configuration
Date: Tue, 17 Feb 2026 11:09:28 +0530
Message-ID: <20260217053943.2748100-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217053943.2748100-1-rbhansali@marvell.com>
References: <20260217053943.2748100-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=6993ff3c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=QC7kw0MEJxuHXxlU5L0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX/mwcUoaQ5myN
 bUNTWLIaW67DbA2oSwxduixuNHW9ZhWOqHmSnBDGe+5ioESHi77VfWG+sIfssU/qCOd6N3JHyiB
 8mMfHwa1a6LCwOEOPst49Al4iWZhRXN2TSjJAJ47j5r+bMALwnCX0FFC29aXpgmQkQgMjfUUGML
 p3um4Evn5k+CY1JRMLlHCK993Lte2UiyiBYlszOd/NbPkdEGrq7eav1Rldz8MLAzGH55hSJzhR6
 rrm1TYYRc+BlB/gCmk/tJVhZ6h+BnoaixXf5AUVOQEb9fDhseNluL9m7lm9ilgSMBNjWzxvUHNO
 POwF6QORcw59WtWeA7RXrIMBlKc5+ciF1/LSCoG6neL3LGmQyIUZvvzIs07MkwyKjHvoJgtLu5/
 2q07si8ZiW+dnHRzUDNdhf/enAHsGrx7U9j+n32no7imbGiPn8BNuA5HQZjnJV5yYWkdtBhCYIm
 Nj3MjZuVWU9sC5HCt0Q==
X-Proofpoint-ORIG-GUID: 3chWHE7FYQUROXzkNeWpBwvNVhf6UAby
X-Proofpoint-GUID: 3chWHE7FYQUROXzkNeWpBwvNVhf6UAby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

Mbox cpt_rx_inl_queue_cfg is extended to enable/disable PDB
for inline inbound IPsec path.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_mbox.h        | 4 +++-
 drivers/common/cnxk/roc_nix_inl_dev.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 3e913fa13c..7871613d9c 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -2423,7 +2423,9 @@ struct cpt_rx_inline_qcfg_req {
 	uint8_t __io pf_func_ctx;
 	uint8_t __io inflight_limit;
 	uint8_t __io queue_pri;
-	uint8_t __io rsvd[32]; /* For future extensions */
+	uint8_t __io cq_remap;
+	uint8_t __io pdb_ena;
+	uint8_t __io rsvd[30]; /* For future extensions */
 };

 #define CPT_INLINE_INBOUND  0
diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 3a4f1ac1e7..727a2e2a81 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -212,6 +212,7 @@ nix_inl_inb_queue_setup(struct nix_inl_dev *inl_dev, uint8_t slot_id)
 	cpt_req->slot = slot_id;
 	cpt_req->rx_queue_id = qid;
 	cpt_req->eng_grpmsk = inl_dev->eng_grpmask;
+	cpt_req->pdb_ena = 1;
 	rc = mbox_process(mbox);
 	if (rc) {
 		plt_err("Failed to configure CPT LF for inline processing, rc=%d", rc);
--
2.34.1

