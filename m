Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B78606A335
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OLF8xImv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6640C40262;
	Mon, 23 Nov 2026 04:06:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 43A59400D5
 for <dev@dpdk.org>; Mon, 23 Nov 2026 04:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795403203; x=1826939203;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=r0Mc/zw2Qo8ERgzxGfORAvgyVAOLjRoWj+KeCspAFBE=;
 b=OLF8xImv0wGEGDqtA0dgyPsdVaG0qNJgKPV3WidR4CpDKubUXJFlxEii
 FnTisjNJF6LB6FLX8U67HfPgW0ZOc9KCHEyzgxIK6aNnzVS25ebJk219p
 clOwOzqTtKFS6yAbvHT34ZDXeraMg9+0ZtykY1HbniKWHJObWsN4iUrKN
 432064JSuInfyS+Obmj5XBXPIihLEz7jng0XflnJc0C7aBMdidF6dXazi
 gqH6P0SAxsg38zyAtEjyQiYCHV9Ud/4TkNcW80m78rKhpgU7pP5YfyPys
 SLrbF/ufDrbZrueBmn53upESBW4uAYd4kTgMapW/CWA4+WqEaAntB/kTi A==;
X-CSE-ConnectionGUID: u5NuViYQTDawW8suxxyZZQ==
X-CSE-MsgGUID: WLWSJmVHTsuGbinXXF/7PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4245854"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4245854"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 19:06:40 -0800
X-CSE-ConnectionGUID: kacnyv+oToyktR0V3BCf1g==
X-CSE-MsgGUID: Q1COcdJwSFetIkaxIHDmgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11310782"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.217])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 19:06:38 -0800
From: Yu Jiang <yux.jiang@intel.com>
To: bruce.richardson@intel.com,
	john.mcnamara@intel.com,
	dev@dpdk.org
Cc: Yu Jiang <yux.jiang@intel.com>
Subject: [ 26.11 intel doc PATCH V1] doc: add tested Intel platforms with
 Intel NICs
Date: Mon, 23 Nov 2026 10:15:34 +0800
Message-Id: <20261123021534.1345651-1-yux.jiang@intel.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add tested Intel platforms with Intel NICs to v26.11 release note.

Signed-off-by: Yu Jiang <yux.jiang@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst | 145 +++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 10ab2355ae..44436f74af 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -657,3 +657,148 @@ ABI Changes
 
 Tested Platforms
 ----------------
