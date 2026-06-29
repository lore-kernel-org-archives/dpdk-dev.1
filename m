Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C8C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D29424021E;
	Mon, 29 Jun 2026 07:21:33 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 75605400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 07:21:32 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A33A1A0AEF;
 Mon, 29 Jun 2026 07:21:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 011F71A0B08;
 Mon, 29 Jun 2026 07:05:31 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BA5D180007B;
 Mon, 29 Jun 2026 13:05:30 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v4 0/9] ENETC driver related changes series
Date: Mon, 29 Jun 2026 10:35:18 +0530
Message-Id: <20260629050527.981200-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623060004.2187716-1-g.singh@nxp.com>
References: <20260623060004.2187716-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

V4 changes:
  - Fixed a compilation issue: "txbd may be used uninitialized"

V3 changes:
  - Added documentation for all devargs in enetc4.rst.
  - Fixed kvlist memory leak issue.

V2 changes:
  - Fixed an un-used variable compilation issue reported on fedora:43-gcc-minsize
  - Fixed various AI reported issues:
	- Release notes updated for all new devargs
	- enect4.ini features doc updated for scattered RX.
	- removed Not required RTE_PTYPE_UNKNOWN.
	- Fixed mid-frame mbuf leak in SG case.
	- Enabled SG for enetc4 PF also.
	- move to calloc from rte_zmalloc in parse_txq_prior().
	- added vaidation checks on strdup, strtoul.
	- added NC devargs to use cacheable ops conditionally.
	- removed dead code like bd_base_p etc.
	- Fixed rte_cpu_to_le_16() conversion on flags and combined
	  all flags related patches in one patch.
	- Fixed memory leak issue due to TXQ priority patch.
  - There were some false positives, I have ignored them:
	Race condition on flags field:
		clean_tx_ring only touches HW-completed BDs (next_to_clean→hwci),
		never newly-submitted BDs; doorbell hasn't fired yet.
	Missing dcbf in clean_tx_ring:
		DPDK is single-threaded per queue; TX path always overwrites
		flags completely before dcbf.
	TX dcbf granularity with wrap:
		Safe (AI admits it).
	RX refill flush at wrap:
		In-loop dcbf at i & mask == 0 already flushes aligned groups;
		trailing flush only needed for partial groups.
	RX reading before invalidate:
		dccivac precedes the read for every group in the loop

Gagandeep Singh (7):
  net/enetc: fix TX BD structure
  net/enetc: fix queue initialization
  net/enetc: support ESP packet type in packet parsing
  net/enetc: update random MAC generation code
  net/enetc: add option to disable VSI messaging
  net/enetc: add devargs to control VSI-PSI timeout and delay
  net/enetc4: add cacheable BD ring support with SW cache maintenance

Vanshika Shukla (2):
  net/enetc: support scatter-gather
  net/enetc: set user configurable priority to TX rings

 doc/guides/nics/enetc4.rst             |  62 +++-
 doc/guides/nics/features/enetc4.ini    |   1 +
 doc/guides/rel_notes/release_26_07.rst |  10 +
 drivers/net/enetc/base/enetc_hw.h      |  13 +-
 drivers/net/enetc/enetc.h              |  31 +-
 drivers/net/enetc/enetc4_ethdev.c      | 172 ++++++++--
 drivers/net/enetc/enetc4_vf.c          | 206 ++++++++++--
 drivers/net/enetc/enetc_ethdev.c       |  25 +-
 drivers/net/enetc/enetc_rxtx.c         | 430 ++++++++++++++++++++++---
 9 files changed, 831 insertions(+), 119 deletions(-)

-- 
2.25.1

