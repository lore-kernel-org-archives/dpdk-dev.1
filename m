Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C3CD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 06:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2755F4028C;
	Fri, 19 Jun 2026 08:09:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C8D804027F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 08:09:21 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A0DF1A0204;
 Fri, 19 Jun 2026 08:09:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B3161A0203;
 Fri, 19 Jun 2026 08:09:21 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D51F3180004C;
 Fri, 19 Jun 2026 14:09:19 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v2 00/18] net/dpaa: bug fixes for bus, net and fmlib drivers
Date: Fri, 19 Jun 2026 11:38:58 +0530
Message-Id: <20260619060916.485258-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

This series contains bug fixes for the DPAA PMD (bus/dpaa, net/dpaa,
net/dpaa/fmlib and dma/dpaa):

v2 changes:
- P05: Fix commit message API name (fm_pcd_kg_scheme_delete not FM_PCD_MatchTableSchemeDelete)
- P08: Guard DPAA_PUSH_QUEUES_NUMBER env-var override for LS1043A to prevent
  inadvertent re-enabling of push mode (errata)
- P09: Document dpaa_finish() call removal in commit message
- P10: Fix wrong Fixes: tag (was log macro commit, now correct interrupt commit)
- P11: Split into two patches with correct per-driver Fixes: tags
- P13: Also fix rx_buf_diallocate -> rx_buf_deallocate typo

All patches are bug fixes tagged with Fixes: and Cc: stable@dpdk.org.

Gagandeep Singh (3):
  bus/dpaa: fix device probe issue
  net/dpaa: fix device remove
  net/dpaa: fix invalid check on interrupt unregister

Hemant Agrawal (11):
  bus/dpaa: fix error handling of qman_create_fq
  bus/dpaa: fix fqid endianness
  bus/dpaa: fix error handling in qman_query
  net/dpaa: fix modify cgr to use index
  bus/dpaa: fix fd leak for ccsr mmap
  net/dpaa: fix xstat name for tx undersized counter
  net/dpaa: fix xstat string typos in BMI stats table
  net/dpaa: remove duplicate ptype entries
  net/dpaa: fix wrong buffer in xstats get by id
  net/dpaa: fix null l3_len check in checksum offload
  net/dpaa: fix mbuf leak in SG fd creation

Jun Yang (1):
  bus/dpaa: fix BMI RX stats register offset

Prashant Gupta (1):
  net/dpaa/fmlib: add null check in scheme delete

Vanshika Shukla (2):
  net/dpaa: fix port_handle leak in fm_prev_cleanup
  dma/dpaa: fix out-of-bounds access in SG descriptor enqueue

 drivers/bus/dpaa/base/qbman/bman_driver.c |  3 ++-
 drivers/bus/dpaa/base/qbman/qman.c        | 11 +++++----
 drivers/bus/dpaa/base/qbman/qman_driver.c |  6 ++---
 drivers/bus/dpaa/dpaa_bus.c               | 17 +++++++------
 drivers/bus/dpaa/include/fman.h           |  6 ++---
 drivers/dma/dpaa/dpaa_qdma.c              |  7 +++++-
 drivers/net/dpaa/dpaa_ethdev.c            | 29 +++++++++++------------
 drivers/net/dpaa/dpaa_flow.c              |  4 ++++
 drivers/net/dpaa/dpaa_rxtx.c              |  3 +++
 drivers/net/dpaa/fmlib/fm_lib.c           |  3 +++
 10 files changed, 53 insertions(+), 36 deletions(-)

-- 
2.43.0

