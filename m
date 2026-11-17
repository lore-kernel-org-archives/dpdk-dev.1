Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBA606A334
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 05:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F11B44026F;
	Tue, 17 Nov 2026 06:46:04 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id DC58640150
 for <dev@dpdk.org>; Tue, 17 Nov 2026 06:46:02 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D0DB1A0012;
 Tue, 17 Nov 2026 06:46:02 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 578321A0003;
 Tue, 17 Nov 2026 06:46:02 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CEAE18000B6;
 Tue, 17 Nov 2026 13:46:01 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v5 0/4] DPAA driver changes
Date: Tue, 17 Nov 2026 11:15:54 +0530
Message-Id: <20261117054558.1297266-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116062512.726405-1-g.singh@nxp.com>
References: <20261116062512.726405-1-g.singh@nxp.com>
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

V5-Changes:
 - Added a reset FQ helper as per the AI suggestion
 - Fixed the portid issue.
 - Added explicit padding, uint8_t, size checks. The version ioctl is
   not avilable in CDX module as of now, so mismatch module will fails
   at probe only through existing ioctl errors.
 - Fixed stale FQs run at close issue.
 - Added a AI suggested warning.
 - The scan moved to probe, close no longer scans. A single combined pass
   would need the Tx CGRIDs before the Rx CGRs are created and a scan that
   takes two ranges, which is too big for this series and saves
   only one scan per port at startup.

V4-Changes:
 - Fixed ol_fd leak issue.
 - Fixed the FQID hold be kernel issue.
 - removed the not required locks.
 - fixed unwanted line and memcpy issue.
 - We want to have rte_pmd_dpaa_ol_* functions, the reason we sent over
   the email.

V3-Changes:
 - Updated rte_pmd_dpaa_oldev.h APIs as per DPDK compliance.
 - Added missing release not for OH port support.
 - Fixed dump_netcfg issue.
 - Added an API to release FQID.
 - moved the fman.h changes to first patch.

V2-changes:
 - Fixed most of the AI comments.
 - added new patch:
   fix out-of-bounds read of mac_idx
 - removed drv_oldev, updated comments and notes.
 - fixes FQ shutdown
 - removed unwanted checks, updated open, updated snprintf.
 - updated commit messages.

V1:
 - Adding OH port support.
 - Updates in shared ethernet code.
 - Congestion related code cleanup.

Gagandeep Singh (2):
  bus/dpaa: fix out-of-bounds read of mac_idx array
  drivers: add offline (O/H) port device support

Hemant Agrawal (1):
  net/dpaa: support non fmX-macY type of shared Ethernet name

Jun Yang (1):
  drivers: add DPAA cgrid cleanup support

 doc/api/doxy-api-index.md                |   1 +
 doc/guides/nics/dpaa.rst                 |  36 +
 doc/guides/rel_notes/release_26_11.rst   |  10 +
 drivers/bus/dpaa/base/fman/fman.c        |  19 +
 drivers/bus/dpaa/base/qbman/qman.c       |  61 ++
 drivers/bus/dpaa/bus_dpaa_driver.h       |   4 +-
 drivers/bus/dpaa/dpaa_bus.c              |  68 +-
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |   2 +
 drivers/bus/dpaa/include/fman.h          |   6 +-
 drivers/bus/dpaa/include/fsl_qman.h      |  28 +
 drivers/net/dpaa/dpaa_ethdev.c           | 234 +++++-
 drivers/net/dpaa/dpaa_ethdev.h           |  12 +
 drivers/net/dpaa/dpaa_flow.c             |   5 +-
 drivers/net/dpaa/dpaa_oldev.c            | 959 +++++++++++++++++++++++
 drivers/net/dpaa/meson.build             |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h    | 198 +++++
 16 files changed, 1623 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

-- 
2.25.1

