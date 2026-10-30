Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8784606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=hizU0hTZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DC4940613;
	Fri, 30 Oct 2026 10:17:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 9736A4025A
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:17:48 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8EgIR2005258 for <dev@dpdk.org>; Fri, 30 Oct 2026 02:17:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 X86MGfAVDl1gw02NVTAYKUgX5ygpW91VyW3c2UVk+4=; b=hizU0hTZfctonnU6h
 1Xhza9tLqdA8ajN1+AvapaYu7pED/Lz+PlgfbZsb6NhXBYkH5z+mojOMDy1EAF10
 LEg7ppAGhhFO2DYLK+t/bdZN0MuV0/zFl59wuOxVUQN9BJawBLAbuwvmo/N+yVyb
 FJRZvWpzSUXxQzebqV/bMhivwJh5E/2A0K8N+hsftpwfxAzMNOHb2srdH+NO3alw
 oCl0zlimhfSihsDwZUWbEzV/15HRs66cAJqwOG27rs+TP3K+d03295hThVjbFFFm
 7AdzXNpY1lx9LXFArwB5mWvKcUgUP68IHOa5/yMHEF2QS85UAPshjfVIptXc6elG
 2eSPw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hme5yt4nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 30 Oct 2026 02:17:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 Oct 2026 02:17:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 30 Oct 2026 02:17:28 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id DE1FB5B6953;
 Fri, 30 Oct 2026 02:17:25 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>
Subject: [PATCH 2/2] common/cnxk: fix DPC double counting for legacy pools
Date: Fri, 30 Oct 2026 14:46:52 +0530
Message-ID: <20261030091700.1237155-2-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261030091700.1237155-1-nkishor@marvell.com>
References: <20261030091700.1237155-1-nkishor@marvell.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNiBTYWx0ZWRfXz5djTYb+npNj
 TI9IdXRmnBn1TQlPCCMCAFzzxUEVoIR69EWbHi+zT/9Vt81Wj1dHWhqz5I0I7cIFVwDI+jzcvLn
 0pDVuBY6iLVgaPepqGjMPAANV+kQX94=
X-Proofpoint-ORIG-GUID: 0fQMaLGwEcPN4sEAmERerY0s7Js8ht8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNiBTYWx0ZWRfX45IKM6OyffqV
 cDRkvvI64P7MShI2OVcLuXQsYHtpt3bBaJiBqH1eKFORx/Dhd1M68xMqbHqEN2N6Qp6uh/FOOGj
 7rgTLKPgsJKjMhDSqW4pti0cKnEoGfYscmYJSLVwEXF9NaPCIsKAzo71dSWViOiChrvSCG8Na2J
 F2+j3qlKxGKe9h2NOmeqccJRbFnJWCyuyIbVHzFdb8HQjun7sExrcBKYOP32iyaq8ZiuA6Msy8Q
 AF98V2saFxeRm0qIpXM2Awl2CFYZFBNfoqAUxGlri/kXu2hJdpQBxNlC1N3CXmEHxaRGAP8NkOD
 yk3nJdXRmO0Ug7oieYXG9w1uidqtbYQ8A1a/Uexx3/lrw7KOnbsA2qM24VsFSfz+YZtOc8h6MNx
 nMk/tcQCD0trElYLyc4mBnaCskp7i7atcBo5xGpYW2Dy7JGFcazsePKq7U9OmP71NZvrY5SX5ic
 SUZ04JojdR/UkTrojVg==
X-Authority-Analysis: v=2.4 cv=N6q8hG9B c=1 sm=1 tr=0 ts=6ae460b4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=yF4zPZGAd_sfkxDKsBcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 0fQMaLGwEcPN4sEAmERerY0s7Js8ht8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For legacy (non-halo) pools, DPC was enabled on both the pool and the
aura contexts, so each operation was counted twice.

Enable and disable DPC only on the aura context.

