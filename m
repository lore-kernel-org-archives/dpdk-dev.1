Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88045CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 06:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56856402D0;
	Wed,  7 Oct 2026 08:02:34 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 53F914027B
 for <dev@dpdk.org>; Wed,  7 Oct 2026 08:02:32 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 00E84200098;
 Wed,  7 Oct 2026 08:02:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0E86200091;
 Wed,  7 Oct 2026 08:02:31 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8E49D18000B1;
 Wed,  7 Oct 2026 14:02:30 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v7-S2 00/13] net/dpaa2: flow, meter and parser features
Date: Wed,  7 Oct 2026 11:32:14 +0530
Message-ID: <20261007060227.219835-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
References: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
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
independently. It adds the net/dpaa2 flow, metering and parser features:

- fix an integer overflow in the CCSR region mapping,
- set Tx confirmation on device init and support a larger burst size,
- support MPLS and PPPoE flow distribution, meter and policing, and the
  flow drop action, with a per-device default flow miss action,
- identify Rx mbuf hash information by FLC and add minimum key size
  support,
- restructure the parser processing, parse tunnel and fragmented packet
  types, remove the unused soft parser driver and rename the Rx queue
  flags.

Note that patch 12 removes the soft parser driver and, with it, the
rte_flow VXLAN and eCPRI pattern items that were only accepted while an
SP image was believed to be loaded. Both items are dropped from the dpaa2
feature matrix and a release note is added.

Every commit builds cleanly (including the aarch64 DPAA cross build with
-Werror) and the series is bisectable.

Changes in v7:
- rebased on next-net to resolve apply conflicts reported by patchwork.

Changes in v6:
- patch 10: dropped the inaccurate "no functional change is intended"
  claim; the commit message now enumerates the functional changes
  (checksum flag ordering, IPV4/6_EXT/SCTP/ICMP fast-path removal) and
  the known limitations that need follow-up work,
- patch 11: added RTE_PTYPE_L4_FRAG, RTE_PTYPE_TUNNEL_ESP,
  RTE_PTYPE_TUNNEL_GTPU and RTE_PTYPE_TUNNEL_GTPC to
  dpaa2_supported_ptypes_get() so the new types are advertised, and
  OR-ed RTE_PTYPE_L4_UDP into the GTP-U/GTP-C cases since GTP runs over
  UDP; corrected the commit message to name dpaa2_dev_rx_parse_new(),
- patch 12: removed the now-unreachable dpaa2_configure_flow_vxlan() and
  dpaa2_configure_flow_ecpri() handlers, their switch cases, mask
  descriptors and the VXLAN_HF_VNI helper; dropped the vxlan and ecpri
  entries from the dpaa2 feature matrix and added a release note; the
  commit message now explains that the SP must be loaded by firmware at
  boot, so runtime loading from the PMD never worked,
- patch 13: dropped the reference to a Tx confirmation rework that is
  not part of this series,
- patch 5: replaced the stack-allocated err_msg[] buffers whose address
  was stored in rte_mtr_error with string literals (-Wdangling-pointer).

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
 drivers/net/dpaa2/dpaa2_ethdev.c        |   88 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  217 +++-
 drivers/net/dpaa2/dpaa2_flow.c          |  620 +++------
 drivers/net/dpaa2/dpaa2_meter.c         |  758 +++++++++++
 drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
 drivers/net/dpaa2/dpaa2_parser_decode.h | 1551 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
 drivers/net/dpaa2/dpaa2_recycle.c       |   24 +-
 drivers/net/dpaa2/dpaa2_rxtx.c          |  329 +++--
 drivers/net/dpaa2/dpaa2_sparser.c       |  137 --
 drivers/net/dpaa2/dpaa2_sparser.h       |  202 ---
 drivers/net/dpaa2/dpaa2_tm.c            |   16 +-
 drivers/net/dpaa2/mc/dpni.c             |   11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h         |   31 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h     |    3 +-
 drivers/net/dpaa2/meson.build           |    2 +-
 19 files changed, 3032 insertions(+), 1421 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

