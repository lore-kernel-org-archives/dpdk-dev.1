Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329BBCD6E60
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EC6B4025F;
	Mon,  1 Jun 2026 12:16:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DA0C94025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 12:16:20 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64VMGmCM1261723 for <dev@dpdk.org>; Mon, 1 Jun 2026 03:16:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=V+QYKfYa5rE4xwq5HjE6grY
 /WfsQDesXLfOeaki0UB0=; b=GyFmTguZIqWd4JWykKtajA8aGUye694mfW9wnx6
 rKauT5BcYrkcdInt8hNs3tNZtaLp7roGpChOamKULl1Kzwzan0GnKdnkCBKihrqU
 +/71P80DKvWMux8MvUGeAwxp3alhW3X/YjzVSwPC7Rp9BtVlmtTmNdd29RUupw3a
 AYBcX4D0MqLDTcaGlk6NMdsi1j8yXd3JpuGHrRHgk5QUQ3DCJdoNVupPwQKMClsO
 qqrFdglSHT0gSDHWeXZvgCofTzGoE2wU5oXL/Oq7yT5M4lsk5OVB1Qqro9+kQiOA
 xfyh+YooEgt9wovlVDaaKZPueB8W7btn8oaD5PnuOLIro2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b40jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Jun 2026 03:16:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 03:16:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 03:16:19 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 1877B3F7053;
 Mon,  1 Jun 2026 03:16:17 -0700 (PDT)
From: Shijith Thotton <sthotton@marvell.com>
To: 
CC: <dev@dpdk.org>, Shijith Thotton <sthotton@marvell.com>
Subject: [PATCH v1 0/2] dma/odm: dev-to-mem support and zero-length validation
Date: Mon, 1 Jun 2026 15:45:57 +0530
Message-ID: <20260601101559.1925302-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEwMyBTYWx0ZWRfX8AP5r3c0XvCC
 SGhh0nyIpWhyIqtVmDnDFhlneDf5ZmWgAmLB4qxsyNF7B77HrxC2d283IquVZwLNuk0uw9TZZJ/
 9X4VxIpYd4adJC/Ljl6Xp+P/Mfv7dwiHzjorckZXFUcM67IJaYCtg82OZVUD39NHUX/W7+UoDsx
 qNyS/XfGaENfzOuZDnl6ULSzS0aO80kz3/yVvGHDaZkSShXx/fETvOy82Jjz54vvk3xfCtEOf1C
 FKbZs+1eEnk9RJzFEnwfAKDmi+++7papXKDfQR8BopeytQjzLuM3NUakApNhp3g18f1iHm9oACD
 gXSFAnVYS0jKJmUHNPJNBg47WirNDtxkzLrP+Z2hzooBCWO7Zadc5uE2bhD4K7E6W+lLwaTWO4q
 H2Kd0ue6pmq1OC9QgOmuMFs8VaQr2nkhEOr9l9w7xmP5MK8fV4ni/GJm2G5Iw5KPYNaq9iaoeFm
 FiAuKeRCiehQyk7ueZA==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1d5bf4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=jv_ALH3rkg8t-CwtK1YA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: C2EEbIOeZAjYz6spaJ1shCBlA1dI_Ztc
X-Proofpoint-GUID: C2EEbIOeZAjYz6spaJ1shCBlA1dI_Ztc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
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

This series extends the Marvell ODM DMA driver with device memory
bidirectional DMA transfers (dev-to-mem and mem-to-dev), and rejects
zero-length operations early with -EINVAL to avoid queue disable.

Shijith Thotton (1):
  dma/odm: avoid zero length DMA transfers

Vamsi Attunuru (1):
  dma/odm: support dev to mem transfers

 drivers/dma/odm/odm.c        | 51 ++++++++++++++++++++++++++++++++++--
 drivers/dma/odm/odm.h        | 12 ++++++++-
 drivers/dma/odm/odm_dmadev.c | 27 ++++++++++++++-----
 drivers/dma/odm/odm_priv.h   |  4 ++-
 4 files changed, 84 insertions(+), 10 deletions(-)

-- 
2.25.1

