Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDBC982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B50E410F6;
	Tue, 22 Sep 2026 11:55:33 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 91965402BA
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:55:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 649321A000E;
 Tue, 22 Sep 2026 11:55:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E0331A0005;
 Tue, 22 Sep 2026 11:55:31 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ED83218000BA;
 Tue, 22 Sep 2026 17:55:29 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v4-S2 00/13] net/dpaa2: flow, meter and parser features
Date: Tue, 22 Sep 2026 15:25:15 +0530
Message-ID: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
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

Every commit builds cleanly (including the aarch64 DPAA cross build with
-Werror) and the series is bisectable.

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
 doc/guides/nics/features/dpaa2.ini      |    3 +
 doc/guides/rel_notes/release_26_11.rst  |    4 +
 drivers/net/dpaa2/dpaa2_ethdev.c        |   84 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  227 +++-
 drivers/net/dpaa2/dpaa2_flow.c          |  397 ++++--
 drivers/net/dpaa2/dpaa2_meter.c         |  637 ++++++++++
 drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
 drivers/net/dpaa2/dpaa2_parser_decode.h | 1542 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
 drivers/net/dpaa2/dpaa2_recycle.c       |   40 +-
 drivers/net/dpaa2/dpaa2_rxtx.c          |  334 +++--
 drivers/net/dpaa2/dpaa2_sparser.c       |  137 --
 drivers/net/dpaa2/dpaa2_sparser.h       |  202 ---
 drivers/net/dpaa2/dpaa2_tm.c            |   17 +-
 drivers/net/dpaa2/mc/dpni.c             |   11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h         |   11 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h     |    6 +-
 drivers/net/dpaa2/meson.build           |    2 +-
 19 files changed, 2999 insertions(+), 1097 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

-- 
2.43.0

