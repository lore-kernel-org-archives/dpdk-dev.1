Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B22109E530
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 01:37:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 341A4427CF;
	Thu, 26 Mar 2026 02:37:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD0E427C1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 02:37:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774489061; x=1806025061;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y+E5ASzPO+cP1mNrwWQcbE5I4s1S1vs0udazeWgcp0A=;
 b=CDhdo95VmWvzRWZgbs0UpUqBiE0xlEPYxF2pjlffLJ50ju58B2diEW0z
 51zWszjWrZosNNem4qLQb5mU3l1Z91AqZagHMP1dl2+Njl5UmNSkk7V+n
 fonzLLAcWOrFTi6NceOe/fl56wKIf25NBlzDWZfG5wTwDcrPgtSeWLBB+
 +jwaXOBw0a9pKS1qf09j4wm3/LPugU1gHeWE91s8PqC6UAysIJXig0ILJ
 E6Tb3g4LBLOK4Gf+xeeJwF1lfPOxBiyyTh1Lt8M3bKBbWRjTtoww7pWWg
 wdjM/3v0qJMyD0FfP+BAG7kPvRNiIjpchd5s6bvq8aTYRp9LoGFvbg7iH w==;
X-CSE-ConnectionGUID: cPQLJXA6SmKJDfggdo3tHA==
X-CSE-MsgGUID: CgvvTFX6SMq2TeSoVCQM0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75442401"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75442401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:41 -0700
X-CSE-ConnectionGUID: 1kUhrk8LTxyt/rZFkHSK3A==
X-CSE-MsgGUID: z304F/C4TYyIv2LlUtDZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="255347312"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 18:37:39 -0700
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v1 3/3] net/ixgbe: updated ixgbe latest recommended matching
 list
Date: Thu, 26 Mar 2026 00:54:07 +0000
Message-Id: <20260326005407.623302-4-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326005407.623302-1-hailinx.xu@intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
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

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/ixgbe.rst | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 34e6dd361c..0af2e0fe65 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -41,6 +41,34 @@ Supported Chipsets and NICs
 - Intel Ethernet Converged Network Adapter E610-XT4
 - Intel Ethernet Converged Network Adapter E610-IT4
 
+Kernel driver, DDP and Firmware Matching List
+---------------------------------------------
+
+It is highly recommended to upgrade the ixgbe kernel driver and firmware
+to avoid the compatibility issues with i40e PMD.
+The table below shows a summary of the DPDK versions
+with corresponding out-of-tree Linux kernel drivers and firmware.
+The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
+and Linux distributions that were tested and verified
+are listed in the Tested Platforms section of the Release Notes for each release.
+
+For E610.
+
+   +--------------+-----------------------+------------------+
+   | DPDK version | Kernel driver version | Firmware version |
+   +==============+=======================+==================+
+   |     26.03    |         6.3.4         |       1.41       |
+   +--------------+-----------------------+------------------+
+
+For X550.
+
+   +--------------+-----------------------+------------------+
+   | DPDK version | Kernel driver version | Firmware version |
+   +==============+=======================+==================+
+   |     26.03    |         6.3.4         |       3.70       |
+   +--------------+-----------------------+------------------+
+
+
 Vector PMD for IXGBE
 --------------------
 
-- 
2.34.1

