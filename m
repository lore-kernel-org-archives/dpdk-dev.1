Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593CFCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B089402E4;
	Thu, 15 Oct 2026 11:25:20 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A3D9E402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:25:18 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 601D3200017;
 Thu, 15 Oct 2026 11:25:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C536200016;
 Thu, 15 Oct 2026 11:25:18 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F2838180006C;
 Thu, 15 Oct 2026 17:25:16 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v11-S2 00/11] net/dpaa2 updates
Date: Thu, 15 Oct 2026 14:55:02 +0530
Message-ID: <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
References: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
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

Changes in v11:
- Fix fragmented packet type handling to match hardware parser
  summary reporting.
- Address review comments.

Series overview:
- fix an integer overflow in the CCSR region mapping,
- set Tx confirmation on device init and support a larger burst size,
- support MPLS and PPPoE flow distribution,
- support the flow drop action and a per-device default flow miss action,
- identify Rx mbuf hash information by FLC and add minimum key size
  support,
- parse tunnel and fragmented packet types,
- remove the unused soft parser driver and rename Rx queue flags.

Gagandeep Singh (6):
  net/dpaa2: set Tx confirmation on device init
  net/dpaa2: support larger burst size
  net/dpaa2: support MPLS and PPPoE flow distribution
  net/dpaa2: support flow drop action
  net/dpaa2: set default flow miss action per device
  net/dpaa2: identify Rx mbuf hash information by FLC

Hemant Agrawal (3):
  net/dpaa2: fix integer overflow in CCSR region mapping
  net/dpaa2: add minimum key size support
  net/dpaa2: parse tunnel and fragmented packet types

Jun Yang (2):
  net/dpaa2: remove unused soft parser driver
  net/dpaa2: rename Rx queue flags

 doc/guides/nics/features/dpaa2.ini     |   4 +-
 doc/guides/rel_notes/release_26_11.rst |  13 +
 drivers/net/dpaa2/dpaa2_ethdev.c       |  84 +---
 drivers/net/dpaa2/dpaa2_ethdev.h       |  32 +-
 drivers/net/dpaa2/dpaa2_flow.c         | 633 ++++++-------------------
 drivers/net/dpaa2/dpaa2_recycle.c      |  24 +-
 drivers/net/dpaa2/dpaa2_rxtx.c         |  56 ++-
 drivers/net/dpaa2/dpaa2_sparser.c      | 137 ------
 drivers/net/dpaa2/dpaa2_sparser.h      | 202 --------
 drivers/net/dpaa2/dpaa2_tm.c           |  16 +-
 drivers/net/dpaa2/mc/dpni.c            |  11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h        |   8 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h    |   3 +-
 drivers/net/dpaa2/meson.build          |   1 -
 14 files changed, 317 insertions(+), 907 deletions(-)
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

