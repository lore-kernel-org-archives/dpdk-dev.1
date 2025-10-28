Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA179CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 18:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0C8140262;
	Tue, 28 Oct 2025 19:14:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 208D74021E;
 Tue, 28 Oct 2025 19:13:59 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SDrTjN1293438; Tue, 28 Oct 2025 10:23:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=5OJZCCKEdzmGTVoGj11cJnS
 gPa8ySvGXNfun+axpwJQ=; b=GcehidiFV34vC4AMQNksHUTIuedEc8RNgjRJjUX
 lBPRE2Ph4NFeimAwTwIh5rWJOhLwqhuVcroS3wNhQy4TtY8RB2C83hzGVT73NYbg
 u+85m84s45BjtbZRBC0nrg0WkVIeTHTIS2y+t8bdVgaHLLhjTabQq8ngxZ40FHBG
 sNo5pvUfNn5/EeCB4DTpPQHLCSumOc1juQPuJAx5JKUwRbnv7j1WYpH2YEEOHGD8
 oC0SzRCVI+KrCn9mNaig1RaGDia5UyVfuYWrXamwhiBgDVBq1x9qLVEZeNNOEOyu
 /i6wb1jE7EPkb8KoJ4LH1uqf7TbF+RJ33ULnYL9RGiNmMkw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a2s5ktedf-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:23:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 28 Oct 2025 10:23:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 28 Oct 2025 10:23:46 -0700
Received: from jerin-lab.marvell.com (jerin-lab.marvell.com [10.28.34.14])
 by maili.marvell.com (Postfix) with ESMTP id 0B2EA5B6930;
 Tue, 28 Oct 2025 10:23:33 -0700 (PDT)
From: <jerinj@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Amit Prakash Shukla
 <amitprakashs@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <stable@dpdk.org>
Subject: [dpdk-dev] [PATCH v1 1/3] app/test-eventdev: fix issues with clang
 21.1.4
Date: Tue, 28 Oct 2025 22:53:21 +0530
Message-ID: <20251028172324.3149379-1-jerinj@marvell.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0NyBTYWx0ZWRfX2JcKfxNyYJHs
 mITmpG8Km8RNKw4g4C/jxkcGvzziKh3iSxey0RIsxhvTalvdYcDCHjT+DGHiezvIg5fdYIsjv/w
 eWYzhOr1XeeUySV+mdkdu1fLrLPUzEW/EjucH54LOmnMl4z0S4khdjex+WQjr3RyZaV1XfPej4c
 JQTUw4I6/jJjGd3WmsY7ogaZyViHSKEnojzZbYgyB9E6UUxlJN8jcARWGmnf0uRgHEjRrBd7u12
 ++ruSXp1ZvkYhmwFPHE6BlY03ra8Rngb/mAdlB0qSVucMFmgiroWg1IxnzCi4/RPTfTFkSa2835
 SkSsXzDU80J7zI1tU7Kv2l4cMkk53OQ73OJkGuv1XiKt6sb0jBYNesxn5Yp8tM5zBoaYqFhYu4C
 436fo6a6cENF27EPurBWv1DKqTEXVQ==
X-Proofpoint-ORIG-GUID: 5YSOEvnMt850NZQJ7uD6RbNtCgYfD0ID
X-Authority-Analysis: v=2.4 cv=BuKQAIX5 c=1 sm=1 tr=0 ts=6900fc20 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=fB2rKyNNVGVUYmmwlCkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 5YSOEvnMt850NZQJ7uD6RbNtCgYfD0ID
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

Fix the following error seen with clang 21.1.4

app/test-eventdev/test_perf_common.c:1340:30: error: variable
'event' is uninitialized when passed as a const pointer argument
here [-Werror,-Wuninitialized-const-pointer]

Fixes: b25a66c49e8d ("app/eventdev: add DMA adapter performance test")
Cc: stable@dpdk.org

Signed-off-by: Jerin Jacob <jerinj@marvell.com>
---
 app/test-eventdev/test_perf_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index 2ad451e457..2bbc17ae96 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -1335,13 +1335,14 @@ perf_event_dma_adapter_setup(struct test_perf *t, struct prod_data *p)
 		return -ENOTSUP;
 	}
 
-	if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND)
+	if (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND) {
+		event.queue_id = p->queue_id;
 		ret = rte_event_dma_adapter_vchan_add(TEST_PERF_DA_ID, p->da.dma_dev_id,
 						      p->da.vchan_id, &event);
-	else
+	} else {
 		ret = rte_event_dma_adapter_vchan_add(TEST_PERF_DA_ID, p->da.dma_dev_id,
 						      p->da.vchan_id, NULL);
-
+	}
 	return ret;
 }
 
-- 
2.51.2

