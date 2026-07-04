Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D24C43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 13:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75DE4402D4;
	Sat,  4 Jul 2026 15:17:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 285A6402C6
 for <dev@dpdk.org>; Sat,  4 Jul 2026 15:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783171059; x=1814707059;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8F4/3dlEM/D0MltSUhg6hl7uBx31U3P9IPWib81z8gg=;
 b=CfWlW9IGTutlEBYNTLP7LEC/AkKSFAL7XIFpvE//kUtasZhZ5aDUqlyG
 HjdsIYQifVFCghXTN/A3SUtCJ6VLh+NH9KfRf+Z+k/b5k9UlNxY2YFGmf
 1zTDQvrSwfrvUL8r33gMfNs32mEXnsqQFduaU0L1/qx0Or9nb+SLLQGFT
 aFLOX/Xb+TZAXRmRPLODvTVvnDpmEsHXT3azyvkDHtkoYuh5syHro5DV7
 cyRkDlPv5wsJg4ggyF7wdo0B46QK/QmtQum4CibXh3h9aLLtCq8rXrw5e
 2D4WL3d6x+3e6ftahFCDPevArB1LU/6E/dSZiHEuJA56ndgxQRsgVqyJw Q==;
X-CSE-ConnectionGUID: AflPEPzwTjejBsv0LIhrKQ==
X-CSE-MsgGUID: Bkzm9sn6SDyxMuR9YKwXZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="94529643"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; d="scan'208";a="94529643"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2026 06:17:38 -0700
X-CSE-ConnectionGUID: zp3M9IP2TayC7F3ovsNNHQ==
X-CSE-MsgGUID: zhOcicVDSV+02N4FKSu7aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; d="scan'208";a="291451851"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa001.jf.intel.com with ESMTP; 04 Jul 2026 06:17:37 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] doc: announce QinQ offloading operations in iavf PMD
Date: Sat,  4 Jul 2026 13:17:30 +0000
Message-Id: <20260704131730.457722-1-anurag.mandal@intel.com>
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

The iavf PMD supports hardware offloading for all QinQ operations.
QinQ tag stripping and insertion offloads have been added for both
outer VLAN TPIDs: 0x88a8 (IEEE 802.1ad) & 0x8100 (IEEE 802.1Q).

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/features/iavf.ini      | 2 +-
 doc/guides/rel_notes/release_26_07.rst | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 0ba6f7dfd7..e324a7aecb 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -30,7 +30,7 @@ Traffic manager      = Y
 Inline crypto        = P
 CRC offload          = Y
 VLAN offload         = P
-QinQ offload         = P
+QinQ offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Timestamp offload    = Y
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index cf79eb57bf..d864019244 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -139,6 +139,7 @@ New Features
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
   * Implemented AVX2 context descriptor transmit paths.
+  * Added support for QinQ offloading operations.
 
 * **Updated Intel ice driver.**
 
-- 
2.34.1

