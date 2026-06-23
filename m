Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE0CD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 04:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFBBA4014F;
	Tue, 23 Jun 2026 06:58:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C80AD4003C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:58:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0gAMt3982266; Mon, 22 Jun 2026 21:58:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=eh9mhNe9t/xS4oeVG095gfH
 Hub0tzTscdXUC/IMcO60=; b=Euyxw3KGIMTL8YXratEd/DNb6fuWoMZo29Ic/Uj
 KR+VeCL/gVhyQN00GXk+7WuuJYCoOxuZRg3LKRBfLr3u64XpS8N14eiwUoC3EtWB
 nLtLkB1giao0EDjxk9CJPQ4svhxZ3ZV2sG7YThzMrrJm7zcmXJ7nowWQBqBAseM+
 Zn6TAadZaZTLlKjhgKgyZSR1Wwt+FCFDflUxU6N4/rsvb5IH6HqqXqSIFoiZqLtk
 fa6L6WSiEZFq2pa5qODoh/MPXHxtN60xXjKWkKNUZWqnvBr5nBj9ZInMStk9AV4p
 7bwWFoMBW9l0pSk3WMhmKYYe8QzuZpBWWp73yLhagFx0ReA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyfr78h6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 21:58:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Jun 2026 21:58:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Jun 2026 21:58:51 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id A7FA93F708D;
 Mon, 22 Jun 2026 21:58:48 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: Cheng Jiang <honest.jiang@foxmail.com>, Chengwen Feng
 <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, <gakhil@marvell.com>, <anoobj@marvell.com>,
 <ktejasree@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>
Subject: [PATCH] app/dma_perf: skip case if worker maps to main lcore
Date: Tue, 23 Jun 2026 10:28:41 +0530
Message-ID: <20260623045841.2602104-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX8V1u7ozA82j7
 QMPzXmPpimrUQbevcsYFddDfVr+rl+FX3MLID/wu9rZLk44vDupf5CrW8qy9lT0WUiansKMw/qj
 cG0z0ABdH+ES9nYWrSfHOVque1s17zQ=
X-Proofpoint-ORIG-GUID: fVCZYEqrflgXLJtwQDByAjqI9hAov9pu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX2gbxfPSvwpaY
 spbqlgiYSGrQy/cEvD/i3pW8/i/u4AeK6g2iaUwopWZTRVbJbU/XfNjuWCcfhdKtZoMrioPi00S
 9Of83iBZAkReNcqu3O90XZd+ra2Wpbek1LySoiwb1PyQXExQ8jc7POp3gWfLM1uwjY/PMfa5StK
 cDf8p87xHeCM2eHhwjhuYBtLtndGSfJ20T8slzj3eSD6s16H4AA1c+mNmNP8bvFnHW/crtIV/SC
 A7maQSyLM911FlcYUzhxwVNSi1PcA9nRydC5pZYjSryyhmTJinpmCk8LDDL8fV2rXdbat+yiiTU
 bK6W0uJTsrI87fHTXi10+eW/eu+A1o6bw6PNmn13z7C313ewoIsiM4iAVs75gea2hvxDsmfHtnO
 ZO8z7uQtnOV9YXxpQatY7/rqfRp7Lfj6X8NNt28s/HV3ZdK87heLx2kd+bI54WsaeZZ+XfMDZx7
 lE7lOEAlK82ck0VAofA==
X-Proofpoint-GUID: fVCZYEqrflgXLJtwQDByAjqI9hAov9pu
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3a128b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=cUNl0c28Ms2mT_XI8t0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
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

Refuse to run DMA/CPU mem-copy cases when any worker is bound to the
EAL main lcore.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 app/test-dma-perf/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 4249dcfd3d..b6aa5b8401 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -109,6 +109,7 @@ run_test_case(struct test_configure *case_cfg)
 static void
 run_test(uint32_t case_id, struct test_configure *case_cfg)
 {
+	uint32_t main_lcore = rte_get_main_lcore();
 	uint32_t nb_lcores = rte_lcore_count();
 	struct test_configure_entry *mem_size = &case_cfg->mem_size;
 	struct test_configure_entry *buf_size = &case_cfg->buf_size;
@@ -122,6 +123,14 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
 		return;
 	}
 
+	for (uint32_t i = 0; i < case_cfg->num_worker; i++) {
+		if (case_cfg->dma_config[i].lcore_dma_map.lcore == main_lcore) {
+			printf("Case %u: worker %u cannot run on the EAL main lcore (%u).\n",
+			       case_id, i, main_lcore);
+			return;
+		}
+	}
+
 	printf("Number of used lcores: %u.\n", nb_lcores);
 
 	if (mem_size->incr != 0)
-- 
2.48.1

