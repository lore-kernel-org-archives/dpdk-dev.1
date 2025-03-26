Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217FC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:30:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 887F0402DF;
	Wed, 26 Mar 2025 14:30:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id AB70C402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742995839; x=1774531839;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xrWvUCFDWiR4OBY1Iu8QjSaZr4rnLx5HqZa6FHnYSqs=;
 b=QEwVieQYWCEeeSKy32L6edkE1M9tZZc4IulN9W3MHpV5ntT5Z/TPQ7JO
 g3v3InsAeSvQFkxzX6GfSbCLOwcKyDk/djLAmguw5RATBEPG9bx6eM+E9
 O/2BqdQJrcKDonmVI369+FoQxRWsDsVWWRqJdCuVfL6//4xu+dg4Sq/77
 395crNxfYJJaZ242AjOgPK+8NNQL3HKtGsT77Vo/fdKGVvWqUsokJNSZV
 RBADTrx42m3Xp0nxlM9hFmOhELkYvbA+rbhnD1twxgAvEPGnSFmxXj2bV
 80nHlJ+stPwYt0yn1RR2hWu48794kQxGP7MvaOi5NCVnh7dUoe/GFstTw A==;
X-CSE-ConnectionGUID: XlpPed0UQ2Gg3Uq2ZfB2jw==
X-CSE-MsgGUID: K+YLPdwQQ6ifcStqF3eFLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="48072963"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="48072963"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 06:30:19 -0700
X-CSE-ConnectionGUID: CzgilFglQYO0nM2PIC++8g==
X-CSE-MsgGUID: Z8LTQoP3SdeWIuzJYtDdrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="124729597"
Received: from silpixa00401164.ir.intel.com (HELO
 silpixa00401164.ger.corp.intel.com) ([10.237.223.78])
 by fmviesa007.fm.intel.com with ESMTP; 26 Mar 2025 06:30:17 -0700
From: Ian Stokes <ian.stokes@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v1] maintainers: update for iavf and i40e
Date: Wed, 26 Mar 2025 13:30:10 +0000
Message-Id: <20250326133010.168470-1-ian.stokes@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Removing myself as maintainer for iavf and i40e.

Signed-off-by: Ian Stokes <ian.stokes@intel.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b01103f8e..5f2f413da8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -802,7 +802,6 @@ F: doc/guides/nics/intel_vf.rst
 F: doc/guides/nics/features/ixgbe*.ini
 
 Intel i40e
-M: Ian Stokes <ian.stokes@intel.com>
 M: Bruce Richardson <bruce.richardson@intel.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
 F: drivers/net/intel/i40e/
@@ -818,7 +817,6 @@ F: doc/guides/nics/features/fm10k*.ini
 
 Intel iavf
 M: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
-M: Ian Stokes <ian.stokes@intel.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
 F: drivers/net/intel/iavf/
 F: doc/guides/nics/features/iavf*.ini
-- 
2.34.1

