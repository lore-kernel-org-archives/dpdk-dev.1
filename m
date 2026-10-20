Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C5606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C18840283;
	Tue, 20 Oct 2026 16:48:47 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 732044025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:48:46 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D5ED2001B1;
 Tue, 20 Oct 2026 16:48:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 09971200271;
 Tue, 20 Oct 2026 16:48:46 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D016818000B1;
 Tue, 20 Oct 2026 22:48:44 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v14-S2 00/10] net/dpaa2 updates
Date: Tue, 20 Oct 2026 20:18:31 +0530
Message-ID: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
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

Changes in v14:
- Use the last Rx queue configured in each traffic class as
  the default flow steering miss queue.
- Update the release note accordingly.

Series overview:
- fix an integer overflow in the CCSR region mapping,
- set Tx confirmation on device init and support a larger burst size,
- support MPLS and PPPoE flow distribution,
- support the flow drop action and a default flow miss action,
- identify Rx mbuf hash information by FLC and add minimum key size
  support,
- parse tunnel and fragmented packet types,
- rename Rx queue flags.

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

Jun Yang (1):
  net/dpaa2: rename Rx queue flags

 doc/guides/nics/features/dpaa2.ini     |   2 +
 doc/guides/rel_notes/release_26_11.rst |   5 +
 drivers/net/dpaa2/dpaa2_ethdev.c       |  54 +++--
 drivers/net/dpaa2/dpaa2_ethdev.h       |  36 +++-
 drivers/net/dpaa2/dpaa2_flow.c         | 285 +++++++++++++++++++++++--
 drivers/net/dpaa2/dpaa2_recycle.c      |  23 +-
 drivers/net/dpaa2/dpaa2_rxtx.c         |  66 ++++--
 drivers/net/dpaa2/dpaa2_tm.c           |  16 +-
 drivers/net/dpaa2/mc/dpni.c            |  11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h        |   8 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h    |   3 +-
 11 files changed, 420 insertions(+), 89 deletions(-)

-- 
2.43.0

