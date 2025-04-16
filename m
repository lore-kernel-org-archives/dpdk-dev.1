Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B7C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 11:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C51A40B98;
	Wed, 16 Apr 2025 13:06:01 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D74CD406B8
 for <dev@dpdk.org>; Wed, 16 Apr 2025 13:05:59 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9dSjG005747;
 Wed, 16 Apr 2025 04:05:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=3YOxeLO4WPCglL0dXmDggNM
 jfoOptpCsf/CcLcEImcM=; b=O9/8T8fmp7PFEzeR8Y4Ax6SbSZOV2xNfAwVYBHS
 doVNcmBueFEmWl0uhEJ6Y/FBh1Bdlp3Mjor448CS9111OPJxbuhqasukr4YWESyh
 8vcJ3mM7PwTLHdLFYknhoRewz4sQPF/BjY817nF8E7mbWN9E/kbKLaWmFswUW0j5
 jM1dw2M9DpiWjSaue99ri9tfhG9yMap7E+7eGhHJXqWE0hF6l1rtq57eXIpNk0NY
 yJcVl/5fYRWkyMge5ATnLRQR0cpQlds1ZazkX9nErt+MFdbxXDGGnXPwJYyuZjoz
 ymMEnkoEwrpkrvoyKNGKIGK/+W6gQjV2Y4r0dA8I7ZieOzw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4620fdh7rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Apr 2025 04:05:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Apr 2025 04:05:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Apr 2025 04:05:58 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 8AAA65B694D;
 Wed, 16 Apr 2025 04:05:53 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <vattunuru@marvell.com>, <g.singh@nxp.com>, <sachin.saxena@nxp.com>,
 <hemant.agrawal@nxp.com>, <fengchengwen@huawei.com>,
 <bruce.richardson@intel.com>, <kevin.laatz@intel.com>,
 <conor.walsh@intel.com>, <gmuthukrishn@marvell.com>,
 <vvelumuri@marvell.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] doc: announce DMA configuration structure changes
Date: Wed, 16 Apr 2025 16:35:41 +0530
Message-ID: <20250416110541.10358-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NaKfJd3ESGTqxczbXnFkHh8q8VmfV8L9
X-Proofpoint-ORIG-GUID: NaKfJd3ESGTqxczbXnFkHh8q8VmfV8L9
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=67ff8f16 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=SkdOB7VhPT-uvE_n3M0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Deprecate rte_dma_conf structure to allow for a more flexible
configuration of DMA devices.
The new structure will have a flags field instead of multiple
boolean fields for each feature.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 doc/guides/rel_notes/deprecation.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 36489f6e68..854db96c08 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -142,3 +142,9 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* dmadev: The ``rte_dma_conf`` structure is updated to include a new field
+  ``rte_dma_conf::flags`` that should be used to configure dmadev features.
+  The existing field ``rte_dma_conf::enable_silent`` is removed and replaced
+  with the new flag ``RTE_DMA_CFG_FLAG_SILENT``, to configure silent mode
+  the flag should be set in ``rte_dma_conf::flags`` during device configuration.
-- 
2.43.0

