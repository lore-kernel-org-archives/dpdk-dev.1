Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B1CCCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFF0B40DD1;
	Mon, 19 Oct 2026 15:08:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9B0054067B
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:48 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Og8i538867 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 Rp7vOZgh6a7oLDB5diV4Zbnc1xdo0mQGoNP5npRTXA=; b=a6LLHoZFC/Wp9oBnd
 d9tOytUc76D+dNMn1n69W9jBsJXR0qpc4AnFaX8Gv4fQF4h8F1FKQiViPgBgQSho
 VmDdwHM8VbzO1vCl5NCk4ZoD72+M9lj1MCNOPaHDbHLLSEJJXQ6Go1CUbJjuWsLY
 d5MR8bMCIqynmeqMaAAUwIJCuTMdHd/0EGYfNBsF+5TfM6scUdHJxSz7mSNoKD58
 qI5UhB+H+rqUOftW6BL12oB+hDgcUA/49WMuEjs7O9hSYr18i1dKTqKptLBn1yc8
 nbkLBKAN/wmDhgjgyRzjlrlx6SoSWqVcj6ruwPIX/m20Py7+r+Fr/KdI1DZQ42k2
 hqpzA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hc6cj5gxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:47 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id BC6C53F704D;
 Mon, 19 Oct 2026 06:08:44 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 16/16] crypto/cnxk: size CN20K IPsec SA by context length
Date: Mon, 19 Oct 2026 18:37:57 +0530
Message-ID: <20261019130759.2181566-17-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Wf-9WNW4GPWK7FUm7a-3q-fw7K0NoLXp
X-Authority-Analysis: v=2.4 cv=L7KI0OT8 c=1 sm=1 tr=0 ts=6ad6165f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=637z7pUVPLZPQSpCa9UA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX0x46xbLpHbyq
 KLXydJ+8a10tVhZ8CAbCzlc0C6e/TMURb0jvL5p413npbmJcZ8OG9ILanu/Yv3Z3GjdPVUItaOU
 /N1n0AABicEv06HQJNryP/lMScmKJm6j7PFUsOjMVvSMkS9q2r9xlbrVauBNyn2RNXRzHOzrU7F
 1yxrExdtKlNNPaIXDwwW53BlvZ0eRolteBEl0D8r6g+ZEDS3Z/ccGzZLfx27ROwyp//unladVR1
 UYwSISEw4AQK9giFaR1oXWRzmpvWMsXmv1Gz5HaFadbc/pRg92JAH3bp5MmUNd4qquqLFEaWWzy
 tHxS88WIHJFSPoOrvdTO/J2qmHuDiVjrDs4bGwzgZdjbVFxZp085r6wgAbF9WlevnpDauLYXYkX
 HFQl2ELlQxPGGm34pfNeXawBOKlyD8UFC7hL5/Z3lDbaTFFZI501tLB4cOXNYkXSXI6pHrg2ZtK
 enKeyB3cISGu3nOPH3g==
X-Proofpoint-GUID: Wf-9WNW4GPWK7FUm7a-3q-fw7K0NoLXp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX8rkDVNsMW3EC
 Vd6SVA2XYWs4tpfwhf6ElWLuUftoHqR3cNE9n914vnWPHCTF7+IGQhrtcEGpKBYRPvL98ULNVqh
 IUxZifTIQhQcUrQzqJMDnYcZqpvLynY=
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

From: Rupesh Chiluka <rchiluka@marvell.com>

Allocate the CN20K inbound/outbound IPsec SA with a size of at least
(ctx_ilen + 1) * 128 bytes when ctx_ilen is set, so larger contexts
such as a 1 KiB SA are supported. Zero the full allocation instead of
only the default SA size.

Also advertise ctx_ilen in the PMD param string.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn20k_ipsec.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
index b2cab4ff5f..c7fe670724 100644
--- a/drivers/crypto/cnxk/cn20k_ipsec.c
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -31,12 +31,17 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	struct cnxk_ipsec_outb_rlens rlens;
 	struct cn20k_ipsec_sa *sa;
 	union cpt_inst_w4 inst_w4;
+	size_t out_sa_sz;
 	void *out_sa;
 	int ret = 0;
 
 	sa = &sec_sess->sa;
 
-	out_sa = rte_zmalloc("cn20k_cpt", sizeof(struct roc_ow_ipsec_outb_sa), ROC_CPTR_ALIGN);
+	out_sa_sz = sizeof(struct roc_ow_ipsec_outb_sa);
+	if (roc_cpt->ctx_ilen)
+		out_sa_sz = PLT_MAX(out_sa_sz, (size_t)(roc_cpt->ctx_ilen + 1) * ROC_CTX_UNIT_128B);
+
+	out_sa = rte_zmalloc("cn20k_cpt", out_sa_sz, ROC_CPTR_ALIGN);
 	if (out_sa == NULL) {
 		plt_err("Couldn't allocate memory for outbound SA");
 		return -ENOMEM;
@@ -124,7 +129,7 @@ cn20k_ipsec_outb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		sa_dptr->w0.s.count_glb_octets = 1;
 	}
 
-	memset(out_sa, 0, sizeof(struct roc_ow_ipsec_outb_sa));
+	memset(out_sa, 0, out_sa_sz);
 
 	/* Copy word0 from sa_dptr to populate ctx_push_sz ctx_size fields */
 	memcpy(out_sa, sa_dptr, 8);
@@ -161,12 +166,17 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 	struct roc_ow_ipsec_inb_sa *sa_dptr;
 	struct cn20k_ipsec_sa *sa;
 	union cpt_inst_w4 inst_w4;
+	size_t in_sa_sz;
 	void *in_sa;
 	int ret = 0;
 
 	sa = &sec_sess->sa;
 
-	in_sa = rte_zmalloc("cn20k_cpt", sizeof(struct roc_ow_ipsec_inb_sa), ROC_CPTR_ALIGN);
+	in_sa_sz = sizeof(struct roc_ow_ipsec_inb_sa);
+	if (roc_cpt->ctx_ilen)
+		in_sa_sz = PLT_MAX(in_sa_sz, (size_t)(roc_cpt->ctx_ilen + 1) * ROC_CTX_UNIT_128B);
+
+	in_sa = rte_zmalloc("cn20k_cpt", in_sa_sz, ROC_CPTR_ALIGN);
 	if (in_sa == NULL) {
 		plt_err("Couldn't allocate memory for inbound SA");
 		return -ENOMEM;
@@ -231,7 +241,7 @@ cn20k_ipsec_inb_sa_create(struct roc_cpt *roc_cpt, struct roc_cpt_lf *lf,
 		sa_dptr->w0.s.count_glb_octets = 1;
 	}
 
-	memset(in_sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));
+	memset(in_sa, 0, in_sa_sz);
 
 	/* Copy word0 from sa_dptr to populate ctx_push_sz ctx_size fields */
 	memcpy(in_sa, sa_dptr, 8);
-- 
2.43.0

