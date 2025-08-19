Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB6BCA0EED
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 10:23:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E30D4060F;
	Tue, 19 Aug 2025 12:23:11 +0200 (CEST)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50]) by mails.dpdk.org (Postfix) with ESMTP id EAD8940297
 for <dev@dpdk.org>; Tue, 19 Aug 2025 12:23:07 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eJiaRxd_1755598973 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 19 Aug 2025 18:23:04 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Subject: [PATCH v5 00/17] NBL PMD for Nebulamatrix NICs
Date: Tue, 19 Aug 2025 03:22:20 -0700
Message-Id: <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

Dimon Zhao (17):
  net/nbl: add doc and minimum nbl build framework
  net/nbl: add simple probe/remove and log module
  net/nbl: add HW layer definitions and implementation
  net/nbl: add Channel layer definitions and implementation
  net/nbl: add Resource layer definitions and implementation
  net/nbl: add Dispatch layer definitions and implementation
  net/nbl: add Dev layer definitions and implementation
  net/nbl: add complete device init and uninit functionality
  net/nbl: add UIO and VFIO mode for nbl
  net/nbl: add nbl coexistence mode for nbl
  net/nbl: add nbl ethdev configuration
  net/nbl: add nbl device rxtx queue setup and release ops
  net/nbl: add nbl device start and stop ops
  net/nbl: add nbl device Tx and Rx burst
  net/nbl: add nbl ethdev infos get
  net/nbl: add nbl device xstats and stats
  net/nbl: nbl device support set MTU and promisc

 .mailmap                                      |    4 +
 MAINTAINERS                                   |    9 +
 doc/guides/nics/features/nbl.ini              |    9 +
 doc/guides/nics/index.rst                     |    1 +
 doc/guides/nics/nbl.rst                       |   87 ++
 doc/guides/rel_notes/release_25_11.rst        |    4 +
 drivers/net/meson.build                       |    1 +
 drivers/net/nbl/meson.build                   |   26 +
 drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
 drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
 drivers/net/nbl/nbl_common/nbl_userdev.c      |  761 ++++++++++
 drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
 drivers/net/nbl/nbl_core.c                    |  105 ++
 drivers/net/nbl/nbl_core.h                    |   98 ++
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 1035 +++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   88 ++
 drivers/net/nbl/nbl_dispatch.c                | 1320 +++++++++++++++++
 drivers/net/nbl/nbl_dispatch.h                |   31 +
 drivers/net/nbl/nbl_ethdev.c                  |  136 ++
 drivers/net/nbl/nbl_ethdev.h                  |   32 +
 drivers/net/nbl/nbl_hw/nbl_channel.c          |  983 ++++++++++++
 drivers/net/nbl/nbl_hw/nbl_channel.h          |  131 ++
 drivers/net/nbl/nbl_hw/nbl_hw.h               |   28 +
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c |  228 +++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |   53 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
 drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
 drivers/net/nbl/nbl_hw/nbl_resource.h         |  153 ++
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  900 +++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.h             |  136 ++
 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  459 ++++++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  120 ++
 drivers/net/nbl/nbl_include/nbl_def_dev.h     |   26 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   99 ++
 drivers/net/nbl/nbl_include/nbl_def_hw.h      |   35 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   91 ++
 drivers/net/nbl/nbl_include/nbl_include.h     |  201 +++
 drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
 .../net/nbl/nbl_include/nbl_product_base.h    |   37 +
 41 files changed, 7889 insertions(+)
 create mode 100644 doc/guides/nics/features/nbl.ini
 create mode 100644 doc/guides/nics/nbl.rst
 create mode 100644 drivers/net/nbl/meson.build
 create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
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
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
		    nbl_hw_leonis_snic.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
		    nbl_hw_leonis_snic.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h

-- 
2.34.1

