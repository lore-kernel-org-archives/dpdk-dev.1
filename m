Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C6C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:50:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B34BB40666;
	Tue,  3 Jun 2025 13:50:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C44674026C
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:30 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKnvM010615
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=P5YHHZtx3uU+pq2eJa0XS+d
 DKfrRZk5TLBVdI/m5wuM=; b=PWtDcinb62ddHIIoYoY2TThjO7yIu+w0FVn9hqt
 zyl10sHixSt9UqFTAyA03linNC5sSHkHJTyTgOFprAkYAXnl6SsticwNyws02+DT
 pKHX1Xyrg/PVeDQllGExjYLK2g95Zc2REEkmkVxc6APm0U3K6R5S/+hnl0O2iLaD
 el5tOP1oRx2SLAUsmB+cKwCLdYQ95asFs8ryf+Y/So+F+MZvhBKvAk6UeLQ2SnQX
 seaWylQ9h22C5jEK6sUX3s2VQD1yYphRbaTAXPTntyVDiLoDQZdZfrb6doJRzEgY
 DqsZxPgIJWsTkFvsqZQD2lRgRo+rgKCjXV+6mpClLFKOdVg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 471g98hw6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:29 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 661703F7048;
 Tue,  3 Jun 2025 04:50:27 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 00/25] add CN20K support to cnxk crypto PMD
Date: Tue, 3 Jun 2025 17:20:01 +0530
Message-ID: <20250603115026.2664706-1-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX1iL/up9kjEtF
 w6BLuTu8OXg9g2tOLwDABCW8o/sRtGfldgTdP1HGbfKogbTyyxWS21bTaurz+1EgCm4tj/yXIQw
 qu0t9qRA//CjOfQx9gILYNNQApkAcRuotQG9tVkn9ouHzdFcz3Ap0uFuTkFqcPwwa5JLjViXt8t
 UquFcPyqtjBM9E3Dh5/qs25r9QNSouiHVYnL9ci/i16lXyWhPx18XX/aqdYPMzMneFG7roMvix4
 PjszlOx37oUrjRL9w9x3XgZ905OupeeMXZQxIT1xlsIxUUGiUoXaZJVuryoWV2qESXBCjx4Jrjp
 2irPLKxycU8JqyyeScs0LPW56CUmd810uzmepnyvOrE97j6jDV5g/tPFfdikhrQcLNuCU5n2gwL
 Pp/gAfOo/dAd6adllXQI+VpH82Tlwipl0VpXU7TPuuX5lGf1O2YiCk+hi8ThUqhlozFamhin
X-Proofpoint-ORIG-GUID: _uPRmflK7QDWcdyZY232xF-nrTGwP-oL
X-Authority-Analysis: v=2.4 cv=JpPxrN4C c=1 sm=1 tr=0 ts=683ee186 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=Ov6ESQcs1Ole_dG7abYA:9
X-Proofpoint-GUID: _uPRmflK7QDWcdyZY232xF-nrTGwP-oL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

This series adds CN20K support to cnxk crypto PMD.

v2:
* Fixed individual patch compilation
* Fixed unnecessary code movement
* Updated patch titles
* Added release notes

Tejasree Kondoj (3):
  crypto/cnxk: move debug dumps to common
  crypto/cnxk: add Rx inject in security lookaside
  doc: update cn20k CPT documentation

Vidya Sagar Velumuri (22):
  crypto/cnxk: probe cn20k device
  crypto/cnxk: add cn20k ops skeleton
  crypto/cnxk: add dev info get
  crypto/cnxk: add cn20k datapath skeleton
  crypto/cnxk: add cn20k lmtst routines
  crypto/cnxk: add cn20k enqueue path
  crypto/cnxk: add cn20k dequeue path
  crypto/cnxk: add cn20k security skeletion
  crypto/cnxk: add security session creation
  crypto/cnxk: add security session destroy
  crypto/cnxk: move code to common
  crypto/cnxk: add IPsec session update
  crypto/cnxk: add security datapath
  crypto/cnxk: add TLS skeleton
  crypto/cnxk: add TLS read session
  crypto/cnxk: add TLS write session
  crypto/cnxk: add TLS session destroy
  crypto/cnxk: add TLS datapath
  crypto/cnxk: add TLS post process
  crypto/cnxk: add TLS session update
  crypto/cnxk: support raw API for cn20k
  crypto/cnxk: add model check for cn20k

 doc/guides/cryptodevs/cnxk.rst                |   26 +-
 doc/guides/cryptodevs/features/cn20k.ini      |  113 ++
 doc/guides/rel_notes/release_25_07.rst        |    3 +
 drivers/common/cnxk/roc_cpt.h                 |    7 +-
 drivers/common/cnxk/roc_ie_ow_tls.h           |  233 +++
 drivers/crypto/cnxk/cn10k_cryptodev.c         |   12 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |  125 +-
 drivers/crypto/cnxk/cn10k_cryptodev_sec.h     |   14 -
 drivers/crypto/cnxk/cn10k_ipsec.c             |    4 +-
 drivers/crypto/cnxk/cn10k_tls.c               |    4 +-
 drivers/crypto/cnxk/cn20k_cryptodev.c         |  158 ++
 drivers/crypto/cnxk/cn20k_cryptodev.h         |   13 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 1277 +++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   85 ++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c     |  137 ++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.h     |   64 +
 drivers/crypto/cnxk/cn20k_ipsec.c             |  378 +++++
 drivers/crypto/cnxk/cn20k_ipsec.h             |   41 +
 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h      |  199 +++
 drivers/crypto/cnxk/cn20k_tls.c               |  917 ++++++++++++
 drivers/crypto/cnxk/cn20k_tls.h               |   40 +
 drivers/crypto/cnxk/cn20k_tls_ops.h           |  250 ++++
 drivers/crypto/cnxk/cnxk_cryptodev.c          |   14 +-
 .../crypto/cnxk/cnxk_cryptodev_capabilities.c |   10 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  119 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h      |   34 +-
 drivers/crypto/cnxk/cnxk_ipsec.h              |    2 +
 drivers/crypto/cnxk/meson.build               |    5 +
 28 files changed, 4119 insertions(+), 165 deletions(-)
 create mode 100644 doc/guides/cryptodevs/features/cn20k.ini
 create mode 100644 drivers/common/cnxk/roc_ie_ow_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.h
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec_la_ops.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.c
 create mode 100644 drivers/crypto/cnxk/cn20k_tls.h
 create mode 100644 drivers/crypto/cnxk/cn20k_tls_ops.h

-- 
2.25.1

