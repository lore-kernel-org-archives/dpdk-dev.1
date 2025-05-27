Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C784C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 04:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40FF540651;
	Tue, 27 May 2025 06:00:46 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5A57D40656
 for <dev@dpdk.org>; Tue, 27 May 2025 06:00:44 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNecGe012646
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 ohDQA7zLNCbndPtRxjb2kXvPrGizkC9neO2+4O3C+w=; b=LCuiSKORlEhMwyLrF
 E8fJFl9dD5ryPL0Fa1dwl/+/Cq5J9LLWkujHTTCFmYIztchwsJRaZuX7SGISdYE6
 D4g6xes+ivdrkR30KhgtzLinkV6PDb2PDV7V5vAeweGWNGN5a/+/hEdn90mItDqD
 aCMpgJTN3cib4BLpTY4LE5yX1ZfhnVznouXop8OIpghHYS5/TcXew26+Bun0bF1x
 7KqckipAkw6WFOIARG0/qD09pdNIQFNNg85xvwb0zTjAwDj1BZ2EOk3UZ8+ptxeq
 UEcQPzWkUD2xihTZ2AIxVVqTisJciY9DL2FmsILMttsEmgcoM8V94ZCPWp1fHIcl
 yxMRQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w20e8bv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 21:00:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 21:00:42 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 6D9843F7060;
 Mon, 26 May 2025 21:00:40 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>,
 Aakash Sasidharan <asasidharan@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 1/6] crypto/cnxk: update the sg list population
Date: Tue, 27 May 2025 09:30:31 +0530
Message-ID: <20250527040036.2280893-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527040036.2280893-1-ktejasree@marvell.com>
References: <20250527040036.2280893-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: p-6D25DFFtLVDsBTftoZrU1EdjnStJ6m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAyOSBTYWx0ZWRfXx9gb3HN6ANHK
 e2xm1z7o9hpa9AionhuKpPaV3IHlifH/s5rSe0k/WXtItoJAFmeCbyxBk4tra7aMUF6NP0Qezch
 1tFwHzqO8kU9FYz+4Arjsu0634oCOR6QLRbBLcgykUgofjGRRAahndF6IjvbCirwN39XnZQU/iI
 lB/lINM1BdD6FtXUMZOVxSWnj5t2UdDIPMaa5yEoxI8dulGa4vc7ipVUO4BNfbg5l2u0SYVeT2R
 Djj/Zrb79q61Y915PzWJluKJiWTcA655eDdasH+8ESR6cCqwds9wjASu0q2MZc8qAuBiM2dhP5y
 wa0rrxDG7qBHLVwIftREcot8kBHtTv/GEJUKGsSCeIam5Q/yJoXw6rTk04UwMzK94NZ98M7nl9w
 tkPugKRls48d/N2whXZZIuern4Ue0qZGXmf38IXOcic2pkCHi1BfTkIcrmg9JyYFO2aFCOWz
X-Proofpoint-ORIG-GUID: p-6D25DFFtLVDsBTftoZrU1EdjnStJ6m
X-Authority-Analysis: v=2.4 cv=G5ccE8k5 c=1 sm=1 tr=0 ts=683538eb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ctROhwN8KPbxf-V8h80A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

