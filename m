Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E6CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E356427DB;
	Fri, 17 Oct 2025 11:19:33 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B987E40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:31 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DC8B200EE7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 48031200D88
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:31 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 88C41180007B
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:19:30 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org
Subject: [v2 00/12] ENETC4 PMD support
Date: Fri, 17 Oct 2025 14:49:17 +0530
Message-Id: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
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

V2 changes:
- Deferred queue start/stop functionality for ENETC4 driver.
- Add rxq_info_get and txq_info_get to report queue information
- Addressed code review comments

Apeksha Gupta (6):
  net/enetc: Add initial ENETC4 PMD driver support
  net/enetc: Add RX and TX queue APIs for ENETC4 PMD
  net/enetc: Optimize ENETC4 data path
  net/enetc: Add TX checksum offload and RX checksum validation
  net/enetc: Add basic statistics
  net/enetc: Add packet type parsing support

Vanshika Shukla (6):
  net/enetc: Add VF to PF messaging support and primary MAC setup
  net/enetc: Add multicast and promiscuous mode support
  net/enetc: Add link speed and status support
  net/enetc: Add link status notification support
  net/enetc: Add MAC and VLAN filter support
  net/enetc: Add support for deferred queue and queue info callbacks

 MAINTAINERS                            |    3 +
 config/arm/arm64_imx_linux_gcc         |   17 +
 config/arm/meson.build                 |   14 +
 doc/guides/nics/enetc4.rst             |   90 ++
 doc/guides/nics/features/enetc4.ini    |   22 +
 doc/guides/nics/index.rst              |    1 +
 doc/guides/rel_notes/release_25_11.rst |    3 +
 drivers/net/enetc/base/enetc4_hw.h     |  188 ++++
 drivers/net/enetc/base/enetc_hw.h      |   49 +-
 drivers/net/enetc/enetc.h              |  245 ++++-
 drivers/net/enetc/enetc4_ethdev.c      | 1058 ++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c          | 1364 ++++++++++++++++++++++++
 drivers/net/enetc/enetc_cbdr.c         |  311 ++++++
 drivers/net/enetc/enetc_ethdev.c       |    9 +-
 drivers/net/enetc/enetc_rxtx.c         |  165 ++-
 drivers/net/enetc/meson.build          |    5 +-
 drivers/net/enetc/ntmp.h               |  110 ++
 17 files changed, 3613 insertions(+), 41 deletions(-)
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

