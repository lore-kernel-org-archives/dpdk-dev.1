Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F465CD8C85
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20BAA402AD;
	Tue,  9 Jun 2026 06:05:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A5040400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:05:19 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65942FJr4101536 for <dev@dpdk.org>; Mon, 8 Jun 2026 21:05:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=4717irglbuzieuHKByv/Jd7
 X/7NmM8eWMINzc1Cm/aE=; b=CILFzqnvr7LShacMqIn3o1z0zbsKqdBWXtYwy7n
 aOM/CjrVdp1jI6WtpxjnhrIhNQbR9H6If231Jhpe4pHh/Lex3BRXL3PGKUd02vsc
 PC7cLjqr+WjJRmqSDClHcFAywPhbmpJ6InrwNC8k/0LplV0kigDO0T9W4H5cOC/u
 1dxr5lYiZ8+9DrvN7OK3bVX/sAjeoD3y1/L449ZaeIuukZzwB7JZCXuAcQf28K1D
 2GCp7cdyHI5PbzAujLO9lI16IPO6qVgoXsqgmdt8+s8K4/IaNflyXMjwi7CW11s7
 xOtUSls+HBLhqgN4371CvHyvsSTkPbaeLKrCZkqyWQPctdQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2esur5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 08 Jun 2026 21:05:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 21:05:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 21:05:17 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 8DEE43F7059;
 Mon,  8 Jun 2026 21:05:17 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>
CC: <dev@dpdk.org>, <sshankarnara@marvell.com>, <ptakkar@marvell.com>,
 <aprabhu@marvell.com>
Subject: [PATCH 1/1] mldev: fix typos in code documentation
Date: Tue, 9 Jun 2026 09:35:13 +0530
Message-ID: <20260609040513.919215-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAzMyBTYWx0ZWRfX9RhF8oAi9FAI
 D6JlXC9iFMco2YXDx/Yj5bxmbjZdvMm+R5WgL2uCiUVpybJ1oCL+IVWwVNM5e0DGrSwDjc2izuS
 O30OHkdxCwbm0rLuylH0LidjqJ9t+9Kos4490WOwMeWIh7Bptn7Ua2aPcKzb4gEFXMccQfZt9oQ
 w+IoabmCn0BiMuHAOJUzo7tEd6NrFCwZPp0HasoVzOPHvijG3ViYzMPQ9oHaBVhniTwIx1BETaw
 ME7uc8JSyPwMEP8sRWdkARW61na/lJI6UTWMcf8JTaoDR42F5xi6Z8GL7yYTEOTAVxVOiGzQCkw
 el3jH1tUXEvgZlnD5gcZhA+k/PDQoaRoJ03hcSRTuDtH94WHSBXAtpC8fHC9OAHUE3jzs3yqu3c
 cZ5lPjNnnUkdoDhYTdV1daUehsaMYrwQgNwrCGTSLVOTmm5xclMJZ/YuozPLVvpXy+w/ASPUdsz
 2TmSqi8ZWCIKSkXFzcg==
X-Proofpoint-GUID: 2UhGlJWlUOfykTGMwlUowXbyasvPq3_I
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a2790fe cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=0rsNSki7CctCLrSa850A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2UhGlJWlUOfykTGMwlUowXbyasvPq3_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
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

Fix typos in MLDEV spec and code documentation.

Fixes: d82cac584f84 ("mldev: introduce machine learning device API")

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 lib/mldev/rte_mldev.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/mldev/rte_mldev.h b/lib/mldev/rte_mldev.h
index 3f51083cb7d..594c46cf72c 100644
--- a/lib/mldev/rte_mldev.h
+++ b/lib/mldev/rte_mldev.h
@@ -497,7 +497,7 @@ struct __rte_cache_aligned rte_ml_op {
  *
  * The rte_ml_enqueue_burst() function returns the number of inferences it
  * actually enqueued for processing. A return value equal to *nb_ops* means that
- * all packets have been enqueued.
+ * all inferences have been enqueued.
  *
  * @param dev_id
  *   The identifier of the device.
@@ -540,7 +540,7 @@ rte_ml_enqueue_burst(int16_t dev_id, uint16_t qp_id, struct rte_ml_op **ops, uin
  * @param dev_id
  *   The identifier of the device.
  * @param qp_id
- *   The index of the queue pair from which to retrieve processed packets.
+ *   The index of the queue pair from which to retrieve processed inferences.
  * The value must be in the range [0, nb_queue_pairs - 1] previously supplied to
  * rte_ml_dev_configure().
  * @param ops
@@ -840,7 +840,7 @@ rte_ml_model_unload(int16_t dev_id, uint16_t model_id);
  *   Identifier of the model to be started.
  *
  * @return
- *   - 0: Success, Model loaded.
+ *   - 0: Success, Model started.
  *   - < 0: Failure, Error code of the model start driver function.
  */
 __rte_experimental
@@ -859,7 +859,7 @@ rte_ml_model_start(int16_t dev_id, uint16_t model_id);
  *   Identifier of the model to be stopped.
  *
  * @return
- *   - 0: Success, Model unloaded.
+ *   - 0: Success, Model stopped.
  *   - < 0: Failure, Error code of the model stop driver function.
  */
 __rte_experimental
-- 
2.34.1

