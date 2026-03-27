Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0D10A62E8
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:33:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A79042D55;
	Fri, 27 Mar 2026 03:33:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8561B427C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 03:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774578834; x=1806114834;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SWm9udUGbtCT7h0ZY6v4CsdL4t6WJqbSsbJGRUl38Tg=;
 b=BJ08WB0ZKp0jpTG0AJBUwtZudD6CnbWGRyRB8VWEo5HKN1ale5i43tmJ
 8I9g7x/0lyixQ985ReNSLT5icbo8kadFwLQ1UihXSTxW5AHd101/V6B2H
 3aVC9Ie79YvmLuptkEArd31CGvSjRWpiou+yLwZWkx0E6mDRvWTnXE5Zj
 Z2Eyo26KzVJ3axeK7epavxg8IAophn7ay7AelxYBpz6q9Qtfm+O66Hugd
 kJRWi1yT1Kqs7pLBgwx+VoTqqNOEzNY3cJwHcB/XxosOxLHR5MqXI4fsF
 HOhqhzp1YXJu9BVxzuU1Yp3eefPSRmN7jen+JLjpZqNEwINkNevGlUL8j A==;
X-CSE-ConnectionGUID: p5Lc4ULDRw6LKsD/zrwKXw==
X-CSE-MsgGUID: YrnCag4CRbCHWT1LTddhTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75532513"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75532513"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:33:53 -0700
X-CSE-ConnectionGUID: dYh2sPZxRyCFQLYI2ap8fQ==
X-CSE-MsgGUID: setZRXJtThK8+nMsgU66yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="224232693"
Received: from unknown (HELO icx-jy-abi-d81..) ([10.239.252.81])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:33:51 -0700
From: Yu Jiang <yux.jiang@intel.com>
To: bruce.richardson@intel.com,
	john.mcnamara@intel.com,
	dev@dpdk.org
Cc: Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Fri, 27 Mar 2026 10:51:50 +0000
Message-ID: <20260327105150.607424-1-yux.jiang@intel.com>
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

Add tested Intel platforms with Intel NICs to v26.03 release note.

