Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEC9CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB8F04027C;
	Fri,  9 Oct 2026 12:49:06 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id C801B40144
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:49:05 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B0C020000B;
 Fri,  9 Oct 2026 12:49:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56ACD200004;
 Fri,  9 Oct 2026 12:49:05 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 29ED6180006C;
 Fri,  9 Oct 2026 18:49:04 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v8-S2 00/13] net/dpaa2 updates
Date: Fri,  9 Oct 2026 16:18:47 +0530
Message-ID: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007060227.219835-1-prashant.gupta_3@nxp.com>
References: <20261007060227.219835-1-prashant.gupta_3@nxp.com>
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

This is the second of four series upstreaming the missing NXP dpaa2
driver changes. It does not depend on series 1 and can be applied
independently.

Changes in v8:
- Address review comments for meter and policing support.
- Add meter resource cleanup during device close.
- Add policing capability checks.
- Validate burst size ranges before hardware programming.
- Fix software/hardware state consistency on profile/policy updates.
- Clarify and guard default flow-miss handling.
- Use standard FDIR reporting for flow-steered packets.
- Document and gate minimum DPNI version for 24-byte flow keys.
- Fold parser fixups into originating patches.
- Remove unused VXLAN offset helper following soft parser removal.
- Update release notes placement and content.

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
 doc/guides/rel_notes/release_26_11.rst  |   18 +
 drivers/net/dpaa2/dpaa2_ethdev.c        |   89 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  218 +++-
 drivers/net/dpaa2/dpaa2_flow.c          |  633 +++------
 drivers/net/dpaa2/dpaa2_meter.c         |  814 ++++++++++++
 drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
 drivers/net/dpaa2/dpaa2_parser_decode.h | 1549 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
 drivers/net/dpaa2/dpaa2_recycle.c       |   24 +-
 drivers/net/dpaa2/dpaa2_rxtx.c          |  399 ++++--
 drivers/net/dpaa2/dpaa2_sparser.c       |  137 --
 drivers/net/dpaa2/dpaa2_sparser.h       |  202 ---
 drivers/net/dpaa2/dpaa2_tm.c            |   16 +-
 drivers/net/dpaa2/mc/dpni.c             |   11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h         |   25 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h     |    3 +-
 drivers/net/dpaa2/meson.build           |    2 +-
 19 files changed, 3134 insertions(+), 1452 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

