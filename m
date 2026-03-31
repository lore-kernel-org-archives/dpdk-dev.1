Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2411FF60D0
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EF454042F;
	Tue, 31 Mar 2026 10:54:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 27D9A4026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 10:54:06 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGMwo32048333 for <dev@dpdk.org>; Tue, 31 Mar 2026 01:54:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=D7VdjbeGL8eWZ+foaqvEpq9
 lkBYjTSS9ly89lrC5mk0=; b=FzBzrHgnnwAkziaf/dxKbQu+NhOUg7JK4BePa5R
 VWFtBRF+RNCqFUQwDs1EVoh20+p8W7dpqU472cAFiCWaZvmsZqjCi4axUS0EHFaJ
 0YTk4QBtfN578FMOVQVJ1AHlpzIaO75fSXFyILmpmxzkeqTP4yYCRb8lu4gF6arh
 z3S1M2c5QOJD8b78w0jfVe+brt2EvmZrCq4aIYlNsK1kBVpTFuK0knrlrfbYrRMx
 FSuP4+TSCW+XGMh1U7pQdgXxAmpWafSoAQAo+JRH9k9adm2s2lSVEXgotUEjV4DE
 fnv9NH533KwA3UwX6WfpXpVcKRPuQTGyr3HIQ9g+DBHWQUw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d7u0rj81n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 31 Mar 2026 01:54:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 01:54:04 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 31 Mar 2026 01:54:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 31 Mar 2026 01:54:03 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 4804B3F705D;
 Tue, 31 Mar 2026 01:54:03 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>, Anup Prabhu <aprabhu@marvell.com>
Subject: [PATCH 1/1] ml/cnxk: enable data caching for all MRVL layers
Date: Tue, 31 Mar 2026 14:23:50 +0530
Message-ID: <20260331085350.1105103-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4NCBTYWx0ZWRfXxj3IJE82W4M5
 egRT6umytwNKHBVM+ngYLsGUlofwDSIRg3vpzlI/5vCwYk4DIlywhfzIj8bZN25EEp2oSVTUlh0
 uF+YOwuIEd+5DXIEeFipn2ToFi523CMkQqCIXF9Dps6AQat/7b/rNKmY0qu08SAY13Rzn6y4Ndk
 L9kPHSTnnO1Cy2qzyKlDqCi7+fD3qsGSlAJK6OooCSxQZATxyXHLOCD6P2qfPo9D+bixkGtHzgX
 o5r5x3K5NRHGyuxyceQWmlyYVs702JQjgH+5RjlRlYwPMqUGPCEdqRhoUDih4ewgQvzdWdMfnyZ
 IgSyDIWDfRsRPV0gp5LBlljJU0Rjcfi+C1B70KkifhFyTpHvtyTtYLKpyP/2v7xHXdSdhqDEMEO
 oOkG6a+LhIPS+nRK2ewlpVavC22NAD63JSSSdEfM2MRLSZsh0jJGeAoCfamoKgbS75a5X34Bveb
 PqkylXhZ3JdbWmsiWxQ==
X-Proofpoint-ORIG-GUID: yKlR4dina_q9uxw-MXBG43R9OKP2UF10
X-Authority-Analysis: v=2.4 cv=UJzQ3Sfy c=1 sm=1 tr=0 ts=69cb8bad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=JSHFuCMBMt6b3OsP86oA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: yKlR4dina_q9uxw-MXBG43R9OKP2UF10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
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

From: Anup Prabhu <aprabhu@marvell.com>

Enabled data caching for all MRVL layers in TVM models.

Signed-off-by: Anup Prabhu <aprabhu@marvell.com>
---
 drivers/ml/cnxk/cn10k_ml_ops.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index b30af7c7a44..628ff963c3c 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -997,13 +997,8 @@ cn10k_ml_layer_start(void *device, uint16_t model_id, const char *layer_name)
 	if (ret < 0) {
 		cn10k_ml_layer_stop(device, model_id, layer_name);
 	} else {
-		if (cn10k_mldev->cache_model_data) {
-			if ((model->type == ML_CNXK_MODEL_TYPE_GLOW &&
-			     model->subtype == ML_CNXK_MODEL_SUBTYPE_GLOW_MRVL) ||
-			    (model->type == ML_CNXK_MODEL_TYPE_TVM &&
-			     model->subtype == ML_CNXK_MODEL_SUBTYPE_TVM_MRVL))
-				ret = cn10k_ml_cache_model_data(cnxk_mldev, layer);
-		}
+		if (cn10k_mldev->cache_model_data)
+			ret = cn10k_ml_cache_model_data(cnxk_mldev, layer);
 	}
 
 	return ret;
-- 
2.47.0

