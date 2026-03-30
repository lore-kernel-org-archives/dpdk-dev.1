Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7458FF4936
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 03:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA3B40269;
	Mon, 30 Mar 2026 05:28:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BB786400D6
 for <dev@dpdk.org>; Mon, 30 Mar 2026 05:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774841327; x=1806377327;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uksw4MB4GeDY4mankZuGh7WEeJDj8C7SdDiZXEeuOk4=;
 b=idPm/aMjWD4TB5CqU98m7gPRzUPaZKNgVMuAPblvQJc8SNoTUv/J06IJ
 L6VqR2vzG+VOzvBJTT3b3l0yY6rozXpeXoF0uvAfDLmibDfZwl3VAW6QI
 Ry7h29ghcvytvlA5JSqzTtpRtBY8Xb4bSP88jXAGuEUBqq/EuIJrJ22is
 F2U2LhzOkQpdFQaUv2Xb4wAcHQOB8FYkwvaloP05DRw3E72lbJ3L1Wpwz
 wpi7OCRsDXKNKj+DIrmN4NGqbln6tPGeHoybAtzgW2DwEDd/Tcst5v9bG
 QxYUB7wEOJLqbftbqgiNVk0McBOmNC5mhDroFxIb0wYA06oMAPsreyg2Q A==;
X-CSE-ConnectionGUID: FPOGZpC+Rx+An1v03eZBsA==
X-CSE-MsgGUID: J1CtzaWaSIO8IXuaO+/5Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87214927"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87214927"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 20:28:45 -0700
X-CSE-ConnectionGUID: iPz0lxm5SieeCWDPZ0hz3Q==
X-CSE-MsgGUID: 5NO4ICGySNyGSwA2THzsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="249123661"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 20:28:44 -0700
From: hailinxx <hailinx.xu@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 hailinxx <hailinx.xu@intel.com>
Subject: [PATCH v2] net/ixgbe: updated ixgbe recommended matching list
Date: Mon, 30 Mar 2026 02:45:18 +0000
Message-Id: <20260330024518.713013-1-hailinx.xu@intel.com>
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

Signed-off-by: hailinxx <hailinx.xu@intel.com>
---
 doc/guides/nics/ixgbe.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 34e6dd361c..ea241927f6 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -54,6 +54,25 @@ They are transparently registered at runtime RX/TX execution if all condition ch
 Some constraints apply as pre-conditions for specific optimizations on bulk packet transfers.
 The following sections explain RX and TX constraints in the vPMD.
 
+Kernel driver, DDP and Firmware Matching List
+---------------------------------------------
+It is highly recommended to upgrade the ixgbe kernel driver and
++firmware to avoid the compatibility issues with i40e PMD.
+The table below shows a summary of the DPDK versions with
+corresponding out-of-tree Linux kernel drivers and firmware.
+The full list of in-tree and out-of-tree Linux kernel drivers from
+kernel.org and Linux distributions that were tested and verified
++are listed in the Tested Platforms section of the Release Notes for each release.
+
++--------------+-----------------------+-----------------+-----------------+
+| DPDK version | Kernel driver version | E610 FW version | X550 FW version |
++==============+=======================+=================+=================+
+|     25.11    |         6.2.5         |       1.30      |                 |
++--------------+-----------------------+-----------------+-----------------+
+|     26.03    |         6.3.4         |       1.41      |       3.70      |
++--------------+-----------------------+-----------------+-----------------+
+
+
 RX Constraints
 ~~~~~~~~~~~~~~
 
-- 
2.34.1

