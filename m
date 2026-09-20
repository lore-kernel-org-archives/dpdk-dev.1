Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A28C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 14:41:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61378402D6;
	Sun, 20 Sep 2026 16:41:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 13228402C3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 16:41:47 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68KBne5o220119; Sun, 20 Sep 2026 07:41:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 e1HLpYPk9W+tS5mj0xNSCp6ZW6xYwhKDSZR7ELoGXA=; b=FkmQFKEiJhmhYUE5W
 GEUz5I51LqrFbZl6CuSAyU8/TRcn7SD7BdIQuC7dx1i4N73WN1+Q/VmnKxWewBJq
 RBZyAnXTzU2riBPT5A+nYRfpjjiTIxIvVe6gvLLSqUNgoxVJAzXqpm6LySx71KzS
 AJ89ERSGd6lGxEiCNlMlxY3I+E0wH8NEuwkkMHCc8cSVIHKmzdCISa/OrqukFcNp
 PMHCOpRW9BjyYVXdxUWzZYSywWLQIffW1gy3clLwcXVJ5tgUoGLr9sAkGOpQgrqK
 B4pxnHdUKh+Q9ePmPQTbtcOpqWFjxbXYFTzCUFeoVLcEuuqoGSkUBRnbnxnmbudF
 UZNwA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gsswh2tyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Sep 2026 07:41:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 20 Sep 2026 07:41:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 20 Sep 2026 07:41:46 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 761153F7040;
 Sun, 20 Sep 2026 07:41:44 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v2 0/4] dma/cnxk: add CN20K (O20) DPI DMA and inter-process
 domain support
Date: Sun, 20 Sep 2026 20:11:28 +0530
Message-ID: <20260920144132.762575-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CALBAE1OdN_HxA4cRZKtsc8AJkCzQQtVV27sGhqjqXE8aSntZ6w@mail.gmail.com>
References: <CALBAE1OdN_HxA4cRZKtsc8AJkCzQQtVV27sGhqjqXE8aSntZ6w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SYXXlw5JQtyANeX7CtvF0vbWH-LYtXy7
X-Proofpoint-GUID: SYXXlw5JQtyANeX7CtvF0vbWH-LYtXy7
X-Authority-Analysis: v=2.4 cv=R6+WitRX c=1 sm=1 tr=0 ts=6aaff0ab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=tVhgFb1v66BlmZ009QcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIxMyBTYWx0ZWRfX83NB9kxrq5OG
 a9/1RY4AnCtuSRI3w3Neptbt7OUpGPLpDuzogsDacz2TtcZblTXyZqz0LLyxGoyyTluYfJk5Zq7
 Enqo+JiFJRg5KpOG6buY/w1qfX4gP3vZ0ZYbD9wk3O8MMHDPC/X7R5Yzx0j4upU/8R4jKJOEC+C
 OEfZ/inWRq+lO506EwzxgBtsrO/hiwvs9kmoT8xn0nIkTeIgb5WF4O/ojXfMKSuI40Ij7mvVLR4
 nxUgMgSpmZBN8qaCCrfv07K1m5SYMD2q4d3/8Dwot/+zIYiE5j4TxgvLGzZbbCfJB7TzwHhJlzj
 eQnMGd4MwNqhCUG+/G8K8V9Avnq8e0Ryfw1iiR1h1eLpWpOTkmK5r0dbniJIxgXZAFrkfFIpwtw
 jjY+kE8JQcISVh+hze8ssIXCbNiDl8RtGyiiYTfDr0pwOYhyuE2IZoEbbAeZaCBuLxO83A2DyBp
 RG9rcwPpatnvRtRc2CA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIxMyBTYWx0ZWRfX3cQR6ytd5i24
 jMitwJBVlHcSVOQYWdEEakAy0uPc/FkdvXov+QnOGOxpyQKfFwk3ZkDiJym6ilK7HP9UrQQntGu
 /HNR3NAMptyfJdRpzbnKy5FCvyabKUs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
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

This series adds DMA support for Marvell CN20K (O20) DPI hardware to the
existing cnxk dmadev driver, building on the common ROC DPI layer used by
CN9K/CN10K.

CN20K DPI is LF and ring-based: commands are posted to per-LF hardware
queues rather than the legacy VF chunk-buffer model. The series introduces
the ROC infrastructure for LF attach/detach, ring configuration, channel
table management, and access-pair group mailbox operations, then wires the
dmadev PMD to expose copy, copy-SG, fill, and enqueue/dequeue on O20.

Patch 1 lays the common foundation. Patch 2 integrates O20 into the dmadev
fast and slow paths. Patch 3 adds inter-process domain DMA on top of the
O20 path using the dmadev access-pair group API.

Vamsi Attunuru (4):
  common/cnxk: add O20 DPI DMA support
  dma/cnxk: add O20 DPI DMA support
  dma/cnxk: enable inter process domain DMA support
  doc: update 26.11 release notes for cnxk dmadev
---
V2 changes:
* updated doc/guides/dmadevs/cnxk.rst
* updated cnxk base driver to use plt_ symbols
* changed rte_wmb() to rte_io_wmb()
* updated doc/guides/rel_notes/release_26_11.rst

 doc/guides/dmadevs/cnxk.rst                   | 138 +++-
 doc/guides/rel_notes/release_26_11.rst        |  17 +
 drivers/common/cnxk/hw/dpi.h                  |  72 +-
 drivers/common/cnxk/hw/rvu.h                  |   2 +
 drivers/common/cnxk/roc_constants.h           |   2 +
 drivers/common/cnxk/roc_dev.c                 |   1 +
 drivers/common/cnxk/roc_dpi.c                 | 683 +++++++++++++++++-
 drivers/common/cnxk/roc_dpi.h                 |  85 +++
 drivers/common/cnxk/roc_dpi_priv.h            |  34 +
 drivers/common/cnxk/roc_mbox.h                | 174 ++++-
 drivers/common/cnxk/roc_platform.h            |  10 +
 .../common/cnxk/roc_platform_base_symbols.c   |  17 +
 drivers/dma/cnxk/cnxk_dmadev.c                | 676 ++++++++++++++++-
 drivers/dma/cnxk/cnxk_dmadev.h                |  73 +-
 drivers/dma/cnxk/cnxk_dmadev_fp.c             | 232 +++++-
 15 files changed, 2166 insertions(+), 50 deletions(-)

-- 
2.34.1

