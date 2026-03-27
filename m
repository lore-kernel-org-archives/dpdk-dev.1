Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4810ED676
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 13:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 107BF42E52;
	Fri, 27 Mar 2026 14:05:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 94FD542E1D
 for <dev@dpdk.org>; Fri, 27 Mar 2026 14:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774616714; x=1806152714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rhutQYQ+p6Z1tiGsoRi6vpPgmCeGhYFTVHUxuxqcR80=;
 b=dBCJyusN69mnYCD5uIISMHXIxtGXOCnM31lmKHkpP30M2t+AUWeJ3D7D
 KQs5uuBqJkxH+uOM+DJvrcXgcvwAbS+I9G7I2L6SlA6sVkpHQLnAKEqtE
 gsBZAPzGZtUnJbU/+cdrzOyNVRWDraFIXHAcYXUykY7hH9HBK0XeN6Oz5
 SavQEoLdhg3S4tXfjCxovc/trqY1EiVfmRBtMN0qTTUxeZiB5wQFnfzUq
 ZV+GkjaQyl0yThc9OO+IKTzXLi2LBz728ds8O6/ok6AHU+QTx5IsfdigM
 MEaDNWBqUThtLStGhmJX3y+Xu1q6GkFKdGbfSRztLDQORMYbqpk1AC0tP w==;
X-CSE-ConnectionGUID: RzKHcUbET82shDqs6Rk6yw==
X-CSE-MsgGUID: KXmW8MXCR52RNwyZnF3kpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75654592"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75654592"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:05:13 -0700
X-CSE-ConnectionGUID: hCOESgd1Qj2+21fF8kGQlg==
X-CSE-MsgGUID: 5rC4a6BfTMemzraxNkhwgQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 27 Mar 2026 06:05:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 4/4] net/i40e: merge version tables
Date: Fri, 27 Mar 2026 13:04:47 +0000
Message-ID: <20260327130448.1033651-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260327130448.1033651-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
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

The only differences between the X722 and the X710 version tables is the
final column, so merge the tables with one column for X710 FW versions
and another for X722 FW versions.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/i40e.rst | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index f4c8d39e54..2613ca46f6 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -99,34 +99,19 @@ The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
 and Linux distributions that were tested and verified
 are listed in the Tested Platforms section of the Release Notes for each release.
 
-For X710/XL710/XXV710,
-
-   +--------------+-----------------------+------------------+
-   | DPDK version | Kernel driver version | Firmware version |
-   +==============+=======================+==================+
-   |    25.11     |         2.28.13       |       9.55       |
-   +--------------+-----------------------+------------------+
-   |    24.11     |         2.26.8        |       9.52       |
-   +--------------+-----------------------+------------------+
-   |    23.11     |         2.23.17       |       9.30       |
-   +--------------+-----------------------+------------------+
-   |    22.11     |         2.20.12       |       9.01       |
-   +--------------+-----------------------+------------------+
-
-
-For X722,
-
-   +--------------+-----------------------+------------------+
-   | DPDK version | Kernel driver version | Firmware version |
-   +==============+=======================+==================+
-   |    25.11     |         2.28.13       |       6.51       |
-   +--------------+-----------------------+------------------+
-   |    24.11     |         2.26.8        |       6.50       |
-   +--------------+-----------------------+------------------+
-   |    23.11     |         2.23.17       |       6.20       |
-   +--------------+-----------------------+------------------+
-   |    22.11     |         2.20.12       |       6.00       |
-   +--------------+-----------------------+------------------+
+   +--------------+-----------------------+------------------+------------------+
+   | DPDK version | Kernel driver version | X710* FW version |  X722 FW version |
+   +==============+=======================+==================+==================+
+   |    25.11     |         2.28.13       |       9.55       |       6.51       |
+   +--------------+-----------------------+------------------+------------------+
+   |    24.11     |         2.26.8        |       9.52       |       6.50       |
+   +--------------+-----------------------+------------------+------------------+
+   |    23.11     |         2.23.17       |       9.30       |       6.20       |
+   +--------------+-----------------------+------------------+------------------+
+   |    22.11     |         2.20.12       |       9.01       |       6.00       |
+   +--------------+-----------------------+------------------+------------------+
+
+   * The X710 FW version is also applicable for XL710 and XXV710.
 
 
 Configuration
-- 
2.51.0

