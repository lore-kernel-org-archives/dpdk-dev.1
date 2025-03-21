Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4299BC35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 09:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1504A4066F;
	Fri, 21 Mar 2025 10:12:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BF9BB40276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 10:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742548331; x=1774084331;
 h=from:to:cc:subject:date:message-id;
 bh=sepVIS9XX5wL87dPz8fstu8A2iksPGx/D9CDTwf4L6k=;
 b=UNVqvBKhefshXNxDDDcicvjg9XRnGBjlQMBKDD9iLyBkyjJSN3jvYW2c
 Iba+RgfiJO3P17FXvH2IFqplvRnWs/mWNFcobmVO1SdgjdP70WLuRmX4C
 KJpqoMeJvqNeyuWoshcjLUQJD63+KjaTU7JMwiZvRXHXyVfxrabsZ0C88
 9wMTywQ97uLlpRJVu+97C836/tsdBEZ2y75M8ZxpE59qjKo35OH8TSdf8
 RzgTHK5nt9TIbFNIhqRtWSmfPxdX3vO/LE49NT6EzLfaDzHZ6Sck7WSP9
 tO7b214xJERoSEO3FgAWTrlvWPjPJmQzOyE3j6szKGPlYQxwzcJ9Uzbk4 w==;
X-CSE-ConnectionGUID: UpmjyhKyTWiovc+fUwBGfA==
X-CSE-MsgGUID: 48DBxiv6QOivtuM6Xf+ALw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43734093"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="43734093"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 02:12:10 -0700
X-CSE-ConnectionGUID: +QkDuntfR/uLNigs1sFEAQ==
X-CSE-MsgGUID: QewtDfhHQ36LZh0aAHYI9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="128406335"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.141])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 02:12:08 -0700
From: Yu Jiang <yux.jiang@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Fri, 21 Mar 2025 17:03:40 +0800
Message-Id: <20250321090340.35913-1-yux.jiang@intel.com>
X-Mailer: git-send-email 2.17.1
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

Add tested Intel platforms with Intel NICs to v25.03 release note.

Signed-off-by: Yu Jiang <yux.jiang@intel.com>
---
 doc/guides/rel_notes/release_25_03.rst | 164 +++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index caadd05d00..1db324cb8d 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -306,3 +306,167 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with Intel\ |reg| NICs combinations
