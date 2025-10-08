Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D717CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 07:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2478B402A0;
	Wed,  8 Oct 2025 09:46:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0A11340297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 09:45:59 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597GloaZ026812;
 Wed, 8 Oct 2025 00:45:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=L00Z150WA176cVvCwfT93FU
 VKUK4hWG77sdlJ3OGn6g=; b=g01w9rddJ0//IKe8ViZY3emB07Jc1+itBgzFJXq
 BWaiC3wyS2k5kd9aFovSn/VdKEv+aymWFSD6nM1Bsi780Fn1TCubCla7UGjDTzPg
 D2WcZYzq/N9JvLPcECw1voAC4cvyp37rteShX3f/plxkSi/hizGCViuAB3rsDVbV
 Vm77cDOuI5kzxEczCI2dP/nuBckybVgFhz/LIV+DsqfTzt4gHZXsGxQ69P8qyQeu
 R5PmppyTzPCCfyFUhjZe9G5mcbdGjC9xEsqJXzOnVCo98bWbwoluK+I8bx/whvAH
 /Bv05UKagRyf75/iTuiunxSo0fKVZhghXqBUZb2YQlidsvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49n6pu9jwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 00:45:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 00:46:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Oct 2025 00:46:07 -0700
Received: from ashishg.sclab.marvell.com (unknown [10.110.24.201])
 by maili.marvell.com (Postfix) with ESMTP id 3588C5B693C;
 Wed,  8 Oct 2025 00:45:57 -0700 (PDT)
From: <ashishg@marvell.com>
To: <dev@dpdk.org>
CC: <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Subject: [PATCH] compressdev: fix device ID validation check
Date: Wed, 8 Oct 2025 07:45:23 +0000
Message-ID: <20251008074532.3066685-1-ashishg@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=A8Nh/qWG c=1 sm=1 tr=0 ts=68e616b6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=AXKQ0g-OwOHdnXYC3O8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 28rFNyRdGlRqaqdMgR7gK9b0jSXjFV5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEzMiBTYWx0ZWRfX/RzfHe/doHjL
 f/eyI4dpWwiJVk0fTP3BzdHU1jcrX1FDh+LoqE6Wpq8U5q0Wm0LlKCPB1/g68eEGMkg/cKc6KmK
 wLO40HlLTpPRsDz8N9Uk/vibZz98n3BFfYJqf8cLJDZKhneOcKSak94geztV0LGY9VAHh8qpaei
 /tBgCC7QNXXcyJCyxnCYFq3/dNOnhefMZkPR5gHCvRk7t4CymFmDy8mqhd/fWg2Nw3PnSq1UkPU
 sQLPO1k2PsvgHq9YKzY6nl1pZU32KSznQ+uzyPwysXicwOxR1CvvF9LWM0682BKIm+ccVTAcIBr
 mZv0cQb05TfZhesJYFK/nvNc2KXUbMHrZpzFHmdSoA58+sJDR2Iq/+wgY4PV3gVTdNr0+wZCbZ0
 W3kiHgHVL/n0pUjXYpINZJ4DUBf5QQ==
X-Proofpoint-ORIG-GUID: 28rFNyRdGlRqaqdMgR7gK9b0jSXjFV5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
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

From: Ashish Gupta <ashishg@marvell.com>

nb_devs is incremented / decremented each time a compressdev is
created/released. However, releasing device 1 incorrectly make device
N invalid and inaccessible. Similarly when first half of the devices
are released, rest half of the devices become inaccessible. This patch
updates the validation check to ensure correct behavior.

Signed-off-by: Ashish Gupta <ashishg@marvell.com>
---
 lib/compressdev/rte_compressdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/compressdev/rte_compressdev.c b/lib/compressdev/rte_compressdev.c
index 33de3f511b..8435bfa134 100644
--- a/lib/compressdev/rte_compressdev.c
+++ b/lib/compressdev/rte_compressdev.c
@@ -104,12 +104,22 @@ rte_compressdev_pmd_get_named_dev(const char *name)
 	return NULL;
 }
 
+static inline uint8_t
+rte_compressdev_is_valid_device_data(uint8_t dev_id)
+{
+	if (dev_id >= RTE_COMPRESS_MAX_DEVS ||
+			compressdev_globals.devs[dev_id].data == NULL)
+		return 0;
+
+	return 1;
+}
+
 static unsigned int
 rte_compressdev_is_valid_dev(uint8_t dev_id)
 {
 	struct rte_compressdev *dev = NULL;
 
-	if (dev_id >= compressdev_globals.nb_devs)
+	if (!rte_compressdev_is_valid_device_data(dev_id))
 		return 0;
 
 	dev = rte_compressdev_get_dev(dev_id);
-- 
2.43.0

