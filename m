Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D23C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:56:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E121B40DCD;
	Fri, 23 May 2025 15:53:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4FD4A410DC
 for <dev@dpdk.org>; Fri, 23 May 2025 15:53:11 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9rCXq016898
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 S1jmhBme3oZd7MLDml3G90IcHY5VUyCv9AdPfqlxdI=; b=RvQrrXl63erA/Pkjx
 hH2r6Qcc8lrnxZd26k3vCyEDNgs/q/ve6xMSre48XtMxk6iNPkjCxcu7gBeSUlh1
 0Sa3WS3Qj0y6PPywEkwXDa5HXh+QamkBkM5TQT3lFchagB5bqHh6TItKCAtvqbXo
 2vmPDZYEKI6xzAGN9JgZtbo/aPK/5BQG1A24XzXf+tyuKRYtdlsWYaz45ma+x/Cl
 cUEyrN7v4xIe/6RnW2xLhs00etb5Y29mB1sklWivqZ+aqw6C4tl1gkRAUpwTngE9
 ZTiqHSsdM4jpMhsGpSSDy5RQ1yawi+ZoHLDhxbPh14VXiyxjFOWwuBpQepxwYh3z
 d3zLA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tmgp8sw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:53:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:53:08 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 4B3E63F7041;
 Fri, 23 May 2025 06:53:06 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 35/40] crypto/cnxk: add struct variable for custom metadata
Date: Fri, 23 May 2025 19:21:06 +0530
Message-ID: <20250523135111.2178408-36-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F7jehE9XpWLzcNeTOEtRc3DsDGkOyS5U
X-Proofpoint-ORIG-GUID: F7jehE9XpWLzcNeTOEtRc3DsDGkOyS5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX2IbvhkLasC/D
 qPe1JoKJwrFdrZp2FN4R0I3y8qPhzKoWUZNDlSvNKCMchaZ/8sPB0ak0q4v5gomoEPN/gRTTZ3W
 w/yWvWhe0E0RizYj8HbbobwNaDZEqh15rAnPqABXiYtSJaQ1DZofvm5fYqSW7aAAEY0xKP0Rk1d
 Pq4n5WQ0VDIfZfxjpuCHLoN8a2Hc3PmWKt9E1DlsnBIVIJ6LJbbx/SHQL4e09S62tXw7e6MkLZe
 EbOdnTaYU/cDyTuk2mSJIJPfbCFOVBfbHJtzVhn2gboVljVD9BSfV330Mu3T2XxQVfqnYO/HVMW
 NnlXAhqFy4ZCwgRjbDfvuWqNl3f6W/QTxAjcAo9vQI+qpwkJEPbla07A46I90Ckf+SmiecPlviY
 y0K3R0wCIc/jspghUkI5kNwnKyjlvdWfCrv27mBKugG4U5cZ8ZhTrS+PgPgxGEVQU0LuTkh6
X-Authority-Analysis: v=2.4 cv=KYPSsRYD c=1 sm=1 tr=0 ts=68307dc5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=FbTz2Mgud2xj_ohD22wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Adding struct variable for passing custom metadata
to microcode.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index df8d08b7c5..17d39aa34f 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -30,6 +30,8 @@
 /* Default command timeout in seconds */
 #define DEFAULT_COMMAND_TIMEOUT 4
 
+#define META_LEN 64
+
 #define MOD_INC(i, l) ((i) == (l - 1) ? (i) = 0 : (i)++)
 
 #define CN10K_CPT_PKTS_PER_LOOP 64
@@ -58,6 +60,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 		struct rte_event_vector *vec;
 	};
 	void *mdata;
+	uint8_t meta[META_LEN];
 	uint8_t op_flags;
 #ifdef CPT_INST_DEBUG_ENABLE
 	uint8_t scatter_sz;
@@ -70,6 +73,7 @@ struct __rte_aligned(ROC_ALIGN) cpt_inflight_req {
 };
 
 PLT_STATIC_ASSERT(sizeof(struct cpt_inflight_req) == ROC_CACHE_LINE_SZ);
+PLT_STATIC_ASSERT(offsetof(struct cpt_inflight_req, meta) == 32);
 
 struct pending_queue {
 	/** Array of pending requests */
-- 
2.25.1