Fixes: 28d65f12ac77 ("common/cnxk: add NPA diagnostic counter")

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_npa.c | 70 +++++------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index ebeebf1205..484fe47465 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -1952,13 +1952,13 @@ roc_npa_pool_dpc_enable(uint64_t aura_handle, uint8_t counter_id, uint32_t flags
 	req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
 	req->op = NPA_AQ_INSTOP_WRITE;
 	if (!(flags & ROC_NPA_HALO_F)) {
-		/* Enable DPC in Pool */
-		req->ctype = NPA_AQ_CTYPE_POOL;
-		req->pool.op_dpc_ena = 1;
-		req->pool.op_dpc_set = counter_id;
-		req->pool_mask.op_dpc_ena = 1;
-		req->pool_mask.op_dpc_set = 0;
-		req->pool_mask.op_dpc_set = ~req->pool_mask.op_dpc_set;
+		/* Enable DPC in Aura */
+		req->ctype = NPA_AQ_CTYPE_AURA;
+		req->aura.op_dpc_ena = 1;
+		req->aura.op_dpc_set = counter_id;
+		req->aura_mask.op_dpc_ena = 1;
+		req->aura_mask.op_dpc_set = 0;
+		req->aura_mask.op_dpc_set = ~req->aura_mask.op_dpc_set;
 	} else {
 		/* Enable DPC in Halo */
 		req->ctype = NPA_AQ_CTYPE_HALO;
@@ -1979,36 +1979,7 @@ roc_npa_pool_dpc_enable(uint64_t aura_handle, uint8_t counter_id, uint32_t flags
 	if (rsp->hdr.rc != 0)
 		goto exit;
 
-	if (!(flags & ROC_NPA_HALO_F)) {
-		req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
-		if (req == NULL)
-			goto disable;
-
-		/* Enable DPC in Aura */
-		req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
-		req->op = NPA_AQ_INSTOP_WRITE;
-		req->ctype = NPA_AQ_CTYPE_AURA;
-		req->aura.op_dpc_ena = 1;
-		req->aura.op_dpc_set = counter_id;
-		req->aura_mask.op_dpc_ena = 1;
-		req->aura_mask.op_dpc_set = 0;
-		req->aura_mask.op_dpc_set = ~req->aura_mask.op_dpc_set;
-
-		rc = mbox_process(mbox);
-		if (rc < 0)
-			goto disable;
-
-		off = mbox->rx_start +
-		      PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
-		rsp = (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
-		if (rsp->hdr.rc != 0)
-			goto disable;
-	}
 	rc = 0;
-	goto exit;
-
-disable:
-	roc_npa_pool_dpc_disable(aura_handle, flags);
 exit:
 	mbox_put(mbox);
 	return rc;
@@ -2038,9 +2009,9 @@ roc_npa_pool_dpc_disable(uint64_t aura_handle, uint32_t flags)
 	req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
 	req->op = NPA_AQ_INSTOP_WRITE;
 	if (!(flags & ROC_NPA_HALO_F)) {
-		req->ctype = NPA_AQ_CTYPE_POOL;
-		req->pool.op_dpc_ena = 0;
-		req->pool_mask.op_dpc_ena = 1;
+		req->ctype = NPA_AQ_CTYPE_AURA;
+		req->aura.op_dpc_ena = 0;
+		req->aura_mask.op_dpc_ena = 1;
 	} else {
 		req->ctype = NPA_AQ_CTYPE_HALO;
 		req->halo.op_dpc_ena = 0;
@@ -2057,28 +2028,7 @@ roc_npa_pool_dpc_disable(uint64_t aura_handle, uint32_t flags)
 	if (rsp->hdr.rc != 0)
 		goto exit;
 
-	if (!(flags & ROC_NPA_HALO_F)) {
-		req = mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
-		if (req == NULL)
-			goto exit;
-
-		req->aura_id = roc_npa_aura_handle_to_aura(aura_handle);
-		req->op = NPA_AQ_INSTOP_WRITE;
-		req->ctype = NPA_AQ_CTYPE_AURA;
-		req->aura.op_dpc_ena = 0;
-		req->aura_mask.op_dpc_ena = 1;
-		rc = mbox_process(mbox);
-		if (rc < 0)
-			goto exit;
-
-		off = mbox->rx_start + PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
-		rsp = (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->mbase + off);
-		if (rsp->hdr.rc != 0)
-			goto exit;
-	}
-
 	rc = 0;
-
 exit:
 	mbox_put(mbox);
 	return rc;
-- 
2.48.1

