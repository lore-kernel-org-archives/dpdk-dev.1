Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDBEC87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 07:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F5E140BA6;
	Tue,  5 Aug 2025 09:14:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C554340BA5
 for <dev@dpdk.org>; Tue,  5 Aug 2025 09:14:10 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574NTvmB032447
 for <dev@dpdk.org>; Tue, 5 Aug 2025 00:14:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=MP5FxPEJv70i3wSS2WHrtsN
 VeU+R4KhW/XgXxfP141g=; b=XkQNbQrwPxhhK5NBsKQTPKFzmQ4MCBJL/H1L0H8
 xBJpPQYY4tGR9jXzF3YRLeqDi19pSTf6WVExaxalpJma/16sduGGPWpB/avRbafq
 wek7VbPkmq7tpcfCGAhll+xc6D9S0ZsCVc+zj5oAkGIT2heefnBxFu/xmI7pLR1+
 vaPn7kJS69e7WttSXqrlbdq8bxuUagZS1nm1Z0WpE7pt+1C1C9no0u5n6IMETLsn
 VzABrtLQbQj+M4MX6A699w/Z3qhbTu/AoX22sI2CchJIrFL11nI3thfa0nx0Zz7G
 xxgNYtacp6WeITnztbPqOLrEeRqkJAxtUiFnZIPUYm9DZcQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48b6k18q3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 Aug 2025 00:14:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 5 Aug 2025 00:14:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Aug 2025 00:14:08 -0700
Received: from cavium-SR1-T640.marvell.com (unknown [10.28.36.102])
 by maili.marvell.com (Postfix) with ESMTP id 991B45C68FA;
 Tue,  5 Aug 2025 00:14:04 -0700 (PDT)
From: Akhil Goyal <gakhil@marvell.com>
To: <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH] app/crypto-perf: update result granularity
Date: Tue, 5 Aug 2025 12:44:01 +0530
Message-ID: <20250805071401.207884-1-gakhil@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RdDnQzso1ofHA4kc9layEWO1o4KQvm5k
X-Proofpoint-ORIG-GUID: RdDnQzso1ofHA4kc9layEWO1o4KQvm5k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA1MSBTYWx0ZWRfXwKen5rKEhsVb
 xEj8t/QFd1bpZSkbyzjcGp/LapyjwS1WA57KLg2arIlkmWTdw1SsBnx+cgeMdTA/nQCc4qvmdUm
 bpVGLvYqaMyeKyjzAAadTx1pqTirDPdYG+P72P6Jnm/sCao8XmoVcreKhekhGFn8N6CCCSO2Ibf
 j+mK5Mlb57qKKoiBRkDlv98cZ5taxsZAl42YJMaJJg/Z7qTJNSssr82TPOIzluVqdSGHLRjoUIy
 xXPeHRg7Br4KERDhUojEt9Ky4//ABR6/oXQMvRYaUV10fUPMFG/oIuog3hQCWgD2aRau9+sV0dj
 iIbm6zYuW1oI+wN+BDPxLdCRqs6Y7hoKaJqI7YpAkDTs0+Los1CntSY+akpaiD7f5MeWo1J6YlI
 +o8oRpknHNWcHBtYgpUBgqF4zgiNgwQtRE/S4a8cp1tmXVXfs+EHd2XjZQC2F2Z5OzezNp89
X-Authority-Analysis: v=2.4 cv=epjfzppX c=1 sm=1 tr=0 ts=6891af41 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=VuSv09_KWT_405Rku0cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
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

In cases like RSA which has low performance numbers
compared to AES, the Mops and gbps may not give accurate results.
Hence updated the number of decimal places to have meaningful
results.
The results are not updated to show Kops or mbps as the results
may be used in CI scripts which considers them as Mops/gbps and
hence all scripts will need to be updated.

Signed-off-by: Akhil Goyal <gakhil@marvell.com>
---
 app/test-crypto-perf/cperf_test_throughput.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_throughput.c b/app/test-crypto-perf/cperf_test_throughput.c
index 13b16d9670..3a82d75f95 100644
--- a/app/test-crypto-perf/cperf_test_throughput.c
+++ b/app/test-crypto-perf/cperf_test_throughput.c
@@ -374,7 +374,7 @@ cperf_throughput_test_runner(void *test_ctx)
 					"Cycles/Buf");
 
 			printf("%12u%12u%12u%12"PRIu64"%12"PRIu64"%12"PRIu64
-					"%12"PRIu64"%12.4f%12.4f%12.2f\n",
+					"%12"PRIu64"%12.6f%12.6f%12.2f\n",
 					ctx->lcore_id,
 					ctx->options->test_buffer_size,
 					test_burst_size,
@@ -394,7 +394,7 @@ cperf_throughput_test_runner(void *test_ctx)
 					"Cycles/Buf\n\n");
 
 			printf("%u,%u,%u,%"PRIu64",%"PRIu64",%"PRIu64",%"PRIu64","
-					"%.3f,%.3f,%.3f\n",
+					"%.6f,%.6f,%.3f\n",
 					ctx->lcore_id,
 					ctx->options->test_buffer_size,
 					test_burst_size,
-- 
2.25.1

