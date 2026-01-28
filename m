Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2ED35697
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:16:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 167E840274;
	Wed, 28 Jan 2026 10:16:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD4D400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:16:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769591783; x=1801127783;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Tbo+KEte3F2diWVXb/5f4lyNHug/7aQN/roi2E/Fx+Q=;
 b=JXYdbHfIQQwLHLQmxdwSIBRiAGVv2vBzZpZiawRFIRAP5V+Jg0Vqc4RZ
 KG7vWYmogyJwJs6zoT1NkFQAErcxYn0hbxpKhtRyqDDOYBtngE86pOupw
 rrt76zsUY3P6Xoj8LwtqODXZRAHYWJ9l5u8ZQJY5FZnXdIkbOKQlND5AD
 6bCJfWMuU+s2pZOrTRzj61SgtvtwyEbAnXT1AiOUzr5yJp2doBFHJ/soL
 AQDAjtZgWEE/M7LMt89T74ibY3ZrTLFDihsuVc/2GK8Uc81i0Wm/e7c0L
 dTb38skg2znb/FdDm4kMQ4zAye/18GZ3TqRf1IWsg0d5otpYWjOLPX+mD w==;
X-CSE-ConnectionGUID: wb12bsTyTWWRHtU1J+OMwA==
X-CSE-MsgGUID: 1DlVAlQRRGya7PsBaXO0Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82166285"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="82166285"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 01:16:21 -0800
X-CSE-ConnectionGUID: 403GwE7yQOyk1ixN1F8dkA==
X-CSE-MsgGUID: TnMJo/vOS9qy7ovpfFBjuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208240087"
Received: from ces-tuh.iind.intel.com ([10.49.105.91])
 by orviesa008.jf.intel.com with ESMTP; 28 Jan 2026 01:16:20 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH] doc/ixgbe: update ixgbe NIC guide to include E610 support
 information
Date: Wed, 28 Jan 2026 14:44:16 +0530
Message-ID: <20260128091416.75683-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.43.0
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

Add Intel Ethernet Controller E610 and related E610-based adapters
to the list of supported devices in the ixgbe NIC guide to reflect
current hardware support.

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/ixgbe.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index a03ec7a7e8..34e6dd361c 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -36,6 +36,10 @@ Supported Chipsets and NICs
 - Intel Ethernet Converged Network Adapter X540-T2
 - Intel Ethernet Converged Network Adapter X550-T1
 - Intel Ethernet Converged Network Adapter X550-T2
+- Intel Ethernet Controller E610
+- Intel Ethernet Converged Network Adapter E610-XT2
+- Intel Ethernet Converged Network Adapter E610-XT4
+- Intel Ethernet Converged Network Adapter E610-IT4
 
 Vector PMD for IXGBE
 --------------------
-- 
2.43.0

