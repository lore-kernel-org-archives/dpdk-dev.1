Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0985C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 16:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D413340652;
	Mon, 26 May 2025 18:58:30 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A762F40656
 for <dev@dpdk.org>; Mon, 26 May 2025 18:58:29 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QA8r9G023219
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 ohDQA7zLNCbndPtRxjb2kXvPrGizkC9neO2+4O3C+w=; b=h4xGCTQH4T6BIBgWE
 tujlb1GQn/bsOfb8quc9NmZotHeeN6MBmh554TGw/Gr/eDzS28QSQlzQ+Brh+SJB
 IcaUNdWZO1TMlILHcLmNe4AXeZmbtVrx+PYzqhOd2tpZoCOj6bmS9sKTk+v+2/+b
 qgpsqe4Or/3V0FVea42BTehqcbGx5N6K6FOXf4/IxOhCq1aesJkY5X2Z/v53V4KK
 H9VBQ0mgfwGwXCJ8AYl62OFFs5vsGxBI5eO/PGVKK114euRVsquPdTBAhmrou7fk
 Zu8mReSLCPhJOXzeFIQRs+vzq6XrGuIRLDkzuq+0wgK6bLe85sB8Dr0NSLr8BMX+
 SSyrQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vp9krp92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:58:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:58:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:58:27 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 70BFC3F7048;
 Mon, 26 May 2025 09:58:24 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 01/40] crypto/cnxk: update the sg list population
Date: Mon, 26 May 2025 22:27:40 +0530
Message-ID: <20250526165819.2197892-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=68349db4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ctROhwN8KPbxf-V8h80A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfXwfgh52YWgL7i
 m2mOCiwhZ+iqnZaTpj0efUKdXJio3guUCPpYgkbnEmSdc3pC8z7VfML+auF6rV8S2MElaz1Wn+6
 Or223ZEgc930DXbGjEwiIz0HVwEWArCP5n98FwVOxrV8XLBNC6Me44wn3vRcdsn+XwI0F65j4xj
 biLLDLgSeAqS+BsWrthNLuH93UGLe0ER0ZEGcgLQ72enmUbAo6R4wSliNibw0ErGebJFQXB/eNx
 JoA467FNmDhpkpUDG6j9ZnL810JBxnkYyrnexH25c+0pBkuyBXxi29ktsLoUaHihda9NEBC1TcW
 BlWwBsaijV6UI5LhdScMVJWYf0VpuuWzoHJ1VzxrmYHnZCY44SK1UeDf+9T234sgOasoHUCcvfW
 nKRZZqI4yv2NDvUz8mm39WCnddYCTWZ5MC+KvGuA63p4k13g7lqrOl85YT1b1BrZ3dxxWeJm
X-Proofpoint-ORIG-GUID: eOCOj08hIBCZtqhpIhYHr8WBfToNCjQE
X-Proofpoint-GUID: eOCOj08hIBCZtqhpIhYHr8WBfToNCjQE
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

