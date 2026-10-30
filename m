Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676C606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:20:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A6754025A;
	Fri, 30 Oct 2026 06:20:23 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id C0BE040151
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:21 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8088C2000CE;
 Fri, 30 Oct 2026 06:20:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C4122000CC;
 Fri, 30 Oct 2026 06:20:21 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E56A11800068;
 Fri, 30 Oct 2026 13:20:19 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v5-S3 00/14] net/dpaa2 and fslmc infrastructure updates
Date: Fri, 30 Oct 2026 10:50:02 +0530
Message-ID: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is part of the ongoing DPAA2 upstreaming effort, applied on
top of v7-S1 ("dpaa2: bus, DMA and mempool base fixes") and
v14-S2 ("net/dpaa2 updates").

Compared to v4-S3, the series has been reduced and reorganized to focus
on DPAA2 PMD and fslmc infrastructure improvements. It includes parser
decode optimizations, common devargs handling, queue management
enhancements, DPRTC infrastructure support, and runtime timestamping.

Highlights:
  - refactor and optimize Rx parser result decoding;
  - centralize DPAA2 device argument definitions and parsing;
  - use table-driven devargs parsing across DPAA2 drivers;
  - unify debug dump infrastructure through log-based helpers;
  - export parser protocol offsets through mbuf dynamic fields;
  - rework Tx queue mapping and queue configuration handling;
  - centralize fslmc device handling infrastructure;
  - move DPNI endpoint lookup from the fslmc bus layer to the PMD;
  - remove the unused soft parser loader;
  - add dynamic Tx confirmation mode;
  - provide shared DPRTC RTC services in the fslmc bus layer;
  - support runtime IEEE1588 timestamping.

The series builds cleanly with arm64 and -Werror and remains bisectable.

Changes in v5:
  - Reduced scope and reorganized the series.
  - Separated independent functionality into dedicated patch sets.
  - Reworked devargs handling using common infrastructure.
  - Added fslmc DPRTC shared service support.
  - Addressed review feedback from previous revisions.

Jun Yang (14):
  net/dpaa2: refactor and optimize Rx parser result decode
  drivers: net/dpaa2 centralize devargs definitions
  crypto/dpaa2_sec: use table-driven devargs parsing
  dma/dpaa2: use table-driven devargs parsing
  net/dpaa2: unify debug dump via log based helpers
  net/dpaa2: export parser protocol offsets via mbuf dynfield
  drivers: net/dpaa2 rework Tx queue mapping
  drivers: bus/fslmc centralize device handling
  drivers: net/dpaa2: move DPNI endpoint lookup to PMD
  drivers: net/dpaa2 remove unused soft parser loader
  drivers: net/dpaa2 cache Rx queue config and share TC CGIDs
  drivers: net/dpaa2 add dynamic Tx confirmation mode
  drivers: bus/fslmc provide shared DPRTC RTC services
  net/dpaa2: support runtime IEEE1588 timestamping

 doc/guides/nics/dpaa2.rst                     |   26 +-
 doc/guides/rel_notes/release_26_11.rst        |    2 +
 drivers/bus/fslmc/bus_fslmc_driver.h          |   14 +-
 drivers/bus/fslmc/fslmc_bus.c                 |  315 ++-
 drivers/bus/fslmc/fslmc_logs.h                |    2 +
 drivers/bus/fslmc/fslmc_vfio.c                |  536 ++---
 drivers/bus/fslmc/fslmc_vfio.h                |   71 +-
 drivers/{net/dpaa2 => bus/fslmc}/mc/dprtc.c   |    0
 .../{net/dpaa2 => bus/fslmc}/mc/fsl_dprtc.h   |    0
 .../dpaa2 => bus/fslmc}/mc/fsl_dprtc_cmd.h    |    0
 drivers/bus/fslmc/meson.build                 |    2 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   79 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |    9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |   52 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c     |  131 ++
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   24 +-
 drivers/bus/fslmc/private.h                   |   16 +-
 drivers/common/dpaax/dpaax_devarg.h           |  112 +
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  146 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h     |   10 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                |   94 +-
 drivers/dma/dpaa2/dpaa2_qdma.h                |   15 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |    2 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h  |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  989 ++++----
 drivers/net/dpaa2/dpaa2_ethdev.h              |  259 ++-
 drivers/net/dpaa2/dpaa2_flow.c                |  118 +-
 drivers/net/dpaa2/dpaa2_parse_dump.h          |  707 +++---
 drivers/net/dpaa2/dpaa2_parser_decode.h       |  750 ++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h            |   40 +-
 drivers/net/dpaa2/dpaa2_ptp.c                 |  233 +-
 drivers/net/dpaa2/dpaa2_recycle.c             |   18 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                | 2013 ++++++++---------
 drivers/net/dpaa2/dpaa2_sparser.c             |  137 --
 drivers/net/dpaa2/dpaa2_sparser.h             |  202 --
 drivers/net/dpaa2/dpaa2_tm.c                  |    1 -
 drivers/net/dpaa2/meson.build                 |    2 -
 drivers/net/dpaa2/rte_pmd_dpaa2.h             |   42 +-
 38 files changed, 3978 insertions(+), 3197 deletions(-)
 rename drivers/{net/dpaa2 => bus/fslmc}/mc/dprtc.c (100%)
 rename drivers/{net/dpaa2 => bus/fslmc}/mc/fsl_dprtc.h (100%)
 rename drivers/{net/dpaa2 => bus/fslmc}/mc/fsl_dprtc_cmd.h (100%)
 create mode 100644 drivers/bus/fslmc/portal/dpaa2_hw_dprtc.c
 create mode 100644 drivers/common/dpaax/dpaax_devarg.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

