Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE25C83F18
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 08:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E48C6402D8;
	Thu, 10 Jul 2025 10:51:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6C61D402D1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 10:51:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NWjU5019700;
 Thu, 10 Jul 2025 01:51:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=VQWCzHqO8/0879HF1Arh0Pm
 9NJT2MSM+TjMxglAhqVw=; b=MetoVlaGIT2BfivXi+UdWj4EhHDu82176AvPlHa
 DWn/uxz1W6H+upyVTY6RAR6T/GBJs02iM320gfnqgOA7op6dUrLvyaOA9VmYb5ro
 D4AdHNVszJNKfljH3o3495HsdvpIZWsK5s6FI2XOxNO0XpHuX/ijayt6X/5mSZMh
 i1vY2timDdspPHEIHYQCC8c0DHrdUKHv8aX9t4j7jlVoT59o7EE3ZZOriXs0r/gm
 euk1Z9CK3kECMuxw2fx64+KK32wrob72Q+GQwxuG45k++60kvYxj2iQksp1t88J3
 GT6O0jn9qZUMTdAY7fKJ0HKyo+YmzWu/AfAqPzqFjXul++Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47t26d982n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:51:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 10 Jul 2025 01:51:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 10 Jul 2025 01:51:21 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 5A3AD3F7041;
 Thu, 10 Jul 2025 01:51:18 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <pbhagavatula@marvell.com>,
 <kevin.laatz@intel.com>, <bruce.richardson@intel.com>,
 <mb@smartsharesystems.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>, Vamsi Attunuru
 <vattunuru@marvell.com>
Subject: [PATCH v0 1/1] doc: announce inter-device DMA capability support in
 dmadev
Date: Thu, 10 Jul 2025 14:21:01 +0530
Message-ID: <20250710085101.1678775-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX2XrrH6FFr2m4
 VCbiI2Z+X+dKzGbrM0/mcvCWtVPbUsPMRrA9wU9Pe2Q8PcDGpAs6v21W1mIflFKMet/2elzZtUY
 g/KzH7U66FLIdl4CuOYfHpi33J7EW1hKomiDUzL3k2sQ3/QKMKTQz0k9v9XgL+EfiT+YiLIjOYP
 8uW9eDHMkV9Ps5uNPkr8HdF8O0OYj2D3qPSY5uXnknSMJHY44t4dcyXXxSjNC3JxuiRr9lfrO7K
 xiWMGt3IJiQqj+bTAqITXwRdP9BHSsPNe16rFwMsHs6ZNynA/j8ZOONpHX2hdj0sVodwc7sQtDT
 TynDf8E99uChTCq1tCozr0PeffQcm7eM/UiXTPRi+zxphT4emYcAKW3AC/CpfXHCxDjwPcQ9o2V
 gz4ZHwge76b5EGCjnqakBuZukVbf9DliM1E9XynHUaNzjWkw8JvSpHiRRJEwGOj4QSEA4ekQ
X-Proofpoint-GUID: Gf8rN9f8P0LLZiEurnN_ACqyRAVYBNsf
X-Proofpoint-ORIG-GUID: Gf8rN9f8P0LLZiEurnN_ACqyRAVYBNsf
X-Authority-Analysis: v=2.4 cv=O8A5vA9W c=1 sm=1 tr=0 ts=686f7f0a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=ZEUzst39qsBJQzYvoCUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Modern DMA hardware supports data transfer between multiple
DMA devices, enabling data communication across isolated domains or
containers. To facilitate this, the ``dmadev`` library requires changes
to allow devices to register with or unregisters from DMA groups for
inter-device communication. This feature is planned for inclusion
in DPDK 25.11.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 doc/guides/rel_notes/deprecation.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..46836244dd 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -152,3 +152,10 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV`` will be added
+  to advertise DMA device's inter-device DMA copy capability. To enable
+  this functionality, a few dmadev APIs will be added to configure the DMA
+  access groups, facilitating coordinated data communication between devices.
+  A new ``dev_idx`` field will be added to the ``struct rte_dma_vchan_conf``
+  structure to configure a vchan for data transfers between any two DMA devices.
-- 
2.34.1

