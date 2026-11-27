Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C7606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mg0Jc7PI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D9C402B2;
	Fri, 27 Nov 2026 14:14:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 5984C40263
 for <dev@dpdk.org>; Fri, 27 Nov 2026 14:14:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795785261; x=1827321261;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=20/dKMrifaYyezPx5Pa97kQCnWB2qVcuuaYuNaWdSPQ=;
 b=Mg0Jc7PIT/2hG1VD+10yJdN0kY9Qu5d/TwCKdazX9R6+/WQWyr82sIOp
 ManAzUe3vGyhssn0hVEmgVGDw15XjsAQ4xo7dzx7ha7XaXVabPO2oQxbm
 dxvDnGWqJ/slaG+Cz1m4qLeraUbXMpkE2AoMBnQ6geSg5iT3OQS6+ARi/
 +F1g4d4bzKudTvd0kjRiJ7/TlsaRP6ZjkwyNgXmgpGLtqPSBR0TMaiaCI
 rXALkAGL4d0p6iJmgJ3qj1HMJFv8Pq1esDWdY9qcyp4jhZaoOkL6eIstX
 6ypghDtfF8l9j2FLzgQlVnTjg10qcjCevgX+GBvFgCwaV3CpqulK9mVYd w==;
X-CSE-ConnectionGUID: 3Il3FM1ZQtKBvOu9tDH+vA==
X-CSE-MsgGUID: pFtrOv5oRVybqfcOJAdkCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4787497"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4787497"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 05:14:18 -0800
X-CSE-ConnectionGUID: R7CGu8NzQwOuVo2VTyld/w==
X-CSE-MsgGUID: Nir8FfZjSXSEcC+QMSr1Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; d="scan'208";a="12655972"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2026 05:14:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 00/13] VFIO-related fixes
Date: Fri, 27 Nov 2026 13:14:00 +0000
Message-ID: <cover.1795785194.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795708917.git.anatoly.burakov@intel.com>
References: <cover.1795708917.git.anatoly.burakov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix a few memory leaks and other bugs in VFIO-related bus code.

v1 -> v2:
- Address AI feedback on nr_efd being potentially bigger than
  nr_intr by adding two patches preventing this from happening
- Move VFIO fix to earlier in the patchset

Anatoly Burakov (13):
  interrupts: fix partial event list resize
  interrupts: validate event list counts
  vfio: fix uninitialized eventfds when enabling MSI-X
  bus/cdx: fix error check when enabling bus master
  bus/cdx: fix eventfd setup when enabling interrupts
  bus/fslmc: fix unchecked device setup for MC portal
  bus/fslmc: fix double close of MC portal device FD
  bus/fslmc: fix unchecked DPIO portal mapping
  bus/fslmc: fix DPIO portal mapping leak on close
  bus/pci: fix shared BAR info reset on mapping failure
  bus/pci: fix leaks on BAR mapping failure
  bus/pci: fix BAR area list free in secondary process
  vdpa/sfc: fix doorbell address in notify area query

 app/test/test_interrupts.c               | 89 ++++++++++++++++++++++++
 drivers/bus/cdx/cdx_vfio.c               | 29 ++++++--
 drivers/bus/fslmc/fslmc_vfio.c           | 10 ++-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 37 ++++++++--
 drivers/bus/pci/linux/pci_vfio.c         | 21 +++---
 drivers/vdpa/sfc/sfc_vdpa_ops.c          | 10 ++-
 lib/eal/common/eal_common_interrupts.c   | 53 +++++++++-----
 lib/eal/include/rte_interrupts.h         |  5 +-
 lib/eal/linux/eal_interrupts.c           |  7 +-
 9 files changed, 213 insertions(+), 48 deletions(-)

-- 
2.52.0

