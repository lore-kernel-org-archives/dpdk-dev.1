Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14412CD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24B8D402AD;
	Tue,  9 Jun 2026 05:52:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BD583400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 05:52:56 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6590vPA93748901 for <dev@dpdk.org>; Mon, 8 Jun 2026 20:52:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 hk0R/hS/IsST4yo8nkWQWMdv+XkRHkHtHI1gxV2W8A=; b=XGTrsv70/SH17YuY1
 Ia3AedYbtvQ6hB4Nvw+NlQSZmxIJrtAcjE28uaFikQs59mPVhzKxHYka4G0Yp2VV
 cmlKqbpTL564uwao9a5zgr7Jp3h+HTIEVgwnwMOKz6b4GaCm5flIjqU2gqvan38Q
 568X7fUMOWFxSt7JziABtyl57t+Hvjeh2u4r+ulTzPIVEHmke5PixopMIKXBxAAw
 fnBcR841Yb+uaooNDD4Zg67l9MThuzmtyR2GOd9Tm2lWNg5AiBbXTIiXi28n0esd
 r8QeEkKaK5jq9igUF1VBOlXpkkQkezfpBHrT2z5UmA7SWX5RuA5TUtLHHOboFh9m
 d3VEA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2estdg-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 08 Jun 2026 20:52:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 20:52:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 20:52:54 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 989353F706C;
 Mon,  8 Jun 2026 20:52:54 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>
Subject: [PATCH v2 1/1] ml/cnxk: fix overwriting layer name during load
Date: Tue, 9 Jun 2026 09:22:51 +0530
Message-ID: <20260609035251.912771-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331085445.1105590-1-syalavarthi@marvell.com>
References: <20260331085445.1105590-1-syalavarthi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzMiBTYWx0ZWRfX/R38u+ID23Vz
 eYC/0G8k+aWslHDP/8Uaw3nIktS7Ej1SbKF7AOZLBR+kWbAdt2bBPdC0BOtUr9YOxJ9sr/Warso
 iJJQls41ze0XvrATmxeV9e3885IxTtt1rJxIM9uBcpyWor6wUV6oSLR1N6vyP7CpDafCczeK6Ga
 IbhudTegjl+eD42x6N6/36KxIBsmTL36Bmt7/40HBoPP5nAAMD0gEhT4+GxddGnBBL8LMf9OPLx
 WWuQwYAq0rEd6myQjDWv1FyEhRclRfb21kC2Zf14HbrynMsa+yC989wNZwx+ShQnXv7P/j+olYM
 bKnfRrbivqynvhwNJejT+fn6LPZMbTbmH5A2+zgLLJU2q16bm9ibMRtzLe3uwjC4xpvDJEXdY2Y
 5iyDwfOKOtPGvG++56vN6+e+dk47ICeuoLkSMOL3kPqowsHRuqc1/B/P8cn8O5D1X7FLPFkM/rQ
 FxFK4B6faLgw31eSaQw==
X-Proofpoint-GUID: A3MfLWJ1KHUvGU6t1TQHAhQpVcuwrCzz
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a278e17 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=iVztVgIAZmhkfI8QdAoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: A3MfLWJ1KHUvGU6t1TQHAhQpVcuwrCzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
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

Layer name is initialized during metadata fetch and parsing
stage and should not be overwritten during model load. Fix
overwriting the layer name during layer load.

Fixes: cc254869ae19 ("ml/cnxk: update model load/unload functions")

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---

v2:
* Updated commit message with fixline

v1:
* Initial patch

 drivers/ml/cnxk/cn10k_ml_ops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index b30af7c7a44..cb9e6561442 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -671,9 +671,6 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, const char *layer_name, uin
 	rte_memcpy(&layer->glow.metadata, buffer, sizeof(struct cn10k_ml_model_metadata));
 	cn10k_ml_model_metadata_update(&layer->glow.metadata);
 
-	/* Set layer name */
-	rte_memcpy(layer->name, layer->glow.metadata.model.name, MRVL_ML_MODEL_NAME_LEN);
-
 	/* Enable support for batch_size of 256 */
 	if (layer->glow.metadata.model.batch_size == 0)
 		layer->batch_size = 256;
-- 
2.34.1

