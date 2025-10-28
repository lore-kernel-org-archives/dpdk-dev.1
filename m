Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1034CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 17:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6CC640262;
	Tue, 28 Oct 2025 18:57:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE464021E;
 Tue, 28 Oct 2025 18:57:23 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SDrTjP1293438; Tue, 28 Oct 2025 10:23:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 za3ymVnbGSNBIdu1mcSKZfjGussBttZWQrYx2F4JXI=; b=k86hQM4bJpsxFtl4E
 jXBF+Jyp5bogLyQTEXobJdtpbHnNKI9n357toVe5bDI/RiVZBwtkskfvxV/3K6Y/
 MhdwD0bWbUQjozzM8VBrFAkzdRgvvSiNqAOpGcTBIPBqy6/gjsGwgli0u5Z7U2Qw
 7j1sqh3keyJXSLCcPyVx8ZTaKo7CI1RtCzVI+QZ0P3ewhw8/hXcRMTolVkyJctdS
 QCvUGva6W7AyYT7rQ/6DviQQaEYpwWNSQ8Q4MVE4UirYlhkWWsSTZrVTXYkX5vME
 ywXtyyg6tNLCZUPgblL+6TFBlOaEJLm3BecNGLNkD8fSHXBCTn3N5+XbNL0pt/t9
 IU3cw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a2s5ktee8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:23:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Oct 2025 10:23:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Oct 2025 10:23:44 -0700
Received: from jerin-lab.marvell.com (jerin-lab.marvell.com [10.28.34.14])
 by maili.marvell.com (Postfix) with ESMTP id 2897B5B6930;
 Tue, 28 Oct 2025 10:23:41 -0700 (PDT)
From: <jerinj@marvell.com>
To: Amit Prakash Shukla <amitprakashs@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, =?UTF-8?q?Morten=20Br=C3=B8rup?=
 <mb@smartsharesystems.com>, Ferruh Yigit <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH v1 3/3] app/test: fix issues with clang 21.1.4
Date: Tue, 28 Oct 2025 22:53:23 +0530
Message-ID: <20251028172324.3149379-3-jerinj@marvell.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251028172324.3149379-1-jerinj@marvell.com>
References: <20251028172324.3149379-1-jerinj@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0NyBTYWx0ZWRfXz9hO9dSZBQ+K
 YjY4uH8HNz+XB3YFj+Ow9LvTvtoOvggVABjw5AqPNKrnttOf43E4+xFS5UX92X5BCi95OS+cHOh
 hjHDRs+jTbifYO8dYzbT8OecUK41I8HWkOvDqcgFcyP91YvncLv/cJmUFe1PJd/riZeRoepaEbX
 fPcNVmZkmnmeOv366S+nL3Cbe6gBRDjiqY7GnsBOityDVd1jsjNMGbcxlKeqzQTBYB7CHaGDaMJ
 ejfdbGvdojsO7nC5HOaVybZQ/AineIsPBIMZ0J5VrDZIm5XzbewVqLsrk0HUDObSg15p5dvDVj8
 dLvamQTVMdBGXNnmHU+47XiN9QBOvO/LFss/15/y4vp+zVjQWKsRGWYhdrrwoFFYQKmGOR2siaO
 tBqWZxdZRfKf2x0iuHdPycEKdaXgwQ==
X-Proofpoint-ORIG-GUID: OoLaLMXXtK2VNkcfRjJF2h2myPJP2hiK
X-Authority-Analysis: v=2.4 cv=BuKQAIX5 c=1 sm=1 tr=0 ts=6900fc23 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=Nnu6frwsqterZxj1QOQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: OoLaLMXXtK2VNkcfRjJF2h2myPJP2hiK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
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

From: Jerin Jacob <jerinj@marvell.com>

Fix the following errors seen with clang 21.1.4

app/test/test_event_dma_adapter.c:532:32: error: variable 'event' is
uninitialized when passed as a const pointer argument here
[-Werror,-Wuninitialized-const-pointer]

app/test/test_trace.c:201:29: error: variable 'tmp' is uninitialized
when passed as a const pointer argument here
[-Werror,-Wuninitialized-const-pointer]

Fixes: 4925e15a1614 ("trace: add trace point emit for blob")
Fixes: a276e7c8fbb3 ("test/event: add DMA adapter auto-test")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
---
 app/test/test_event_dma_adapter.c | 2 ++
 app/test/test_trace.c             | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/app/test/test_event_dma_adapter.c b/app/test/test_event_dma_adapter.c
index 7f72a4e81d..4df5991285 100644
--- a/app/test/test_event_dma_adapter.c
+++ b/app/test/test_event_dma_adapter.c
@@ -144,6 +144,7 @@ test_dma_adapter_params(void)
 	TEST_ASSERT_SUCCESS(err, "Failed to get adapter capabilities\n");
 
 	if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
+		event.queue_id = 0;
 		err = rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID, TEST_DMA_DEV_ID,
 							    TEST_DMA_VCHAN_ID, &event);
 	} else
@@ -528,6 +529,7 @@ test_dma_adapter_vchan_add_del(void)
 	TEST_ASSERT_SUCCESS(ret, "Failed to get adapter capabilities\n");
 
 	if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
+		event.queue_id = 0;
 		ret = rte_event_dma_adapter_vchan_add(TEST_ADAPTER_ID, TEST_DMA_DEV_ID,
 							    TEST_DMA_VCHAN_ID, &event);
 	} else
diff --git a/app/test/test_trace.c b/app/test/test_trace.c
index 8ea1443044..52b5ba5cbb 100644
--- a/app/test/test_trace.c
+++ b/app/test/test_trace.c
@@ -179,7 +179,7 @@ static int
 test_generic_trace_points(void)
 {
 	uint8_t arr[RTE_TRACE_BLOB_LEN_MAX];
-	int tmp;
+	int tmp = 0;
 	int i;
 
 	for (i = 0; i < RTE_TRACE_BLOB_LEN_MAX; i++)
-- 
2.51.2

