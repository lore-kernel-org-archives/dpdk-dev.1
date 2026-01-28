Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19263D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:03:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B04B7402D8;
	Wed, 28 Jan 2026 07:03:50 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7C6EB402D1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:03:49 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S0YQho190508 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 8PDkIVKEBVe8dm0pSzJHF5n3wPBBytafXLp+GMKSyk=; b=dvYAA2gjVqvIrN8xF
 ygKh7FwvQ0wAGDZjbSYLTDebngqBjIjFkfbj9NMbq+Fhetzrm6OGK2+hk1lArHmM
 x9cSneLbSkA/EHYCDmGPR360h0N4Y460h6Krvutzay/LEYsr7D5YCMpOouRK5tNt
 zWSSBlIUE0YNjA9/9zQuiQwU//jZugcHEItZ0Yxw5pM+IM3uNhCZ1kpRWyT0qRf8
 N0rVmrROmwfCB5pQXrgyGEJjDG2vR5USexMCw1F0xq7kSV1sfc+OAs03RzERgBsX
 ld7Oa9cX6xwwPkSWPisIGK1RqbqUM1NAllqr4+XJgYUU65nbUE/Y28oR1KUu9jdx
 sgIXg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4by80yghbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:03:48 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:03 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 312DF3F7070;
 Tue, 27 Jan 2026 22:03:44 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 03/18] common/cnxk: support inbound pdb configuration
Date: Wed, 28 Jan 2026 11:33:01 +0530
Message-ID: <20260128060316.3967610-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FYc6BZ+6 c=1 sm=1 tr=0 ts=6979a6c4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=QC7kw0MEJxuHXxlU5L0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX9gkLHDgyPURz
 tzD5qAeMTR9NVQJ/OsNBH3lSgj2r8LOCOIBMNjZyaCuceDI/DLc+nDtPLXIS0qwBW9In0ML/NmP
 IvaAac7s+mUXJcgww37fXubF6w6FPX/hsqOIkn8ceCGpNNtmfGsxhPZ1+X10OxMrVxjpveTtAfH
 zvjmepmtuSoM2ubXsbt0u2YFZ9PTE7W2sQkF8cQ6Z9l1Y/EqUOig2XaMIKFeAaeE9Hc3ByVRdv+
 tE0PeWuWoA2Wgo4UuJHhoZMO+ozwXp1j+nBtsmu5/up7tdU07fYMQWmxtCOpASMqcHMll3OzSHo
 YOtW+Kdblvv5fC03m35Sa7d+oX7w3fuyhMI5YXr9ZzKSbozx0oFfmA5GxJbODZWSwEjRz/ZvvSI
 pG0rVeQ3p8xBP09jHbKvcEETcvvqyBALpoOHATHPu/fUwbB/Pq0P66bf6RrQVYIEI7s9s4yyQ+o
 hVvLH2c1NIZj58X35fQ==
X-Proofpoint-GUID: Ud9ogtQHwGubFKZtneg28fnbBgJ6U7bt
X-Proofpoint-ORIG-GUID: Ud9ogtQHwGubFKZtneg28fnbBgJ6U7bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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
index 1eb96f913a..fcbe9314a1 100644
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

