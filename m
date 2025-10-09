Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8735CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F23940297;
	Thu,  9 Oct 2025 13:16:37 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5A6B140277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:35 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 19F98201F27
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D8FF4201F22
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:34 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1E7131800089
 for <dev@dpdk.org>; Thu,  9 Oct 2025 19:16:34 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org
Subject: [v1 00/12] ENETC4 PMD support
Date: Thu,  9 Oct 2025 16:46:21 +0530
Message-Id: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This series introduces a new ENETC4 PMD driver for NXP's new generation
SoC, enabling basic network operations.

Apeksha Gupta (6):
  net/enetc: Add initial ENETC4 PMD driver support
  net/enetc: Add RX and TX queue APIs for ENETC4 PMD
  net/enetc: Optimize ENETC4 data path
  net/enetc: Add TX checksum offload and RX checksum validation
  net/enetc: Add basic statistics
  net/enetc: Add packet type parsing support

Gagandeep Singh (1):
  net/enetc: Add support for multiple queues with RSS

Vanshika Shukla (5):
  net/enetc: Add VF to PF messaging support and primary MAC setup
  net/enetc: Add multicast and promiscuous mode support
  net/enetc: Add link speed and status support
  net/enetc: Add link status notification support
  net/enetc: Add MAC and VLAN filter support

 MAINTAINERS                            |    3 +
 config/arm/arm64_imx_linux_gcc         |   17 +
 config/arm/meson.build                 |   14 +
 doc/guides/nics/enetc4.rst             |   92 ++
 doc/guides/nics/features/enetc4.ini    |   22 +
 doc/guides/nics/index.rst              |    1 +
 doc/guides/rel_notes/release_24_11.rst |    4 +
 drivers/net/enetc/base/enetc4_hw.h     |  186 ++++
 drivers/net/enetc/base/enetc_hw.h      |   52 +-
 drivers/net/enetc/enetc.h              |  245 ++++-
 drivers/net/enetc/enetc4_ethdev.c      | 1002 +++++++++++++++++
 drivers/net/enetc/enetc4_vf.c          | 1364 ++++++++++++++++++++++++
 drivers/net/enetc/enetc_cbdr.c         |  311 ++++++
 drivers/net/enetc/enetc_ethdev.c       |    5 +-
 drivers/net/enetc/enetc_rxtx.c         |  165 ++-
 drivers/net/enetc/meson.build          |    5 +-
 drivers/net/enetc/ntmp.h               |  110 ++
 17 files changed, 3557 insertions(+), 41 deletions(-)
 create mode 100644 config/arm/arm64_imx_linux_gcc
 create mode 100644 doc/guides/nics/enetc4.rst
 create mode 100644 doc/guides/nics/features/enetc4.ini
 create mode 100644 drivers/net/enetc/base/enetc4_hw.h
 create mode 100644 drivers/net/enetc/enetc4_ethdev.c
 create mode 100644 drivers/net/enetc/enetc4_vf.c
 create mode 100644 drivers/net/enetc/enetc_cbdr.c
 create mode 100644 drivers/net/enetc/ntmp.h

-- 
2.25.1