+
+  * CPU
+
+    * Intel\ |reg| Atom\ |trade| x7835RE
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2699 v4 @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6139 CPU @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6140M CPU @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6252N CPU @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6348 CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8180 CPU @ 2.50GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8280M CPU @ 2.70GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8358 CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8380 CPU @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8468H
+    * Intel\ |reg| Xeon\ |reg| Platinum 8490H
+
+  * OS:
+
+    * Microsoft Azure Linux 3.0
+    * Fedora 41
+    * FreeBSD 14.2
+    * OpenAnolis OS 8.9
+    * openEuler 24.03 (LTS)
+    * Red Hat Enterprise Linux Server release 9.0
+    * Red Hat Enterprise Linux Server release 9.4
+    * Red Hat Enterprise Linux Server release 9.5
+    * Ubuntu 22.04.3 LTS
+    * Ubuntu 22.04.4 LTS
+    * Ubuntu 22.04.5 LTS
+    * Ubuntu 24.04.1 LTS
+
+  * NICs:
+
+    * Intel\ |reg| Ethernet Controller E810-C for SFP (4x25G)
+
+      * Firmware version: 4.70 0x8001f79e 1.3755.0
+      * Device id (pf/vf): 8086:1593 / 8086:1889
+      * Driver version(out-tree): 1.16.3 (ice)
+      * Driver version(in-tree): 6.8.0-48-generic (Ubuntu24.04.1) /
+        5.14.0-503.11.1.el9_5.x86_64 (RHEL9.5) (ice)
+      * OS Default DDP: 1.3.39.1
+      * COMMS DDP: 1.3.53.0
+      * Wireless Edge DDP: 1.3.14.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for QSFP (2x100G)
+
+      * Firmware version: 4.70 0x8001f7b8 1.3755.0
+      * Device id (pf/vf): 8086:1592 / 8086:1889
+      * Driver version(out-tree): 1.16.3 (ice)
+      * Driver version(in-tree): 6.6.12.1-1.azl3+ice+ (Microsoft Azure Linux 3.0) (ice)
+      * OS Default DDP: 1.3.39.1
+      * COMMS DDP: 1.3.53.0
+      * Wireless Edge DDP: 1.3.14.0
+
+    * Intel\ |reg| Ethernet Controller E810-XXV for SFP (2x25G)
+
+      * Firmware version: 4.70 0x8001f7ba 1.3755.0
+      * Device id (pf/vf): 8086:159b / 8086:1889
+      * Driver version: 1.16.3 (ice)
+      * OS Default DDP: 1.3.39.1
+      * COMMS DDP: 1.3.53.0
+
+    * Intel\ |reg| Ethernet Network Adapter E830-XXVDA2 for OCP
+
+      * Firmware version: 1.00 0x800107e3 1.3766.0
+      * Device id (pf/vf): 8086:12d3 / 8086:1889
+      * Driver version: 1.16.3 (ice)
+      * OS Default DDP: 1.3.39.1
+
+    * Intel\ |reg| Ethernet Network Adapter E830-CQDA2
+
+      * Firmware version: 1.00 0x800107ca 1.3766.0
+      * Device id (pf/vf): 8086:12d2 / 8086:1889
+      * Driver version: 1.16.3 (ice)
+      * OS Default DDP: 1.3.39.1
+      * COMMS DDP: 1.3.53.0
+      * Wireless Edge DDP: 1.3.19.0
+
+    * Intel\ |reg| Ethernet Connection E825-C for QSFP
+
+      * Firmware version: 3.81 0x8000674f 1.0.0
+      * Device id (pf/vf): 8086:579d / 8086:1889
+      * Driver version: 2.1.0 (ice)
+      * OS Default DDP: 1.3.39.2
+      * COMMS DDP: 1.3.54.0
+      * Wireless Edge DDP: 1.3.22.0
+
+    * Intel\ |reg| 82599ES 10 Gigabit Ethernet Controller
+
+      * Firmware version: 0x000161bf
+      * Device id (pf/vf): 8086:10fb / 8086:10ed
+      * Driver version(out-tree): 6.0.6 (ixgbe)
+      * Driver version(in-tree): 6.8.0-48-generic (Ubuntu24.04.1) (ixgbe)
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT2
+
+      * Firmware version: 1.00 0x800066ae 0.0.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-tree): 6.0.6 (ixgbe)
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT4
+
+      * Firmware version: 1.00 0x80004ef2 0.0.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-tree): 6.0.6 (ixgbe)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter X710-DA4 (4x10G)
+
+      * Firmware version: 9.53 0x8000f8f5 1.3755.0
+      * Device id (pf/vf): 8086:1572 / 8086:154c
+      * Driver version(out-tree): 2.27.8 (i40e)
+
+    * Intel\ |reg| Corporation Ethernet Connection X722 for 10GbE SFP+ (2x10G)
+
+      * Firmware version: 6.50 0x80004216 1.3597.0
+      * Device id (pf/vf): 8086:37d0 / 8086:37cd
+      * Driver version(out-tree): 2.27.8 (i40e)
+      * Driver version(in-tree): 5.14.0-427.13.1.el9_4.x86_64 (RHEL9.4)(i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XXV710-DA2 (2x25G)
+
+      * Firmware version:  9.53 0x8000f912 1.3755.0
+      * Device id (pf/vf): 8086:158b / 8086:154c
+      * Driver version(out-tree): 2.27.8 (i40e)
+      * Driver version(in-tree): 6.8.0-45-generic (Ubuntu24.04.1) /
+        5.14.0-427.13.1.el9_4.x86_64 (RHEL9.4)(i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
+
+      * Firmware version(PF): 9.53 0x8000f8f5 1.3755.0
+      * Device id (pf/vf): 8086:1583 / 8086:154c
+      * Driver version(out-tree): 2.27.8 (i40e)
+
+    * Intel\ |reg| Ethernet Controller I225-LM
+
+      * Firmware version: 1.3, 0x800000c9
+      * Device id (pf): 8086:15f2
+      * Driver version(in-tree): 6.8.0-48-generic (Ubuntu24.04.1)(igc)
+
+    * Intel\ |reg| Ethernet Controller (2) I225-IT
+
+      * Firmware version: 1.82, 0x8000026C
+      * Device id (pf): 8086:0d9f
+      * Driver version(in-tree): 6.6.25-lts-240422t024020z (Ubuntu22.04.4 LTS)(igc)
+
+    * Intel\ |reg| Ethernet Controller I226-LM
+
+      * Firmware version: 2.14, 0x8000028c
+      * Device id (pf): 8086:125b
+      * Driver version(in-tree): 6.8.0-45-generic (Ubuntu24.04.1)(igc)
+
+    * Intel\ |reg| Corporation Ethernet Server Adapter I350-T4
+
+      * Firmware version: 1.63, 0x80001001
+      * Device id (pf/vf): 8086:1521 /8086:1520
+      * Driver version: 6.6.25-lts-240422t024020z(igb)
+
+    * Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100
+
+      * Firmware version: CI-9231
+      * Device id (idpf/cpfl): 8086:1452/8086:1453
+      * Driver version: 0.0.754 (idpf)
-- 
2.17.1

