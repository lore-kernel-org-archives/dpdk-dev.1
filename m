Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB0FC61DBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 10:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1DDE4025A;
	Sat, 29 Aug 2026 12:54:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B93ED40151
 for <dev@dpdk.org>; Sat, 29 Aug 2026 12:54:21 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67T9ZAH9097376; Sat, 29 Aug 2026 03:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=3kjqlz3Kq0Xd1Rrf1a/72z5
 u5pob7aU+V6CiUdk3S9c=; b=CeOUNTfqPbW17IxmB0fYgHIm3INrMFt8xVw1+2R
 CAj9Ne9a7eC7pkuGjZVk5M7TMJH7pwo9TSpUBg5FTNsMefQRFlLpPoiftKGk+DBU
 QqEJt50nNMSbB9RFslzAbTSAYOvLSyMxPfFA7Ko13ysTJxMLpgLp7mtOq3cIRZDX
 xVcdrMQswCB5v7OookJZKzWI3QflsyGFUeSZtYJHDEXfzkHWAeN8ipbVWavmlOIc
 /dXGk75cvAwDIqZNzVe9yeaf+s6cbEga9ydXvQ0wxwZNJnTxqL+4GgotrnMD5W96
 A/+ISTxnHWsCvFwh8TCT++bKVGVIs+zYuUlXwVn1ipejfgA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbqhvgkru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 03:54:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 29 Aug 2026 03:54:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 29 Aug 2026 03:54:19 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 0CDD03F7084;
 Sat, 29 Aug 2026 03:54:17 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <vattunuru@marvell.com>
CC: <jerinj@marvell.com>, <fengchengwen@huawei.com>, <ndabilpuram@marvell.com>
Subject: [PATCH v0 0/3] dma/cnxk: add CN20K (O20) DPI DMA and inter-process
 domain support
Date: Sat, 29 Aug 2026 16:24:06 +0530
Message-ID: <20260829105409.1160766-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfX5zr6KlXG0xSe
 pGvzDRUADUbaIhcUru6/vEZoi3XCuWop0Y83i3BbdV4fjjIypdDflYjIQZoKxkx4ASq0vuTq9ub
 U0XiqCGKN2jAyDVHqlBvSsZU/7ojQa0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA5MiBTYWx0ZWRfXysAGBIFztiQM
 1ysrRHgDTn4IlXDz9/F8KAWuDx5xm48DYLjapophZjScErz+3LeiBSvaoR2kxDGYzwYSYDkNKCt
 LYVq4prHmUky4iB+T5wPxDgDUHqYcG2sEBEPC1iTIsNgc1L2J58xYbCH08kGX+wyRVldEcR33bi
 kxhkSm9c+vpkXwyUDwFmTogSeRzqNe5Zt2RkZiuzW3hXcKH4az7kxTMNC9A/R/f/Js/Ouv/yF7l
 qRINGaF+uAOAvNVRSUlIkRXNHKAaZbjU4cejGiYZLug9nGRLunxb2s3CyqCarxgqEySVaRIkBYb
 ftF2fPSPixYj2G3MT7xyU63uPtZpijnZQ6nCXbXCHoH7j4ZpefpZzT/ai4XknnpIZL0zshHzM44
 zje3yOzrmcx60/UWuZ6JHbNzCJJ5iZ6xXJh8VILoO1pDm0HP11M41DaHUhHOzbO/vP8C8vnSzGD
 b4m0FpQO+34P161kC3w==
X-Proofpoint-GUID: 61VRtQUNBU224J7Revd7QSuwhpYXSTIg
X-Proofpoint-ORIG-GUID: 61VRtQUNBU224J7Revd7QSuwhpYXSTIg
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a92ba5c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=rEyQHtKcqPD1cmbjqa4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
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

Vamsi Attunuru (3):
  common/cnxk: add O20 DPI DMA support
  dma/cnxk: add O20 DPI DMA support
  dma/cnxk: enable inter process domain DMA support

 drivers/common/cnxk/hw/dpi.h                  |  72 +-
 drivers/common/cnxk/hw/rvu.h                  |   2 +
 drivers/common/cnxk/roc_constants.h           |   2 +
 drivers/common/cnxk/roc_dev.c                 |   1 +
 drivers/common/cnxk/roc_dpi.c                 | 683 +++++++++++++++++-
 drivers/common/cnxk/roc_dpi.h                 |  85 +++
 drivers/common/cnxk/roc_dpi_priv.h            |  34 +
 drivers/common/cnxk/roc_mbox.h                | 174 ++++-
 drivers/common/cnxk/roc_platform.h            |   8 +
 .../common/cnxk/roc_platform_base_symbols.c   |  18 +
 drivers/dma/cnxk/cnxk_dmadev.c                | 673 ++++++++++++++++-
 drivers/dma/cnxk/cnxk_dmadev.h                |  73 +-
 drivers/dma/cnxk/cnxk_dmadev_fp.c             | 214 ++++++
 13 files changed, 2003 insertions(+), 36 deletions(-)

-- 
2.34.1