Signed-off-by: Yu Jiang <yux.jiang@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst | 123 +++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 6bb18433f5..9f80d627a8 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -263,3 +263,126 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with Intel\ |reg| NICs combinations
+
+  * CPU
+
+    * Intel\ |reg| Xeon\ |reg| 6740E  CPU @ 2.4GHz
+    * Intel\ |reg| Xeon\ |reg| 6756P-B  CPU @ 2.2GHz
+    * Intel\ |reg| Xeon\ |reg| 6760P  CPU @ 2.2GHz
+    * Intel\ |reg| Xeon\ |reg| 6767P
+    * Intel\ |reg| Xeon\ |reg| 6767P  CPU @ 2.4GHz
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480  CPU @ 1.9GHz
+    * Intel\ |reg| Xeon\ |reg| D-2796NT CPU @ 2.00GHz  CPU @ 2.0GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6348 CPU @ 2.60GHz  CPU @ 2.0GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6430L
+    * Intel\ |reg| Xeon\ |reg| Gold 6430L  CPU @ 1.9GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8380 CPU @ 2.30GHz  CPU @ 2.3GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8468H  CPU @ 2.1GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8490H
+    * Intel\ |reg| Xeon\ |reg| Platinum 8490H  CPU @ 1.9GHz
+
+  * OS:
+
+    * Fedora 43
+    * FreeBSD 15.0
+    * Microsoft Azure Linux 3.0
+    * OpenAnolis OS 8.10
+    * openEuler 24.03 (LTS-SP2)
+    * Red Hat Enterprise Linux Server release 10
+    * Red Hat Enterprise Linux Server release 9.6
+    * Ubuntu 24.04.3 LTS
+    * Ubuntu 24.04.4 LTS
+    * Vmware Exsi 9.0
+
+  * NICs:
+
+    * Intel\ |reg| Ethernet Controller E810-C for SFP (4x25G)
+
+      * Firmware version: 4.91 0x8002147b 1.3909.0
+      * Device id (pf/vf): 8086:1593 / 8086:1889
+      * Driver version(out-of-tree): 2.4.5 (ice)
+      * Driver version(in-tree): 6.8.0-87-generic (Ubuntu24.04.3 LTS) (ice)
+      * OS Default DDP: 1.3.53.0
+      * COMMS DDP: 1.3.61.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for QSFP (2x100G)
+
+      * Firmware version: 4.91 0x800214ae 1.3909.0
+      * Device id (pf/vf): 8086:1592 / 8086:1889
+      * Driver version(out-of-tree): 2.4.5 (ice)
+      * Driver version(in-tree): 6.6.119.3-1.azl3 (Microsoft Azure Linux 3.0) /
+        6.12.0-55.9.1.el10_0.x86_64+rt (RHEL10) (ice)
+      * OS Default DDP: 1.3.53.0
+      * COMMS DDP: 1.3.61.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for QSFP
+
+      * Firmware version: 1.20 0x80017ef4 1.3909.0
+      * Device id (pf/vf): 8086:12d2 / 8086:1889
+      * Driver version: 2.4.5 (ice)
+      * OS Default DDP: 1.3.53.0
+      * COMMS DDP: 1.3.61.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Connection E825-C for QSFP
+
+      * Firmware version: 4.04 0x80007e5c 1.3885.0
+      * Device id (pf/vf): 8086:579d / 8086:1889
+      * Driver version: 2.4.5 (ice)
+      * OS Default DDP: 1.3.53.0
+      * COMMS DDP: 1.3.61.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT2
+
+      * Firmware version: 1.41 0x8000eda0 1.3909.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-of-tree): 6.3.4 (ixgbe)
+
+    * Intel\ |reg| Corporation Ethernet Controller X550
+
+      * Firmware version: 0x80001860, 1.3105.0
+      * Device id (pf/vf): 8086:1563 / 8086:1565
+      * Driver version(out-of-tree): 6.3.4 (ixgbe)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter X710-DA4 (4x10G)
+
+      * Firmware version: 9.56 0x800100c4 1.3909.0
+      * Device id (pf/vf): 8086:1572 / 8086:154c
+      * Driver version(in-tree): 6.12.0-55.9.1.el10_0.x86_64 (RHEL10) (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XXV710-DA2 (2x25G)
+
+      * Firmware version:  9.56 0x80010121 1.3909.0
+      * Device id (pf/vf): 8086:158b / 8086:154c
+      * Driver version(out-of-tree): 2.28.16 (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
+
+      * Firmware version(PF): 9.56 0x80010101 1.3909.0
+      * Device id (pf/vf): 8086:1583 / 8086:154c
+      * Driver version(out-of-tree): 2.28.16 (i40e)
+      * Driver version(in-tree): 6.8.0-101-generic (Ubuntu24.04.3 LTS) (i40e)
+
+    * Intel\ |reg| Corporation Ethernet Connection X722 for 10GbE SFP (2x10G)
+
+      * Firmware version: 6.51 0x80004430 1.3909.0
+      * Device id (pf/vf): 8086:37d0 / 8086:37cd
+      * Driver version(out-of-tree): 2.28.16 (i40e)
+
+    * Intel\ |reg| Ethernet Controller I226-LM
+
+      * Firmware version: 2.14, 0x8000028c
+      * Device id (pf): 8086:125b
+      * Driver version(in-tree): 6.8.0-88-generic (Ubuntu24.04.3 LTS) (igc)
+
+    * Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100
+
+      * Firmware version: ci-ts.release.2.0.0.11126
+      * Device id (idpf/cpfl): 8086:1452/8086:1453
+      * Driver version: 0.0.772 (idpf)
-- 
2.17.1

