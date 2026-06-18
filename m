Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D75CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:12:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2218840DD1;
	Thu, 18 Jun 2026 16:11:55 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4FFB640DD1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:11:54 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1694620002B;
 Thu, 18 Jun 2026 16:11:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D1EF6200028;
 Thu, 18 Jun 2026 16:11:53 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7BB1C1800071;
 Thu, 18 Jun 2026 22:11:52 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Subject: [PATCH v1 00/17] net/dpaa: bug fixes for bus, net and fmlib drivers
Date: Thu, 18 Jun 2026 19:41:34 +0530
Message-Id: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
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

- Fix error handling in qman_create_fq and qman_query
- Fix fqid endianness in qman_fq_flow_control
- Fix CGR index usage in dpaa_modify_cgr
- Add null check in fmlib scheme delete
- Fix BMI RX stats register offset
- Fix file descriptor leak after CCSR mmap
- Fix device probe regression on LS1043A
- Fix double-close in device remove path
- Fix incorrect condition in interrupt unregister
- Fix Coverity-reported issues in dpaa_flow and dpaa_qdma
- Fix xstat name for tx undersized counter
- Fix xstat string typos in BMI stats table
- Remove duplicate ptype entries
- Fix wrong buffer in xstats get by id
- Fix null l3_len check in checksum offload
- Fix mbuf leak in SG fd creation

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

Vanshika Shukla (1):
  net/dpaa: fix coverity reported issues

 drivers/bus/dpaa/base/qbman/bman_driver.c |  3 ++-
 drivers/bus/dpaa/base/qbman/qman.c        | 11 +++++----
 drivers/bus/dpaa/base/qbman/qman_driver.c |  6 ++---
 drivers/bus/dpaa/dpaa_bus.c               |  6 ++---
 drivers/bus/dpaa/include/fman.h           |  6 ++---
 drivers/dma/dpaa/dpaa_qdma.c              |  7 +++++-
 drivers/net/dpaa/dpaa_ethdev.c            | 27 +++++++++++------------
 drivers/net/dpaa/dpaa_flow.c              |  4 ++++
 drivers/net/dpaa/dpaa_rxtx.c              |  3 +++
 drivers/net/dpaa/fmlib/fm_lib.c           |  3 +++
 10 files changed, 46 insertions(+), 30 deletions(-)

-- 
2.43.0

