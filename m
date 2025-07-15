Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C05C83F1D
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 06:32:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5627D4021E;
	Tue, 15 Jul 2025 08:32:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 684D74013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 08:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752561168; x=1784097168;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t5ZuaF7o8hqgNyc+VkLWQGFImngKU1ENZqOfVQWZb9w=;
 b=ksvql/jZdlNcCO6uMoRfGqYZeLN2vKxgRhmodJdDyZaP7WT9WwBv1P7X
 BN8HWCzOIcssORTAcdmWV6Elzan3JKIzHOkOpnkdAtktSOIaXeHuKysjb
 Ojey0F0mY7gH9bn8U5I4jP8M7dOeKouGjGkDIYGraO3bWBWublaOW5Kb7
 I9qm2pXdis439mPz88Is2Ny0P2sShQx50s9IhxfJX0STyzQXr695OUONZ
 ZHYN846MrBEm84gQxvgBkiHqYVri7Qz6VFzrI3rcDhE/qs4dc05awfbqY
 tI1DTcere6sFBhuqsvHr7wvdzdKU7kCfNCYFZEIwcqMgBclJXEgpCfjE+ g==;
X-CSE-ConnectionGUID: 7Vr/l1hzQKybg1VVoAW2Vg==
X-CSE-MsgGUID: vOZ4GanoTTySd35wXgSKeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57379314"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="57379314"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 23:32:47 -0700
X-CSE-ConnectionGUID: Fbpyl9okQuGv4sXKcrKmZw==
X-CSE-MsgGUID: dBzFIO+HSWehaIsT5a8d2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="156784506"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.217])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 23:32:46 -0700
From: Yu Jiang <yux.jiang@intel.com>
To: bruce.richardson@intel.com,
	john.mcnamara@intel.com,
	dev@dpdk.org
Cc: Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Tue, 15 Jul 2025 13:57:48 +0800
Message-Id: <20250715055748.1006691-1-yux.jiang@intel.com>
X-Mailer: git-send-email 2.25.1
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

Add tested Intel platforms with Intel NICs to v25.07 release note.

Signed-off-by: Yu Jiang <yux.jiang@intel.com>
---
 doc/guides/rel_notes/release_25_07.rst | 164 +++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 0b8300a718..44c33b179b 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -318,3 +318,167 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with Intel\ |reg| NICs combinations
