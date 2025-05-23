Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841DC54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E579F40A73;
	Fri, 23 May 2025 15:52:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6AD1A4028C
 for <dev@dpdk.org>; Fri, 23 May 2025 15:52:10 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBl8Rm006690
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 ohDQA7zLNCbndPtRxjb2kXvPrGizkC9neO2+4O3C+w=; b=eSduC46SlqfomQ1Qr
 3pleekEoi4agjWNyLUgWg1pmeUOGgCtAahqj/Prll4CiDiPcqG/fgQcPm+LzqpMo
 VcUC9XFk+H2rNIhYuf0Eh0PxUL+cTktA0QEibGSPxDjyIVodMEKYBD/NkU+D+Qxc
 kYEG/96/+rnAFkbcqaErh3DaInLnLnziZYFcj0+0OkHc6X58b+kXzt8eEOYCCzMi
 WcJ3Fmlnp4uYIIfktQcAyoxiPYIrIB1UwOLuBVNorLQkwmoiwkNziLb/8dwGaney
 6ITPfj/y3OAa0/tUxraMHtX9GdYp0HkqcyP26/gNxNvdIEvEXrBgZuyQMe59UEj8
 fJSqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnksh52-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:52:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:18 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E36493F7081;
 Fri, 23 May 2025 06:51:15 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 01/40] crypto/cnxk: update the sg list population
Date: Fri, 23 May 2025 19:20:32 +0530
Message-ID: <20250523135111.2178408-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX3DxpezRUB3Fh
 aSGa64d55pkRkPNkljTONHaB0/yy83iTEE+rZsObH7KRgu5BYw4aVzVerCbGqqWseNzfjuJa2wS
 MSF5hngO7kbhneaCj1FAvGmlPXJqGSol6aIA94nwRVZ2MuIJUea3QexywxKo/UjL63PgtJKIlyY
 JMWBao4fN/EGC1ccEt/L46YT7cYS8nKeoXMlNjuQCjUgocXIeSReisCLcp1gWhKJzxZtIc3ZLug
 As928/MCXDCtO0B7SgzL0CPAXIY+DMl9WxS54aCgDGxL3sniyo+TQ4LYKj8CZP31saxUH5e8jLk
 AGaB4VHQi99tvEXpndtA07EN73lsgtonjMPC2daNRJGuyaLTmkO3RjHxI13P5VsHOh1ecBq/oOP
 YkFloXXOdv0voX74/1K9CBvWk9hpZSYblAEdj4rU3ezHu/fm6fZNhZdZ2D4VqV1NP3WeBDtn
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307d89 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ctROhwN8KPbxf-V8h80A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: BWam5S2TkwCgAknE_dhyAiDN7TId2Z7k
X-Proofpoint-ORIG-GUID: BWam5S2TkwCgAknE_dhyAiDN7TId2Z7k
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

update the last seg with length before populating the scatter list

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn10k_tls_ops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_tls_ops.h b/drivers/crypto/cnxk/cn10k_tls_ops.h
index e8e2547f68..c5ef3027ac 100644
--- a/drivers/crypto/cnxk/cn10k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn10k_tls_ops.h
@@ -136,6 +136,8 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k
 
 		g_size_bytes = ((i + 3) / 4) * sizeof(struct roc_sglist_comp);
 
+		/* Output Scatter List */
+		last_seg->data_len += sess->max_extended_len + pad_bytes;
 		i = 0;
 		scatter_comp = (struct roc_sglist_comp *)((uint8_t *)gather_comp + g_size_bytes);
 
@@ -156,8 +158,6 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k
 		w4.s.opcode_major |= (uint64_t)ROC_DMA_MODE_SG;
 		w4.s.opcode_minor = pad_len;
 
-		/* Output Scatter List */
-		last_seg->data_len += sess->max_extended_len + pad_bytes;
 		inst->w4.u64 = w4.u64;
 	} else {
 		struct roc_sg2list_comp *scatter_comp, *gather_comp;
@@ -189,6 +189,8 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k
 		cpt_inst_w5.s.gather_sz = ((i + 2) / 3);
 		g_size_bytes = ((i + 2) / 3) * sizeof(struct roc_sg2list_comp);
 
+		/* Output Scatter List */
+		last_seg->data_len += sess->max_extended_len + pad_bytes;
 		i = 0;
 		scatter_comp = (struct roc_sg2list_comp *)((uint8_t *)gather_comp + g_size_bytes);
 
@@ -209,8 +211,6 @@ process_tls_write(struct roc_cpt_lf *lf, struct rte_crypto_op *cop, struct cn10k
 		w4.s.opcode_minor = pad_len;
 		w4.s.param1 = w4.s.dlen;
 		w4.s.param2 = cop->param1.tls_record.content_type;
-		/* Output Scatter List */
-		last_seg->data_len += sess->max_extended_len + pad_bytes;
 		inst->w4.u64 = w4.u64;
 	}
 
-- 
2.25.1

