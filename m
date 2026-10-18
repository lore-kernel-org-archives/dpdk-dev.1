Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309AECCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:54:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6344940A7D;
	Sun, 18 Oct 2026 11:54:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2DAEF40A70
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:54:51 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69I5vRgu1572683 for <dev@dpdk.org>; Sun, 18 Oct 2026 02:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 H2Wti/e4VrsG6VI5RXEnRwzefx2z03ADftCI/q2z6g=; b=eMZ0PbYDq8IJ5hKI8
 H4J/OT1RUaatl+rf3sTEgC3HeT6aWmmaH9tL2LSpFZy7Clwo7brN7j3OjRnERwE7
 WIAqbIoWxpKPFTsvDsfDKL6jhRiGiI385tP1kBFKKVBRMAxuRRNlTF185MZMjJjn
 aJLJfaBivQYue1zEGUBSlyRenYjN9x0Jvl2EkTOCf13MQBbz7mpp/Y6pL9Qj85LJ
 x4vA8Xuoenaw2UYvZeobtO/OfntT8Gie6UaXsLFp5WXytIkblv+MRZg/ddVZjSK1
 y761teiXVk4LrToZr38NxKjWFdPv8PRcd64W+IYXfDiXJhy3rKaG2dh6Z5+Qcvdg
 PyRbg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hbvu13kak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 18 Oct 2026 02:54:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 18 Oct 2026 02:54:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 18 Oct 2026 02:54:48 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 4EC723F7044;
 Sun, 18 Oct 2026 02:54:47 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, <ndabilpuram@marvell.com>, Vamsi Attunuru
 <vattunuru@marvell.com>
Subject: [PATCH v2 0/2] net/octeon_ep: add CN20K SDP VF support
Date: Sun, 18 Oct 2026 15:24:35 +0530
Message-ID: <20261018095437.1531211-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830163133.1399749-1-vattunuru@marvell.com>
References: <20260830163133.1399749-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDAzOSBTYWx0ZWRfXzGmTa1AnKsOq
 H5SRtS8Beq3EsOTVftkH1ahaO+4UR54TUpqkSA0P0oMx6N2aB87QC3B6Cu37NiJj6vP/tsi9joI
 ZpcltiOPZIm0yoj3xAZuFaH+iIIS3/wrcsS9DhA8ReezKKGp1aGg2WUFSIH+TBTvKQ9oJmur70p
 +Wcnn2g/3sFrCgMQaAQTi89yUd7MmWV+X9YbU30SZfs4ATT6NuuFnIqnpNC88iWCiUrZPvwsh2s
 D/wNOK6M2XYghO2tYsnvyuFer5aBiYw2upT+My0FkMMlGzH1PooiYcIhfJAMMPFWuLD3DnjsAN/
 7Zgjgxh/WbtaulDTQBIpJDDQk/7wQG+9u7vZXXYchuTJLsheCaA/a8V+cRzofuluNyIMcgCl8mN
 XsYmphMP1rt31hGLETS/nYoeHO3QZ5DFaS0MZQHlEauGhy9k7/6nXqqcxuQcSH9To7fNl3y2UC+
 C4/3ANGTvw/QjCi/JqA==
X-Authority-Analysis: v=2.4 cv=P9+vFSAu c=1 sm=1 tr=0 ts=6ad4976a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=T08beJtn8S8yd6y1o6gA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: uMhxBR4DolRx8HKC6AnQ0vNkMOdpMZJ5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDAzOSBTYWx0ZWRfX6dYkN4XC2dvJ
 d88+FgyNgXlxtiQJmyPmwPBq3+/ufKeKZ1x6e0TJZ6spE6RQ66xxG8OgPQwkyzrxVYT08W2WzlU
 1n9Jy7U7iSl5GlLwU9kMt8J7UURnPUs=
X-Proofpoint-ORIG-GUID: uMhxBR4DolRx8HKC6AnQ0vNkMOdpMZJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_02,2026-10-14_01,2025-10-01_01
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

This series adds CN20K SDP VF support in octeon_ep ethdev
driver. It also updates 26.11 release notes. 

Vamsi Attunuru (2):
  net/octeon_ep: add CN20K SDP VF endpoint support
  doc: update 26.11 release notes for octeon_ep driver
---
V2 changes:
- updated release notes & user guide.
- fixed v1 review comments.

 doc/guides/nics/octeon_ep.rst           | 105 ++-
 doc/guides/rel_notes/release_26_11.rst  |   8 +
 drivers/net/octeon_ep/cn20k_ep_mbox.c   | 836 ++++++++++++++++++++++++
 drivers/net/octeon_ep/cn20k_ep_mbox.h   | 133 ++++
 drivers/net/octeon_ep/cn20k_ep_vf.c     | 425 ++++++++++++
 drivers/net/octeon_ep/cn20k_ep_vf.h     | 175 +++++
 drivers/net/octeon_ep/cnxk_ep_rx.c      | 132 ++--
 drivers/net/octeon_ep/cnxk_ep_rx.h      |  29 +-
 drivers/net/octeon_ep/cnxk_ep_rx_avx.c  |  38 +-
 drivers/net/octeon_ep/cnxk_ep_rx_neon.c |  71 +-
 drivers/net/octeon_ep/cnxk_ep_rx_sse.c  |  29 +-
 drivers/net/octeon_ep/meson.build       |   2 +
 drivers/net/octeon_ep/otx_ep_common.h   |   9 +
 drivers/net/octeon_ep/otx_ep_ethdev.c   |  88 ++-
 drivers/net/octeon_ep/otx_ep_mbox.c     |  16 +-
 drivers/net/octeon_ep/otx_ep_rxtx.c     |   3 +
 16 files changed, 1987 insertions(+), 112 deletions(-)
 create mode 100644 drivers/net/octeon_ep/cn20k_ep_mbox.c
 create mode 100644 drivers/net/octeon_ep/cn20k_ep_mbox.h
 create mode 100644 drivers/net/octeon_ep/cn20k_ep_vf.c
 create mode 100644 drivers/net/octeon_ep/cn20k_ep_vf.h

-- 
2.34.1

