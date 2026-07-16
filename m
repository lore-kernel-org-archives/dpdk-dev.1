Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7BC44512
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 01:51:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E77D4028A;
	Fri, 17 Jul 2026 03:51:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1E74E40274
 for <dev@dpdk.org>; Fri, 17 Jul 2026 03:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784253069; x=1815789069;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SuLaTgsrXTC27xnop1Vqi7UmrdL+NQrFTCUquls0sO0=;
 b=Nyj5EgWC35CaIOtJujy7N+ymogiXnf2UgWdhlbQt5T2aYdLIpzXKCU4S
 GtiwPbumtAJK0FSyc5MO8otFCHi/WDws5ILJ7rqha8OWybjuaf25/LcTx
 pUw2WmJuA1JATpZnjfvLkJIRJDwISiB5VnLYuxILExAVs4iOHwNLqBsjE
 StseESAS4HTfXpgD3IcoSyiI/tFNsUdchQmHCTR4jGHmHvoQiVI3sRoA/
 AIxJgZjwSgyCAIV5Sq6f8AaWJfxDbfw8CwWVeoZ1KWIT3e1kG536Qy6eb
 a4G64T1my6BXuF4NBJkswH1QfQRShPmH3jt9rPuXXLXVE83AcNJvIYWC0 Q==;
X-CSE-ConnectionGUID: Tv0ujcdKT0uZMZV/pzobcQ==
X-CSE-MsgGUID: 1B/M5nJbTJ+z/wiiop5jhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84948345"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="84948345"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 18:51:07 -0700
X-CSE-ConnectionGUID: E+VPex7HTBywSse/b6j66A==
X-CSE-MsgGUID: anHThCvLQQO9bVdoOB8DAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="257280835"
Received: from unknown (HELO dpdk-jiangyu-purley..) ([10.239.252.147])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 18:51:05 -0700
From: Yu Jiang <yux.jiang@intel.com>
To: bruce.richardson@intel.com,
	john.mcnamara@intel.com,
	dev@dpdk.org
Cc: Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Thu, 16 Jul 2026 15:08:30 +0800
Message-ID: <20260716070830.134401-1-yux.jiang@intel.com>
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

Add tested Intel platforms with Intel NICs to v26.07 release note.

Signed-off-by: Yu Jiang <yux.jiang@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 127 +++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..2203feda1f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -403,3 +403,130 @@ Tested Platforms
    This section is a comment. Do not overwrite or remove it.
    Also, make sure to start the actual text at the margin.
    =======================================================
+
+* Intel\ |reg| platforms with Intel\ |reg| NICs combinations
+
+  * CPU
+    * Intel\ |reg| Xeon\ |reg| 6553P-B  CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| 6740E  CPU @ 2.40GHz
+    * Intel\ |reg| Xeon\ |reg| 6756P-B  CPU @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| 6760P  CPU @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| 6767P  CPU @ 2.40GHz
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480  CPU @ 1.90GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6348  CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6430L  CPU @ 1.90GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8468H  CPU @ 2.10GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8490H  CPU @ 1.90GHz
+
+  * OS:
+
+    * Fedora 43
+    * FreeBSD 15.0
+    * Microsoft Azure Linux 3.0
+    * OpenAnolis OS 8.10
+    * openEuler 24.03 (LTS-SP3)
+    * Red Hat Enterprise Linux Server release 10
+    * Red Hat Enterprise Linux Server release 9.6
+    * Ubuntu 24.04.4 LTS
+    * Ubuntu 26.04
+    * Vmware Exsi 9.0
+
+  * NICs:
+
+    * Intel\ |reg| Ethernet Controller E835-CC for SFP
+
+      * Firmware version: 2.10 0x80018d57 1.4002.0
+      * Device id (pf/vf): 8086:124a / 8086:1889
+      * Driver version: 2.6.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for SFP (4x25G)
+
+      * Firmware version: 5.00 0x80021c11 1.4002.0
+      * Device id (pf/vf): 8086:1593 / 8086:1889
+      * Driver version(out-of-tree): 2.6.6 (ice)
+      * Driver version(in-tree): 7.0.0-15-generic (Ubuntu26.04) (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for QSFP (2x100G)
+
+      * Firmware version: 5.00 0x80021bcc 1.4002.0
+      * Device id (pf/vf): 8086:1592 / 8086:1889
+      * Driver version(out-of-tree): 2.6.6 (ice)
+      * Driver version(in-tree): 6.6.119.3-1.azl3 (Microsoft Azure Linux 3.0) /
+        6.12.0-55.9.1.el10_0.x86_64+rt (RHEL10) / 7.0.0-15-generic (Ubuntu26.04) (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for QSFP
+
+      * Firmware version: 2.10 0x80018d29 1.4002.0
+      * Device id (pf/vf): 8086:12d2 / 8086:1889
+      * Driver version: 2.6.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Connection E825-C for QSFP
+
+      * Firmware version: 4.10 0x800084d5 1.4002.0
+      * Device id (pf/vf): 8086:579d / 8086:1889
+      * Driver version: 2.6.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT2
+
+      * Firmware version: 1.60 0x8000f173 0.0.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-of-tree): 6.4.4 (ixgbe)
+
+    * Intel\ |reg| Ethernet Controller X550 1563
+
+      * Firmware version: 3.70 0x8000184a 1.3052.0
+      * Device id (pf/vf): 8086:1563 / 8086:1565
+      * Driver version(out-of-tree): 6.4.4 (ixgbe)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter X710-DA4 (4x10G)
+
+      * Firmware version: 9.57 0x80010340 1.4002.0
+      * Device id (pf/vf): 8086:1572 / 8086:154c
+      * Driver version(out-of-tree): 2.30.18 (i40e)
+      * Driver version(in-tree): 6.12.0-55.9.1.el10_0.x86_64 (RHEL10) (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XXV710-DA2 (2x25G)
+
+      * Firmware version:  9.57 0x80010398 1.4002.0
+      * Device id (pf/vf): 8086:158b / 8086:154c
+      * Driver version(out-of-tree): 2.30.18 (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
+
+      * Firmware version(PF): 9.57 0x8001037b 1.4002.0
+      * Device id (pf/vf): 8086:1583 / 8086:154c
+      * Driver version(out-of-tree): 2.30.18 (i40e)
+      * Driver version(in-tree): 7.0.0-27-generic (Ubuntu26.04) (i40e)
+
+    * Intel\ |reg| Corporation Ethernet Connection X722 for 10GbE SFP (2x10G)
+
+      * Firmware version: 6.51 0x80004430 1.4002.0
+      * Device id (pf/vf): 8086:37d0 / 8086:37cd
+      * Driver version(out-of-tree): 2.30.18 (i40e)
+
+    * Intel\ |reg| Ethernet Controller I226-LM
+
+      * Firmware version: 2.14, 0x8000028c
+      * Device id (pf): 8086:125b
+      * Driver version(in-tree): 7.0.0-15-generic (Ubuntu26.04) (igc)
+
+    * Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100
+
+      * Firmware version: ci-ts.release.2.0.0.11126
+      * Device id (idpf/cpfl): 8086:1452/8086:1453
+      * Driver version: 1.0.13 (idpf)
-- 
2.43.0

