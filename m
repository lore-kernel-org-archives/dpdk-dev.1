Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B3CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 05:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADD9640611;
	Wed, 24 Jun 2026 07:43:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1132C40150;
 Wed, 24 Jun 2026 07:43:01 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1WxWV1234342; Tue, 23 Jun 2026 22:43:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 6H7BXnwr9/PwuYPM1pE5ZNxPVZw5vQw8w5udb3RPUo=; b=E5Tl8fhfWj0QpC3g4
 zc72jqROd/+O0p8YP6fhSU9rcw/X37O3nDQIBnkYJfWn4xhVr9FbrGaQxvATBcxF
 +osfCEE0R6eW7Zv1JoBfvR6JaRapyuGmbXvQDto5eTey+gYfze2n6P0ZUovDqj0m
 HXiPEMr1vM1C+5eYONTafKeU6ELQ8MMiHyrTS+7/weiZPgI85yJMmxk6tq0IgDC5
 FtM+579OdREbAXDokRJpACPRMLuF/ggKl4W9JqWFoy8wi4glPKlnZmis3rx0jgeg
 b2eJCTaGwP80pCozjUMnJvpHO7E+bT80cuiaI97NJSNmedLGgOA15672utMegZpb
 5vUEw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f03u9guh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 22:43:01 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Jun 2026 22:43:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Jun 2026 22:43:00 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id A43143F7041;
 Tue, 23 Jun 2026 22:42:57 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <dev@dpdk.org>
CC: <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>,
 <gakhil@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 "Rupesh Chiluka" <rchiluka@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2] app/dma_perf: skip case if worker maps to main lcore
Date: Wed, 24 Jun 2026 11:12:54 +0530
Message-ID: <20260624054254.3367097-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260624045417.3294252-1-rchiluka@marvell.com>
References: <20260624045417.3294252-1-rchiluka@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA0NCBTYWx0ZWRfXyCFEDOsBUdTz
 Ey5zB6vxXBtMAaxlnEUhvDr98/tat7R+Xu/sNtaQ60oErmtbIMW7ywncS17KppuFq4+fwXp7qA8
 nZeYmj5ZLAPWQAbXby5s3UGpYoKu13LQxqqOaH7efXJM7vu7p4qRte1spTmDsdXupTdCaeUREeL
 itsHL/9sOBT0DWAkdMMl6/2fZWrnzBd4/8XqW7lB3mpigL8McgM97DBTGPY/EXZUxCHsPiUP+W0
 qJPChoJp5bVaM+Rh2kYkT060+PVjEbu2Jkdg3ckrrnHnc5Dx9Gjy6nXNgn7N2dgzk5ZQESSE5jA
 gE86kH9VOQI0iybOEtpJa/dBEFRlNWrze+W0jXnRkFNKTFkxXWUZM6CCPtVb4yoHKiM9Hbn6CZ1
 9qYwA1akpBqwp7rRv9bhXNhSys5w5ei5R+BVyiM91XnJCKnQsxM67sgM4iu/5eW8IO1RINz8NJL
 fvNqdXBO7FnrDaciveA==
X-Authority-Analysis: v=2.4 cv=LMdWhpW9 c=1 sm=1 tr=0 ts=6a3b6e65 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=8L6Ihs-hDQBXnjAS2lIA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: NBqMb5n5z93RsFWLAtmpl9FIGphL6rSV
X-Proofpoint-ORIG-GUID: NBqMb5n5z93RsFWLAtmpl9FIGphL6rSV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA0NCBTYWx0ZWRfX1RXiwdujjXs8
 /yHahzrKmmKS3E1L3hBK1KhBxErpzDcCmmhnweKYqTizHFOLQ9Yex4irZZEausFWNLaSdB0PWR+
 8L/x9ummgIiR/C79WufX7iH9+VubtfY=
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
 app/test-dma-perf/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 4249dcfd3d..2809e5417c 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -110,6 +110,7 @@ static void
 run_test(uint32_t case_id, struct test_configure *case_cfg)
 {
 	uint32_t nb_lcores = rte_lcore_count();
+	uint32_t main_lcore = rte_get_main_lcore();
 	struct test_configure_entry *mem_size = &case_cfg->mem_size;
 	struct test_configure_entry *buf_size = &case_cfg->buf_size;
 	struct test_configure_entry *ring_size = &case_cfg->ring_size;
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