+
+  * CPU
+
+    * Intel\ |reg| Atom\ |trade| x7835RE
+    * Intel\ |reg| Xeon\ |reg| 6767P
+    * Intel\ |reg| Xeon\ |reg| CPU E5-2699 v4 @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480  CPU @ 1.9GHz
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
+    * Fedora 42
+    * FreeBSD 14.2
+    * Microsoft Azure Linux 3.0
+    * OpenAnolis OS 8.10
+    * openEuler 24.03 (LTS-SP1)
+    * Red Hat Enterprise Linux Server release 9.6
+    * Ubuntu 24.04.2 LTS
+
+  * NICs:
+
+    * Intel\ |reg| Ethernet Controller E810-C for SFP (4x25G)
+
+      * Firmware version: 4.80 0x80020601 1.3805.0
+      * Device id (pf/vf): 8086:1593 / 8086:1889
+      * Driver version(out-tree): 2.2.8 (ice)
+      * Driver version(in-tree): 6.8.0-60-generic (Ubuntu24.04.2 LTS) /
+        5.14.0-570.12.1.el9_6.x86_64 (RHEL9.6) (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.23.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for QSFP (2x100G)
+
+      * Firmware version: 4.80 0x80020543 1.3805.0
+      * Device id (pf/vf): 8086:1592 / 8086:1889
+      * Driver version(out-tree): 2.2.8 (ice)
+      * Driver version(in-tree): 6.6.12.1-1.azl3+ice+ (Microsoft Azure Linux 3.0) (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.23.0
+
+    * Intel\ |reg| Ethernet Controller E810-XXV for SFP (2x25G)
+
+      * Firmware version: 4.80 0x80020544 1.3805.0
+      * Device id (pf/vf): 8086:159b / 8086:1889
+      * Driver version: 2.2.8 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for SFP
+
+      * Firmware version: 1.00 0x800161b9 1.3832.0
+      * Device id (pf/vf): 8086:12d3 / 8086:1889
+      * Driver version: 2.2.8 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.23.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for QSFP
+
+      * Firmware version: 1.00 0x800161b7 1.3832.0
+      * Device id (pf/vf): 8086:12d2 / 8086:1889
+      * Driver version: 2.2.8 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.23.0
+
+    * Intel\ |reg| Ethernet Connection E825-C for QSFP
+
+      * Firmware version: 3.94 0x8000766d 1.3825.0
+      * Device id (pf/vf): 8086:579d / 8086:1889
+      * Driver version: 2.2.8 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.23.0
+
+    * Intel\ |reg| 82599ES 10 Gigabit Ethernet Controller
+
+      * Firmware version: 0x000161bf
+      * Device id (pf/vf): 8086:10fb / 8086:10ed
+      * Driver version(out-tree): 6.1.5 (ixgbe)
+      * Driver version(in-tree): 6.8.0-60-generic (Ubuntu24.04.2 LTS) (ixgbe)
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT2
+
+      * Firmware version: 1.00 0x800066ae 0.0.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-tree): 6.1.5 (ixgbe)
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT4
+
+      * Firmware version: 1.00 0x80004ef2 0.0.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-tree): 6.1.5 (ixgbe)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter X710-DA4 (4x10G)
+
+      * Firmware version: 9.54 0x8000fb3f 1.3800.0
+      * Device id (pf/vf): 8086:1572 / 8086:154c
+      * Driver version(out-tree): 2.28.7 (i40e)
+
+    * Intel\ |reg| Corporation Ethernet Connection X722 for 10GbE SFP+ (2x10G)
+
+      * Firmware version: 6.50 0x800043a1 1.3597.0
+      * Device id (pf/vf): 8086:37d0 / 8086:37cd
+      * Driver version(out-tree): 2.28.7 (i40e)
+      * Driver version(in-tree): 5.14.0-570.12.1.el9_6.x86_64 (RHEL9.6) (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XXV710-DA2 (2x25G)
+
+      * Firmware version:  9.54 0x8000fb47 1.3800.0
+      * Device id (pf/vf): 8086:158b / 8086:154c
+      * Driver version(out-tree): 2.28.7 (i40e)
+      * Driver version(in-tree): 6.8.0-63-generic (Ubuntu24.04.2 LTS) /
+        5.14.0-570.12.1.el9_6.x86_64 (RHEL9.6) (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
+
+      * Firmware version(PF): 9.54 0x8000fb7f 1.3800.0
+      * Device id (pf/vf): 8086:1583 / 8086:154c
+      * Driver version(out-tree): 2.28.7 (i40e)
+
+    * Intel\ |reg| Ethernet Controller I225-LM
+
+      * Firmware version: 1.3, 0x800000c9
+      * Device id (pf): 8086:15f2
+      * Driver version(in-tree): 6.8.0-60-generic (Ubuntu24.04.2 LTS) (igc)
+
+    * Intel\ |reg| Ethernet Controller I225-IT
+
+      * Firmware version: 1094:878d
+      * Device id (pf): 8086:0d9f
+      * Driver version(in-tree): 6.12-intel (Ubuntu 24.04.2 LTS) (igc)
+
+    * Intel\ |reg| Ethernet Controller I226-LM
+
+      * Firmware version: 2.14, 0x8000028c
+      * Device id (pf): 8086:125b
+      * Driver version(in-tree): 6.8.0-60-generic (Ubuntu24.04.2 LTS) (igc)
+
+    * Intel\ |reg| Corporation Ethernet Server Adapter I350-T4
+
+      * Firmware version: 1.63, 0x8000116b
+      * Device id (pf/vf): 8086:1521 /8086:1520
+      * Driver version: 6.12-intel (Ubuntu 24.04.2 LTS) (igb)
+
+    * Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100
+
+      * Firmware version: ci-ts.release.2.0.0.11126
+      * Device id (idpf/cpfl): 8086:1452/8086:1453
+      * Driver version: 0.0.772 (idpf)
+
-- 
2.17.1

