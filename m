Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEBBC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 08:59:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC284021F;
	Thu, 12 Jun 2025 10:59:17 +0200 (CEST)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com
 [115.124.28.217])
 by mails.dpdk.org (Postfix) with ESMTP id 0D32E4003C
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:59:16 +0200 (CEST)
Received: from localhost.localdomain(mailfrom:kyo.liu@nebula-matrix.com
 fp:SMTPD_---.dJxIn83_1749718753 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 12 Jun 2025 16:59:13 +0800
From: Kyo Liu <kyo.liu@nebula-matrix.com>
To: kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v1 00/17] NBL PMD for Nebulamatrix NICs
Date: Thu, 12 Jun 2025 08:58:21 +0000
Message-ID: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This nbl PMD (**librte_net_nbl**) provides poll mode driver for 
NebulaMatrix serials NICs.

Features:
---------
- MTU update
- promisc mode set
- xstats
- Basic stats 

Support NICs:
-------------
- S1205CQ-A00CHT
- S1105AS-A00CHT
- S1055AS-A00CHT
- S1052AS-A00CHT
- S1051AS-A00CHT
- S1045XS-A00CHT
- S1205CQ-A00CSP
- S1055AS-A00CSP
- S1052AS-A00CSP


Kyo Liu (17):
  net/nbl: add doc and minimum nbl build framework
  net/nbl: add simple probe/remove and log module
  net/nbl:  add PHY layer definitions and implementation
  net/nbl:  add Channel layer definitions and implementation
  net/nbl:  add Resource layer definitions and implementation
  net/nbl:  add Dispatch layer definitions and implementation
  net/nbl:  add Dev layer definitions and implementation
  net/nbl:  add complete device init and uninit functionality
  net/nbl:  add uio and vfio mode for nbl
  net/nbl:  bus/pci: introduce get_iova_mode for pci dev
  net/nbl:  add nbl coexistence mode for nbl
  net/nbl: add nbl ethdev configuration
  net/nbl: add nbl device rxtx queue setup and release ops
  net/nbl: add nbl device start and stop ops
  net/nbl: add nbl device tx and rx burst
  net/nbl: add nbl device xstats and stats
  net/nbl: nbl device support set mtu and promisc

 .mailmap                                      |    5 +
 MAINTAINERS                                   |    9 +
 doc/guides/nics/features/nbl.ini              |    9 +
 doc/guides/nics/index.rst                     |    1 +
 doc/guides/nics/nbl.rst                       |   42 +
 doc/guides/rel_notes/release_25_07.rst        |    5 +
 drivers/bus/pci/bus_pci_driver.h              |   11 +
 drivers/bus/pci/linux/pci.c                   |    2 +
 drivers/net/meson.build                       |    1 +
 drivers/net/nbl/meson.build                   |   26 +
 drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
 drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
 drivers/net/nbl/nbl_common/nbl_thread.c       |   88 ++
 drivers/net/nbl/nbl_common/nbl_userdev.c      |  758 ++++++++++
 drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
 drivers/net/nbl/nbl_core.c                    |  100 ++
 drivers/net/nbl/nbl_core.h                    |   98 ++
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 1007 ++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   65 +
 drivers/net/nbl/nbl_dispatch.c                | 1226 +++++++++++++++++
 drivers/net/nbl/nbl_dispatch.h                |   31 +
 drivers/net/nbl/nbl_ethdev.c                  |  167 +++
 drivers/net/nbl/nbl_ethdev.h                  |   32 +
 drivers/net/nbl/nbl_hw/nbl_channel.c          |  853 ++++++++++++
 drivers/net/nbl/nbl_hw/nbl_channel.h          |  127 ++
 .../nbl_hw_leonis/nbl_phy_leonis_snic.c       |  230 ++++
 .../nbl_hw_leonis/nbl_phy_leonis_snic.h       |   53 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
 drivers/net/nbl/nbl_hw/nbl_phy.h              |   28 +
 drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
 drivers/net/nbl/nbl_hw/nbl_resource.h         |  153 ++
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  906 ++++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.h             |  136 ++
 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  434 ++++++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  128 ++
 drivers/net/nbl/nbl_include/nbl_def_dev.h     |  107 ++
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   95 ++
 drivers/net/nbl/nbl_include/nbl_def_phy.h     |   35 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   87 ++
 drivers/net/nbl/nbl_include/nbl_include.h     |  212 +++
 drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
 .../net/nbl/nbl_include/nbl_product_base.h    |   37 +
 44 files changed, 7766 insertions(+)
 create mode 100644 doc/guides/nics/features/nbl.ini
 create mode 100644 doc/guides/nics/nbl.rst
 create mode 100644 drivers/net/nbl/meson.build
 create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/nbl/nbl_common/nbl_thread.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h
 create mode 100644 drivers/net/nbl/nbl_core.c
 create mode 100644 drivers/net/nbl/nbl_core.h
 create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.c
 create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.h
 create mode 100644 drivers/net/nbl/nbl_dispatch.c
 create mode 100644 drivers/net/nbl/nbl_dispatch.h
 create mode 100644 drivers/net/nbl/nbl_ethdev.c
 create mode 100644 drivers/net/nbl/nbl_ethdev.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_snic.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_phy.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_phy.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h

-- 
2.43.0

