Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A4FF495E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E323740677;
	Mon, 30 Mar 2026 16:14:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C8C334065C
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880068; x=1806416068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rhutQYQ+p6Z1tiGsoRi6vpPgmCeGhYFTVHUxuxqcR80=;
 b=HwQfD9siEUQbqpJ6BT9ZJF7EI8RZPlQxR1uosv3o00A0cJL4yxE+JKWq
 fH/BlHPRqKmOeZbfYOwoo1Xfguz7Z7QSzba3yYj/1wKQQtKIm74SNFkG9
 b446OIOQszmTCqIC8Co1hXK5029b/4EA98MKrHEk9ELWm5t1OwfGiswWu
 ZHhUKBJCE29RqdVNyPtrImXu/v7gQWePV20yiCGDppNDSXyjzkV4Tpuh9
 XPBtwDiW9v3KFt+KV4ftabWUC0y7YcBYzD9c93UqY7KLmIPsqbdooYlaT
 F0tDDVU4TT3JgKHMsZFHQYW/Xi7oZ33utCeSBVy22OOvJHABT9kgEBTJY w==;
X-CSE-ConnectionGUID: wDeLq2wcRw6q0ga3X5bmdw==
X-CSE-MsgGUID: Hw6TULxTRQu9RHQTbminSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75761670"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="75761670"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:14:27 -0700
X-CSE-ConnectionGUID: hkQmoqorQdenlalJaubWAw==
X-CSE-MsgGUID: 99+ZQ8mmQ/mcr4RbLmmFeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249123050"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 30 Mar 2026 07:14:26 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org,
	john.mcnamara@intel.com
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 5/6] net/i40e: merge version tables
Date: Mon, 30 Mar 2026 15:11:06 +0100
Message-ID: <20260330141415.1267233-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260330141415.1267233-1-bruce.richardson@intel.com>
References: <20260327130448.1033651-1-bruce.richardson@intel.com>
 <20260330141415.1267233-1-bruce.richardson@intel.com>
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