+
+* Intel\ |reg| platforms with Intel\ |reg| NICs combinations
+
+  * CPU
+
+    * Intel Atom\ |reg| P6952 processor CPU @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| 6553P-B  CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| 6740E  CPU @ 2.40GHz
+    * Intel\ |reg| Xeon\ |reg| 6756P-B  CPU @ 2.20GHz
+    * Intel\ |reg| Xeon\ |reg| 6767P  CPU @ 2.40GHz
+    * Intel\ |reg| Xeon\ |reg| 6972P  CPU @ 2.40GHz
+    * Intel\ |reg| Xeon\ |reg| CPU Max 9480  CPU @ 1.90GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6348  CPU @ 2.60GHz
+    * Intel\ |reg| Xeon\ |reg| Gold 6430L  CPU @ 1.90GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8468H  CPU @ 2.10GHz
+    * Intel\ |reg| Xeon\ |reg| Platinum 8490H  CPU @ 1.90GHz
+
+  * OS:
+
+    * Fedora Linux 43
+    * Fedora Linux 44
+    * FreeBSD 15.1
+    * Microsoft Azure Linux 3.0
+    * OpenAnolis OS 8.10
+    * openEuler 24.03 (LTS-SP4)
+    * Red Hat Enterprise Linux Server release 10
+    * Red Hat Enterprise Linux Server release 10.2
+    * Ubuntu 24.04.4 LTS
+    * Ubuntu 26.04.1 LTS
+    * Vmware Exsi 9.0
+
+  * NICs:
+
+    * Intel\ |reg| Ethernet Controller E835-CC for QSFP
+
+      * Firmware version: 2.20 0x80019eb7 1.4116.0
+      * Device id (pf/vf): 8086:1249 / 8086:1889
+      * Driver version: 2.7.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E835-CC for SFP
+
+      * Firmware version: 2.20 0x80019ed9 1.4116.0
+      * Device id (pf/vf): 8086:124a / 8086:1889
+      * Driver version: 2.7.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for SFP (4x25G)
+
+      * Firmware version: 5.10 0x80022601 1.4113.0
+      * Device id (pf/vf): 8086:1593 / 8086:1889
+      * Driver version(out-of-tree): 2.7.6 (ice)
+      * Driver version(in-tree): 7.0.0-31-generic (Ubuntu26.04.1 LTS) (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E810-C for QSFP (2x100G)
+
+      * Firmware version: 5.10 0x80022601 1.4113.0
+      * Device id (pf/vf): 8086:1592 / 8086:1889
+      * Driver version(out-of-tree): 2.7.6 (ice)
+      * Driver version(in-tree): 6.6.150.1-1.azl3 (Microsoft Azure Linux 3.0) /
+        6.12.0-211.7.3.el10_2.x86_64+rt (RHEL10.2) / 7.0.0-31-generic (Ubuntu26.04.1 LTS) (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Controller E830-CC for QSFP
+
+      * Firmware version: 2.20 0x80019f95 1.4116.0
+      * Device id (pf/vf): 8086:12d2 / 8086:1889
+      * Driver version: 2.7.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Connection E825-C for QSFP
+
+      * Firmware version: 4.10 0x800084d5 1.4002.0
+      * Device id (pf/vf): 8086:579d / 8086:1889
+      * Driver version: 2.7.6 (ice)
+      * OS Default DDP: 1.3.59.0
+      * COMMS DDP: 1.3.63.0
+      * Wireless Edge DDP: 1.3.28.0
+
+    * Intel\ |reg| Ethernet Network Adapter E610-XT2
+
+      * Firmware version: 1.70 0x8000f6da 1.4116.0
+      * Device id (pf/vf): 8086:57b0 / 8086:57ad
+      * Driver version(out-of-tree): 6.5.9 (ixgbe)
+
+    * Intel\ |reg| Ethernet Controller X550 1563
+
+      * Firmware version: 3.70 0x8000184a 1.3052.0
+      * Device id (pf/vf): 8086:1563 / 8086:1565
+      * Driver version(out-of-tree): 6.5.9 (ixgbe)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter X710-DA4 (4x10G)
+
+      * Firmware version: 9.58 0x8001049c 1.4113.0
+      * Device id (pf/vf): 8086:1572 / 8086:154c
+      * Driver version(out-of-tree): 2.30.83 (i40e)
+      * Driver version(in-tree): 6.12.0-55.9.1.el10_0.x86_64 (RHEL10) (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XXV710-DA2 (2x25G)
+
+      * Firmware version:  9.58 0x800104f6 1.4113.0
+      * Device id (pf/vf): 8086:158b / 8086:154c
+      * Driver version(out-of-tree): 2.30.83 (i40e)
+
+    * Intel\ |reg| Ethernet Converged Network Adapter XL710-QDA2 (2X40G)
+
+      * Firmware version(PF): 9.58 0x800104da 1.4113.0
+      * Device id (pf/vf): 8086:1583 / 8086:154c
+      * Driver version(out-of-tree): 2.30.83 (i40e)
+      * Driver version(in-tree): 7.0.0-31-generic (Ubuntu26.04.1 LTS) (i40e)
+
+    * Intel\ |reg| Corporation Ethernet Connection X722 for 10GbE SFP (2x10G)
+
+      * Firmware version: 6.51 0x80004430 1.4113.0
+      * Device id (pf/vf): 8086:37d0 / 8086:37cd
+      * Driver version(out-of-tree): 2.30.83 (i40e)
+
+    * Intel\ |reg| Ethernet Controller I226-LM
+
+      * Firmware version: 2.14, 0x8000028c (2017:888d)
+      * Device id (pf): 8086:125b
+      * Driver version(in-tree): 7.0.0-15-generic (Ubuntu26.04.1 LTS) (igc)
+
+    * Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100
+
+      * Firmware version: ci-ts.release.2.2.0.12025
+      * Device id (idpf/cpfl): 8086:1452/8086:1453
+      * Driver version: 1.0.12 (idpf)
+
+    * Intel\ |reg| Corporation Device 11df
+
+      * Firmware version: MEV IMC IPU-6.18.1-CI-RELEASE.3.1.14860.478
+      * Device id (idpf/cpfl): 8086:11df/8086:0de2
+      * Driver version: 1.0.12 (idpf)
-- 
2.25.1

