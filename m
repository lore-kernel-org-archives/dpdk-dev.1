Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5306DCFD31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 08:47:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64238402E7;
	Mon, 24 Nov 2025 09:47:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5C6F3400D7
 for <dev@dpdk.org>; Mon, 24 Nov 2025 09:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763974019; x=1795510019;
 h=from:to:cc:subject:date:message-id;
 bh=9D+EnXvI9GogsyAkBOxj27cPsIK2eI6nsQzwjd9g+Ag=;
 b=OGCvM+yBXOTkHv0tVGeWiQEMiUrRj17VvGtW5tUkyaYJ1481+iJ/vkbu
 9Kp7dmunqNcRBkWdPp/hWtjPqbiqCSnj/nDvv1Svg4+etnFAHfXtIw/oa
 HxikH5MUv4b4Ut57WJlHmNyU82pu7YID48y5r0lurtcMpLh+Xz+Q7UWOZ
 UuI0YEwRya8SqxbY3LTVzs0xBirONsVwjo2QBx+0eF38Qxxwa9E76N+Nx
 aOKKkMMnpp8v+Tu2sDJ4l2gwKxfQ36AUyp6oGSITKVjFS8qenMruyiZgj
 hdzMXccfeVGJygz5ciP0W026uMzjZHE4W3LWifCCHPDS2YDMrroH5jKNR A==;
X-CSE-ConnectionGUID: UShdxRt/TEW31dXxX0KG8A==
X-CSE-MsgGUID: v1Lqqy5GSlCZ3tWpuBOc+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="77329729"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="77329729"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 00:46:57 -0800
X-CSE-ConnectionGUID: +jpdcJ/HS5qEJ25MeUR66Q==
X-CSE-MsgGUID: IPws3HijQseKQKU8lsnVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="197392951"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.141])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 00:46:55 -0800
From: Yu Jiang <yux.jiang@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com,
 Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Mon, 24 Nov 2025 16:34:18 +0800
Message-Id: <20251124083418.61881-1-yux.jiang@intel.com>
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

Add tested Intel platforms with Intel NICs to v25.11 release note.

Signed-off-by: Yu Jiang <yux.jiang@intel.com>
---
 doc/guides/rel_notes/release_25_11.rst | 135 +++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 83e86ada64..42ed826fe2 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -345,3 +345,138 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with Intel\ |reg| NICs combinations
+
+  * CPU
+
+    * Intel\ |reg| Atom\ |trade| x7835RE
+    * Intel\ |reg| Xeon\ |reg| 6553P-B  CPU @ 2.6GHz
+    * Intel\ |reg| Xeon\ |reg| 6767P  CPU @ 2.4GHz
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480  CPU @ 1.9GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6330 CPU @ 2.00GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6348 CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8280M CPU @ 2.70GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8380 CPU @ 2.30GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8468H  CPU @ 2.1GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8490H  CPU @ 1.9GHz
+
+  * OS:
+
+    * Fedora 42
+    * FreeBSD 14.3
+    * Microsoft Azure Linux 3.0
+    * OpenAnolis OS 8.10
+    * openEuler 24.03 (LTS-SP2)
+    * Red Hat Enterprise Linux Server release 10
+    * Red Hat Enterprise Linux Server release 9.6
+    * Ubuntu 24.04 LTS
+    * Ubuntu 24.04.3 LTS
+    * Vmware Exsi 8.0.3
+
+  * NICs:
+
+    * Intel\ |reg| Ethernet Controller E810-C for SFP (4x25G)
+
+      * Firmware version: 4.90 0x80020eeb 1.3863.0
+      * Device id (pf/vf): 8086:1593 / 8086:1889
+      * Driver version(out-of-tree): 2.3.14 (ice)
+      * Driver version(in-tree): 6.8.0-86-generic (Ubuntu24.04 LTS) (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for QSFP (2x100G)
+
+      * Firmware version: 4.90 0x80020ef2 1.3863.0
+      * Device id (pf/vf): 8086:1592 / 8086:1889
+      * Driver version(out-of-tree): 2.3.14 (ice)
+      * Driver version(in-tree): 6.6.12.1-1.azl3+ice+ (Microsoft Azure Linux 3.0) /
+        6.12.0-55.9.1.el10_0.x86_64+rt (RHEL10) (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for SFP
+
+      * Firmware version: 1.20 0x800179c0 1.3862.0
+      * Device id (pf/vf): 8086:12d3 / 8086:1889
+      * Driver version: 2.3.14 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for QSFP
+
+      * Firmware version: 1.20 0x800179c1 1.3862.0
+      * Device id (pf/vf): 8086:12d2 / 8086:1889
+      * Driver version: 2.3.14 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Connection E825-C for QSFP
+
+      * Firmware version: 4.04 0x80007e5c 1.3885.0
+      * Device id (pf/vf): 8086:579d / 8086:1889
+      * Driver version: 2.3.14 (ice)
+      * OS Default DDP: 1.3.43.0
+      * COMMS DDP: 1.3.55.0
+      * Wireless Edge DDP: 1.3.25.0
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT2
+
+      * Firmware version: 1.30 0x8000e8a2 1.3864.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-of-tree): 6.2.5 (ixgbe)
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT4
+
+      * Firmware version: 1.30 0x8000e8a5 1.3864.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-of-tree): 6.2.5 (ixgbe)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter X710-DA4 (4x10G)
+
+      * Firmware version: 9.55 0x8000fdf4 1.3862.0
+      * Device id (pf/vf): 8086:1572 / 8086:154c
+      * Driver version(in-tree): 6.8.0-88-generic (i40e)
+
+    * Intel\ |reg| Corporation Ethernet Connection X722 for 10GbE SFP+ (2x10G)
+
+      * Firmware version: 6.51 0x80004430 1.3862.0
+      * Device id (pf/vf): 8086:37d0 / 8086:37cd
+      * Driver version(out-of-tree): 2.28.13 (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XXV710-DA2 (2x25G)
+
+      * Firmware version:  9.55 0x8000fe4c 1.3862.0
+      * Device id (pf/vf): 8086:158b / 8086:154c
+      * Driver version(out-of-tree): 2.28.13 (i40e)
+      * Driver version(in-tree): 6.8.0-88-generic (Ubuntu24.04.3 LTS) /
+        6.12.0-55.9.1.el10_0.x86_64 (RHEL10) (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
+
+      * Firmware version(PF): 9.55 0x8000fe31 1.3862.0
+      * Device id (pf/vf): 8086:1583 / 8086:154c
+      * Driver version(out-of-tree): 2.28.13 (i40e)
+
+    * Intel\ |reg| Ethernet Controller I226-LM
+
+      * Firmware version: 2.14, 0x8000028c
+      * Device id (pf): 8086:125b
+      * Driver version(in-tree): 6.8.0-87-generic (Ubuntu24.04.3 LTS) (igc)
+
+    * Intel\ |reg| Corporation Ethernet Server Adapter I350-T4
+
+      * Firmware version: 1.63, 0x8000116b
+      * Device id (pf/vf): 8086:1521 /8086:1520
+      * Driver version: 6.14.0-35-generic (Ubuntu 24.04.3 LTS) (igb)
+
+    * Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100
+
+      * Firmware version: ci-ts.release.2.0.0.11126
+      * Device id (idpf/cpfl): 8086:1452/8086:1453
+      * Driver version: 0.0.772 (idpf)
-- 
2.17.1

