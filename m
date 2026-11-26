Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929D606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iIFhIPr1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BF8440431;
	Thu, 26 Nov 2026 17:03:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id C87FE402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 17:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795709004; x=1827245004;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tSQ8Le2yErMMSdZHjNEpZNsfyLP1kM1eX7R0qyB3HLM=;
 b=iIFhIPr1Aqe64/A5I1bmOpqmSYyFyPamAqjPkZwPZTpR4t9w7W5AREsn
 Jg4a/5kyfeuBoUyzFkjlMZHFdwVkn3ei8xRV4j8XWlNnbSc+ZA7LnEZqg
 QIUoiSBsrOhbMCYbyVmzHVAHgRR9OYag++92h6eeFHHusbwjkVLidGqVe
 8zNdAR2HmuFI57FJcuVEBQ0fKuCLm6TmDOfaombnLWGFO+wKQ3neCZRA5
 nBJVuWIM/wBwi0bb8r5d23PeuRWtVFHX0XOi460rrNV6Cn5lxERO4p5zl
 IHLHnjpPBaTyoptJq4Rf+BZU/mRTHw3fX16CEbBDWoUlJcyA/y49vHK1T w==;
X-CSE-ConnectionGUID: ZiZo+Xa7TfCcuH3dxSBuaA==
X-CSE-MsgGUID: 27cS8RUlQzqq3z0wuFE4iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4519717"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4519717"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 08:03:22 -0800
X-CSE-ConnectionGUID: gfZAPHVeRu6RXIzsJU2dmA==
X-CSE-MsgGUID: U5llRKArTsimHsTNRZJsHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12236579"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Nov 2026 08:03:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/11] VFIO-related fixes
Date: Thu, 26 Nov 2026 16:03:06 +0000
Message-ID: <cover.1795708917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Anatoly Burakov (11):
  bus/cdx: fix error check when enabling bus master
  bus/cdx: fix eventfd setup when enabling interrupts
  bus/fslmc: fix unchecked device setup for MC portal
  bus/fslmc: fix double close of MC portal device FD
  bus/fslmc: fix unchecked DPIO portal mapping
  bus/fslmc: fix DPIO portal mapping leak on close
  bus/pci: fix shared BAR info reset on mapping failure
  bus/pci: fix leaks on BAR mapping failure
  bus/pci: fix BAR area list free in secondary process
  vfio: fix uninitialized eventfds when enabling MSI-X
  vdpa/sfc: fix doorbell address in notify area query

 drivers/bus/cdx/cdx_vfio.c               | 29 ++++++++++++++-----
 drivers/bus/fslmc/fslmc_vfio.c           | 10 +++++--
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 37 ++++++++++++++++++++----
 drivers/bus/pci/linux/pci_vfio.c         | 21 +++++++-------
 drivers/vdpa/sfc/sfc_vdpa_ops.c          | 10 +++++--
 lib/eal/linux/eal_interrupts.c           |  7 ++++-
 6 files changed, 86 insertions(+), 28 deletions(-)

-- 
2.52.0

