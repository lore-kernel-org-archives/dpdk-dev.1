Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2941AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 06:55:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01AE740612;
	Thu, 17 Jul 2025 08:54:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE82400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 08:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752735294; x=1784271294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cRCFY4PKVOSJFjSJmchMuQPC9PBsJ/vy7GMvTeVmvKE=;
 b=mDz/CzlrDSdMN5Sd75eKAAXNYn6qgP70Q4xigdzc5sG/5ElXHaLwYWfW
 JQ1YQN2SlcedEzbwv/IjAyeyIdMsHwG+BwC/zeNLvVqb3AbPGJOwU9l2l
 jcaW8zHgDx16vfEUhAZUXEOUadZ6zW2YRDFB5LQ2MffRc+G8gjZ0olbq9
 jABXxOQbMmsf55vYNq9muhegl6lgByL2DIaCeB0xVAhbsY51kqdXOtcJj
 KjNMFljN//DtkEEIWIbDlBUmPkpV2vWsH7O0hbsle1u6BU0WAp9UsOt3I
 HXi8JWV8FRFkyFz0NESou5XeXgw5F2aQcZEaUW/xAF60W0bBwshp5oGJo g==;
X-CSE-ConnectionGUID: 3wcuhmoGQyi9+CE/8JdizQ==
X-CSE-MsgGUID: crzeGUVMROSzRYJzcOs9QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54970990"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54970990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 23:54:54 -0700
X-CSE-ConnectionGUID: KdXy1F60SJiOdo+YTx9qaA==
X-CSE-MsgGUID: PeWoerl2TlelJG6Tawlrpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="194848786"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 23:54:52 -0700
From: hailinx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, hailinx <hailinx.xu@intel.com>
Subject: [PATCH v1] net/ixgbe: add nic and updated recommended matching list
Date: Thu, 17 Jul 2025 14:16:04 +0800
Message-Id: <20250717061604.3288049-3-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717061604.3288049-1-hailinx.xu@intel.com>
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
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

Signed-off-by: hailinx <hailinx.xu@intel.com>
---
 doc/guides/nics/ixgbe.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index a03ec7a7e8..6380e18feb 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -36,6 +36,8 @@ Supported Chipsets and NICs
 - Intel Ethernet Converged Network Adapter X540-T2
 - Intel Ethernet Converged Network Adapter X550-T1
 - Intel Ethernet Converged Network Adapter X550-T2
+- Intel Ethernet Network Adapter E610-XT2
+- Intel Ethernet Network Adapter E610-XT4
 
 Vector PMD for IXGBE
 --------------------
@@ -93,6 +95,25 @@ Windows Prerequisites and Pre-conditions
 - Loading of private Dynamic Device Personalization (DDP) package
   is not supported on Windows.
 
+Kernel driver and Firmware Matching List
+----------------------------------------
+
+It is highly recommended to upgrade the ixgbe kernel driver and firmware
+to avoid the compatibility issues with ixgbe PMD.
+The table below shows a summary of the DPDK versions
+with corresponding out-of-tree Linux kernel drivers and firmware.
+The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
+and Linux distributions that were tested and verified
+are listed in the Tested Platforms section of the Release Notes for each release.
+
+For E610,
+
+   +--------------+-----------------------+------------------+
+   | DPDK version | Kernel driver version | Firmware version |
+   +==============+=======================+==================+
+   |     25.07    |         6.1.5         |        1.0       |
+   +--------------+-----------------------+------------------+
+
 
 Feature not Supported by RX Vector PMD
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.25.1

