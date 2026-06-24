Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA50CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 04:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 011F640299;
	Wed, 24 Jun 2026 06:54:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0AA3340150;
 Wed, 24 Jun 2026 06:54:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1XIwK1234603; Tue, 23 Jun 2026 21:54:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=3
 W80mMkGbxhpvXGZyibTekA56cip3e89qTDvi9Hrgxs=; b=SrBrU9WIWvtrsdjnR
 DFMBgXft/IU/8xCBeihABnF0724nFRZthq5iWUF5udTiCLY30MNMnPSgOJNKEkZT
 upOr0V0TetJd/htTm8ER6dLNjPYMf/ENhpB4Oefdo9h72MFohk1nDN96PlWRWuB9
 yHsvT3mkyEYFLGLvaTs+E46YmgzjulaKaZA75bmBsfneLx0dwDW9gg8bMjXdrKUn
 aDQzhoRts0tRCjxLBiw+jVhbOthc5ZwRg5tlJxNS/yO8DkmRd6WS/TOtLzxdtktM
 8Fzh4kHULltbi+89e2qKx6dECrVY45MUBt7OE7bWSHxqpqWrSCkfNMSkYO/iEoYt
 bP+qA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f03u9gr33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 21:54:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Jun 2026 21:54:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Jun 2026 21:54:30 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id 3C03B3F7061;
 Tue, 23 Jun 2026 21:54:28 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <dev@dpdk.org>
CC: Rupesh Chiluka <rchiluka@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] app/dma_perf: skip case if worker maps to main lcore
Date: Wed, 24 Jun 2026 10:24:17 +0530
Message-ID: <20260624045417.3294252-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260623045841.2602104-1-rchiluka@marvell.com>
References: <20260623045841.2602104-1-rchiluka@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDAzNyBTYWx0ZWRfXwsrN2iqCn+Rq
 ZDlz6nbFMz70Hl0A9U+blOZQTovNnKsPgn7ljc47xHGq/+r6VBr4f5PnkD/qB2zBXw0puVBW5PY
 07suyPPvt4vf2iCD6+GuwE1wnez1M6pSZTowTc8++snwTWUyDtjDg0YmgGuNLbqO4WWk3tIZdVG
 OB9w8nn2Uo/CZqmixb7Odsthq0c2v7gUa+l3/d2dHj7HGprKJFgWT6Yg7/ZjXNqc2mpN8nOY5VP
 NlVuDOAQ9BQL+KzrsbhU//ui4MGt8KtTOkyDe3Teqkf/2j5mAvU6GQJCxg1qPSGiNgH+r5wdaC6
 mfagYe2B0srK+rVgRZ+o4ny5BgpyvKhMzKS4Yle7RIbC9Fo+4Ku1juLw9x+5+0KpzTSFLUH19NZ
 QcqNkfIO2ajoX63UtLp6zv9idiuCDHHieid3CRMdqkgi2pG8tbRwyCtC1KSbkZnFo0s4JNsigP0
 1u8ZS56EfaKXwHQImXA==
X-Authority-Analysis: v=2.4 cv=LMdWhpW9 c=1 sm=1 tr=0 ts=6a3b6307 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=8L6Ihs-hDQBXnjAS2lIA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RljdYCXzhY3RRHiqJCcSKXLG_nK5Wv2i
X-Proofpoint-ORIG-GUID: RljdYCXzhY3RRHiqJCcSKXLG_nK5Wv2i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDAzNyBTYWx0ZWRfXzwyFm31HTNuo
 Ahh5mf53yfNz98R/8NnogzCGpMgseJ9OhsFbdrm2v+nNsKNlODCYZIyIBKrrZTl09njwLllI2bl
 gDQOf3T3nK4Gd2aKm1IkuKYo1Qjmy1I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
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

When a configured worker lcore is same as EAL main lcore, the main
thread calls `rte_eal_remote_launch()` on itself and then waits for
`worker_info.ready_flag`. The worker function cannot run on the main
lcore while the main thread is blocked in that loop, and the test hangs.

Reject such cases early in the `run_test()`.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
CC: stable@dpdk.org

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 app/test-dma-perf/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 4249dcfd3d..a22434c558 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -109,7 +109,9 @@ run_test_case(struct test_configure *case_cfg)
 static void
 run_test(uint32_t case_id, struct test_configure *case_cfg)
 {
+	uint32_t worker_lcore;
 	uint32_t nb_lcores = rte_lcore_count();
+	uint32_t main_lcore = rte_get_main_lcore();
 	struct test_configure_entry *mem_size = &case_cfg->mem_size;
 	struct test_configure_entry *buf_size = &case_cfg->buf_size;
 	struct test_configure_entry *ring_size = &case_cfg->ring_size;
@@ -122,6 +124,15 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
 		return;
 	}
 
+	for (uint32_t i = 0; i < case_cfg->num_worker; i++) {
+		worker_lcore = case_cfg->dma_config[i].lcore_dma_map.lcore;
+		if (worker_lcore == main_lcore) {
+			printf("Case %u: worker %u (lcore %u) cannot run on the EAL main lcore (%u).\n",
+			       case_id, i, worker_lcore, main_lcore);
+			return;
+		}
+	}
+
 	printf("Number of used lcores: %u.\n", nb_lcores);
 
 	if (mem_size->incr != 0)
-- 
2.48.1

