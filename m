Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD2CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 07:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B0B402DC;
	Mon,  1 Sep 2025 09:31:40 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 040F94060F
 for <dev@dpdk.org>; Mon,  1 Sep 2025 09:31:37 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5817VRLp013921
 for <dev@dpdk.org>; Mon, 1 Sep 2025 00:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 /34CNJR8x7swOTHZI4GB3GB5OjRcX7OU76un3LazLU=; b=PJTd8lUWkmXWTNIM7
 a/JWcBnAl6WU8MQSzCtCMB67THDMLhMgGl0y8FhTMTsWuvIzFrrjLPG8SUE1hKBB
 faBdItkEmfR66BCgG7zKrEjS7gbJQZ+fZU0nDXuSKI7dObtAJ9lya1ZkD3wfEXvo
 jbbhh/wmO6sPN/0WZksfjtltJHZwYbzeh1ZjAlzKPgTog/LCfs88bZi4nm9+IN0i
 EROXCZG17KvT4lanihBNvZ88K76RcZQQCEd3bAck6jzh21NjbJ+oXcA0V6PEEidm
 YQMc2AdAi4Os+y9bJupEIpNs//1MukzpLxmcpknKhFUM/YTMwISL0qj+8V03jk2Z
 ihaPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48w75y8033-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Sep 2025 00:31:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Sep 2025 00:31:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Sep 2025 00:31:36 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id B2CD53F70AD;
 Mon,  1 Sep 2025 00:31:33 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Monendra Singh Kushwaha
 <kmonendra@marvell.com>
Subject: [PATCH 05/19] common/cnxk: fix inline device API
Date: Mon, 1 Sep 2025 13:00:21 +0530
Message-ID: <20250901073036.1381560-5-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901073036.1381560-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDA3OSBTYWx0ZWRfX4aGByrEqfCDs
 //Tes8IGY323l1W3Yl6uDQYuhN9s2iwqWendL8MJDqb1+UBHlO6tEJ8OujsZQ8kN3qFp45OoLd9
 tQAwKOz+mQk3bQ9dTa5s1lEgFTRyeET/2Jzb5kmPa9Qx80ats8Ws6wW6m99g1qBZ9A5qf5qfIkm
 WkbhlGZ+x0TH4FbR8qMiTxu539Vl+KDeL7chBAc+6Ve+AlaTz7vXG15F7mPrvxHvprr5QwWuAth
 KGTuX91Aj1Hjb1QiDVvAS0y1UeiWRLSctgpYM+xZGT4eb393PI5OWkeyoMrzdKsUQaSMDSGEjJI
 qjSkFtegUvmS7ZID7MxEiURn7oW93plvpZr8HcXAQw1NrJXe28UhBTt//B4KhPwPUiVYYUljzLZ
 jl4fmdKf
X-Proofpoint-GUID: lVPkqVLk_jwDzVOVzIWswpKxkib1451o
X-Authority-Analysis: v=2.4 cv=D9BHKuRj c=1 sm=1 tr=0 ts=68b54bd9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=5jKgjrcBzDdf451F3XwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lVPkqVLk_jwDzVOVzIWswpKxkib1451o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
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

From: Monendra Singh Kushwaha <kmonendra@marvell.com>

This patch fixes the inline device functions to work
when roc_nix is NULL.

Fixes: f81ee7133b48 ("common/cnxk: support inline SA context invalidate")

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index c7637ddbdc..a5fc33b5c9 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2324,7 +2324,7 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 	if (outb_lf == NULL)
 		goto exit;
 
-	if (roc_model_is_cn10k() || roc_nix->use_write_sa) {
+	if (roc_model_is_cn10k() || (roc_nix && roc_nix->use_write_sa)) {
 		rbase = outb_lf->rbase;
 		flush.u = 0;
 
-- 
2.34.1

