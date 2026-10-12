Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D8FCA9EC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 07:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87FA04026D;
	Mon, 12 Oct 2026 09:04:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 95E2340041
 for <dev@dpdk.org>; Mon, 12 Oct 2026 09:04:49 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3807E20014B;
 Mon, 12 Oct 2026 09:04:49 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0462820010E;
 Mon, 12 Oct 2026 09:04:49 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 20B54180006C;
 Mon, 12 Oct 2026 15:04:47 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v9-S2 00/13] net/dpaa2 updates
Date: Mon, 12 Oct 2026 12:34:31 +0530
Message-ID: <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
References: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
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

Changes in v9:
- Address review comments for meter and policing support.
- Add meter resource cleanup during device close.
- Add policing capability checks.
- Validate burst size ranges before hardware programming.
- Fix software/hardware state consistency on profile and policy updates.
- Use standard FDIR reporting for flow-steered packets.
- Replace global flow miss configuration with a per-device default flow
  and remove the DPAA2_FLOW_CONTROL_MISS_FLOW environment variable.
- Document and gate minimum DPNI version requirement for 24-byte flow keys.
- Rework parser decode infrastructure and parser-result dumping.
- Parse additional tunnel and fragmented packet types.
- Fold parser-related fixes into the originating patches.
- Remove unused VXLAN offset helpers after soft parser removal.
- Move release note updates into the existing DPAA2 ethernet driver
  entry under New Features.
- Fix coding style issues reported during review.

Series overview:
- fix an integer overflow in the CCSR region mapping,
- set Tx confirmation on device init and support a larger burst size,
- support MPLS and PPPoE flow distribution, meter and policing, and the
  flow drop action, with a per-device default flow miss action,
- identify Rx mbuf hash information by FLC and add minimum key size
  support,
- restructure parser processing, parse tunnel and fragmented packet
  types, remove the unused soft parser driver and rename Rx queue flags.

Gagandeep Singh (7):
  net/dpaa2: set Tx confirmation on device init
  net/dpaa2: support larger burst size
  net/dpaa2: support MPLS and PPPoE flow distribution
  net/dpaa2: support meter and policing
  net/dpaa2: support flow drop action
  net/dpaa2: set default flow miss action per device
  net/dpaa2: identify Rx mbuf hash information by FLC

Hemant Agrawal (4):
  net/dpaa2: fix integer overflow in CCSR region mapping
  net/dpaa2: add minimum key size support
  net/dpaa2: restructure dpaa2 parser processing
  net/dpaa2: parse tunnel and fragmented packet types

Jun Yang (2):
  net/dpaa2: remove unused soft parser driver
  net/dpaa2: rename Rx queue flags

 doc/guides/nics/dpaa2.rst               |    1 +
 doc/guides/nics/features/dpaa2.ini      |    4 +-
 doc/guides/rel_notes/release_26_11.rst  |   15 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        |   89 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  218 +++-
 drivers/net/dpaa2/dpaa2_flow.c          |  633 +++------
 drivers/net/dpaa2/dpaa2_meter.c         |  804 ++++++++++++
 drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
 drivers/net/dpaa2/dpaa2_parser_decode.h | 1549 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
 drivers/net/dpaa2/dpaa2_recycle.c       |   24 +-
 drivers/net/dpaa2/dpaa2_rxtx.c          |  351 +++--
 drivers/net/dpaa2/dpaa2_sparser.c       |  137 --
 drivers/net/dpaa2/dpaa2_sparser.h       |  202 ---
 drivers/net/dpaa2/dpaa2_tm.c            |   16 +-
 drivers/net/dpaa2/mc/dpni.c             |   11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h         |   25 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h     |    3 +-
 drivers/net/dpaa2/meson.build           |    2 +-
 19 files changed, 3096 insertions(+), 1429 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

